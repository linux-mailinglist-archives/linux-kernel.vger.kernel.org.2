Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBE3A3E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhFKIf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhFKIfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:35:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:33:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c9so5104801wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBMYS7fSMpepJ3rPGZYlHS0eUZ5phCJ/hHdr74JX0M8=;
        b=ddrJGR5oSVpJnpuxIUJ1hB9+uErCwivG4mXDn1qDEBBUAe7cvdnGimz7wp4I3KhnQa
         gJcOCjB5HDj6tU0G3HOzYS34heuywRPyKQzjNXaji65q94f+5oJas/H4oK2Xch7mrX+G
         73N+OtmaX52QjgsmyDMSmiw/4tsZdqEYQ90SPpiBpxqp8jw46vSrgm7FHHlSNu8ulm/f
         JA45HE9HG3aRrrd3Ve1/62R6zE15LSiPESbEHLmGG+EQm7Il5TDNdc7RybgBmms1ZXt8
         utqZ5B9DGAhDL826zN9XM/hvPJv5r8R1AHk/JAh0OcErgBnUFvlphf8St85LRmA6ReSH
         PAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBMYS7fSMpepJ3rPGZYlHS0eUZ5phCJ/hHdr74JX0M8=;
        b=hjhRNsCbkLV/ZhQK6Sr+bwH9VSX/uldzWc6uo1Iprx7/Zk36y+Bo9yqOPf3bsxp9E2
         aDf5YgqXte2KW1gQjKeR/0IeL+m5k0xDTsQ2oqB9Ma7hp4YUsf61q0z8jmYKCwWXrQxr
         BVaHrUY2AWzK3W4uRm+3fe9cfpFasRNEgaPh67R8OPJlFGKeUXmBrtI/eGXczeam8Tgp
         ek1RQoqES1CACht+rZve2u81uozBsCqAg1Gx+FtarEWFfPu2baQXe1uV0kiollcJ4skN
         C2ped1jBBJrTYITyY0xmv50FOQka+5NaoiQRZbh8zc68BNf51x1qLgqgpy+KqHRnl+aT
         MGSA==
X-Gm-Message-State: AOAM533EVmm116PUMY+9v+EcUJAK4y9vCHvAisoHkpaefNhYgjYJT3bz
        XucBC6V105e6DjL8KLrohNTwUA==
X-Google-Smtp-Source: ABdhPJz83D32wbqvwVH5KXNMgrJijet+fgHqsaOV+rDqqE0fxHk6WU+esEEi7iWRj/o+o0ctFLHjJA==
X-Received: by 2002:a5d:58f6:: with SMTP id f22mr2660924wrd.128.1623400435941;
        Fri, 11 Jun 2021 01:33:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:33:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Zou Wei <zou_wei@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/9] nvmem: sc27xx: Add missing MODULE_DEVICE_TABLE
Date:   Fri, 11 Jun 2021 09:33:42 +0100
Message-Id: <20210611083348.20170-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Fixes: 19c54468f222 ("nvmem: Add Spreadtrum SC27XX efuse support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sc27xx-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index c825fc902d10..7f9bd2195b97 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -262,6 +262,7 @@ static const struct of_device_id sc27xx_efuse_of_match[] = {
 	{ .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sc27xx_efuse_of_match);
 
 static struct platform_driver sc27xx_efuse_driver = {
 	.probe = sc27xx_efuse_probe,
-- 
2.21.0

