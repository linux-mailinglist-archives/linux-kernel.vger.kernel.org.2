Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB15394B12
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhE2ISc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 04:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhE2ISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 04:18:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46BBC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y202so5018201pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hgq7e1/NKd5FJQDiWlDOoRnh3f92YL4vi/h4IjW0IVw=;
        b=b6L5xoHQQEPzt2ux4pQz4lAhmbz6UYPgWKclb8mM0/iRdy8Uc7og7IUd4+26BgWF2q
         Gzx9wkyishHTwltiQXJRhuVExKTIqXXlHF7uexgCAdvtPLI/dog7al8QqttFhkzURaD7
         1l6+QOiTOKx4veoQEd8gAAdKJGgbOBx3MUE9N7slcymGcDEJ73txdw3jUoem3v95ucvo
         BFcqBOD1Y2Wr7zd1wcAVo4PBWY+0uxXuNvOACQfdaXZl5W55pKPLSDv0X7nNCZM7h6cZ
         P4q4wKltYmUrnibLvzt5QwoJFlyYwHgc8WPGmqnh6ulXuzxVXtPU6uJdjAh0BMBhaDCl
         PX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hgq7e1/NKd5FJQDiWlDOoRnh3f92YL4vi/h4IjW0IVw=;
        b=BNfPIQ99tN73ZrYN17PQEIfFMyPRqq60A3Mr8mQUWuMeEL+tPfUgVpiQ7YRJCxKKqY
         CCPu+I8rRNMkfKEXe2bK43b4MtDIgf1xFkCzYRVamioMtUFWhSZJa0Qpz3fchaD7+fp+
         q06pg5bVhrGvbsACZkSG4I8Db6O6b7woSi1ohnJ3H/cTU3dMKU2xqWXMhueQB4VL1yQM
         qiNX65CuIJA2hTSPKB5mWE9hp4Xa6A0xlv00tqAKZgV5MAnvDkTyALerZDzind953cTz
         zaGchxxPiHvhkcIcwv990r8+hRcCXWfsu5BRPdeemQsj2kvNOMSdsKnrwfLr+GGALvMS
         +o5w==
X-Gm-Message-State: AOAM533h4f9Wof0Izvwb/+wTzwAfKDBbmZ5Zcy99F9UyeMwzNJt6+D64
        LFU5z+JdUEV12qR+nOzutE68ZA==
X-Google-Smtp-Source: ABdhPJwHnZWg86VmGa37wnfX+mmWrAGASrQGMMG3zMqWAyInSebvCUxqS1STwVmCjU9tj8dbZ58UMg==
X-Received: by 2002:a62:bd19:0:b029:2db:9bd7:edf0 with SMTP id a25-20020a62bd190000b02902db9bd7edf0mr7681803pff.40.1622276213394;
        Sat, 29 May 2021 01:16:53 -0700 (PDT)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id b12sm6613960pgs.52.2021.05.29.01.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 01:16:53 -0700 (PDT)
From:   houdek.ryan@fex-emu.org
X-Google-Original-From: Houdek.Ryan@fex-emu.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>
Subject: [PATCH 2/4] arm64: Track the sigreturn landing pad location
Date:   Sat, 29 May 2021 01:16:18 -0700
Message-Id: <20210529081620.164422-3-Houdek.Ryan@fex-emu.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
References: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Houdek <Houdek.Ryan@fex-emu.org>

This will be required once userspace dispatch is implemented

Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/kernel/vdso/sigreturn.S | 1 +
 arch/arm64/kernel/vdso/vdso.lds.S  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/vdso/sigreturn.S b/arch/arm64/kernel/vdso/sigreturn.S
index 0e18729abc3b..44ed8c5486d0 100644
--- a/arch/arm64/kernel/vdso/sigreturn.S
+++ b/arch/arm64/kernel/vdso/sigreturn.S
@@ -73,6 +73,7 @@ SYM_CODE_START(__kernel_rt_sigreturn)
 	mov	x8, #__NR_rt_sigreturn
 //	PLEASE DO NOT MODIFY
 	svc	#0
+SYM_INNER_LABEL(__kernel_vdso_sigreturn_landing_pad, SYM_L_GLOBAL)
 //	PLEASE DO NOT MODIFY
 //	.cfi_endproc
 SYM_CODE_END(__kernel_rt_sigreturn)
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index a5e61e09ea92..65d2bd880e2f 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -91,3 +91,4 @@ VERSION
  * Make the sigreturn code visible to the kernel.
  */
 VDSO_sigtramp		= __kernel_rt_sigreturn;
+VDSO_vdso_sigreturn_landing_pad	= __kernel_vdso_sigreturn_landing_pad;
-- 
2.30.2

