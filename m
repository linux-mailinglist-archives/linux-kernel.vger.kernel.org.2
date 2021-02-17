Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5419331DD03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhBQQLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhBQQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9199BC061574;
        Wed, 17 Feb 2021 08:10:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n4so14992116wrx.1;
        Wed, 17 Feb 2021 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHsYy4kfuz+dbx5gX5ft7BQfcq6kBGE+mw/1lENuRso=;
        b=aQ7MHk22HeT/jY9RUMRVTlOcqM92NR7YscR9Mwy3ShNBI0Rtx3hEjiNkFHGtIv7Sg2
         wWQS/mHOqr99gmjydS6/32KC96jGW1BcPrN0vNFNixn4YCaY4CCsh8Dn3tLc8uFWTbqy
         GLJQorhZ9MBYGwwtNNaEczjG1JB6CtrmHZ4XCLHkExBFlE54TDJdsSCiku7unuY+IsyW
         vOg127XwIpyPMjV7P0eAMc+XgRnFYpe9DRoT5CfeQRURtLvkQgQEmTw3Tjdc9TJynbaU
         vGmfNzRdM7JEJRpR2F29Ik6Z0QvBWpIzj7PWwhIL5+0o4CKWwp2boK+z8LIn4Q0LOvvX
         odfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHsYy4kfuz+dbx5gX5ft7BQfcq6kBGE+mw/1lENuRso=;
        b=YmL+96dmLUhCLb0HK4mdodCkkzGaKyDobxXDwAMx/7fMtNR8x+jyzmhidL+WhSGgXw
         y+uIDsSXrU9n1PI7Jh+ey7xhugXlcb4DHGFUyFhabjqcOK2B0/Yt/UmjyOwT8PeZOzL/
         14DE8Z1G0/KaHlFRapR46WElv25+oDLzVVYclkRmHzET5uXarIFDEQ2ODp+S4oWp+wdO
         yLItpIv8y01BHH1Q0D15smBmdwIPX7Jrdvnl+97n7slu6rf5GnX/FapKtiT2LzXBZ7Cy
         fFBYj52UCwCk+6xeTI6E1InzA22ZLceJVyhSRb5P+4mkcn0i9cbGXIw3EXWCPRLOaFNi
         sNfg==
X-Gm-Message-State: AOAM530hEsq+i1YOmD7vlo+gObX2F3POAZesTpIzStlAqwL7Z1sUH+dX
        3OAtbQGn2hnN5mQhBAmx27M=
X-Google-Smtp-Source: ABdhPJzOqQjVdT9zAKzwZdWyKKojD2Cz+/nfbiJMOhT3nN1KnubeVvM78t/slY9c0UFmyZvNd0ehKQ==
X-Received: by 2002:adf:e511:: with SMTP id j17mr30903395wrm.251.1613578256290;
        Wed, 17 Feb 2021 08:10:56 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:10:55 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 0/8] Add peripheral support for imx8mm-nitrogen-r2 board
Date:   Wed, 17 Feb 2021 17:10:44 +0100
Message-Id: <20210217161052.877877-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch set is to add several peripheral support for the
imx8mm-nitrogen-r2 board.

Thanks,

Update in v2:
  - Fix some typo found in v1;
  - Fix UART description

Adrien Grassein (8):
  arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
  arm64: dts: imx8mm-nitrogen-r2: add USB support
  arm64: dts: imx8mm-nitrogen-r2: add espi2 support
  arm64: dts: imx8mm-nitrogen-r2: add UARTs
  arm64: dts: imx8mm-nitrogen-r2: add PWMs
  arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
  arm64: dts: imx8mm-nitrogen-r2: add audio
  arm64: defconfig: Enable wm8960 audio driver.

 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 307 +++++++++++++++++-
 arch/arm64/configs/defconfig                  |   1 +
 2 files changed, 306 insertions(+), 2 deletions(-)

-- 
2.25.1

