Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE23335CFE8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbhDLR7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbhDLR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:59:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6EBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:59:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g5so15041077ejx.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HM2+WjgVNp2s8oN3ygCDI5DayIVOUQDYvbW2EA6ryRo=;
        b=esLCFcZrPotVd1SoNfCXRoUwMhDLsk6XhgI8BfkxHlgIvZeIIFkMHm9MPiXdRk0ry4
         nUFxIk6MY43ZYqQ5VW3i05wa3dwgYOCVMl6kY0eTIkgojR/K43RpThyUbw8nT1rftzA2
         gHcn6X6Otvs0JDBuJLua8pgrUMuzG8TotjJxLojFmTr5A5nOpVr6KuPp0jmOYQAerHGn
         iRrHqwR77c6iTe+q/4e33w3Al2u2OCWsR3P9U5/hnjioM88JZLiGvswEHFyHnKxJeFOJ
         5lIX3dnlK4tGn0R1nOPZHst7nWwskGtTBA0L9en0Aej80nTKuV1FRmWfxMJchGxGuEAY
         qdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HM2+WjgVNp2s8oN3ygCDI5DayIVOUQDYvbW2EA6ryRo=;
        b=n3TbwAHp8E9bsHO8x/jeH2Eo285M2O6WQMP9W4iUKcTiDk26rlTOfu2kDKpNhV1dMn
         kL6bolCUn7V9u2Pj6Vp0oygIy+MpwihDIiZr5lRk1BsKF4zhgBrI2gOqh/96j9VPMD/W
         lBTgtpkCpLwBJfNB3ztRF2YcXxolVRKZGxFQvHSyKpLTk8z/ZxKE9NlZJp6gCa5OIEsz
         iWfL/Y4Enk4S8/WDbT0tM7PsYtpp4qL/ab0wfJhDQLLtT97DAdkXHABXgBskxrFFcFjD
         9nbPkZHPn/IEg7J724TYumk/LHdf9ceQFKvcfgd+mOR8JdDVsZPknACCO9KMVLDw1TUX
         dmDQ==
X-Gm-Message-State: AOAM530tFRwdL4b1AlIFHNXMEwt/GuuImVIhxr+SqmoF3aHUQkr0o+Lv
        eklQ4wUN0bkQWFC+1X3KcR4=
X-Google-Smtp-Source: ABdhPJxKCII/8OLgPgV63ZFXMbCuIQXJWPa5bsJ+xqVKWuBqOmiPS2NU7xTmEcw13DHeb+lDs/fZsw==
X-Received: by 2002:a17:906:6a94:: with SMTP id p20mr28753434ejr.68.1618250352838;
        Mon, 12 Apr 2021 10:59:12 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gz20sm6300534ejc.25.2021.04.12.10.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:59:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH 2/2] staging: rtl8723bs: hal: Remove multiple blank lines
Date:   Mon, 12 Apr 2021 19:59:03 +0200
Message-Id: <20210412175903.17819-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412175903.17819-1-fmdefrancesco@gmail.com>
References: <20210412175903.17819-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary multiple blank lines. Issue detected by
checkpatch.pl.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
index 1ff2043fb2e2..4a91913e20bf 100644
--- a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
+++ b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
@@ -19,12 +19,9 @@
 #ifndef __INC_HAL8723BREG_H
 #define __INC_HAL8723BREG_H
 
-
-
 /*  */
 /*  */
 /*  */
-
 /*  */
 /*  */
 /*	0x0000h ~ 0x00FFh	System Configuration */
@@ -142,7 +139,6 @@
 #define REG_RQPN_NPQ_8723B			0x0214
 #define REG_DWBCN1_CTRL_8723B			0x0228
 
-
 /*  */
 /*  */
 /*	0x0280h ~ 0x02FFh	RXDMA Configuration */
@@ -158,7 +154,6 @@
 #define REG_RSVD5_8723B					0x02F0
 #define REG_RSVD6_8723B					0x02F4
 
-
 /*  */
 /*  */
 /*	0x0300h ~ 0x03FFh	PCIe */
@@ -355,7 +350,6 @@
 #define REG_BFMEE_SEL_8723B		0x0714
 #define REG_SND_PTCL_CTRL_8723B		0x0718
 
-
 /*	Redifine 8192C register definition for compatibility */
 
 /*	TODO: use these definition when using REG_xxx naming rule. */
@@ -365,7 +359,6 @@
 #define	MSR_8723B		(REG_CR_8723B + 2)	/*  Media Status register */
 #define	ISR_8723B		REG_HISR0_8723B
 #define	TSFR_8723B		REG_TSFTR_8723B		/*  Timing Sync Function Timer Register. */
-
 #define PBP_8723B		REG_PBP_8723B
 
 /*  Redifine MACID register, to compatible prior ICs. */
-- 
2.31.1

