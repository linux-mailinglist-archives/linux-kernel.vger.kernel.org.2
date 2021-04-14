Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A005635FA84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349415AbhDNSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351782AbhDNSMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C53C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m3so24831375edv.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQhkdC5CcQ7hQ6cBneOuG1liDEe+YJ+J8dvyHLF5dQw=;
        b=mR6t8UHKLVP42ZJn6SFG3sm1kn5Rwyjt5lPaPRqT2ZXO/xfE2GgUSEbQmRAFNiC35K
         qk7P2uQEsjrQS4/4ebnYHevlzgyKDHK+XLsRyOhlJecxnCpaw4TezJnGjDZGLpq/qZMK
         Le2KoLHa0VdldVwYCFwjA5yoKL7f0ZoxI8Bo0XmGaJz+GutENynCRdDQHbqMzoV5WXVX
         oB22pjpVTXUbC4FMI0xDnASVpaVy7qfwyBZg6FvA39qjYHuJ8Tr3EIDh2vj9Seb7bUCb
         3LWEFVF2ew8M4lJrrTjZiS43sHcaf9TWwBQVRXUPn53aH1p6B8VYNhQYzv4l6Rdgu5bj
         Xowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQhkdC5CcQ7hQ6cBneOuG1liDEe+YJ+J8dvyHLF5dQw=;
        b=Mo1VEzVPUdfRrRoAmV+CTOdh2vqoRI7Pc/Tv+y3fTf7ccni4AL73fWob2XUpxrhqM8
         nEy54a0gUz0+nicH62HzXpiKaW9lWhqAfL7tD7C1J+Uhm7rMGql8I+UeDkGFPk6X3SdB
         HOFyAVg8kqAaibv08qRk+xXkWsFGH7DyuexKd0mUCUs8X9gy8Wx/I+n+F/fgLgW7fu1U
         +ovFo1c5rZx7+l5jD2LvY3Apy6n1//5hhJDsLYoAOaclgcX+4iG3iNq2GjvibXU6bcrf
         xxBwHdAuMWfpRYlnxX5beZHYzytiY1/lCIXEVHg2fToJ+sSrpoQ9vr7lLHPEdB2ug1KP
         xNZg==
X-Gm-Message-State: AOAM530O4kYhORqTYrR8KCA8pdHFJH39BGl4dpNM7o9+kc5WaNb716Cf
        iKXcB3mwCkSQ/0FrcOasHDTDcQ==
X-Google-Smtp-Source: ABdhPJzTquNRTvyY8sV9bktbH6k2T3AmlnXbtNtQ8FWuSGH2EdZoywSNy+4Dt4LBZU2ocxi9lxqFcw==
X-Received: by 2002:a05:6402:150e:: with SMTP id f14mr175353edw.63.1618423918607;
        Wed, 14 Apr 2021 11:11:58 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 23/57] staging: ks7010: ks_hostif: Remove a bunch of unused variables
Date:   Wed, 14 Apr 2021 19:10:55 +0100
Message-Id: <20210414181129.1628598-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments to preserve documentation.

Fixes the following W=1 kernel build warning(s):

 drivers/staging/ks7010/ks_hostif.c: In function ‘hostif_mib_get_confirm’:
 drivers/staging/ks7010/ks_hostif.c:528:6: warning: variable ‘mib_val_type’ set but not used [-Wunused-but-set-variable]
 drivers/staging/ks7010/ks_hostif.c:527:6: warning: variable ‘mib_val_size’ set but not used [-Wunused-but-set-variable]
 drivers/staging/ks7010/ks_hostif.c: In function ‘hostif_infrastructure_set_confirm’:
 drivers/staging/ks7010/ks_hostif.c:849:6: warning: variable ‘result_code’ set but not used [-Wunused-but-set-variable]
 drivers/staging/ks7010/ks_hostif.c: In function ‘hostif_phy_information_confirm’:
 drivers/staging/ks7010/ks_hostif.c:929:19: warning: variable ‘noise’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/ks7010/ks_hostif.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 8bc3b7d8d3d5e..eaa70893224a1 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -524,13 +524,11 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
 	struct net_device *dev = priv->net_dev;
 	u32 mib_status;
 	u32 mib_attribute;
-	u16 mib_val_size;
-	u16 mib_val_type;
 
 	mib_status = get_dword(priv);
 	mib_attribute = get_dword(priv);
-	mib_val_size = get_word(priv);
-	mib_val_type = get_word(priv);
+	get_word(priv); /* mib_val_size */
+	get_word(priv); /* mib_val_type */
 
 	if (mib_status) {
 		netdev_err(priv->net_dev, "attribute=%08X, status=%08X\n",
@@ -846,9 +844,7 @@ void hostif_ps_adhoc_set_confirm(struct ks_wlan_private *priv)
 static
 void hostif_infrastructure_set_confirm(struct ks_wlan_private *priv)
 {
-	u16 result_code;
-
-	result_code = get_word(priv);
+	get_word(priv); /* result_code */
 	priv->infra_status = 1;	/* infrastructure mode set */
 	hostif_sme_enqueue(priv, SME_MODE_SET_CONFIRM);
 }
@@ -926,14 +922,14 @@ static
 void hostif_phy_information_confirm(struct ks_wlan_private *priv)
 {
 	struct iw_statistics *wstats = &priv->wstats;
-	u8 rssi, signal, noise;
+	u8 rssi, signal;
 	u8 link_speed;
 	u32 transmitted_frame_count, received_fragment_count;
 	u32 failed_count, fcs_error_count;
 
 	rssi = get_byte(priv);
 	signal = get_byte(priv);
-	noise = get_byte(priv);
+	get_byte(priv); /* noise */
 	link_speed = get_byte(priv);
 	transmitted_frame_count = get_dword(priv);
 	received_fragment_count = get_dword(priv);
-- 
2.27.0

