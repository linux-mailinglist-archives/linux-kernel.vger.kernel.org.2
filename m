Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4BC31994B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBLEqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhBLEqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:46:05 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24F2C061793
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx20so4682686pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrab7yyrY6izENmuGhYDJQsf4eQZBI5ABzXIsoq1FoQ=;
        b=FShs87mvnngzKi8IzVcBTPQTUsIm10SxUmM4Oj3XhCHxxyon/6XsVUydQEx4tCOVBo
         OupK/2U/a4dVIs4+SD15hDy3UL+J70PQAdHNXbk41lu1dAr+O3820d38jJrFQ8/zsLKQ
         6Gvca4Xq6a9Vp6ByLx1mKRCtm46wO8SPw/Im0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrab7yyrY6izENmuGhYDJQsf4eQZBI5ABzXIsoq1FoQ=;
        b=JT1Uzep3CSmxPp8Fl6yemEt5G8p6NL4r6DB3LsbC3cH0symq3YfV61hZTaAZms+Bqe
         qnCiWj3pcjkTPY7LWkflY3P/VA04R+AWENCsRzaH1AWr0yc8CecMsaL3jz40cIWN679z
         4SIjsyB0+VK6nURwY596cIwUakeJtnoz6CTdwMB3UBuiwppV0Iz1uajY8UX015VwHipn
         kQziVGzgyXpW38HnyGTfyBr6OGIhsFrj8xogesHo1jHuSa7V0alfjWDq3GRjhgEfgK1i
         RYOhEuDTjDDrgtaZCQbxbnk8azyVwrekbRZ0skevOAvfzDRRnnygVfebm15LWel0QGg+
         3rzQ==
X-Gm-Message-State: AOAM532xFJvcQ1YXMKUhicxKOSDbk+u/OKULE5ptT9ZzWvaCbhaKLxIk
        10dtK5vWOyS+r2GIDsXasUlu1g==
X-Google-Smtp-Source: ABdhPJx9NuSyqDAE6FSlYcMwxTvccof+XpmkmpKv2tJfLMfv7QBDULmn9gUrDB8H8rQqDt39e6q8zw==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr1132137pjo.234.1613105094529;
        Thu, 11 Feb 2021 20:44:54 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:a453:d6cd:41b9:5925])
        by smtp.gmail.com with ESMTPSA id 25sm7298904pfh.199.2021.02.11.20.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 20:44:54 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] tracefs: Add FS_GENERATED_CONTENT to filesystem flags
Date:   Fri, 12 Feb 2021 12:44:04 +0800
Message-Id: <20210212124354.5.Ibc4b187415025a544425f206264db4fd94a555a7@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210212044405.4120619-1-drinkcat@chromium.org>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tracefs content is generated at runtime.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

 fs/tracefs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 4b83cbded559..89980312c7a3 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -308,6 +308,7 @@ static struct file_system_type trace_fs_type = {
 	.name =		"tracefs",
 	.mount =	trace_mount,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_GENERATED_CONTENT,
 };
 MODULE_ALIAS_FS("tracefs");
 
-- 
2.30.0.478.g8a0d178c01-goog

