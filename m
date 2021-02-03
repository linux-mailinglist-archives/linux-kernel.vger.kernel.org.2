Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F730DE4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhBCPhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhBCPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:35:17 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB52C0613ED;
        Wed,  3 Feb 2021 07:34:36 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id l27so6017qki.9;
        Wed, 03 Feb 2021 07:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SI4n9NRZTLZPCM1z1O/Whm3jwW/kVVyz3ohtgppebY=;
        b=U33Mu5S3DR/Kltq3UsElzYH9yWpTROTHoA/JO35yPO2vlbX2t1CUPaao0vcggQmw47
         T6qD3mEoXocShsOlsMq2WVQnFIooFj8oG3VuvDqlwekjyqho1a0iRi5i1GKyzGD9RTJ0
         rH6Fy+m6TAB2KnP6WyicW/KtlsSBCcpQoxJ6g/rBJx6U9jfsWaJMKD6YlRvfd6HGMOTF
         AhAySHW7Sp6OfrfagC+kz4Csq9V9zF2qP5ujspFh8PVgHpEMwVgF9Galu40Ok2GrLw85
         L2usI6vuNpLoKzs8jmSwrIBVDdFz/pQxkSzM1LXE3fVtgihAyB7v9NekfwFJoCeDNDtO
         hrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SI4n9NRZTLZPCM1z1O/Whm3jwW/kVVyz3ohtgppebY=;
        b=oyhRTWcuoVGSVZwVtjNc4u0cH5HS8V6AM7hiwX9apjwgGXsURKY/9Hg/WXvDch6czT
         dHOIuuHw2QxaKDXf+8qn8BUVPd1xCNxa/Lmq8x7MObGyr9ILojpkbI3U5PretsugIYMq
         y/Q6P4QH+CLshqSGXVIzG3pdjFRX2DBApnaZz9e3O0hjzyJX3mZ/Ee2KJ5NUTPPHvyHv
         VKc5i1lcFJ0yWEsY7qOWr4pJ/qbAbo89j3iudJ9pOwwT8ofi/WN07qMgy8z0qa8Sr+45
         VBu+iABamItdj41s7aXkzwE6Z2bkEZ2S1nDSZND/5BS+MqSvhiYQ10BkVMBiRDmIL9Pj
         krBA==
X-Gm-Message-State: AOAM531K/5nN+R3K+5s8em3qPt6QXWu7X0bPXfMnslgPtIlK3SeVWUNs
        Nk6TgHApHq/DHGKbJLe+T2U=
X-Google-Smtp-Source: ABdhPJzFP5pyxMzBYir5zIW9rnpybBBaeVuX5gKCiAhyrukcyoTKjKImOIUDRyhMttL2MN8vAn6rSQ==
X-Received: by 2002:a05:620a:745:: with SMTP id i5mr3136120qki.321.1612366476033;
        Wed, 03 Feb 2021 07:34:36 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id o76sm1827858qke.104.2021.02.03.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:35 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] doc: devicetree: bindings: usb:  Change descibe to describe in usbmisc-imx.txt
Date:   Wed,  3 Feb 2021 21:04:14 +0530
Message-Id: <20210203153414.17044-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/descibe/describe/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/devicetree/bindings/usb/usbmisc-imx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
index b353b9816487..b796836d2ce7 100644
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
+++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
@@ -1,7 +1,7 @@
 * Freescale i.MX non-core registers

 Required properties:
-- #index-cells: Cells used to descibe usb controller index. Should be <1>
+- #index-cells: Cells used to describe usb controller index. Should be <1>
 - compatible: Should be one of below:
 	"fsl,imx6q-usbmisc" for imx6q
 	"fsl,vf610-usbmisc" for Vybrid vf610
--
2.26.2

