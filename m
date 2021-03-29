Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED9D34D499
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhC2QNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhC2QND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:13:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43262C061574;
        Mon, 29 Mar 2021 09:13:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 12so6888427wmf.5;
        Mon, 29 Mar 2021 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vumQFbft4TUafDDrGaQYDL2MVOcmMkJAnn1vxeYAC5E=;
        b=ffNu/g88ZA6KOYVXv8Lsu6lVSv0qtWWmEHUdeUR4wT94EBzXxxW9HCfzLRSqpjBLKr
         8GxL6K/RyLmxg/n4ZB0MG971BDRCVsAuslPPQZY+L7DZkgnQVbI07kPqmWeiDpq2eYqk
         F16RrwcKxTA5rEttuftCPCX7d9X3D9XjM17eRQLmXmP0wwQxSXUq5hKdr8XMaUlV2r4+
         3Opn5bEqYh38J/lUQF744l57/8Nlw5L7KZMjjYdIdvNAGeEF5eeKb57lqLlZ33dthW8/
         +zk/qBafapF0a9YLtdUyMeXzWXifmSGY/rGuo3jeOmpobSLhtKTV349M2rd6MZscaJHq
         EPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vumQFbft4TUafDDrGaQYDL2MVOcmMkJAnn1vxeYAC5E=;
        b=Oeq33FMLwA56Fkff2/Fe9DgBzD210kNWT7tUJOs3rh6cgg1uOMkq0QnZ6CMA9EuUiW
         X6U8Z9Z/OogwSQ1/LOUYTTcUYzv9P46/aWhlucC36HqK3Kcy11NqUJrHkdFUn/jLswO2
         D0Alp0LqOX9ENaBoCIpZ5losuc0Tti6spO2ezojRifyFUdOs0M/fWW6WMqU5tr2xb+hE
         lx0SCtcJh70vDqeCPZjLQL9itr3lhq+9nGgTdSDltKQ9pvbTheH5BTLGrnneZxEix8Fx
         MKRfC2TX9qphFcserpuy8Vumv1lgtbuJJ+j3Fr3hD886IOyfuHT0EiCidq90ef36TZAU
         JMIA==
X-Gm-Message-State: AOAM531PvhOQjdlKiF2EU/bCZsLSJD3ik/xYLegVUR/SMPDpfdbDI5Y3
        MJMQ/G0uAUma2ta0ptj7EN4=
X-Google-Smtp-Source: ABdhPJzRmUhFza6e/7DKRAMWFBmKOgWUb6fdMECHk398ZIn7NJxTfemfK+CMzjqLk48PjMSfCimDyA==
X-Received: by 2002:a05:600c:259:: with SMTP id 25mr25764293wmj.5.1617034381001;
        Mon, 29 Mar 2021 09:13:01 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a6sm28570964wmm.0.2021.03.29.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:13:00 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] arm64: dts: meson: misc ODROID-N2/N2+ changes
Date:   Mon, 29 Mar 2021 16:12:53 +0000
Message-Id: <20210329161256.31171-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans-up and submits some minor patches used in HardKernel
Linux 5.10 and 5.11 images for the ODROID N2/N2+, and fixes a stray tab.

Christian Hewitt (1):
  arm64: dts: meson: remove extra tab from ODROID N2/N2+ ext_mdio node

Hyeonki Hong (2):
  arm64: dts: meson: add saradc node to ODROID N2/N2+
  arm64: dts: meson: add GPIO line names to ODROID N2/N2+

 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

-- 
2.17.1

