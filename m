Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5855934E41C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhC3JOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhC3JOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:14:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D05C061762;
        Tue, 30 Mar 2021 02:14:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k8so15489080wrc.3;
        Tue, 30 Mar 2021 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQC3ZslEGYXOQvKi6+Tazqn0geOYcSLsLHXS38HHwkE=;
        b=AroCag/Ciss9pHcAP9t2HsmhjINHjcpvBIGuHddQrNV6ANKwQkCi04163200iQjDcO
         yM9hDlUFzIpSUyizNoPiqUnSAyof32wfWu24XJ9NPKtgerqvGVo20s5CvZEb3ZpXrH2V
         vBSfCAYXax85T8uUEakz+TAgfDrh6B8YH67dny7OG8GjXqevECvnDC4Dv5QcflGKr06/
         QhhycfziBX80TxxU1caf6uYEarp+qwDZkF0wUB2mpr0AISsq0uj1k4RAZMWGAY9h3pFg
         sfc/btG3AiuEjRS03zCEXx54DzKjTIEW6H45LLlcJ+JB1VGEXXQtQ4FOubht60mtN4Me
         vPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQC3ZslEGYXOQvKi6+Tazqn0geOYcSLsLHXS38HHwkE=;
        b=VMNsPQos9BIFAgK21Pn4sDhgwIvSGdvXviWdydgAYQyTkY44v4rY/jLo25jFeoy/S/
         8PCHQreHmG0NA6jEo/mnGOXrpDs5XGb5H8Rx2EMsDDxy6CyDZrUCfwvNiSRJaoBBRtTI
         6WtP4tjUjeMzSRO8w0cM4KXjjqAdTIkoW5tSaXoRGrUWVVuFTbCeBssEk8G6+V0t6CqM
         HDb8mzgCyYLIl/a3IMAjd9lgSg3FPyIdqsx31c4bq/hSjKKc1ddjU5P01zrk0Z4x2XD5
         uMdCy5RXu2Z4/R2nP6gd/NFej/0nfU/jDCGgv7ybLXPHd/uzrbYLfoDDAEPvLbh1e3L8
         NiBA==
X-Gm-Message-State: AOAM531wE7wQFmNlX1FvYOzlWbKW3WfwoTQNlw1H01S/bh13slpMOn5v
        KEGZOifV7pjOak9bUZKIqtU=
X-Google-Smtp-Source: ABdhPJxia7HxP9PbstWN2r0vyfvB896H+IDH3YGpqjweL9bTNH7pHentndoQ9TWa6GTeAqh9zK1w5w==
X-Received: by 2002:adf:c70b:: with SMTP id k11mr33573910wrg.165.1617095669469;
        Tue, 30 Mar 2021 02:14:29 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id l8sm33305840wrx.83.2021.03.30.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:14:29 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 0/4] Add peripheral support to imx8mq-nitrogen board
Date:   Tue, 30 Mar 2021 11:14:22 +0200
Message-Id: <20210330091426.95030-1-adrien.grassein@gmail.com>
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
  - USB Host;
  - USB device;
  - DB_DSIHD sub board for MIPI-DSI to HDMI output (via lt8912b chip).


Updates in v2:
  - Use a GPIO hog to handle the USB HOST reset line;
  - Remove useless GPIO hog for lt8912b.


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

