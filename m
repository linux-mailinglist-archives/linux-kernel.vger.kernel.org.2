Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DF6416186
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbhIWO77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:59:59 -0400
Received: from foss.arm.com ([217.140.110.172]:35768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241501AbhIWO76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:59:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5259D6E;
        Thu, 23 Sep 2021 07:58:26 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB23A3F718;
        Thu, 23 Sep 2021 07:58:24 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v5 0/13] Introduce atomic support for SCMI transports
Date:   Thu, 23 Sep 2021 15:57:49 +0100
Message-Id: <20210923145802.50938-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series mainly aims to introduce atomic support for transports
that can support it.

At first in [02/13], as a closely related addition, it is introduced a
common way for a transport to signal to the SCMI core that it does not
offer completion interrupts, so that the usual polling behaviour based
on .poll_done() will be required: this can be done enabling statically
a global polling behaviour for the whole transport with flag
scmi_desc.force_polling OR dynamically enabling at runtime such polling
behaviour on a per-channel basis with scmi_chan_info.no_completion_irq,
typically during .chan_setup(). The usual per-command polling selection
behaviour based on hdr.poll_completion is preserved as before.

In [03/13] a Kconfig is added to enable at build-time force_polling on
SCMI Mailbox transport only. (VirtIO does not support polling, while it
does not make sense to support global force_polling on SMC given the
presence of sync_cmds_atomic_replies flag)

Then in [04/13], a transport that supports atomic operations on its TX
path can now declare itself as .atomic_capable and, if the platform has
been also configured to use such atomic operation mode, the SCMI core will
refrain itself too from sleeping on the correspondent RX-path even when
using completion IRQs.

In [07/13] a simple method is introduced so that an SCMI driver can easily
query the core to check if the currently used transport is configured to
behave in an atomic manner: in this way, interested SCMI driver users, like
Clock framework [08/13], can optionally support atomic operations when
operating on an atomically configured transport.

In [09/13] virtio transport is declared atomic and a new Kconfig is added
to be able to choose at build time if that specific platform should use
the atomic operation mode or not; such new option is default N, so VirtIO
will continue to operate in non-atomic mode unless otherwise specified.

Finally there are 4 patches related to SMC transport.

At first [10/13] ports SMC to use the common core completions when
completion interrupt is available or otherwise revert to use common core
polling mechanism above introduced: this avoids the improper call of
scmi_rx_callback directly in smc_send_message.

Then in [11/13] SMC is converted to be .atomic_capable by substituting
the mutexes with busy-waiting to keep the channel 'locked' ONLY IF the
SMC transport is configured to operate in atomic mode.
(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE=y)

With [12/13] I introduce a flag to allow a transport to signal to the core
that upon return of a .send_message() the requested command execution can
be assumed by the core to have been fully completed by the platform, so
that the response payload (if any) can be immediately fetched without the
need to poll the channel.

Finally in [13/13] I enable the above flag for SMC transport.

Atomic support has been minimally tested against the virtio transport,
while polling has been tested with mailbox transports.

The series is based on sudeep/for-next/scmi[1] on top of:

commit 1cd73200dad2 ("firmware: arm_scmi: Remove __exit annotation")

Given I'm still gathering feedback on this, I still not have CCed any
maintainer out of SCMI subsystem.

Any feedback welcome.

Thanks,

Cristian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi 

---
V4 --> V5
- removed RFCs tags
- added scmi_desc.atomic_enabled flags and a few Kconfig options to set
  atomic mode for SMC and VirtIO transports. Default disabled.
- added Kconfig option to enable forced polling as a whole on the Mailbox
  transport
- removed .poll_done callback from SMC transport since no real polling is
  needed once sync_cmds_atomic_replies is set
- made atomic_capable changes on SMC transport dependent on Kconfig
  CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE: so no change and no busy waiting
  if atomic mode is NOT enabled in Kconfig.
- made const: force_polling/atomic_capable/atomic_enabled/sync_cmds_atomic_replies

V3 --> V4
- rebased on linux-next/master next-20210824
- renamed .needs_polling to .no_completion_irq
- added .sync_cmds_atomic_replies
- make SMC use .sync_cmd_atomic_replies

V2 --> v3
- rebased on SCMI VirtIO V6 which in turn is based on v5.14-rc1


Cristian Marussi (13):
  firmware: arm_scmi: Perform earlier cinfo lookup call in do_xfer
  firmware: arm_scmi: Add configurable polling mode for transports
  firmware: arm_scmi: Add forced polling support to mailbox transport
  firmware: arm_scmi: Add support for atomic transports
  include: trace: Add new scmi_xfer_response_wait event
  firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
  firmware: arm_scmi: Add is_transport_atomic() handle method
  clk: scmi: Support atomic enable/disable API
  firmware: arm_scmi: Add atomic mode support to virtio transport
  firmware: arm_scmi: Make smc transport use common completions
  firmware: arm_scmi: Add atomic mode support to smc transport
  firmware: arm_scmi: Add sync_cmds_atomic_replies transport flag
  firmware: arm_scmi: Make smc support atomic sync commands replies

 drivers/clk/clk-scmi.c              |  44 ++++-
 drivers/firmware/arm_scmi/Kconfig   |  38 +++++
 drivers/firmware/arm_scmi/common.h  |  25 +++
 drivers/firmware/arm_scmi/driver.c  | 251 +++++++++++++++++++++++-----
 drivers/firmware/arm_scmi/mailbox.c |   1 +
 drivers/firmware/arm_scmi/smc.c     | 114 ++++++++++---
 drivers/firmware/arm_scmi/virtio.c  |   2 +
 include/linux/scmi_protocol.h       |   8 +
 include/trace/events/scmi.h         |  28 ++++
 9 files changed, 432 insertions(+), 79 deletions(-)

-- 
2.17.1

