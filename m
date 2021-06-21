Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A423AF4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFUSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhFUSQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:16:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA91C08ED4B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:56:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a6so8243621ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IV95GMbU/+c678tswYY3L9SohfbRzkw3apADsCCEPR4=;
        b=N8FZrnlSmGZsKkgxuqor+nYtDsFl3WWcjXfqc7RyjIrL9D2XnzaXDBCx21T9ODu8Fi
         q03iUsN6caOhg5x1NryfeP+8d1Fh0ftGHY32+Rcvh9OTv6bHHMN0uuoNqK6ERNo0ZRql
         ea2waOflPGGF32s/P877qcP7JmsNVpWMukaNoXZZcogTS5/nFgQoQ3fhA8YhKVvLznsW
         zNPnOslWv6HzyN3Fp77tT5udQHU9opPstsUexGf1F1WJdOXSHjGyQeVBmQnGvrFbrm3Y
         PE+h97+jcEgtcb6E43L7SKX2kzxOznpMBz2g9Ro6wtfL2zi6DDFjsbzfnwJEKglq+6s4
         2G5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IV95GMbU/+c678tswYY3L9SohfbRzkw3apADsCCEPR4=;
        b=ds3DkuFrq/WhoDrYoyOV4LlShJLnQFhpluJvuUWCx5WFEhmsTrayrVAIJtWkYztOXS
         0GHdrxTzv2q7XVgJ8iyRPTJ5zIyEIwJCK5ekhfH3CCrYTpNOUaMtNBFm1WrZj9v4P0M2
         TusqSYb5XBvOrTmsZOzqoq8xv7swItNJsLvUExUGHXXea+OjQFKiAy0LwQnVvH2QpKyD
         qabPUuEzXhTxYSthfqon3cxJAY/SIioU/WewNJVjpD9Sw1h+zRfX8h8HLMHVpBGnaNWC
         TcHop9OUCohWa+kGuyMn/uC0lI+xcmSH5c/svrAPm9y8hZDQRB0Bv3Q1VMDqGuNyetYK
         LKPw==
X-Gm-Message-State: AOAM531QMc2Pb9twDzePD34ziTGpWXkAcIIrZD68szRY19sDfHZhTlO/
        on/EUBDp6GYVTxUIc7xifX+Qxg==
X-Google-Smtp-Source: ABdhPJysswUYpGvk3TRgNscJn2cqDNovUnctIaKHNvC6wYmw/FJo3NIZ9iwg/hf1z2bUJkvfNe5izQ==
X-Received: by 2002:a05:6602:134f:: with SMTP id i15mr15993299iov.143.1624298191316;
        Mon, 21 Jun 2021 10:56:31 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m13sm6259264iob.35.2021.06.21.10.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:56:30 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org
Cc:     angelogioacchino.delregno@somainline.org, jamipkettunen@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: add support for IPA v3.1
Date:   Mon, 21 Jun 2021 12:56:21 -0500
Message-Id: <20210621175627.238474-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for IPA v3.1, used by the Qualcomm
Snapdragon 835 (MSM8998).

The first patch adds "qcom,msm8998-ipa" to the DT binding.

The next four patches add code to ensure correct operation on
IPA v3.1:
  - Avoid touching unsupported inter-EE interrupt mask registers
  - Set the proper flags in the clock configuration register
  - Work around the lack of an IPA FLAVOR_0 register
  - Work around the lack of a GSI PARAM_2 register

The last patch defines configuration data for this version of IPA.

Many thanks are due to AngeloGioacchino Del Regno and Jami Kettunen,
both associated with SoMainline.  Angelo first posted code to
implement most of what was required for this, and Jami has been
helpful testing these changes on his hardware.

					-Alex

Alex Elder (6):
  dt-bindings: net: qcom,ipa: add support for MSM8998
  net: ipa: inter-EE interrupts aren't always available
  net: ipa: disable misc clock gating for IPA v3.1
  net: ipa: FLAVOR_0 register doesn't exist until IPA v3.5
  net: ipa: introduce gsi_ring_setup()
  net: ipa: add IPA v3.1 configuration data

 .../devicetree/bindings/net/qcom,ipa.yaml     |   1 +
 drivers/net/ipa/Makefile                      |   6 +-
 drivers/net/ipa/gsi.c                         |  90 ++-
 drivers/net/ipa/gsi.h                         |   2 +-
 drivers/net/ipa/gsi_reg.h                     |   3 +-
 drivers/net/ipa/ipa_data-v3.1.c               | 533 ++++++++++++++++++
 drivers/net/ipa/ipa_data.h                    |   1 +
 drivers/net/ipa/ipa_endpoint.c                |  15 +
 drivers/net/ipa/ipa_main.c                    |  18 +-
 9 files changed, 629 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ipa/ipa_data-v3.1.c

-- 
2.27.0

