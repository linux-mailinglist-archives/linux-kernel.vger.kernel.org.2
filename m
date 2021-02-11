Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA6319205
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhBKSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhBKRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:52:42 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3FEC061786;
        Thu, 11 Feb 2021 09:50:21 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4A7001F4EA;
        Thu, 11 Feb 2021 18:50:17 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     elder@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, davem@davemloft.net,
        kuba@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v1 0/7] Add support for IPA v3.1, GSI v1.0, MSM8998 IPA
Date:   Thu, 11 Feb 2021 18:50:08 +0100
Message-Id: <20210211175015.200772-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all!

This time around I thought that it would be nice to get some modem
action going on. We have it, it's working (ish), so just.. why not.

This series adds support for IPA v3.1 (featuring GSI v1.0) and also
takes account for some bits that are shared with other unimplemented
IPA v3 variants and it is specifically targeting MSM8998, for which
support is added.

Since the userspace isn't entirely ready (as far as I can see) for
data connection (3g/lte/whatever) through the modem, it was possible
to only partially test this series.
Specifically, loading the IPA firmware and setting up the interface
went just fine, along with a basic setup of the network interface
that got exposed by this driver.

With this series, the benefits that I see are:
 1. The modem doesn't crash anymore when trying to setup a data
    connection, as now the modem firmware seems to be happy with
    having IPA initialized and ready;
 2. Other random modem crashes while picking up LTE home network
    signal (even just for calling, nothing fancy) seem to be gone.

These are the reasons why I think that this series is ready for
upstream action. It's *at least* stabilizing the platform when
the modem is up.

This was tested on the F(x)Tec Pro 1 (MSM8998) smartphone.

AngeloGioacchino Del Regno (7):
  net: ipa: Add support for IPA v3.1 with GSI v1.0
  net: ipa: endpoint: Don't read unexistant register on IPAv3.1
  net: ipa: gsi: Avoid some writes during irq setup for older IPA
  net: ipa: gsi: Use right masks for GSI v1.0 channels hw param
  net: ipa: Add support for IPA on MSM8998
  dt-bindings: net: qcom-ipa: Document qcom,sc7180-ipa compatible
  dt-bindings: net: qcom-ipa: Document qcom,msm8998-ipa compatible

 .../devicetree/bindings/net/qcom,ipa.yaml     |   7 +-
 drivers/net/ipa/Makefile                      |   3 +-
 drivers/net/ipa/gsi.c                         |  33 +-
 drivers/net/ipa/gsi_reg.h                     |   5 +
 drivers/net/ipa/ipa_data-msm8998.c            | 407 ++++++++++++++++++
 drivers/net/ipa/ipa_data.h                    |   5 +
 drivers/net/ipa/ipa_endpoint.c                |  26 +-
 drivers/net/ipa/ipa_main.c                    |  12 +-
 drivers/net/ipa/ipa_reg.h                     |   3 +
 drivers/net/ipa/ipa_version.h                 |   1 +
 10 files changed, 480 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/ipa/ipa_data-msm8998.c

-- 
2.30.0

