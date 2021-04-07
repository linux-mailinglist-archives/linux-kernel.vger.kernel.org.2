Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03703568E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350672AbhDGKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhDGKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:04:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D880AC0613E4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 03:04:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h10so20075176edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44ZqeD5EPkyiyFJAkLWDYZXBNtCAIXuuyBZhNmXgs0M=;
        b=u/qSxrao7mOSvvfEmGSW2fzH0XEfHO8maFw5c9HCl34YysuTze6lqPLTjRnRTvJ3me
         RfeTYTn0WukHHg9JeTEtw6cCmzAfr+l2qh9Q5siNCsPO5I5r0GHTPXtZvqLNQmU6L1d1
         wKJV/ADf9TZ28i+Y8tdjLy68CMO3m3/WgOK/kh0MtfBUwbHAjHC94ZtH325G3FzYiMO5
         cXRJ+UeqwkTirPwow9jl4Jp8tiM45Ow24x3s+5tsur1cXD+1HXlnsayU50aAWNDX0+OV
         LsYOYcQzPL0//hgaTNPNA4xDXIr9OXhDzqwMppSwnLF8SByTteK6Kq1UWvHjSLtyMuOr
         b3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44ZqeD5EPkyiyFJAkLWDYZXBNtCAIXuuyBZhNmXgs0M=;
        b=ltRA43c0ZBaA5u5dQ8rkbk5+CdPXuf8ajOIW5wXKiOzj5prr0+LBV0SQS6MIkIeT94
         IWVTATk53KNbRq4A3Tz0Yx9CTk8Bmje7d34u2PDPLurZerZS9q4ltXAVFBLm1d9rTU+N
         tiV3ONdodnOl1usPG8DOHUcf7+YWCql5WcvP59njnG+HC78LJRAhQX+M6GniodHR8ixI
         NCB5hI9l5j7a+EKSEqGGbu3ueefTeNY9uvUR+vc9MZtBRuF1JFHVcHOtsv852IndmcC4
         0QvyzZLWqBbvTykaQqZvMZ7kHW6/Raql/g8eqs298+6APHcDpt45u80z7wS8TWNvnOUd
         poHQ==
X-Gm-Message-State: AOAM532Sf531abkaxK8YeuIQgg8OgAxj2QaUXxLmesK6CbyiMQ1f/y+K
        iRgokk+oN6T2pv4kgPImr7I=
X-Google-Smtp-Source: ABdhPJwTPdIlhDnf3qWqbIT1K3D1vTVfwJAOzx9LyF4DagVoXaJs33p7OdefzswJ1sNPCSoEIOJ1Qg==
X-Received: by 2002:a05:6402:b26:: with SMTP id bo6mr3559011edb.162.1617789854662;
        Wed, 07 Apr 2021 03:04:14 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id g22sm12427533ejm.69.2021.04.07.03.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:04:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v4] staging: rtl8723bs: hal: Remove camelcase
Date:   Wed,  7 Apr 2021 12:04:10 +0200
Message-Id: <20210407100410.8058-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove camelcase. Issue detected by checkpatch.pl. The symbols aren't
used in other files, so this change doesn't break the driver's code.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes since v3: the previous patch cannot anymore be applied to the current
staging-testing.
Changes since v2: forgot to cc some recipients (again); no changes to
the code.
Changes since v1: forgot to cc some recipients; no changes to the code.

 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
index b9aca99478db..616d20106392 100644
--- a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
+++ b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
@@ -112,7 +112,7 @@
 #define REG_RSVD3_8723B					0x0168
 #define REG_C2HEVT_MSG_NORMAL_8723B	0x01A0
 #define REG_C2HEVT_CMD_SEQ_88XX		0x01A1
-#define REG_C2hEVT_CMD_CONTENT_88XX	0x01A2
+#define REG_C2HEVT_CMD_CONTENT_88XX	0x01A2
 #define REG_C2HEVT_CMD_LEN_88XX		0x01AE
 #define REG_C2HEVT_CLEAR_8723B			0x01AF
 #define REG_MCUTST_1_8723B				0x01C0
@@ -429,13 +429,13 @@
 #define	IMR_RXFOVW_8723B		BIT8	/*  Receive FIFO Overflow */
 
 /* 2 ACMHWCTRL 0x05C0 */
-#define	AcmHw_HwEn_8723B		BIT(0)
-#define	AcmHw_VoqEn_8723B		BIT(1)
-#define	AcmHw_ViqEn_8723B		BIT(2)
-#define	AcmHw_BeqEn_8723B		BIT(3)
-#define	AcmHw_VoqStatus_8723B		BIT(5)
-#define	AcmHw_ViqStatus_8723B		BIT(6)
-#define	AcmHw_BeqStatus_8723B		BIT(7)
+#define	ACMHW_HWEN_8723B		BIT(0)
+#define	ACMHW_VOQEN_8723B		BIT(1)
+#define	ACMHW_VIQEN_8723B		BIT(2)
+#define	ACMHW_BEQEN_8723B		BIT(3)
+#define	ACMHW_VOQSTATUS_8723B		BIT(5)
+#define	ACMHW_VIQSTATUS_8723B		BIT(6)
+#define	ACMHW_BEQSTATUS_8723B		BIT(7)
 
 /*        8195 (RCR) Receive Configuration Register	(Offset 0x608, 32 bits) */
 #define	RCR_TCPOFLD_EN			BIT25	/*  Enable TCP checksum offload */
-- 
2.30.2

