Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AE3E3475
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhHGJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhHGJsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C1DC061799
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so7758063wmg.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGCbtWJwEXecjRjLaPtZhLsCu+HFDEnINtH2kvAnhVE=;
        b=FKe4uxsvid8xtzoj8wDq6OJpjHXt0CXt/GnLZpC1ftpWLuhJvH6f5OM7FhM1lEZSqU
         RTA9cHowyY+e5l+9y8+MNpSMI9189fYsoazk21Ve3dyLOSEJyUkGWB2jZadRPuZdl50l
         ns+RtcPJ3G9DPLasyORz8VqyDbWlD+9DPZF7H1ecVGcAk4R/kxk7/SMrC/4LFcv0AHzn
         Vj5M+sHigaEsczeXaHgElUd8ciWBEK3RXVWQPMYTkhMMfD+3t+I1MN7H/O6XZCb/ylgE
         JMD3DGsBG38UZaWQmGgYXd5VcCjPZTUXCYuXfbBECPMEvrmivAM9BSj9evZdKh4VxOhi
         qd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGCbtWJwEXecjRjLaPtZhLsCu+HFDEnINtH2kvAnhVE=;
        b=b9wqMMgIsh961IQlCcoIyZejBadqLA+UUBPaJxvUTL1ioW+AZBJGWyujvhK7CPnBA1
         svj+TrFwQW8GJrpG3E+MaUdbdMNANHXO7VHWA7PBKXv9/aeIApEHmnBr9QLRc1Gh5WUW
         nNtU56Yj2mJal8rWgBCtyfciGfI7Ww4Gv7S+F6/FQjWqOcErLBzJQyVy+llE7EULvBeT
         HNkKww5WWpaLRKOMPyHR1qnQNCjAkfO2Z5tTWwLtA96w1ldQf5Ijd7Z/MBU5Zcse32be
         jR6vnWvq7KEgHZLrZfqrcKFHYWEa8drCmkVOfmCCReEGKQ10mbpEJffdmXBMm0QA6T1D
         iZWg==
X-Gm-Message-State: AOAM5322lfyW8PqfvkPdu2v/E1jTMdlddhi53OILbGr9RjeVwhbagKuk
        exgVVLUQIn3BYP+C9vSJDwehSm3njqc=
X-Google-Smtp-Source: ABdhPJx6mljV/Z1u0kkkkbqZE7RklJySLxS/XXTekphVik8ppjS7+l3gVeZqat48uBbVI6ohxsZaSw==
X-Received: by 2002:a1c:7f50:: with SMTP id a77mr7215967wmd.163.1628329708605;
        Sat, 07 Aug 2021 02:48:28 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id w5sm14383755wro.45.2021.08.07.02.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/21] staging: rtl8723bs: remove unused macros
Date:   Sat,  7 Aug 2021 11:48:02 +0200
Message-Id: <00575e78b23e36edb3a7e404e26a3c5e84394f3d.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros in hal/odm_HWConfig.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
index 2e10974ffef1..0c3697c38e64 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
@@ -9,23 +9,6 @@
 #ifndef __HALHWOUTSRC_H__
 #define __HALHWOUTSRC_H__
 
-
-/*--------------------------Define -------------------------------------------*/
-/* define READ_NEXT_PAIR(v1, v2, i) do { i += 2; v1 = Array[i]; v2 = Array[i+1]; } while (0) */
-#define AGC_DIFF_CONFIG_MP(ic, band) (ODM_ReadAndConfig_MP_##ic##_AGC_TAB_DIFF(pDM_Odm, Array_MP_##ic##_AGC_TAB_DIFF_##band, \
-	sizeof(Array_MP_##ic##_AGC_TAB_DIFF_##band)/sizeof(u32)))
-#define AGC_DIFF_CONFIG_TC(ic, band) (ODM_ReadAndConfig_TC_##ic##_AGC_TAB_DIFF(pDM_Odm, Array_TC_##ic##_AGC_TAB_DIFF_##band, \
-	sizeof(Array_TC_##ic##_AGC_TAB_DIFF_##band)/sizeof(u32)))
-
-#define AGC_DIFF_CONFIG(ic, band)\
-	do {\
-		if (pDM_Odm->bIsMPChip)\
-			AGC_DIFF_CONFIG_MP(ic, band);\
-		else\
-			AGC_DIFF_CONFIG_TC(ic, band);\
-	} while (0)
-
-
 /*  */
 /*  structure and define */
 /*  */
-- 
2.20.1

