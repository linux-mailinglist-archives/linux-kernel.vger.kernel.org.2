Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A604331B072
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 14:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBNNPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 08:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhBNNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 08:15:51 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA303C061574;
        Sun, 14 Feb 2021 05:15:09 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lg21so6978107ejb.3;
        Sun, 14 Feb 2021 05:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zxfPNMt6m8rT4kKvDjn14QMCz4FlPwjCyfiRcaQhI9U=;
        b=RhqWrWVOolE+nHs5uVms79QqERY6lux+h4lHeMhcJgn3fsIrDf6Dfb9fV4AFB/sKFz
         4w1MQzVrc1ZHrr1YR/1RemMZWupRUIQBzxFtAIWMAJwV7PUkrvAAErlCHqVvvrnZlrUd
         rwCp1HlM9BEpah+Efzd3hh4MH7nghDUREQknq5hegyiSSC/O2Gsj/pWZFGNmr8QPyoCS
         FlKw83IQJSac74hlCEihPp0YN91Irz7KcbJeot6fU/oe9raWaI/+NhsvckyfCG65s66U
         LGz9+koJdUmQUTzkN8a0K7apxf1nVhpCI8P0SSN5ROw26gn9XmcuYpCxsE2L5PmQAUCD
         zptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zxfPNMt6m8rT4kKvDjn14QMCz4FlPwjCyfiRcaQhI9U=;
        b=iwhR77YmCb9T5PCq6F1ReSyLH+Z/9jnVIbR1xxPYpzXwxIaCbqj6Muwkt13ok/yY3k
         o+EnPUXTLxPsF5Qpjm+pFyda71CMD1pXLC/UQ2iYfaxg3/ShYwnGGhSd439ppqqJPnma
         FBDJ+g6zrCOFqEgUDGbUbTpXyhF9wkw2hAB5AF2EG5MWDa9KuaviueFYw51mayWmKK/y
         ALabM4S+w2F3aneqySbpTioqdWXdWX0y3Z8I5Vg3U+SXrKs8fRUI2Kxg3wqIGDNIyz1q
         iqbJir2P/YZRmWExufAw8DRspZMa1jlDC6q3LjkK2tK0fnYoeoi2ctMJxwEhfqpM3XCa
         yhxw==
X-Gm-Message-State: AOAM532Wy8L2v6iQV7Tg9W1a2+5uLTGg09lZKtua5y8fJvpff44XIz98
        NygUvWW57K1yy4Iyad+WjWk=
X-Google-Smtp-Source: ABdhPJygh/m1WfubWPibCRi+1Ef3XdxdpA8Q6qZTpPqIvL8n/DxHnU2bYKTYH2G8P4Si7fddwSvmqA==
X-Received: by 2002:a17:906:c05a:: with SMTP id bm26mr11833669ejb.288.1613308508317;
        Sun, 14 Feb 2021 05:15:08 -0800 (PST)
Received: from localhost (ipv6-31ee9f1acdb5aef4.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:31ee:9f1a:cdb5:aef4])
        by smtp.gmail.com with ESMTPSA id f6sm8625066edk.13.2021.02.14.05.15.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2021 05:15:07 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     m.felsch@pengutronix.de, festevam@gmail.com,
        narmstrong@baylibre.com, Oliver Graute <oliver.graute@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/3] Variscite DART-6UL SoM support
Date:   Sun, 14 Feb 2021 14:13:47 +0100
Message-Id: <1613308450-27958-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Variscite DART-6UL SoM

Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits

Oliver Graute (3):
  ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
  ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard
  dt-bindings: arm: fsl: Add Variscite i.MX6UL compatibles

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 314 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts    | 255 +++++++++++++++++
 4 files changed, 604 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

-- 
2.7.4

