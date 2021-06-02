Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA00398CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFBOfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhFBOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:34:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073A0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h12-20020a05600c350cb029019fae7a26cdso1788178wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78IZFmK5jsA34hqJO0M2qv8hujM84El09YurAWZwzJM=;
        b=WdrTLrzWk4itXaz1izoOEsBVPQAc38HR9oCFgSF8CasRhUQ/mV0xqaBwWh8qm+DRLp
         dz6e89ggMSBX7tN4p+HNf2RPU+dvF7+tOnexD/duWK5cfdkujKueSpzur/26pWFfBz8J
         DwHgj3wlHU1Dlv4UEZNY+JX8wOuC/aNbTpF2CDhflG7/sk+dOb4mA+9DvRigY5lB5e/I
         4osgQWBD0vsPfZwszEDhpluGVTC7Ah/FJ5sYB3baQEOMrmWPZoFjqCQYn3EBm65N1DzB
         n8234K6KzftioCYHjWpQVd12GDkF2aeZ/YrD/a2cm2GwwDniCbnkC1n7wvj1qjMWQ1Ra
         H7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78IZFmK5jsA34hqJO0M2qv8hujM84El09YurAWZwzJM=;
        b=R2lKEbDreuxDyGpjvPYznwiVnDF2HVr7PpNHBSpXOjL+eHHDMJuBArDUIi7q2DFnOP
         AnNGb3gSyq5CtKE0u+Gziwh8W+iIMtaiIHmx5ZXjRWqKvEw16Pu1U/QiA06S1HUbppuo
         w2TsOWqPbs1ctHYWfhqbzMMwP4RiMjVBIOLTAldvyXWHTf4T77tHKrW+ZclhlAqW0NDy
         YSlAAY23DNyz1af0B4rmKJ3Om0P3vmsCVU7ypFefwx3iSh5zyPGrWXUqZARWIGdgwh0e
         BgaP49aYKNceZayPZ5I0sSRuwusQ0G4GQHtm/946cAa7CEG/PhqqfHzjqi9jqjmS234F
         HPuw==
X-Gm-Message-State: AOAM530Pbo+sb4TPH+mXCSIniFsq/x2J+dgPGnHsEa7VSOqCdvJPz2Zq
        NQzBzLReejiKkyQ2TdS6b21Dx4WPP9udVA==
X-Google-Smtp-Source: ABdhPJyqpHwUHtws34ryd9DXmm/uUl27GMgYVuaG8fO9cG+srbCDO/rS5IW6FmI/z4rqAod291xNNg==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr5568518wmo.180.1622644394679;
        Wed, 02 Jun 2021 07:33:14 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 05/26] drm/sti/sti_hdmi_tx3g4c28phy: Provide function names for kernel-doc headers
Date:   Wed,  2 Jun 2021 15:32:39 +0100
Message-Id: <20210602143300.2330146-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c:77: warning: expecting prototype for Start hdmi phy macro cell tx3g4c28(). Prototype was for sti_hdmi_tx3g4c28phy_start() instead
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c:187: warning: expecting prototype for Stop hdmi phy macro cell tx3g4c28(). Prototype was for sti_hdmi_tx3g4c28phy_stop() instead

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c b/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
index d5f94dca0d323..d25ecd4f4b673 100644
--- a/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
+++ b/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
@@ -67,7 +67,7 @@ static struct hdmi_phy_config hdmiphy_config[NB_HDMI_PHY_CONFIG] = {
 };
 
 /**
- * Start hdmi phy macro cell tx3g4c28
+ * sti_hdmi_tx3g4c28phy_start - Start hdmi phy macro cell tx3g4c28
  *
  * @hdmi: pointer on the hdmi internal structure
  *
@@ -179,7 +179,7 @@ static bool sti_hdmi_tx3g4c28phy_start(struct sti_hdmi *hdmi)
 }
 
 /**
- * Stop hdmi phy macro cell tx3g4c28
+ * sti_hdmi_tx3g4c28phy_stop - Stop hdmi phy macro cell tx3g4c28
  *
  * @hdmi: pointer on the hdmi internal structure
  */
-- 
2.31.1

