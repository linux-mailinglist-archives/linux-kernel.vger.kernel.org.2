Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9DA407C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 09:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhILHaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhILHai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 03:30:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D86C061574;
        Sun, 12 Sep 2021 00:29:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so4374091wrq.4;
        Sun, 12 Sep 2021 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZBdcwxffYSz2RZwsY3FdiDmTR5iWVRuIsz5WG9s6e0=;
        b=mbstrXTZ7CJiqgHTD8VzbSlUC5f6gbW37gVX8U1iiDAj/2mWI2mekhdTml88dmdD5j
         V+rGzH+CeRwm4cC/MgzrxEm3KfMylmQAUszcB+yz9/QADmMXzczGMgAvbClBXXPezWPP
         2KySYmMvvflXGznsO/uxHdmT/Bbv17WAtj/WGSuX00yAcCWbr+3tmc/zasDUxRzsYg1d
         QK5I1SwNqT/Y318H0RkT/Kie+iToCUI01OZ/wffJUsMrqlD4saVwGpF8wdlXlzgdZVJM
         fafkaoj+jqafTRhMqRb6+nOmLeTUzQWMpjid90n1YyFPNguJpT/93Hh8xTYkMWacaj3L
         Csbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZBdcwxffYSz2RZwsY3FdiDmTR5iWVRuIsz5WG9s6e0=;
        b=2fYFG5ZCTrWs3o9Nq95UhSKg2LSqqaViUonQ+MPaRRMKF37e1eZnZ6lmSxqQtE7iPp
         l8iDcZHdvotKpbz9ruBzkaeao/aQ61YRUthPWoyYNoWsw0Wtsybhl3CZQSarMDLULbZl
         bpDx6MVzSGS0EePAOTih5jCrzj3S6OQ5I/Y90stofNECeZsPP/5M/PWtQYT6ucaB3rme
         UZsx0eoLAB82eY6PiGB64o4qJuOeJ+kN6+dmTztNwTz7NWMvebBscwsA9DyaoFG7u0IJ
         P6vXnWelSzLk6nObwNMfkEUlb2wOeUsm3zRCCVvoTlXLxnkXHgUAM90Uwq8BcbvgpM6O
         OJqg==
X-Gm-Message-State: AOAM531zFBtOHXIwIq3kAqorWkRRI95nmYCRX7QSIJOJ7pLLzrpPJNkc
        AgBYYpnghBkN31aYtd6M7TQ=
X-Google-Smtp-Source: ABdhPJz4nvfQiFNKXBcEJWr2d1iLp+AdlSJBArr3BW9WSAH6qQxaUTFzEymeHIWc0lqAOCiJ+EZ+Xw==
X-Received: by 2002:a5d:4f88:: with SMTP id d8mr6382713wru.358.1631431762809;
        Sun, 12 Sep 2021 00:29:22 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id t18sm3584889wrp.97.2021.09.12.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 00:29:22 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/2] ARM: dts: sun8i: r40: Add I2S nodes
Date:   Sun, 12 Sep 2021 09:29:12 +0200
Message-Id: <20210912072914.398419-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R40 has 3 I2S controllers, compatible to those in H3.

Patch 1 adds R40/H3 compatible pair to DT bindings.
Patch 2 adds I2S nodes to R40 DT.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (2):
  dt-bindings: sound: sun4i-i2s: add Allwinner R40 I2S compatible
  ARM: dts: sun8i: r40: Add I2S nodes

 .../sound/allwinner,sun4i-a10-i2s.yaml        |  3 ++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 39 +++++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.33.0

