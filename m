Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4113BBE68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGEOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:52:48 -0400
Received: from foss.arm.com ([217.140.110.172]:47908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGEOwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:52:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AA371FB;
        Mon,  5 Jul 2021 07:50:09 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53A5D3F694;
        Mon,  5 Jul 2021 07:50:05 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: [PATCH v5 00/15] Introduce SCMI transport based on VirtIO
Date:   Mon,  5 Jul 2021 15:48:59 +0100
Message-Id: <20210705144914.35094-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While reworking this series starting from the work done up to V3 by
OpenSynergy, I am keeping the original autorship and list distribution
unchanged.

The main aim of this rework, as said, is to simplify where possible the
SCMI VirtIO support added in V3 by adding at first some new general
mechanisms in the SCMI Transport layer.

Indeed, after some initial small fixes, patches 05/06/07/08 add such new
additional mechanisms to the SCMI core to ease implementation of more
complex transports like virtio, while also addressing a few general issues
already potentially affecting existing transports.

In terms of rework I dropped original V3 patches 05/06/07/08/12 as no more
needed, and modified where needed the remaining original patches to take
advantage of the above mentioned new SCMI transport features.

DT bindings patch has been ported on top of freshly YAML converted arm,scmi
bindings.

Moreover, in V5 I dropped support for polling mode from the virtio-scmi
transport, since it is an optional general mechanism provided by the core
to allow transports lacking a completion IRQ to work and it seemed a
needless addition/complication in the context of virtio transport.

Additionally, in V5 I could also simplify a bit the virtio transport
probing sequence starting from the observation that, by the VirtIO spec,
in fact, only one single SCMI VirtIO device can possibly exist on a system.

This V5 series is based on top of next-20210701 in order to include all the
recent DT YAML-conversion changes and all the fixes queued as of today in
sudeep/for-next/scmi.

The series has been tested using an emulated fake SCMI device and also a
proper SCP-fw stack running through QEMU vhost-users, with the SCMI stack
compiled, in both cases, as builtin and as s loadable module, running tests
against mocked SCMI Sensors using HWMON and IIO interfaces to check the
functionality of notifications and sync/async commands.

Virtio-scmi support has been exercised in the following testing scenario
on a JUNO board:

 - normal sync/async command transfers
 - notifications
 - concurrent delivery of correlated response and delayed responses
 - out-of-order delivery of delayed responses before related responses
 - unexpected delayed response delivery for sync commands
 - late delivery of timed-out responses and delayed responses

Some basic regression testing against mailbox transport has been performed
for commands and notifications too.

No sensible overhead in total handling time of commands and notifications
has been observed, even though this series do indeed add a considerable
amount of code to execute on TX path.
More test and measurements could be needed in these regards.

Any feedback/testing is welcome :D

Thanks,
Cristian
---

Cristian Marussi (9):
  firmware: arm_scmi: Avoid padding in sensor message structure
  firmware: arm_scmi: Fix max pending messages boundary check
  firmware: arm_scmi: Add support for type handling in common functions
  firmware: arm_scmi: Remove scmi_dump_header_dbg() helper
  firmware: arm_scmi: Add transport optional init/exit support
  firmware: arm_scmi: Introduce monotonically increasing tokens
  firmware: arm_scmi: Handle concurrent and out-of-order messages
  firmware: arm_scmi: Introduce optional support for delegated xfers
  firmware: arm_scmi: Make SCMI transports configurable

Igor Skalkin (4):
  firmware: arm_scmi: Make shmem support optional for transports
  firmware: arm_scmi: Add method to override max message number
  dt-bindings: arm: Add virtio transport for SCMI
  firmware: arm_scmi: Add virtio transport

Peter Hilber (2):
  firmware: arm_scmi: Add message passing abstractions for transports
  firmware: arm_scmi: Add optional link_supplier() transport op

 .../bindings/firmware/arm,scmi.yaml           |   8 +-
 MAINTAINERS                                   |   1 +
 drivers/firmware/Kconfig                      |  34 +-
 drivers/firmware/arm_scmi/Kconfig             |  97 +++
 drivers/firmware/arm_scmi/Makefile            |   8 +-
 drivers/firmware/arm_scmi/common.h            |  99 ++-
 drivers/firmware/arm_scmi/driver.c            | 792 ++++++++++++++++--
 drivers/firmware/arm_scmi/msg.c               | 113 +++
 drivers/firmware/arm_scmi/sensors.c           |   6 +-
 drivers/firmware/arm_scmi/virtio.c            | 545 ++++++++++++
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  23 +
 12 files changed, 1593 insertions(+), 134 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/msg.c
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h

-- 
2.17.1

