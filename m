Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA83BC213
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGERNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:13:19 -0400
Received: from foss.arm.com ([217.140.110.172]:51116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhGERNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:13:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFAC46D;
        Mon,  5 Jul 2021 10:10:40 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05B693F694;
        Mon,  5 Jul 2021 10:10:38 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH v2 0/8] Introduce atomic support for SCMI transports
Date:   Mon,  5 Jul 2021 18:10:14 +0100
Message-Id: <20210705171022.25861-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This RFC series mainly aims to introduce atomic support for transports
that can support it.

At first in [1/8], as a closely related addition, it is introduced a
common way for a transport to signal to the SCMI core that it does not
offer completion interrupts, so that the usual polling behaviour based
on .poll_done() will be required: this can be done enabling statically
a global polling behaviour for the whole transport with flag
scmi_desc.force_polling OR dynamically enabling at runtime such polling
behaviour on a per-channel basis with scmi_chan_info.needs_polling,
typically during .chan_setup(). The usual per-command polling selection
behaviour based on hdr.poll_completion is preserved as before.

Then in [2/8], a transport that supports atomic operations on its tx path
can now declare itself as .atomic_capable and as a consequence the SCMI
core will refrain itself from sleeping on the correspondent rx-path.

In [5/8] a simple method is introduced so that an SCMI driver can easily
query the core to check if the currently used transport is configured to
behave in an atomic manner: in this way, interested SCMI driver users, like
Clock framework [6/8], can optionally support atomic operations when
operating on an atomically configured transport.

Finally there are 2 *tentative" patch for SMC transport: at first [7/8]
ports SMC to use the common core completions when completion interrupt is
available or otherwise revert to use common core polling mechanism above
introduced; then in [8/8] SMC is converted to be .atomic_capable by
substituting the mutexes with busy-waiting to keep the channel 'locked'.

SMC changes have NOT been tested so far (I cannot), AND they are just a
proposal at this stage to try to better abstract and unify behaviour with
the SCMI core; both patches are completely intended as RFCs, though, not
only regarding their implementation but even their mere existence is RFC:
I mean maybe we just don't want to do such kind of unification/abstraction,
and I can just drop those SMC patches if unwanted; any feedback welcome.

Atomic support has been minimally tested against the upcoming virtio
transport V5 series, while polling has been tested with mailbox transports.

The series is based on SCMI VirtIO Transport support V5 [1] (since it will
be the main prospective user of atomic mode) and, as such, it is also
publicly available from ARM GitLab [2].
(Note that in order to use/test atomic mode on virtio you'll have to enable
 it setting .atomic_capable = true in virtio.c::scmi_virtio_desc)

Given the RFC status of the series in general I still not have CCed any
maintainer out of SCMI subsystem.

Any feedback welcome.

Thanks,

Cristian

---

[1]:https://lore.kernel.org/linux-arm-kernel/20210705144914.35094-1-cristian.marussi@arm.com/
[2]:https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_atomic_transport_V2_on_virtio/

Cristian Marussi (8):
  firmware: arm_scmi: Add configurable polling mode for transports
  firmware: arm_scmi: Add support for atomic transports
  include: trace: Add new scmi_xfer_response_wait event
  firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
  firmware: arm_scmi: Add is_transport_atomic() handle method
  clk: scmi: Support atomic enable/disable API
  firmware: arm_scmi: Make smc transport use common completions
  firmware: arm_scmi: Make smc transport atomic

 drivers/clk/clk-scmi.c             |  44 ++++--
 drivers/firmware/arm_scmi/common.h |  13 ++
 drivers/firmware/arm_scmi/driver.c | 206 +++++++++++++++++++++++------
 drivers/firmware/arm_scmi/smc.c    |  60 +++++----
 include/linux/scmi_protocol.h      |   8 ++
 include/trace/events/scmi.h        |  28 ++++
 6 files changed, 288 insertions(+), 71 deletions(-)

-- 
2.17.1

