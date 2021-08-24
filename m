Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716003F5FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhHXOA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:00:58 -0400
Received: from foss.arm.com ([217.140.110.172]:36142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237572AbhHXOA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:00:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68FD41042;
        Tue, 24 Aug 2021 07:00:11 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A81F43F766;
        Tue, 24 Aug 2021 07:00:09 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v4 0/12] Introduce atomic support for SCMI transports
Date:   Tue, 24 Aug 2021 14:59:29 +0100
Message-Id: <20210824135941.38656-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series mainly aims to introduce atomic support for transports
that can support it.

At first in [2/12], as a closely related addition, it is introduced a
common way for a transport to signal to the SCMI core that it does not
offer completion interrupts, so that the usual polling behaviour based
on .poll_done() will be required: this can be done enabling statically
a global polling behaviour for the whole transport with flag
scmi_desc.force_polling OR dynamically enabling at runtime such polling
behaviour on a per-channel basis with scmi_chan_info.no_completion_irq,
typically during .chan_setup(). The usual per-command polling selection
behaviour based on hdr.poll_completion is preserved as before.

Then in [3/12], a transport that supports atomic operations on its TX path
can now declare itself as .atomic_capable and as a consequence the SCMI
core will refrain itself too from sleeping on the correspondent RX-path
even when using completion IRQs.

In [6/12] a simple method is introduced so that an SCMI driver can easily
query the core to check if the currently used transport is configured to
behave in an atomic manner: in this way, interested SCMI driver users, like
Clock framework [7/12], can optionally support atomic operations when
operating on an atomically configured transport.

In [8/12] virtio transport is declared atomic.

Finally there are 4 *tentative" RFC patch related to SMC transport.

At first [9/12] ports SMC to use the common core completions when
completion interrupt is available or otherwise revert to use common core
polling mechanism above introduced: this avoids the improper call of
scmi_rx_callback directly in smc_send_message.
Then in [10/12] SMC is converted to be .atomic_capable by substituting
the mutexes with busy-waiting to keep the channel 'locked'.

With [11/12] I introduce a flag to allow a transport to signal to the core
that upon return of a .send_message() the requested command execution can
be assumed by the core to have been fully completed by the platform, so
that the response payload (if any) can be immediately fetched without the
need to poll the channel.

Finally in [12/12] I enable the above flag for SMC transport.

As a side note on the sync_cmds_atomic_replies flag added in [11/12], note
that such flag assumes that a specific transport can set it and so
univocally assure to the SCMI core that the described behavior holds true
anytime for the said transport; in reality, in a transport like SMC such
behavior could also be dependent on the effective placement of the SCMI
platform server: while a pure EL-3 SCMI server could reasonably assure
that upon smc call termination the command is fully completed, the same
could not be true for an SCMI server living in S-EL1.

For such reasons a possible evolution could be to add also some DT property
to enable the SMC transport to conditionally enable the flag at run-time
depending on the effective runtime platform configuration in terms of
SCMI server placement.

This whole matter is up for discussion, though, maybe it's not even a real
possibility an S-EL1 SCMI server using an SMC transport, so the DT patch
has not been included in this series.

Moreover, SMC changes have NOT been tested so far (I cannot), AND they are
just a proposal at this stage to try to better abstract and unify behaviour
with the SCMI core, so they are marked as RFCs.

Atomic support has been minimally tested against the upcoming virtio
transport V7 series, while polling has been tested with mailbox transports.

The series is based on linux-next/master on top of tag next-20210824 so as
to include the recently queued series on SCMI virtio and its core changes
currently queued also on sudeep/for-next/scmi [1].

Given I'm still gathering feedback on this, I still not have CCed any
maintainer out of SCMI subsystem.

Any feedback welcome.

Thanks,

Cristian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi 

---

V3 --> V4
- rebased on linux-next/master next-20210824
- renamed .needs_polling to .no_completion_irq
- added .sync_cmds_atomic_replies
- make SMC use .sync_cmd_atomic_replies

V2 --> v3
- rebased on SCMI VirtIO V6 which in turn is based on v5.14-rc1


Cristian Marussi (12):
  firmware: arm_scmi: Perform earlier cinfo lookup call in do_xfer
  firmware: arm_scmi: Add configurable polling mode for transports
  firmware: arm_scmi: Add support for atomic transports
  include: trace: Add new scmi_xfer_response_wait event
  firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
  firmware: arm_scmi: Add is_transport_atomic() handle method
  clk: scmi: Support atomic enable/disable API
  firmware: arm_scmi: Declare virtio transport .atomic_capable
  [RFC] firmware: arm_scmi: Make smc transport use common completions
  [RFC] firmware: arm_scmi: Make smc transport atomic
  [RFC] firmware: arm_scmi: Add sync_cmds_atomic_replies transport flag
  [RFC] firmware: arm_scmi: Make smc support atomic commands replies

 drivers/clk/clk-scmi.c             |  44 ++++--
 drivers/firmware/arm_scmi/common.h |  22 +++
 drivers/firmware/arm_scmi/driver.c | 224 +++++++++++++++++++++++------
 drivers/firmware/arm_scmi/smc.c    |  61 +++++---
 drivers/firmware/arm_scmi/virtio.c |   1 +
 include/linux/scmi_protocol.h      |   8 ++
 include/trace/events/scmi.h        |  28 ++++
 7 files changed, 311 insertions(+), 77 deletions(-)

-- 
2.17.1

