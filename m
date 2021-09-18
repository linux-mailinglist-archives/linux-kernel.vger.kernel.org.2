Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C610410569
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbhIRJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbhIRJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D760C061764
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x6so19110811wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o62fR3XicmTQpyeoxj/xI/V7ktA8LxV/7f30/vkQiH0=;
        b=qSnMsioDq4Lb2uTMVPD//5zjflkgCOqUx8Hg4quPioYvLpBylNQkHpfVHhnOmplxV4
         CNTAQZpoycE8mZLZr6ZZlQwA6pwv4fXwc7dj3j91rItWTJ3B9CD1UotBcUzL2I/hln0p
         v1sIOwRrQEeyp3RI7Gtg+JqEtajmHANW43AzPeAJ0YTJDi/GrWtQuMnqJ6yC0n/T8sBq
         qUMH6mxWbn/HviiCOR47InU/6ekjLDJjD5DTPQ20Olt8SGnntM+x3tI5YHmiIreZVST9
         c8H6A5uZOvPM1mFgm5brOA1p9rqzPgkRFH2vwYzedGuxrCBBol5p/Pc89v+6LTdvIIaE
         DTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o62fR3XicmTQpyeoxj/xI/V7ktA8LxV/7f30/vkQiH0=;
        b=Zx1LBSEkGWnUiPBLecDbnO7ymEBNPwdZCTdutgXjGH4bN2iYxZM602mpEGUx7NMkv6
         TxkWUvyj2Es4bx0yh24IE9REwTMzUtaEjWlzEaet6jxRJHfmSINyJp6BG6LbeMglYWg/
         0T8HbCYDFbW+YS+E7Wyc0iVR94ho/D7NIl63Go2RUMMSeT2YxI4A8DffDz5+JkNmnkDy
         kbGamaaM+sRhWrDsqkee1Z3olphOMVD4Av8A9Hm9650QqLHD/jXEU0ZxBPypxKXzFwSg
         yoDqJpbNLBTvYSQwNPA3Fl2cwJfd7GX8CkzSu/RKVVL+HhokVR1q69Tepfdti/nc4an4
         8d1Q==
X-Gm-Message-State: AOAM531ow7BbDbONc6qH5P/t0A7bTdeuf25c3fewZ9FMaG/AHfCR7Png
        Vh2wVb3dR5JQ8f5b1MO8fd0=
X-Google-Smtp-Source: ABdhPJwWhp9wEkEI6v8ORTthLI0ZVRN/xx9CJOvsSiO+hLPnfE7il60MOKvyl+iJBuFoo/7DfIckzQ==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr16773864wro.401.1631957106925;
        Sat, 18 Sep 2021 02:25:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 03/12] staging: r8188eu: remove _ic_type from macro _cat in odm_interface.h
Date:   Sat, 18 Sep 2021 11:24:34 +0200
Message-Id: <20210918092443.8724-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

((_ic_type) & ODM_IC_11N_SERIES) is always true since SupportICType
is ODM_RTL8188E in this driver. Remove it from the _cat macro.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm_interface.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index d3e46b2a4cea..4f35dcd0bf49 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -5,18 +5,12 @@
 #define __ODM_INTERFACE_H__
 
 #define _reg_11N(_name)			ODM_REG_##_name##_11N
-#define _reg_11AC(_name)		ODM_REG_##_name##_11AC
 #define _bit_11N(_name)			ODM_BIT_##_name##_11N
-#define _bit_11AC(_name)		ODM_BIT_##_name##_11AC
 
-#define _cat(_name, _ic_type, _func)					\
-	(								\
-		((_ic_type) & ODM_IC_11N_SERIES) ? _func##_11N(_name) :	\
-		_func##_11AC(_name)					\
-	)
+#define _cat(_name, _func)	(_func##_11N(_name))
 
-#define ODM_REG(_name, _pDM_Odm) _cat(_name, _pDM_Odm->SupportICType, _reg)
-#define ODM_BIT(_name, _pDM_Odm) _cat(_name, _pDM_Odm->SupportICType, _bit)
+#define ODM_REG(_name, _pDM_Odm) _cat(_name, _reg)
+#define ODM_BIT(_name, _pDM_Odm) _cat(_name, _bit)
 
 enum odm_h2c_cmd {
 	ODM_H2C_RSSI_REPORT = 0,
-- 
2.33.0

