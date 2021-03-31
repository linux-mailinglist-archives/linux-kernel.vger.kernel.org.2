Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4870E350AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhCaXYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCaXYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:24:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28279C061574;
        Wed, 31 Mar 2021 16:24:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z2so21250811wrl.5;
        Wed, 31 Mar 2021 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmV7bsD3079FhPGeR+NPlT6XRWILLECqCaOl72fDWFs=;
        b=bXCACYRX/djgxFAejtEdDm3upE/3aE9oU4l2pbC+d4zWIe6/RXR0jpfTxWRaJvYDWn
         3vl0mp+7Dsg4YLD/b8l0o2sEOPeeWjh1AlPnIobsOXqmMZf35lQGNMVAj7kefS6fTguJ
         1W2KhenQMpoYEPvhuXaIoD9f6nURYPd86ZCUiw2yMKZ3qjEmltNNNLIjH5LVb0Vy4fxw
         AXx1dGdnJjZ3O/hQT+DId6q44Le9zexzBf/YoomvOAGHoPR1Oicvq2+OeD53pWz5FyzE
         njEgDnHZWK/t8qRyXjWOBMUcvwRsbpfwonLtK9QeXS1MSliIBaTynkX8sWvIIqec7/oQ
         B/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmV7bsD3079FhPGeR+NPlT6XRWILLECqCaOl72fDWFs=;
        b=VOubw/qBV+9z4/D7CPG1qqLrgaX1NIb3SHVBgJwVB7d572UIgrcWw9fa+oIDl6JJvJ
         0927FzbQDBR0IbEDje6pmJc6XDUBF1z35Imv2L7LdP2GO3IdK50R+zWiAMt2BV24W3/N
         gXxnwtuK7RBLW4Ukv3wXK5gf9WkwyaaPXUabQPEP4y25ORXGPQGicD8ShEE62MOHxYQF
         lLS8SPm9CxYDwRZ11qvYUtLs7iGSpkoyj05cRedt3BCYX/BQcPlfjoHmdAfV3+1iOFYU
         H4d1qSGK2LDRliMmooD/BdEw+v4y6/Z8BxrLV8zMQtXSiRPm9xWDbUPm8vpN/qyCW1Kn
         W6uw==
X-Gm-Message-State: AOAM531o4eok6zF0E7hiSP2Xq3is691/4zlkciIVpsclq/jceTI+gbGB
        LWTEtJNgKkrNh8umfUHr8YG8dTR2oxc=
X-Google-Smtp-Source: ABdhPJwmAqEskNEpxs9rH0nlfEuPHxKDi8Evc0T5PsAYABC2wqYmQQntnNAwvbp9+WiJA2Rmz221OA==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr6218334wrt.255.1617233038862;
        Wed, 31 Mar 2021 16:23:58 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27007d57ea0d08d946c1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:7d57:ea0d:8d9:46c1])
        by smtp.gmail.com with ESMTPSA id t14sm6343041wru.64.2021.03.31.16.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 16:23:58 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 0/4] Add peripheral support to imx8mq-nitrogen board
Date:   Thu,  1 Apr 2021 01:23:52 +0200
Message-Id: <20210331232356.2204476-1-adrien.grassein@gmail.com>
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

Update in v3:
  - Fix bad squash in git commits.

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

