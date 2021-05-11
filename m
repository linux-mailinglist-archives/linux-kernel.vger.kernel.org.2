Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128AB37ADDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhEKSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhEKSJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3FFC061760
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v8so1723386qkv.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5/6pzxNzbbYkFsZXg0EnLX6bHrV+zgSw51fRvk1jaw=;
        b=GxqXSpc9O3mQr6WF2n529jLUFaUDRLuLriBdpyn0AZdRmFZL30u5fVlxn6NBAZUYlS
         UuEdXTOgaE8+46iQTvUj5Cxi+zP087QIt+Q4KbqDdvw8qljS6C7fYaaphVAg/lXkdwQb
         63cy2eJymoWOm24Kq0QVkSpU4P473CSkNrOu6n9RscYz6sg8LMXvvtBrLacse+7KrC5I
         zZzvY0eWm6SB7c9dQhVXjBs0wpvlr8qUVxXQtn+9NSf5xMWX7Wi8Dp+jJjHGc1A85XBx
         mzS5RUqsoPSOFzXOTwmY/20OpyEwohkPDTUXAnpwZnVezauDybPjQBFeQbgTJC4IgHrz
         Ofug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5/6pzxNzbbYkFsZXg0EnLX6bHrV+zgSw51fRvk1jaw=;
        b=FG0KlbP5kyvAbD3ZwvBBOsIotk9luA2oOBJgDc9I7BkdY4ExQgBP5anu+tzBkSR29b
         zqLGoQensgQuyYw/s7yn/l3xR/f3Ik1nXwbEli/bqn/oODsfSvNhG83nlmRsO440vzSx
         9OI1YvkXFWWHQL/1hbNBetxM4Lc/No9SvEG3pRF7HYrQtSmcW+fn20izLcPocT967biG
         wSq0Og7ODojY1Tf3vxlVVwE0ClErJjetPfk008sGCHVO1uz9hVcnz4OZlNK2v0022ft3
         Ynm/lSaPjIkms7iyFwdpN1aayj4OQCTC4pkOewkCMN46QfG/E977hj6Kx6Zj/bCPLyQG
         ekQA==
X-Gm-Message-State: AOAM531K1+ndzW1ggua4HPlnhPOALyrnCidfm5UuPa8x9Wpeb1SmG0Nc
        YIxe7gVNB1sUW02UEWehxZz0dQ==
X-Google-Smtp-Source: ABdhPJx8gtspoCkhqQR/buYqOvYmOoVT/ts0w783jwbgCnO58tAbN0EGk2e/Hpn9a+JSCs8Vzsnfjw==
X-Received: by 2002:a05:620a:21c5:: with SMTP id h5mr23029616qka.395.1620756486485;
        Tue, 11 May 2021 11:08:06 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g5sm17104476qtm.2.2021.05.11.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:06 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:QUALCOMM CAMERA SUBSYSTEM DRIVER),
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Todor Tomov <todor.too@gmail.com>
Subject: [PATCH 00/17] CAMSS: SM8250 support (and some fixes)
Date:   Tue, 11 May 2021 14:07:07 -0400
Message-Id: <20210511180728.23781-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds initial support for SM8250 and its 4 VFEs and 6 CSIPHYs.
The only big change is the added camss-vfe-480.c to support the
Titan 480 VFE.

Jonathan Marek (17):
  media: camss: csiphy-3ph: don't print HW version as an error
  media: camss: csiphy-3ph: disable interrupts
  media: camss: csiphy-3ph: add support for SM8250 CSI DPHY
  media: camss: csid-170: fix non-10bit formats
  media: camss: csid-170: don't enable unused irqs
  media: camss: csid-170: remove stray comment
  media: camss: csid-170: support more than one lite vfe
  media: camss: csid-170: set the right HALF_CMD when disabled
  media: camss: csid: allow csid to work without a regulator
  media: camss: remove vdda-csiN from sdm845 resources
  media: camss: fix VFE irq name
  media: camss: vfe-170: clean up some dead code
  media: camss: vfe-170: fix "VFE halt timeout" error
  media: camss: Add initial support for VFE hardware version Titan 480
  media: camss: add support for V4L2_PIX_FMT_GREY for sdm845 HW
  media: camss: add support for SM8250 camss
  media: dt-bindings: media: camss: Add qcom,sm8250-camss binding

 .../bindings/media/qcom,sm8250-camss.yaml     | 398 +++++++++++++
 drivers/media/platform/qcom/camss/Makefile    |   1 +
 .../platform/qcom/camss/camss-csid-170.c      |  31 +-
 .../media/platform/qcom/camss/camss-csid.c    |  39 +-
 .../qcom/camss/camss-csiphy-3ph-1-0.c         | 181 ++++--
 .../media/platform/qcom/camss/camss-csiphy.c  |   9 +-
 .../media/platform/qcom/camss/camss-vfe-170.c |  65 +-
 .../media/platform/qcom/camss/camss-vfe-480.c | 554 ++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c |  13 +-
 drivers/media/platform/qcom/camss/camss-vfe.h |   1 +
 .../media/platform/qcom/camss/camss-video.c   |   5 +-
 drivers/media/platform/qcom/camss/camss.c     | 202 ++++++-
 drivers/media/platform/qcom/camss/camss.h     |   1 +
 13 files changed, 1352 insertions(+), 148 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-480.c

-- 
2.26.1

