Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C53409CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbhIMTWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbhIMTW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:22:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993FFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:21:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x6so16312943wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ow2AcbCkht59g9jmVFoN/IDYWnYCxeClWzmZryCz84=;
        b=X55IDDLK/NjA0sMIr2pipRl4xkVu1h/JiKRmPQkJnNGR+mrnaTeDfSmITZDqZWteBg
         LoEqmzjoSPtYG0ZS2VcD21Tz7m56d3z7E1XhfRqCIo8knHu/hkm7rkaP0x0HzqKf2Zca
         hEwyilh7Bl9RimgmLS9d0HDuluduAYDJiG2T7M+S8JXoyInvWXdT5NKoPbnHDbr2C9nw
         V98h7UGnkiH5qiFcNlw/tFlHO91Zo7FJ21W7lo/Ho8YPX+DcpoezLtFMVtLc2He2Ys8K
         uV5zQpelCu5Le7vmjEByBWuZumx7A6WshZNdcgb8aJefFwWK7dQq5ffAI6s96MCGcq99
         DCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ow2AcbCkht59g9jmVFoN/IDYWnYCxeClWzmZryCz84=;
        b=J6bsoS11UydVesPD5/ernUK7msxKmnkZT6I9/ild3zckeVrIU0XYvxbpV4YNRJ+mji
         WtDXoMwClJ9+W6RKGw4z0OJ8cHskKEQZzW3uwA/qeBUR5cFedkUc2uEWV5KuxG304GER
         nEi+q5h8O0W5E3yLrznASbMaUKXR8bGJ/OvMSQOgk6hUkgrFEFTd112D2mBEmS0Fsez6
         j4D8OKRjdqnk9J80TiOFK9m5VGUCRSQY7sfnoE+zTEy0FuUk2ABu4vtjK60qVvl5APBU
         Of2DPsErzHRI2SYAdfbFReLvJ8W6kQsvHUTFrD0nP2U2DkiztaphnTYvtuL5WCWoA2Di
         PYag==
X-Gm-Message-State: AOAM532jvn9jS0ULYX99yk5oCdpeVXMFQPDQ9dYK4Cl2SmEQta8tSElm
        Fft+6fR1TZYlNti9Tfhy0Jo=
X-Google-Smtp-Source: ABdhPJwlKes/TevbRVdiwijg0MDLPWsePyRC4Dfi+Ar/8PoFBriXTJ4PG/6/iO4DVe1NsNMsxMzQqQ==
X-Received: by 2002:adf:e649:: with SMTP id b9mr14684696wrn.309.1631560871249;
        Mon, 13 Sep 2021 12:21:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id m2sm475021wmm.3.2021.09.13.12.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:21:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: remove unused defines from odm_types.h
Date:   Mon, 13 Sep 2021 21:20:42 +0200
Message-Id: <20210913192043.26527-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913192043.26527-1-straube.linux@gmail.com>
References: <20210913192043.26527-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused defines from odm_types.h. This compiles without
introducing any new warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm_types.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
index ecb2bef38351..b8a8465f08f9 100644
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ b/drivers/staging/r8188eu/include/odm_types.h
@@ -12,10 +12,6 @@
 #define	ODM_CE			0x04	/* BIT(2) */
 #define	ODM_MP			0x08	/* BIT(3) */
 
-#define		RT_PCI_INTERFACE				1
-#define		RT_USB_INTERFACE				2
-#define		RT_SDIO_INTERFACE				3
-
 enum HAL_STATUS {
 	HAL_STATUS_SUCCESS,
 	HAL_STATUS_FAILURE,
@@ -23,8 +19,6 @@ enum HAL_STATUS {
 
 #include "basic_types.h"
 
-#define DEV_BUS_TYPE	RT_USB_INTERFACE
-
 #define SET_TX_DESC_ANTSEL_A_88E(__ptxdesc, __value)			\
 	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(24))
 #define SET_TX_DESC_ANTSEL_B_88E(__ptxdesc, __value)			\
@@ -32,10 +26,4 @@ enum HAL_STATUS {
 #define SET_TX_DESC_ANTSEL_C_88E(__ptxdesc, __value)			\
 	le32p_replace_bits((__le32 *)(__ptxdesc + 28), __value, BIT(29))
 
-/* define useless flag to avoid compile warning */
-#define	USE_WORKITEM			0
-#define		FOR_BRAZIL_PRETEST	0
-#define	BT_30_SUPPORT			0
-#define   FPGA_TWO_MAC_VERIFICATION	0
-
 #endif /*  __ODM_TYPES_H__ */
-- 
2.33.0

