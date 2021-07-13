Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604EB3C6EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhGMKxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhGMKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:53:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA63C0613EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:50:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso1837975pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xLUJ1dW1Qt0KgF3pEuea/62PVc6DCT7EsaU/Szp0Bg=;
        b=E2vCdTP4Dqtla5LUcohrAy+3w9yg8TqQrenrE5K9FTm+s6OAAqAP4MkvIUanmoewVh
         p9Xoha8+yUnUYTMCuoC0YpI5U+SKq2/0jW9vqhW6ACR2JbmbQlA9mE3k0V9hJ0hd8oan
         tTlxN5pFfvjiYWIdZqviVCBXIrYVnUuADNxLHBtHQAw7pqzSDE/xUbphfgNvfjOHqS5u
         JeJ0nuh0WIXCgIrUZzo3opYAS5jkLPFYAnwd+nwZ+eSIYIbqkkdOPQeqgg2Mc7wm6yd8
         LE1lVaUisP/flFiy87qUDrIeegoszDgg1BVBZsTYuXAIoMCvvY120W27WX3hWkBNqpEq
         uoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xLUJ1dW1Qt0KgF3pEuea/62PVc6DCT7EsaU/Szp0Bg=;
        b=eyzc0Z8w+c8T8kFj5n973dKNHoJmMKRr3qDoeqi5j3m96VuyyZGkMjV1qvnhiAqlqC
         4UclOLBJE5AuK+j5PAbMdFYeFI0kZ6i5iPKIQVW2lVYhQUZvwbkSUwv9FE7XIhuoo9bw
         6b3Be4IE9ogKI3TOBYs40IblBQT6pg8QdjU6MeUsG3cnZEQJD8154nJKfmBuBDDUs3DB
         qYdo5bUd6WrXQQmMEOT9eWZf6vE5FU4x5aE9mnDCeUxbQDHG9CDJfhkEzzMc+/AEHtQ1
         cUg1OngPbOtcXVI72xKPm4v4dnvw1OcL+R833i+ACUEypFcxg50sJ2kzwEJTzhsuVzzq
         MjHQ==
X-Gm-Message-State: AOAM533oG/w0TtKIuqZxTxekF/o1xsKk2tsDV9EYO/+U+eP2SV4htAR/
        9htVsdAy2ybxWR5PnRyauhqJmw==
X-Google-Smtp-Source: ABdhPJxwSt+fW6q6oLmsbQWUpPWMZxVQMEC0vEz1IMyhrgYVT2WsxbkoAvR6ROOjdRLOSHodWNX0Yg==
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr12591539pjb.123.1626173446842;
        Tue, 13 Jul 2021 03:50:46 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id lj13sm15276916pjb.53.2021.07.13.03.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 03:50:46 -0700 (PDT)
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
Subject: [PATCH 0/5] virtio: Parse virtio-device nodes from DT
Date:   Tue, 13 Jul 2021 16:20:29 +0530
Message-Id: <cover.1626173013.git.viresh.kumar@linaro.org>
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

And each virtio-mmio corresponds to a virtio-device. But there is no way for
other users in the DT to show their dependency on virtio devices.

This patchset provides that support.

The first patch update virtio,mmio bindings to allow for device subnodes to be
present and the second patch updates the virtio-mmio driver to update the
of_node.

Other patches add bindings for i2c and gpio virtio devices (they have some
dependencies, mentioned in the patches).

Tested on x86 with qemu for arm64.

--
Viresh

Viresh Kumar (5):
  dt-bindings: virtio: mmio: Add support for device subnode
  virtio_mmio: Bind virtio device to device-tree node
  dt-bindings: i2c: Add bindings for i2c-virtio
  i2c: virtio: Update i2c-adapter's of_node
  dt-bindings: gpio: Add bindings for gpio-virtio

 .../devicetree/bindings/gpio/gpio-virtio.yaml | 67 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 59 ++++++++++++++++
 .../devicetree/bindings/virtio/mmio.yaml      | 41 ++++++++++++
 drivers/i2c/busses/i2c-virtio.c               |  1 +
 drivers/virtio/virtio_mmio.c                  | 44 ++++++++++++
 include/dt-bindings/virtio/virtio_ids.h       |  1 +
 6 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
 create mode 120000 include/dt-bindings/virtio/virtio_ids.h

-- 
2.31.1.272.g89b43f80a514

