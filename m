Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80E30A75B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhBAMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBAMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:15:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D8C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 04:14:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o10so11377560wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 04:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O7LEqE301i0utftIEa551QfXNX2X5B5jgaY6PWrEijQ=;
        b=OCuIx7GJoUPlt6a5ceSbMt2Vj5WKZZE7ls7EL1x4KnLZ6CuQKEycbe314oynUSOHIV
         a58OAN2bxvOlx016lFZBEBCy+8uem2cwJMZFpDoNM7ORM5Q7RRzE/pn0ZiJo6QlJ0b1/
         7cy1i2ViFNk3mK4zB2VB5jsvysYOs9bIXLOrxdDkCxg4Z2IW5ekz6AxF8UwMwnpahzU9
         G+45fgMfQwvHhmiS7FLKvrwGfJ4xdgc8EQ4vCU5X7n0Lt3p5QX9reffA3G7f1mtcumW5
         TOn2vbh9ViynKhGYVLERo5g3Lx2QNkc+uOXF10i95QrJ0HF8mfekHPPHW9WulFsyVNK2
         KUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7LEqE301i0utftIEa551QfXNX2X5B5jgaY6PWrEijQ=;
        b=OwNdzF6AamMQNNsJEMeB5ZDVhs4tueVZgT81SOOu5xNoFesS6bp4e+2kP4SzEYXJAq
         BJV/FXPqZ6LTGqAccI2qEah6dB8nwfAmPH1pln0YPKKPVeEilDfj9bz69SzBpR5Amujs
         Ka4Bcb4jbgByglr0nQ6q9jgnDvNFtRO6cdxlPikOBRmNzoVPcI28OFOFD3GLZCOSalqd
         j8qqLtnaAXyJ0tc4hVtimbMAFbb6zT4Tr0g8wE0xYQTkcVw5ftMRbBgof0P3kYup1I7f
         UoXc8GpNcI9NxgbYGBmGzdCIPTOescndLUWg9UEqIai/iYdDctSCIC1uBNWQ4/KUb3dw
         ejaA==
X-Gm-Message-State: AOAM531+c0aWWXdXjus7nohAgAAk6Whn+RsPvm+Ad9vDPEj/n4iyaK2b
        ugC31j7OguO+M6Bb93yWwXw=
X-Google-Smtp-Source: ABdhPJwOuVm8lLkSy36OuClrBdp2b3D1NYc1jr8EDZykah2SgHBYS1aBk75CAcS9UbFwHuYmWI9sJA==
X-Received: by 2002:a1c:1f4d:: with SMTP id f74mr1782289wmf.133.1612181659606;
        Mon, 01 Feb 2021 04:14:19 -0800 (PST)
Received: from localhost.localdomain (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.googlemail.com with ESMTPSA id j13sm20698332wmi.24.2021.02.01.04.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:14:19 -0800 (PST)
From:   Bilal Wasim <bilalwasim676@gmail.com>
X-Google-Original-From: Bilal Wasim <Bilal.Wasim@imgtec.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, enric.balletbo@collabora.com,
        hsinyi@chromium.org, weiyi.lu@mediatek.com
Subject: [PATCH v2 2/3] soc: mediatek: pm-domains: Add domain_supply cap for mfg_async PD
Date:   Mon,  1 Feb 2021 17:14:15 +0500
Message-Id: <20210201121416.1488439-3-Bilal.Wasim@imgtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
References: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mfg_async power domain in mt8173 is used to power up imgtec
gpu. This domain requires the da9211 regulator to be enabled before
the power domain can be enabled successfully.

Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/soc/mediatek/mt8173-pm-domains.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
index 3e8ee5dabb43..065b8195e7d6 100644
--- a/drivers/soc/mediatek/mt8173-pm-domains.h
+++ b/drivers/soc/mediatek/mt8173-pm-domains.h
@@ -63,6 +63,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = 0,
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8173_POWER_DOMAIN_MFG_2D] = {
 		.sta_mask = PWR_STATUS_MFG_2D,
-- 
2.25.1

