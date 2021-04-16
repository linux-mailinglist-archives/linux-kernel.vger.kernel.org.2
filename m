Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A43361D49
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhDPJ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbhDPJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:28:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2433C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:27:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so13827151wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BqRj0LNCA4WBYZmT+NFPaGLh8/3JIeNWN0kNZbU1po=;
        b=p9vuhEWJ72/1jKNusXS3smwfCyriKDrf1mSy+nnr8fQsMoiNn1NKy7ZDKbn7p+wwtc
         Y7ZxsfaoIA7GjjO56ZWve3BjkwgisWOwzngPF/zdmhLZHX4ztcUbItMM/gtSAQzkeJJH
         T2C7TyUqaMAru2a88UqkUjsLOufrmb9e/Cz1fgQYBZygowAB+sMz7sHfdFhAdVksHepW
         Cr3K81jRE25GB4khUmPkhPovAMTJO9uBvP5uadZ4NH9OAdRo/yck6D8WO9EbqxW60MaM
         DpgFZsAwpIKy6+qU/6tHRjiqperbiltfKqbJycwL/cFeG+8NiguT7z+7YtZdQ0j0R+9f
         xlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BqRj0LNCA4WBYZmT+NFPaGLh8/3JIeNWN0kNZbU1po=;
        b=s4ez3/ipPYaltjKQfDHRpvgdNiTM5AwAbFHCQdBv4psLDeyQinAjhb7bPohJEK3DFp
         RJmWAa8zIq0g4nXYCJ2W647LjCrViOgl5FncR+vV4Sj99x3Ae5F9K0CV+S3iJuXHl8ch
         p/bOYgN+04DUDRI/xHwbPrQ7iydJckbDf8kz3POq/lGyqpnB+kmmHsIaAdCDHsDz9d3J
         3zAtxCul5QAkMQOX9C63qjRkqLfWiWGo/XYGgjj8OakdkCL06WBvAOWNjq0pE4e0DX9s
         TbIK7jvZ/1bHqr8uNudn7SrT3d806WiedSnnhqjlf+FQlxf3aK27YzXQYIEyVotB+jMX
         h7ug==
X-Gm-Message-State: AOAM532kmqsZbfrkISEyzcZd15a2oo9HryuKqko1q2RqH4wjJc/JSBZX
        tBR2FTOA05cS3wdAR4eBPsJJ5g==
X-Google-Smtp-Source: ABdhPJwn2tFqclBip9+el1SG+TFDi6VD+1YJ7fmLPq4JrBkmfmzo8sBE62ixZffYLJeBE0UMs5auUA==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr7270490wmk.50.1618565262461;
        Fri, 16 Apr 2021 02:27:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7])
        by smtp.gmail.com with ESMTPSA id h8sm8805156wrt.94.2021.04.16.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 02:27:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jonas@kwiboo.se, jernej.skrabec@siol.net, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC driver
Date:   Fri, 16 Apr 2021 11:27:36 +0200
Message-Id: <20210416092737.1971876-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416092737.1971876-1-narmstrong@baylibre.com>
References: <20210416092737.1971876-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=Y2Kp96dW3X0U27vNrMM/XkOOWYrIUuOu1Mi+zc7UuTs=; m=8YzxMzRM2R/oOFCOZbnFjWww/0CRXwSKJOS10A7bahU=; p=In2Hgqc+nqwSrOrGnpYjxqY39B1rnskpZvUG56iaipo=; g=1623597293b4caa25ab43c3fbd39773cfca1dd42
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmB5WDgACgkQd9zb2sjISdF0zxAAsPF S9X840FovT4celkzqEHde6wQVRpNvUWE4KfpsyuthouG4Ogh7m+mtKyMmMmQER6NI98m6UNn3Xbw5 Qx99KHfaJJIDzeVKrURJGlExHSEpMuPeHdJ0RAe7bLK9WQEQPtzxAOjV6Fv1laxc0C3c0dOfy8vr4 JZX5oSKvz9oZ6X4ORBzl2Ighs0m1oNE6+fVDA/Go3PF9hK75cBWYIkms1I+K8tbvzEzZ/qZHYkJMM 7MdZj+Z8QXTj3HtlH0D3/Ir+WsE8g6vWtPbpiCYZQN20Qba8AIbNzlVgl5W4Bp9Ui+L/fbej+SOpF aEBcnw6wNLiKHAL3TxQDO8vkBR+JtaUespcIgE+/lqPeRJ7hsAfbsopzmkOz7kY6HCLvbAKtSlZbZ DhO86B1AKA7zjpTtuW+LijHIpzcK4kY7MRwuh+pFxFjOUv35K25z56vjnxJmLjo6zKyuhDR6WiFAY gscXpmhObHHjk36uTWeTJr87NINY7CH0pBu9ZFSzSp01gkLMx4phDLjm0+JayYtEWb3C4TQ7JEMT6 83Pdk0v0cAmx9Zef/LH5+R5kpZDsDpIJ7MeGQOrHUqbzKJF7K9EFKhDwaxXbSJKhCaEp+AKawxo1e xNymIxJyVDqU92s+pABPeTAYzotm3k9rcTGAjvOMAJe4zZlBjgZxL2N8piBFhgP8=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

This adds DW-HDMI driver a glue option to disable loading of the CEC sub-driver.

On some SoCs, the CEC functionality is enabled in the IP config bits, but the
CEC bus is non-functional like on Amlogic SoCs, where the CEC config bit is set
but the DW-HDMI CEC signal is not connected to a physical pin, leading to some
confusion when the DW-HDMI CEC controller can't communicate on the bus.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 include/drm/bridge/dw_hdmi.h              | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index dda4fa9a1a08..ae97513ef886 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3421,7 +3421,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 		hdmi->audio = platform_device_register_full(&pdevinfo);
 	}
 
-	if (config0 & HDMI_CONFIG0_CEC) {
+	if (!plat_data->disable_cec && (config0 & HDMI_CONFIG0_CEC)) {
 		cec.hdmi = hdmi;
 		cec.ops = &dw_hdmi_cec_ops;
 		cec.irq = irq;
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index ea34ca146b82..6a5716655619 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -153,6 +153,8 @@ struct dw_hdmi_plat_data {
 	const struct dw_hdmi_phy_config *phy_config;
 	int (*configure_phy)(struct dw_hdmi *hdmi, void *data,
 			     unsigned long mpixelclock);
+
+	unsigned int disable_cec : 1;
 };
 
 struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
-- 
2.25.1

