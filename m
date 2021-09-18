Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B378841080D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhIRSUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhIRSUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q3so43091299edt.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJYLNkpD2oLEZhMe2V2yp/Hy0smx9hVqOX2DDPaz9/M=;
        b=Zu1F/9KPQO6iVaNc7qE2g6Prmdy0VEzN/wwGVcYBgpCSLO/ET7oX8fuhptmi25L4hi
         /mqY+JE5iMl+XVoNI1jyKnZaZJEsJ0bfE3GgyGG9zFhac01OfE99J1Vk/caiqrv5LqeO
         ZIke6hFyetIxoo8/n1HsuKHUxQm8GCfLnSsziZbzeVDki9jFXLMS0Z+JU8/JcgathYfw
         1RLpVKak0FCBAmdZL75b/LzhJ6c1sjBxLY0yMeIytBzczz8JJrc5qA1KYjbJjbFsPK2+
         hPLIf3Ml0xg8d+PyYagyNrI4rzxlh7QvHI29oLSuN5Ede2Hkzkl3GcliIGeca7KVORGw
         GtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJYLNkpD2oLEZhMe2V2yp/Hy0smx9hVqOX2DDPaz9/M=;
        b=1Qch/FV+hk0YF4n6k8oTptRXvd78xGvtKcAmEgQwkNScUubYLQ1QFaYk+Ej1M36qz7
         YjChlxmlCsEcDS9ynqjONqcTkAVPtIyFL0QhIOdCg3MwtQga4un2dX8+ElEVpbnTmf2j
         4D+0LguqCP7zhmOpjhiQWZwSpKV9ofdxBsFSS+mV07UMaLzDhWRYLw9ukg/81ddWwJMY
         QD6Njt2hHtJxoOznsibhQ8BHOy8Mt2cqvxiDDrcRZWIaxuzuE/44/F+kCfrU4PTK0s4E
         W+m2jnobjkNGVHwySVRZvUTZEZNlIdpPHwWI69HNUPb7dniI3VAZ2iDb/79+AVPfvHOD
         xsIw==
X-Gm-Message-State: AOAM5320EXTZfOHkMiI20lu2CJo67EcKOHWJztZ4rvu5vwZ4ZKekrKR0
        bzAbFO9m013MF6XkigUA4vQ=
X-Google-Smtp-Source: ABdhPJwZ3yqaHWPhLVyp45xu3u9JxTg2fI6/wMCBsEMxC61aotAF35fyE6isLIJxjptBCQTl/FtULQ==
X-Received: by 2002:a17:906:31ca:: with SMTP id f10mr18778972ejf.73.1631989158388;
        Sat, 18 Sep 2021 11:19:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 01/14] staging: r8188eu: remove comments from odm_interface.h
Date:   Sat, 18 Sep 2021 20:18:51 +0200
Message-Id: <20210918181904.12000-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
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

