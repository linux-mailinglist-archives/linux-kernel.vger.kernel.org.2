Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5634473D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCVOcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhCVOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2291EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x21so19609118eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKw0Cn2bVUGNBja2BXUS2+diqo/9Y5C7FlOuogFpzRU=;
        b=OG+WbZ8x4tSEntH3GU6lZ9t+gPMinmyYorq5TPfaytK92P2Wu6+Jv/5COZfyrJ3pMv
         Y9usal3lsnmTndA2ej0y1P+thj901XSQebg7palEo3vif4Hxs48gcWnLHvUbjCgTl5rQ
         p3NvpuTO57xNWy0T9CXf5KqLbMxqGDv6luJFuU6de3r6friwp3GjP/0vqjw+3WVOqme7
         s/I8cjA4DWf7vsfIMs1qTGMkc6aK0wlad/oFfXJwzIik0Hg/zbCvFwH9LDbe4tmqHgl6
         t7ANNMYsqjMcXqJ5utFV1Ex6wLLPZYaVbC+NlKYxQ2YlqKH0Fv6R8c966NHQ808fWXeQ
         L0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKw0Cn2bVUGNBja2BXUS2+diqo/9Y5C7FlOuogFpzRU=;
        b=S8fkp3LcrJ6PHH2xWfvo13RqVbZ4SCldLPl8tOJb3ECMJ6Z9R9Tl3wkOOtC2AV/P1E
         dGSY7rbyyrugkQ4UHTv387wVxizprKCeKZs0iy4bQn0jmpIhgDrJuUPgVSqPhpndxSHl
         4p5TmkGceoqx4amqdt4a9YJq4oW30pXxdRBYgxShg3vpHtm9YCUOWUasA7Pou/pS/9eo
         dqas11ZKJz5demyf2jqC+flo+fFZQBOxCT2qfqMBckPHsbCrhxR5yT2CdYf1Z+A8hI6o
         V/fLOpoeeG6Kgdf0zgEltr3YLhArx+NiOvYTO1otz4x9BYtMD7nbvWVazCB87B9EE3AE
         yXcQ==
X-Gm-Message-State: AOAM532QgBPTPkpSnfn1uZBDSNIt9KkU5wCFzj5eLcmrOVIkvkvzxR6I
        F4hAKHvg82CknheN4t8odgo=
X-Google-Smtp-Source: ABdhPJyt3djyirIo9/J1qUN7JFmjH/4EU7CmlNXB6FxLmUSlEjrsw3Mgf0b+O91RQXAVrnuW+x5esw==
X-Received: by 2002:aa7:d484:: with SMTP id b4mr26269816edr.63.1616423528964;
        Mon, 22 Mar 2021 07:32:08 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id r17sm9948696ejz.109.2021.03.22.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 01/11] staging: rtl8723bs: delete extern declarations in core/rtw_ap.c
Date:   Mon, 22 Mar 2021 15:31:39 +0100
Message-Id: <e48480113c7ffc5128d867787bb3f73b3eb505ae.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

delete extern declaration in .c file (RTW_WPA_OUI) and
fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
14: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:14:
+extern unsigned char WMM_OUI[];
--
WARNING: externs should be avoided in .c files
15: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:15:
+extern unsigned char WPS_OUI[];
--
WARNING: externs should be avoided in .c files
16: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:16:
+extern unsigned char P2P_OUI[];

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index a01b68274fa0..3cd9c61eec99 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -10,11 +10,6 @@
 #include <rtw_debug.h>
 #include <asm/unaligned.h>
 
-extern unsigned char RTW_WPA_OUI[];
-extern unsigned char WMM_OUI[];
-extern unsigned char WPS_OUI[];
-extern unsigned char P2P_OUI[];
-
 void init_mlme_ap_info(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.20.1

