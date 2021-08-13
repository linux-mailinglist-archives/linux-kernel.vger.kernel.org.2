Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B33EB188
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbhHMHcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbhHMHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:32:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x10so5668529wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8i1jhWaEERiSPVp0HX2ctGAQkaxzUOwrA8rdOg+vKg=;
        b=F6qOLbRj9WyHGpa52KZo62Vu6z9OiM/m1oOdQXTHp7z1Pf5OxAymDUva8xjGXdgQ2k
         7IuAhD+8CALExsJiMSg1QTA/aYJUg3iDG9ipmyQZEmiyumvtWqlj5eDmWq/d8uTcB1fY
         IRA42b8naLx2U54bDIr+nps3yGhZ/FqcSfQYWGedRWDupMGOHTBfDPyPb9E1eQ9wa5MU
         2xm489nNIwoCk2GDmAoilxvThuM0avDxUjR4UbrD8NaQOY976IvLH7NWJ6t28ejXclBA
         PCdOTzfKa+iSOs67xowiqjXVhv4kSRe5HGnePh/78J2rEXD7KqqeIBP5+qdso5EB2vCa
         KwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8i1jhWaEERiSPVp0HX2ctGAQkaxzUOwrA8rdOg+vKg=;
        b=O8Pq8eC2vYunAR8jKrljFKsC4+4NrbD90hfdcTZRodc93e31vacTHrTUngKkVd91si
         0sVbAcMOXhQOFTWvvs1wkS5xed6mjP2s/90HdmP1LZgyW7TZ0Gk4RPSSbSYtXC2MdKy1
         rxEf4Ad0Yd946pZvetEO4kpVSlu2ZyiMUAYvAFyI3Iy1U2gwB9BhsDXUloYqqKhfQtC1
         pULD++b5E3mnaVNNJ3qb5lp0Mk6HBPCQ65u4iI00GN1Ty906P7KgGuOI1p6o2a7gzC7I
         v5UokTYQ+sK5VElbritLUYWmjmjPboihuim40EObdYst6xZ4uI3FclAP7499i58njBQs
         2Lxw==
X-Gm-Message-State: AOAM532ZP++/wJp6iVhEChBxbWBh+ms/JvskwM8u9AoLyutNhnTXAc0h
        zjaVaP9/1WIf0vPrm9LVY88=
X-Google-Smtp-Source: ABdhPJxV/FaVQh5PnEWjeNTt0dOCS2MIH9iezlZ7ue/GB4e6+sAe11NRVFcMSBFQo/ENtkLyG2rDbA==
X-Received: by 2002:adf:e0c4:: with SMTP id m4mr1411921wri.312.1628839922936;
        Fri, 13 Aug 2021 00:32:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id k12sm697406wrd.75.2021.08.13.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 00:32:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: rename Hal_GetChnlGroup88E()
Date:   Fri, 13 Aug 2021 09:31:09 +0200
Message-Id: <20210813073109.25609-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813073109.25609-1-straube.linux@gmail.com>
References: <20210813073109.25609-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename Hal_GetChnlGroup88E() to avoid camel case.
HalGetChnlGroup88E -> hal_get_chnl_group_88e

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 07ba5f0eecc2..24a82fc41872 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -2060,7 +2060,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 	}
 }
 
-static void Hal_GetChnlGroup88E(u8 chnl, u8 *group)
+static void hal_get_chnl_group_88e(u8 chnl, u8 *group)
 {
 	if (chnl < 3)			/*  Channel 1-2 */
 		*group = 0;
@@ -2114,7 +2114,7 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 
 	for (rfPath = 0; rfPath < pHalData->NumTotalRFPath; rfPath++) {
 		for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
-			Hal_GetChnlGroup88E(ch, &group);
+			hal_get_chnl_group_88e(ch, &group);
 
 			pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
 			if (ch == 14)
-- 
2.32.0

