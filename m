Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6493D2156
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGVJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhGVJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:16:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC5C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:56:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e14so3848156plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95+EWQpHPYU4UdkXqyGmVpXQnpCt50H8R7U1NdxVx1Y=;
        b=i3U8N+tEhW+LW38nVEAcGy2SDigyEJu5MrcAHdaCZnZvI3yoKV3rgKaPZvna1Qaee/
         wCFeLlbX3scqTlPnefRqOpyrBwWV+fjfK11fJYk1TDbvG6TjQDYEaJ/BcEyPL1QOPdWU
         hugqnJ3SWjVw6XQxsCzhB8WiAWjX7iPr279lZ1QAPF3CeyfNovM72NaMrayS6ZIkxx5Z
         UCfXcGquPRFyWbcJMr8CM+d2MDLywk6xC8Ib7XpyGyGSGPqRKckjNOQ7t8x3Ay12v3sy
         URMVl1JsyV/idSQIO9eV/THkJAYYljbfRVW9H1vcW6UMt9XPutSjOsR3ZU36asE8QJnh
         UiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95+EWQpHPYU4UdkXqyGmVpXQnpCt50H8R7U1NdxVx1Y=;
        b=MQ1iJv32XLEwgukTkokJ31bIPze5D5/znnqhbCZ3HiYQLoZv4q9uKfGqdLjKsyM/uY
         i8E/d7bW8ufxhe2tJtPeKiLoe5tu00+mKvdsPTSqnS9z35zOr5IDuHa7RTcFKTj5fylN
         rfnEZuhFfYER9+rxc+/p3+wkZbG+0n0je/wXqC2DIlm8Phu/XWbzmyxz2k6ulmQicD0J
         XGBUM3oVdbNEfheIPh+Hj4hURIoxBQet+XAIodhDQ2SpN8A4beyUbytTlmTJ+zSncIyj
         1N0mKGw87rPWT0D60z1XztpX1gS7BD08QTNz3xt3jJ+5LTaNRdCYNw+HvpoU/BEB1b/u
         HNeg==
X-Gm-Message-State: AOAM532+d1wSrlOhlmmWS/8mqfsz/jiFgUomf9vC+kPRATyezgqM5lNL
        JmR2tw1AZf/HP7JpSvo6jEiVYw==
X-Google-Smtp-Source: ABdhPJzHw29QGU7w1n29t6HldkPP4fdUC6UQrBEYR9Zbf4pHntjA3REhqKrWZyLwpSmu9u5mGl6POg==
X-Received: by 2002:a63:2fc2:: with SMTP id v185mr20230069pgv.71.1626947809408;
        Thu, 22 Jul 2021 02:56:49 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id r15sm25273137pje.12.2021.07.22.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:56:47 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH V2 0/5] virtio: Add virtio-device bindings
Date:   Thu, 22 Jul 2021 15:26:38 +0530
Message-Id: <cover.1626947324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently the DT only provides support for following node types for virtio-mmio
nodes:

        virtio_mmio@a000000 {
                dma-coherent;
                interrupts = <0x00 0x10 0x01>;
                reg = <0x00 0xa000000 0x00 0x200>;
                compatible = "virtio,mmio";
        };

Here, each virtio-mmio corresponds to a virtio-device. But there is no way for
other users in the DT to show their dependency on virtio devices.

This patchset provides that support.

The first patch adds virtio-device bindings to allow for device sub-nodes to be
present and the second patch updates the virtio core to update the of_node.

Other patches add bindings for i2c and gpio devices.

Tested on x86 with qemu for arm64.

V1->V2:
- The changes (both binding and code) are made at virtio level, instead of
  virtio-mmio. This allows the same to be used by all device types, irrespective
  of the transport mechanism.

- Dropped the reg property and used compatible in the form "virtio,<DID>".

- Dropped dt-bindings/virtio/virtio_ids.h.

- Add a patch to sync virtio-ids from spec, required for the last patch.

--
Viresh

Viresh Kumar (5):
  dt-bindings: virtio: Add binding for virtio devices
  dt-bindings: i2c: Add bindings for i2c-virtio
  dt-bindings: gpio: Add bindings for gpio-virtio
  uapi: virtio_ids: Sync ids with specification
  virtio: Bind virtio device to device-tree node

 .../devicetree/bindings/gpio/gpio-virtio.yaml | 60 +++++++++++++++++
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 51 ++++++++++++++
 .../devicetree/bindings/virtio/mmio.yaml      |  2 +-
 .../bindings/virtio/virtio-device.yaml        | 47 +++++++++++++
 drivers/virtio/virtio.c                       | 67 ++++++++++++++++++-
 include/uapi/linux/virtio_ids.h               | 12 ++++
 6 files changed, 235 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml

-- 
2.31.1.272.g89b43f80a514

