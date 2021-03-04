Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED2832DDE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhCDXfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCDXfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:35:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1A6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 15:35:16 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j8so46954otc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNaca+9r1gRcSq04wJ/07YdJf7lYCV1lxu+6s6o0cM8=;
        b=ctcvSvTrn0/f33Y1kC8ZkdOIXZt9/B9Fxq+OgKX//aUvAIxEsdoEzxezyzwbu9/ACA
         WF4qRTpg3FHi7Tpc14KqI6NOZeeyl7/KMVtlws8WZmidtDRHPCNa+ap75ii2G5yVGtHm
         N8Z3xDrYHqewVF6h4MUEsZrg7ZO4gttpgtNhJMFbUItCJSi1gxbcuch+14z/PaHE4G9H
         8W3VL57jhAtBuOdvHJij8ubcR6aigu4xVDNjxR/wRzV7JtUg76sHD10Ba3GtFrch1pnA
         1auh5qDkMM0Xcz8QvhztWmbNsIYZPLSgmzyEoAy5v9VB+w6FXuzpJMmGU+598XfmFtyU
         cwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNaca+9r1gRcSq04wJ/07YdJf7lYCV1lxu+6s6o0cM8=;
        b=NCMKRegijL2rSL0T3HMvgrui3YvFCgWebQvsLLV1Y9Zef8qey+SYTRB4eMnfN2kIrG
         aiRDC8VjVjQXqr7tPDRCzajhLcVqnePu16aAG4l0QdvA86RDAHI+numFaJwwzyaLNLnc
         RN0QDoX8YbGMVfB42XxT7r/Ichi1vSV4pBCSNzjMKdCVuBJkSh3FZaHwNb8w2lFrYoUd
         DucAnnLrdQiu7MF35kaavYtHpmgs7pjWN25ovPpEsOldwl6PJGCAX5u1BYc+RYV1FSTm
         3GAOUNQt1hvcWEalLelD13ev/KxIa9lcF2qZbuebAayoQ5TIsbXnC2sT/b1P7AzEt+R3
         PLvw==
X-Gm-Message-State: AOAM531uoavgkdN9uTXhUuaxR8Vo5m6t3FhViMO/Va4umvYQj2puXuAa
        aXzxjREd5+iUqujC1sYgxQ8=
X-Google-Smtp-Source: ABdhPJxTsVY8BsnmBpA1HatHQ6MwLhDBKnBfVq5P+IiALOG8LCXXGfAa1nxHelnA3jiCViXxPJi8IA==
X-Received: by 2002:a9d:340b:: with SMTP id v11mr5553744otb.284.1614900915601;
        Thu, 04 Mar 2021 15:35:15 -0800 (PST)
Received: from x1c.localdomain (192-241-58-140.ip.ctc.biz. [192.241.58.140])
        by smtp.gmail.com with ESMTPSA id z32sm207211ota.81.2021.03.04.15.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 15:35:15 -0800 (PST)
From:   Hsuan-Chi Kuo <hsuanchikuo@gmail.com>
To:     keescook@chromium.org
Cc:     hsuanchikuo@gmail.com, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] seccomp: Fix resetting filter count at seccomp_sync_threads()
Date:   Thu,  4 Mar 2021 17:37:08 -0600
Message-Id: <20210304233708.420597-1-hsuanchikuo@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The desired behavior is to set the caller's filter count to thread's.

Signed-off-by: Hsuan-Chi Kuo <hsuanchikuo@gmail.com>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 1d60fc2c99..3dde1aa173 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -597,7 +597,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		smp_store_release(&thread->seccomp.filter,
 				  caller->seccomp.filter);
 		atomic_set(&thread->seccomp.filter_count,
-			   atomic_read(&thread->seccomp.filter_count));
+			   atomic_read(&caller->seccomp.filter_count));
 
 		/*
 		 * Don't let an unprivileged task work around
-- 
2.30.1

