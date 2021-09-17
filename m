Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66174101B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbhIQXci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbhIQXc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78332C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i3so8487723wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJYLNkpD2oLEZhMe2V2yp/Hy0smx9hVqOX2DDPaz9/M=;
        b=Nr89vy4VVUGaRvRA7xPdfu57yUCn2i+1LztVdlBsXeHUB4d5tz7VPPHOIUXorKWRtZ
         xL1mg8f1fLpcqs0WSKVD93U/n8wLEdsGskfzTT6Ia8dHH8PNJLO9483pRy/SQqUVDzwm
         /ZCdHrVHlIfX9Y0Cz+WwuVERjsnWMIS2lDp8y34CB7bh4+oZ3CGGhG67m8Dmqa5f2Bvo
         dErD0N2m8Nn3z6L+K8nGy4uSe509Cru+jhVpwok7klaMNnp2M+zmuoLAOrzJw+ABkKmI
         Up9CKoTsFkKjpzk5iy0zI48aTLd584MPX88Vu2C8If3ueH/dQHKwLyKbg9tQjLyoPa3l
         eD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJYLNkpD2oLEZhMe2V2yp/Hy0smx9hVqOX2DDPaz9/M=;
        b=qznhpSPhkr6SBVN1vHOY4U/50ZaCSyPN5eDZIz0DTur9JNQZbnyWz0f25HvrPczG6N
         z6VyJvmkRNfSwyOkFa/+HmQHtXpCnd1U2K9YpoL7Hv1+VmtXFr+2ZY7S388VE1pK8PEX
         9pKA/8h5mfnMxyEwV/nQO5oLV6Auub5HuE0adMJInWCVLs8rVLd11DC1b7VIb/ggLFIR
         d7ei6IHMwjaVb2g9J3wNaT2hLI20zWUQkPXJZkiBv3UkKAlaQk888QX2Nk2Bhfly/dVY
         DY6MdNtySup+KmxxQnZ+CwCh+f4bBFUpsnNgcpdqoyDNWczzFur7Jv58maK165iqb0xT
         MNYA==
X-Gm-Message-State: AOAM530B3QHV+a5tJVGK4huE7d4h6H2nflfzGyODdaaMoVcim0JC8VTA
        6AxetpdafGssQuIDRChPjyiklyPvkXNskQ==
X-Google-Smtp-Source: ABdhPJzEX0DxiPbvhQLtXam9pCiDOYNJcBcBubTKJI0CbpY5VkItxTWKW7vyYoeercC52FTEqkIN0g==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr528272wme.3.1631921462086;
        Fri, 17 Sep 2021 16:31:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/12] staging: r8188eu: remove comments from odm_interface.h
Date:   Sat, 18 Sep 2021 01:30:37 +0200
Message-Id: <20210917233048.31677-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
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

