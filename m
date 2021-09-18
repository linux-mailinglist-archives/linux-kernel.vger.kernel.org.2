Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E575410566
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhIRJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbhIRJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A72C061757
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s24so9092415wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJYLNkpD2oLEZhMe2V2yp/Hy0smx9hVqOX2DDPaz9/M=;
        b=DC/XyPEbsDlZaFITonycHO6pphZKVYFRejc9uVaQvGrgMriMuYdVV4iJ7Ilbo/0msM
         5xBPrg7ml9tdEmcsQAuuvHCwpXsQDy+qyPnHK2l6duk1mRHilECpL+6SBODdrD6EtMFI
         qfIcVK4uh5WTs9thl5UHDfwWuLBsO/fSAYHHvWfHJXj61mGYR6N3IgbWcBU762to03yA
         +9Z4Y4wrqYSl61shWNVyxtEMzDBx/iNC8Vhkv8q61gfB3sx69xHDgLfQhHMcSzxSEtDj
         C/qtNqrhU/+RNg+Dc+IXrYHpgIPRlLyKT41pyRMH99HGJGOXtsqnaruPgRh/LpAuu9YM
         nbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJYLNkpD2oLEZhMe2V2yp/Hy0smx9hVqOX2DDPaz9/M=;
        b=mqP9gViXV7w20kgTjFN+xRPEDvjAwyssFJhELXnPNdLt66fScTMSFH9ECI8CiHx4zY
         RuA2gCV+n8XQJAQ1qjYrWQSe2k3anVBOIG9Cz1dab6OoDnI4OQn5FMI0McHzDVvH5lPC
         DS2KRzwO0dEgJne4O09sEdc7zQhzM6sLGLu9CMqU151l0NDDYWKu3rE3qBIyR2hSTGJo
         +Ig6kOuJwXFLHxWy7AHC8Smf6T2IVVFXyhW9G7O2V+7yMzE2TaLc6k6u114KUCUy7Tu/
         qK00awGOdghefMk/uoqAuheU0bFdoo6gH3WRylRyOy5LB6R+J3UuVqrRQOG/17vnKMHL
         Ooag==
X-Gm-Message-State: AOAM533+na2Mk8/Fqr6d5B4aA3aBmAlOnBe/YD4u81/9rm2yik9EnkSl
        3Pr1vRI8U8blUtI60pAh4zc=
X-Google-Smtp-Source: ABdhPJw6tAn9YmXXQsSaQ/AQQhaq1nzCQMk8BQJtjqKZ0O2NV1vJvG7m07763ft9wS7xGC9me0qMrA==
X-Received: by 2002:a7b:c107:: with SMTP id w7mr14767682wmi.91.1631957105264;
        Sat, 18 Sep 2021 02:25:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 01/12] staging: r8188eu: remove comments from odm_interface.h
Date:   Sat, 18 Sep 2021 11:24:32 +0200
Message-Id: <20210918092443.8724-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make further cleanup easier to review remove some
unnecessary comments from odm_interface.h

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/odm_interface.h   | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 95e0303c28b8..efc2ca069a3d 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -4,29 +4,11 @@
 #ifndef	__ODM_INTERFACE_H__
 #define __ODM_INTERFACE_H__
 
-/*  */
-/*  =========== Constant/Structure/Enum/... Define */
-/*  */
-
-/*  */
-/*  =========== Macro Define */
-/*  */
-
 #define _reg_all(_name)			ODM_##_name
 #define _reg_ic(_name, _ic)		ODM_##_name##_ic
 #define _bit_all(_name)			BIT_##_name
 #define _bit_ic(_name, _ic)		BIT_##_name##_ic
 
-/*  _cat: implemented by Token-Pasting Operator. */
-
-/*===================================
-
-#define ODM_REG_DIG_11N		0xC50
-#define ODM_REG_DIG_11AC	0xDDD
-
-ODM_REG(DIG,_pDM_Odm)
-=====================================*/
-
 #define _reg_11N(_name)			ODM_REG_##_name##_11N
 #define _reg_11AC(_name)		ODM_REG_##_name##_11AC
 #define _bit_11N(_name)			ODM_BIT_##_name##_11N
@@ -38,10 +20,6 @@ ODM_REG(DIG,_pDM_Odm)
 		_func##_11AC(_name)					\
 	)
 
-/*  _name: name of register or bit. */
-/*  Example: "ODM_REG(R_A_AGC_CORE1, pDM_Odm)" */
-/*         gets "ODM_R_A_AGC_CORE1" or "ODM_R_A_AGC_CORE1_8192C",
- *	   depends on SupportICType. */
 #define ODM_REG(_name, _pDM_Odm) _cat(_name, _pDM_Odm->SupportICType, _reg)
 #define ODM_BIT(_name, _pDM_Odm) _cat(_name, _pDM_Odm->SupportICType, _bit)
 
-- 
2.33.0

