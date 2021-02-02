Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B162A30B513
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhBBCLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBBCLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:11:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898BC06174A;
        Mon,  1 Feb 2021 18:10:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 6so18734850wri.3;
        Mon, 01 Feb 2021 18:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9xOUKO2XKFLeSm4wVIMXSdkTxiy8OHddK5mDTptdxKU=;
        b=nTrwA/bfhrMSTUtiwyKvX84Zn86AcrWRQF0mXnJQ01zf4FHwi8wgGFr1cQscLzjyEa
         zvWVxICc17mU5fq18gcaQX2wpgIAfQskkKAs36tuvpnVeZhZMByx1jXByIBqZLjT5gzu
         6WaUhH4Z6aC+TkpMMGw0pNNaoZqkZm4jziWgTA4Ow2H7uW5lpIjqgd0jaGxzEkeGi7P8
         dfD9A7Eth0U8V2kG7AckQpz/3xsjfG40aTbZJcRGCeX+Sj0UpppH9Y28blcldbsFBgdc
         42WfJ2WXzR77w59Rsyl0R+Z6C36gjHm8aP6ckPG0CgjIq97VF2ZKbCL27rFf6HtoQ7C+
         cL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9xOUKO2XKFLeSm4wVIMXSdkTxiy8OHddK5mDTptdxKU=;
        b=To+UG9vky5kzJGvYt9mQjHtKOFcwITPjuJt9cuL5H661nEu2SOG00qCKsK1KnEXqHs
         0cpb9gOhGoK64cC1hK5f4zNkX/bnHZnwua8W6RnZ+VtRnuqT+Pr3mBr0u7T4UlcgjKQy
         HFCBY/G8xw/uJscv0Go7TXCo1ehpc7F1uxasKAlQ9vEpi+mLW+pVLvgflXeIj8mnBlma
         tQ+zQxnO7/QfodVwdajooGxyr4Cfe9YhQSX49K70Zn3QUtg80O/MplsoAmjxdhygtHYi
         SccqlV2CdkiAbx/vQPuvqJRGPWOM9lw6Ie81zrbjqBC+KnLbFFZwI4tlMuSrxLe0eSUY
         ghSw==
X-Gm-Message-State: AOAM531+/ITOkYwrZPcAKcu+d9mfMprNPKSioscHt6sP6vgDlUQfPkSV
        DzbeKPy3qmFrFDtTC8YOVqU=
X-Google-Smtp-Source: ABdhPJx6ZWXpoOZVm6QgJHNsRJkiU0/hVUk2t1g4sekaaXJRU3bsQXMe2U/mxHab1BsEKP703HQpsw==
X-Received: by 2002:a5d:4dcd:: with SMTP id f13mr21028655wru.10.1612231828014;
        Mon, 01 Feb 2021 18:10:28 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u14sm990570wmq.45.2021.02.01.18.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:10:27 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: arm: amlogic: sort SM1 bindings
Date:   Tue,  2 Feb 2021 02:10:17 +0000
Message-Id: <20210202021021.11068-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202021021.11068-1-christianshewitt@gmail.com>
References: <20210202021021.11068-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the bindings before adding new SM1 devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6bef60ddda64..b21ba8ba23dd 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -164,9 +164,9 @@ properties:
       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
-              - seirobotics,sei610
-              - khadas,vim3l
               - hardkernel,odroid-c4
+              - khadas,vim3l
+              - seirobotics,sei610
           - const: amlogic,sm1
 
       - description: Boards with the Amlogic Meson A1 A113L SoC
-- 
2.17.1

