Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA34F397158
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhFAK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:26:17 -0400
Received: from foss.arm.com ([217.140.110.172]:46328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFAK0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:26:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 610D311FB;
        Tue,  1 Jun 2021 03:24:35 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B2FF3F73D;
        Tue,  1 Jun 2021 03:24:33 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 0/5] Review/Extend SCMI Transport Core layer
Date:   Tue,  1 Jun 2021 11:24:16 +0100
Message-Id: <20210601102421.26581-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this short series is meant to review and extend a couple of SCMI transport
core layer mechanisms in order to ease the interaction with more complex
SCMI transport driver like the upcoming virtio-scmi and optee-scmi.

The commits in this series have not and *should not* have any impact or
require any change in the currently existing SCMI transports.

The three main principal area of change are:

- introduce monotonically increasing message tokens: change the policy
  used by the OSPM agent to select sequence number for outgoing messages
  in order to minimize the re-use of recently utilized tokens so as to
  mitigate the possible misbehaviors on reception of late arrival 'ghost'
  reply from the platform, currently hard to identify and discard.
  More details and ASCII art of the involved logics follows in the related
  commit :D

- introduce optional support for delegated xfers: expose a few helpers
  from the SCMI core transport layer that can be used by the transports
  to actively query the core for existing in-flight transactions already
  associated with a received message header or to obtain a brand new xfer
  to accommodate a just received notification.
  The general idea is to optionally let the transports process early and
  more of their transport specific payloads filling the xfer already
  naturally associated with the received message header, so that the
  transport specific implementations can get rid early-on of their
  specific message envelope structures (before even calling into the
  core scmi_rx_callback()) and so avoiding upfront the need to keep track
  of the state of such transport specific message envelopes till the core
  has processed them till completion or timeout. (while not modifying the
  signature of scmi_rx_callback)....any feedback even on a more sensible
  naming for this optional feature would be highly appreciated :D

- add optional support for transport-specific init/exit functions: when a
  transport provides .init/.exit functions in its scmi_desc descriptor,
  they will be called early on during SCMI core stack init/deinit, so well
  ahead of SCMI core probing.
  This allows some transports like virtio/optee to have performed early on
  some specific setup, such as registering as drivers also with some other
  kernel subsystem like virtio or optee, before the main SCMI stack is
  probed.
  This early init cannot be done through the usual kernel module_* methods
  because an SCMI transport implementation is not a full-fledged driver but
  compiled as part of the SCMI core itself, so using module_init() in a
  transport makes then SCMI core fail to build as a single module including
  the desired transports.

This, as said, is intended to be preparatory work for the rework and
simplification of the WIP virtio-scmi series. (init/exit support is indeed
needed also by upcoming optee transport)

The series is based on sudeep/for-next [1] on top of commit:

commit a3b884cef873 ("firmware: arm_scmi: Add clock management to the SCMI
		     power domain")

Any feedback welcome.

Thanks,

Cristian

---
v1 --> v2:
 - fixed a lot of typos in "firmware: arm_scmi: Introduce monotonically
 increasing tokens"
 - added init/exit optional support patch

[1]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi


Cristian Marussi (5):
  firmware: arm_scmi: reset_rx_to_maxsz during async commands
  firmware: arm_scmi: Add support for type handling in common functions
  firmware: arm_scmi: Add transport optional init/exit support
  firmware: arm_scmi: Introduce monotonically increasing tokens
  firmware: arm_scmi: Introduce delegated xfers support

 drivers/firmware/arm_scmi/common.h |  51 +++-
 drivers/firmware/arm_scmi/driver.c | 449 ++++++++++++++++++++++++++---
 2 files changed, 460 insertions(+), 40 deletions(-)

-- 
2.17.1

