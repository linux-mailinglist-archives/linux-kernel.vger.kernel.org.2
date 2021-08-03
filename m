Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255D23DEEC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhHCNLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:11:13 -0400
Received: from foss.arm.com ([217.140.110.172]:49504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236003AbhHCNLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:11:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A277C11FB;
        Tue,  3 Aug 2021 06:11:00 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 690DE3F70D;
        Tue,  3 Aug 2021 06:10:57 -0700 (PDT)
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
Subject: [PATCH v7 00/15] Introduce SCMI transport based on VirtIO
Date:   Tue,  3 Aug 2021 14:10:09 +0100
Message-Id: <20210803131024.40280-1-cristian.marussi@arm.com>
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

Indeed, after some initial small fixes, patches 03/04/05 add such new
additional mechanisms to the SCMI core to ease implementation of more
complex transports like virtio, while also addressing a few general issues
already potentially affecting existing transports.

In terms of rework I dropped original V3 patches 05/06/07/08/12 as no more
needed, and modified where needed the remaining original patches to take
advantage of the above mentioned new SCMI transport features.

DT bindings patch has been ported on top of freshly YAML converted arm,scmi
bindings.

Moreover, since V5 I dropped support for polling mode from the virtio-scmi
transport, since it is an optional general mechanism provided by the core
to allow transports lacking a completion IRQ to work and it seemed a
needless addition/complication in the context of virtio transport.

Additionally, since V5 I simplified a bit the virtio-scmi transport probing
sequence observing that, as of now, only one single SCMI VirtIO device can
be possibly used, since the SCMI VirtIO devices are not identifiable from
the VirtIO layer and neither they are currently identifiable from the DT
config; as a consequence only one single SCMI transport channel is
currently supported when using virtio-scmi transport.

The series has been tested using an emulated fake SCMI device and also a
proper SCP-fw SCMI stack running through QEMU vhost-users, with the SCMI
stack compiled, in both cases, as builtin and as a loadable module, running
tests against mocked SCMI Sensors using HWMON and IIO interfaces to check
the functionality of notifications and sync/async commands.

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

This series is based on sudeep/for-next/scmi [1] on top of

commit bdb8742dc6f7 ("firmware: arm_scmi: Fix range check for the maximum
		     number of pending messages")

Any feedback/testing is welcome :D

Thanks,
Cristian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
---
v6 --> v7
 - rebased on sudeep/for-next/scmi (v5.14-rc1)
 - added Cc: for maintainers regarding Virtio SCMI device number addition
   in include/uapi/linux/virtio_ids.h (previously only list was Cc'ed)
 - V6 patches 01 and 02 have been removed from V7 since already queued on
   sudeep/for-next/scmi
 - renamed scmi_desc .init/.exit to .transport_init/.exit
 - moved "firmware: arm_scmi: Add priv parameter to scmi_rx_callback" later
   in the series
 - simplified new SCMI Kconfig layout
 - refactored/simplified  support for non-polling transports
 - moved introduction of xfer refcounting from "firmware: arm_scmi:
   Introduce monotonically increasing tokens" to "firmware: arm_scmi:
   Handle concurrent and out-of-order messages"
 - renamed scmi_xfer_is_free to scmi_xfer_acquired
 - moved scmi_xfer_state_update() call inside scmi_xfer_command_acquire
 - added missing barrier in do_xfer()
 - added proper comment to justify pending_xfers sizing and relocated such
   #define directive
 - removed last_token atomic counter, now generating monotonic seqnums
   based on transfer_id

V5 --> V6:
 - removed delegated xfers and its usage
 - add and use *priv optional parameter in scmi_rx_callback()
 - made .poll_done and .clear_channel ops optional

V4 --> V5:
 - removed msg raw_payload helpers
 - reworked msg helpers to use xfer->priv reference
 - simplified SCMI device probe sequence (one static device)
 - added new SCMI Kconfig layout
 - removed SCMI virtio polling support

V3 --> V4:
 - using new delegated xfers support and monotonically increasing tokens
   in virtio transport
 - ported SCMI virtio transport DT bindings to YAML format
 - added virtio-scmi polling support
 - added delegated xfers support


Cristian Marussi (9):
  firmware: arm_scmi: Add support for type handling in common functions
  firmware: arm_scmi: Remove scmi_dump_header_dbg() helper
  firmware: arm_scmi: Add optional transport_init/exit support
  firmware: arm_scmi: Introduce monotonically increasing tokens
  firmware: arm_scmi: Handle concurrent and out-of-order messages
  firmware: arm_scmi: Make .clear_channel optional
  firmware: arm_scmi: Make polling mode optional
  firmware: arm_scmi: Make SCMI transports configurable
  firmware: arm_scmi: Add priv parameter to scmi_rx_callback

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
 drivers/firmware/arm_scmi/Kconfig             |  95 +++
 drivers/firmware/arm_scmi/Makefile            |   8 +-
 drivers/firmware/arm_scmi/common.h            | 113 ++-
 drivers/firmware/arm_scmi/driver.c            | 649 +++++++++++++++---
 drivers/firmware/arm_scmi/mailbox.c           |   2 +-
 drivers/firmware/arm_scmi/msg.c               | 111 +++
 drivers/firmware/arm_scmi/smc.c               |   3 +-
 drivers/firmware/arm_scmi/virtio.c            | 491 +++++++++++++
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  24 +
 13 files changed, 1403 insertions(+), 137 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/msg.c
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h

-- 
2.17.1

