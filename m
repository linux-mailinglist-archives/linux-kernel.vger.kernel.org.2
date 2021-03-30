Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF834E33B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhC3Ifr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhC3IfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:35:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF8C061762;
        Tue, 30 Mar 2021 01:35:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so7940036wmj.1;
        Tue, 30 Mar 2021 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCDnrdurBxHp4hqMgyHqr8HK9SC1LgyhjeSGAs35CXg=;
        b=pE1wuzjDl5NiJTgvlwq/xZiPi0DfV9nOPXFBgQnalkn8T5D2qQri92Ezqz90SY+L8V
         RTA0napESHabMe6FvOw9Ln46RgZLsfAtItVPGGKqw0OKkzUYLhuKRFKhqJpAp1AzSxbv
         RtmA/F/fySZ4wYduR7MwyDs1r3eXRJHa6F+7ii8BcPdwY7dbYOU9QQqYoePQLCq7ZeHD
         1XrCi0Vs0LzvC8kOrm/QMedHcMR6ExW/kuW6XyF5FAE+W8BvtIKKVYTod/2BkTDbEUdF
         Vi1T805WeBpIfjJn6Z+QzNdC1CASw5uy2LihxVVGlSL89Yy4cp0S7SwH024MQZvlLtS8
         Ka1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCDnrdurBxHp4hqMgyHqr8HK9SC1LgyhjeSGAs35CXg=;
        b=na1VkU2mDJXPWC7VTN7LbRReZhR3m43jUxg+4VEHYnle7Zy/KkkjCJugEfQGFAm3K6
         50faOMb8PDn3/ty7PyuywuzwMybuK6P84mpI0cmzi1motdUDYCp3/EOQ2gpzKcT+cQA+
         CJISjZFd/B3+t9Soy+SjYozalwQDEHVnhvXRMzfGxf72lb/aMmB9JmpSy+VDj6jDxoXS
         kjrpW9fsCjW88K2/fLRDSyOGtKCMl/Vlwv+GNIRYwV8A18hmtBGyPYnixqiUcW1wnLnv
         MVKUJhorPnd0UvkLO5RuYypWbw6RWBrLlvQEdTz3oL9Pb4m9AmlFDdY8Cve4ssgVMjSB
         UGHQ==
X-Gm-Message-State: AOAM532fkguduTet4+5a4RAF0CGjBzdDBr7NlplTD2xVBnQ7Qi9jlqnH
        ki64hGyr/umtwpSzvsXNc4s=
X-Google-Smtp-Source: ABdhPJw7Gphw/yEy3iqJQuiu9+xzLv7r0ntuDECV95y2FfsdIh/gO3/CAh3IoPtlOgK9yxqFIWHfmQ==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr2844786wmc.187.1617093320070;
        Tue, 30 Mar 2021 01:35:20 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id g9sm32830263wrp.14.2021.03.30.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:35:19 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 0/4] Add peripheral support to imx8mq-nitrogen board
Date:   Tue, 30 Mar 2021 10:35:10 +0200
Message-Id: <20210330083514.5874-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch set aims is to add support of multiple peripheral of the
Boundary8M board:
  - USB Host (behind a resatable hub, started by u-boot);
  - USB device;
  - DB_DSIHD sub board for MIPI-DSI to HDMI output (via lt8912b chip).

Thanks, 

Adrien Grassein (4):
  arm64: dts: imx8mq-nitrogen: add USB OTG support
  arm64: dts: imx8mq-nitrogen: add USB HOST support
  arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI to HDMI
  arm64: defconfig: Enable LT8912B DRM bridge driver

 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 185 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 2 files changed, 186 insertions(+)

-- 
2.25.1

