Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA36E379B86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhEKAaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:30:05 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:31139 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhEKA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:49 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id DB4CDA1985;
        Tue, 11 May 2021 02:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:message-id:mime-version:reply-to:subject:subject
        :to:to; s=srmailgate02; bh=FCh41QnDzuZx1SoLyt+Ukk7YYsu2IqqxlaWus
        tSRs7g=; b=I0HdMOheNa+7Cq2Nwa31HjKzbuALCcTzteIpWTIS8Gjr2sTFI7/y6
        SASr5wZrrxFuOVVirV6IsX9r2qEcq2DptxDA5DzQjmPtRotbRgi5rBNHqCWR9X0b
        JaVKkj6AXibmQ1gyWQAqzPj3BvAqMrfBEQbsbx5t0Zry5cA5ucCg9zbdFR2tt51D
        Pk3qdn5b4SopoMSMdKwRfEZT7SHfiD5ic9q/OhHYAYpt2i0Mtx2nEvw+fLXYULU3
        McHaUh01BG0aF8ytUUuJjfyUeuF+VIRfAEyfEIb6nKBoqw2d88BSpmZPFwg+NFH3
        Y50FeiNSqyooyzYgpK3FsgUrBav+UXvPw==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>
CC:     Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>
Subject: [RFC PATCH v3 00/12] firmware: arm_scmi: Add virtio transport
Date:   Tue, 11 May 2021 02:20:28 +0200
Message-ID: <20210511002040.802226-1-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements an SCMI virtio driver according to the virtio
SCMI device spec [1], after simple preparatory changes to the
existing arm-scmi driver.

This RFC patch series is intended to give others an understanding of the
current development progress.

The virtio transport differs in some respects from the existing
shared-memory based SCMI transports, and therefore some preparatory
steps are necessary.

The series is based on v5.13-rc1.

Changes in RFC v3:

- Fix scmi_xfer buffer management. Use dedicated buffers for actual
  Tx/Rx. Introduce a message handle, and a drop_message() op for message
  passing-based transports.

- Add service data unit abstraction for transports which use message
  passing.

- The virtio transport doesn't call the core once the channel is not
  ready any more.

- Handle races between core and transport.

- Use generic transport init/deinit (Cristian Marussi).

- Don't use vqueue->priv field (Viresh Kumar).

- Numerous small improvements.

The following problems remain:

- Polling is not implemented.

- When handling races between core and transport, a timeout corner case
  can keep an scmi_xfer permanently occupied.

- We must be sure that the virtio transport option (such as virtio over
  MMIO) is available when the virtio SCMI device is probed.

All other known problems should have been addressed.

Test:

The series was smoke tested with a v5.4 based kernel, with the Base
protocol and Sensor management protocol. The virtio SCMI device used was
a proprietary implementation by OpenSynergy.

The following was not tested yet:

- delayed responses

- driver remove

- timeouts

Changes in RFC v2:

- Remove the DT virtio_transport phandle, since the SCMI virtio device
  may not be known in advance. Instead, use the first suitable probed
  device. Change due to Rob Herring's comment.

Any comments are very welcome.

[1] https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-scmi.tex


Cristian Marussi (1):
  firmware: arm_scmi: Add transport init/deinit

Igor Skalkin (4):
  firmware: arm_scmi, smccc, mailbox: Make shmem based transports
    optional
  firmware: arm_scmi: Add op to override max message #
  dt-bindings: arm: Add virtio transport for SCMI
  firmware: arm_scmi: Add virtio transport

Peter Hilber (7):
  firmware: arm_scmi: Add optional link_supplier() transport op
  firmware: arm_scmi: Add per-device transport private info
  firmware: arm_scmi: Add is_scmi_protocol_device()
  firmware: arm_scmi: Add msg_handle to some transport ops
  firmware: arm_scmi: Add optional drop_message() transport op
  firmware: arm_scmi: Add message passing abstractions for transports
  firmware: arm_scmi: Handle races between core and transport

 .../devicetree/bindings/arm/arm,scmi.txt      |  35 +-
 MAINTAINERS                                   |   1 +
 drivers/firmware/Kconfig                      |  26 +-
 drivers/firmware/arm_scmi/Makefile            |   4 +-
 drivers/firmware/arm_scmi/bus.c               |   5 +
 drivers/firmware/arm_scmi/common.h            |  81 ++-
 drivers/firmware/arm_scmi/driver.c            | 310 +++++++++--
 drivers/firmware/arm_scmi/mailbox.c           |   7 +-
 drivers/firmware/arm_scmi/msg.c               | 113 ++++
 drivers/firmware/arm_scmi/smc.c               |   5 +-
 drivers/firmware/arm_scmi/virtio.c            | 524 ++++++++++++++++++
 drivers/firmware/smccc/Kconfig                |   1 +
 drivers/mailbox/Kconfig                       |   1 +
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  25 +
 15 files changed, 1065 insertions(+), 74 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/msg.c
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.25.1


