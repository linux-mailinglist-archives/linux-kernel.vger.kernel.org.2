Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8675639D1C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFFWO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:14:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhFFWO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:14:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A73AE31B;
        Sun,  6 Jun 2021 15:13:06 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FC053F719;
        Sun,  6 Jun 2021 15:13:04 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH 00/10] Introduce SCMI transport atomic support
Date:   Sun,  6 Jun 2021 23:12:22 +0100
Message-Id: <20210606221232.33768-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This RFC series mainly aims to introduce atomic support for transport that
can support it.

At first in [03/10], as a closely related addition, it is introduced a
common way  for a transport to signal to the SCMI core that it does not
offer completion interrupts, so that the usual polling behaviour based
on .poll_done() will be required: this can be done enabling statically
a global polling behaviour for the whole transport with flag
scmi_desc.force_polling OR dynamically enabling at runtime such polling
behaviour on a per-channel basis with scmi_chan_info.needs_polling,
typically during .chan_setup(). The usual per-command polling selection
behaviour based on hdr.poll_completion is preserved as before.

then in [04/10], a transport that supports atomic operation on its tx path
can now declare itself as .atomic_capable and as a consequence the SCMI
core will refrain itself from sleeping on the correspondent rx-path.

In [07/10] a simple method is introduced so that an SCMI driver can easily
query the core to check if the currently used transport is configured to
behave in an atomic manner: in this way, interested SCMI driver users, like
Clock framework [08/10], can optionally support atomic operations when
operating on an atomically configured transport.

Finally there are 2 *tentative" patch for SMC transport: at first [09/10]
ports SMC to use the common core completions when completion interrupt is
available or otherwise revert to use common core polling mechanism above
introduced; then in [10/10] SMC is converted to be .atomic_capable by
substituting the mutexes with busy-waiting to keep the channel 'locked'.

SMC changes have not been tested so far (I cannot), AND they are just a
proposal at this stage to try to better abstract and unify behaviour with
the SCMI core; both patches are completely intended as RFCs, though, not
only regarding their implementation but even their mere existence is RFC:
I mean maybe we just don't want to do such kind of unification/abstraction,
and I can just drop those SMC patches if unwanted; any feedback welcome.

Atomic support has been minimally tested against the upcoming virtio
transport draft(unposted) series, while polling has been tested both
with virtio and mailbox transports.

The series is based on sudeep/for-next [1] on top of commit:

commit 0aa69c9fc80d ("firmware: arm_scmi: Add compatibility checks for
		     shmem node")

Given the RFC status of the series in general I still not have CCed any
maintainer out of SCMI subsystem.

Any feedback welcome.

Thanks,

Cristian

---

[1]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi

Cristian Marussi (10):
  firmware: arm_scmi: Reset properly xfer SCMI status
  firmware: arm_scmi: Add missing xfer reinit_completion
  firmware: arm_scmi: Add configurable polling mode for transports
  firmware: arm_scmi: Add support for atomic transports
  include: trace: Add new scmi_xfer_response_wait event
  firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
  firmware: arm_scmi: Add is_transport_atomic() handle method
  clk: scmi: Support atomic enable/disable API
  firmware: arm-scmi: Make smc transport use common completions
  firmware: arm-scmi: Make smc transport atomic

 drivers/clk/clk-scmi.c             |  44 +++++--
 drivers/firmware/arm_scmi/common.h |  11 ++
 drivers/firmware/arm_scmi/driver.c | 184 +++++++++++++++++++++++++----
 drivers/firmware/arm_scmi/smc.c    |  60 ++++++----
 include/linux/scmi_protocol.h      |   8 ++
 include/trace/events/scmi.h        |  28 +++++
 6 files changed, 277 insertions(+), 58 deletions(-)

-- 
2.17.1

