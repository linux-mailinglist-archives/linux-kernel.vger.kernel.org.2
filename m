Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D62B4101B9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbhIQXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbhIQXca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ACBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so4752923wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o62fR3XicmTQpyeoxj/xI/V7ktA8LxV/7f30/vkQiH0=;
        b=oSwabKuWSy4y7DFcShF6YMBpgJOZ8Mh/YPAUkSK5OrQDETRSoMs10VohCfH1m111lE
         Y9kecgdOKIpD0h2ypZRWKUS2CfxV/wAnePBoHcvHiOiPbzuGxtATSPtSlrQLE9jMYeaU
         XAiJi4Dh0N32B6rxMcRdS5wHFHJw+UIgauF2oVuMEpxXqwTqLsKKqv8o2cGw+HjJHDRr
         BAxBITUGKBLYA+nIxCjOO0NYtFfji6abxTiC2k+D1dMvlRJiOQOufvOX8C1RoYO02SQI
         gDAV00c6pjvQ3w12zoVzb2HUHrFeGj0JzfWVpwa0hoohgU60+qii3qGlb+N4DAnk/a1W
         i7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o62fR3XicmTQpyeoxj/xI/V7ktA8LxV/7f30/vkQiH0=;
        b=t+DfY1e5xNgGiC2Idy2MlN5goe0wsE4yKAcJ7gtjxwUWY2aQLtRq+/ohA1fNqnhiVo
         n5jN3Irx7tyLyHBJ7PhEEeVJHDmkEjRQp61/c+jwsBTadA6E8jB8SwA6g6Pmlrdrsdv9
         3s9zwxVHwZNGxpne+WmutghTz8qTDa6YSALfdSRUm4Gh9ClpGXhoJxlFzymAhDgaY7IP
         1e4WWkPO+W+kTBMxbndpBi1J1nJbrOTP3MPsuqrf9YD1DeCwotQTDRsH0m/WoY+nHf1s
         8gNHIaxaBNud4Pl3GaFbum70TYoWGVKoBrKPv9eJfas1PLqPcTxAuzzkubUYmNf5xx1B
         9N9w==
X-Gm-Message-State: AOAM531j7U7rrHmnyOfdGposb6bjlf9zdk75UKy0zSgfJ78xih7d+mrV
        S9Z+QIXQQYn4wNBih/4leWs=
X-Google-Smtp-Source: ABdhPJxfnABk/yJnCwABRP7z/GDutthczw0QUfKNbYxwWLz3Kil9lM8MoEm8f4JE/R2Maj13wpIttA==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr12556805wmc.152.1631921466205;
        Fri, 17 Sep 2021 16:31:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/12] staging: r8188eu: remove _ic_type from macro _cat in odm_interface.h
Date:   Sat, 18 Sep 2021 01:30:39 +0200
Message-Id: <20210917233048.31677-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
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

