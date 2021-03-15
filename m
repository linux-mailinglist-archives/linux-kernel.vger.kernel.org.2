Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A02C33AA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCODqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCODpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:45:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B84C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:45:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so13989085pjg.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZXwTrKTQx/OD6J1Cdgr6noLCkJcjXYe7PmZkNPxSLw=;
        b=GW+3M0F4XTrVee2/9JkZlTXDDFvjDx9LnhyGu3Fz7YcGkOtCZjg6/M345D7nHUgOxv
         RMb9CEfp4fuasgYTcW9hx/wI5G9vJN0G3L0Az6g7Dtlyys6soNQ+Rp7Wk8FvocVSBIxG
         tOg8Mijm6o7NzOt8q74VMyruY3+LxGhRTsVjgxAHVYm0ytdPNgVICCtufQ16aXgUr6VI
         Eq//xgdPhgfXbmaz+wct4yZKow3TIn4pdG07xNjmv0hpLMFMGJ74iAvWeSOa53XL0o3A
         5cgYRKcP55NJRyPcNQXcWFUP6y4ZjDfCuDlLUNl+twexj/oCBufOGaVVYmTnTqjkyqhz
         5hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZXwTrKTQx/OD6J1Cdgr6noLCkJcjXYe7PmZkNPxSLw=;
        b=ZIBw7ov6KoETPn5ImwZ9ZqwEf9b27YOXL9Rik0znPYjjfUMMRohAG2fJcN+vV1tEQj
         IFtIoZFxgaSwrr5z7AWsdm/nbme5IK8DJAVTVkrv6stcO7rZEB32vIBx/vcFJdrTFcBB
         wo9+IxMSq1IYmGNfzHfVNI/+5kc1QmMPCH0mgEjLHakeQrhXo2kUUmYUcF8cbQ+3i86G
         8ir8v+ZPktO4keo49ZjmafcuwGIHQK7i+A8FwxeKqEnBJF5+60r+bKBOqr0HQRpZskOR
         ac84+aXZO7tlj9Hl3StEAdCzllDhLAHOQ1Vs6ibZQU6b/SDZRnuCwF7rZXBXUW5w5hLg
         hAlA==
X-Gm-Message-State: AOAM532ibLKKfo384N1VTI8TU0Pn3l/eL2adtCeuUHTP0jWepkmngHGz
        egia9mZSXGaYcQPmmXuVDdA=
X-Google-Smtp-Source: ABdhPJzPpq5RIU2aIz5fDXpDTCJ1X17Eoipi87SCTLHI72uyBaqOG78NBM2kPoYCy8F5mcqtwbzYdQ==
X-Received: by 2002:a17:90a:7045:: with SMTP id f63mr10517644pjk.35.1615779940495;
        Sun, 14 Mar 2021 20:45:40 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:9e10:6493:2d45:37bd:648d])
        by smtp.gmail.com with ESMTPSA id e11sm11761771pfm.24.2021.03.14.20.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:45:40 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: drop extraneous register load from initialize_mmu
Date:   Sun, 14 Mar 2021 20:45:33 -0700
Message-Id: <20210315034533.20643-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a9f2fc628e3a ("xtensa: cleanup MMU setup and kernel layout macros")
removed the use of a2 in the beginning of the initialize_mmu macro, but
left the register load that is no longer used. Remove it as well.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/initialize_mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/initialize_mmu.h b/arch/xtensa/include/asm/initialize_mmu.h
index 05cb13dfe6f4..9793b49fc641 100644
--- a/arch/xtensa/include/asm/initialize_mmu.h
+++ b/arch/xtensa/include/asm/initialize_mmu.h
@@ -73,7 +73,7 @@
 	_j	2f
 
 	.align	4
-1:	movi	a2, 0x10000000
+1:
 
 #if CONFIG_KERNEL_LOAD_ADDRESS < 0x40000000ul
 #define TEMP_MAPPING_VADDR 0x40000000
-- 
2.20.1

