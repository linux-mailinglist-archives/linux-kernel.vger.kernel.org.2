Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15163A473B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhFKRCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:02:21 -0400
Received: from foss.arm.com ([217.140.110.172]:35476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhFKRCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:02:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05F00D6E;
        Fri, 11 Jun 2021 10:00:22 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E762C3F719;
        Fri, 11 Jun 2021 10:00:18 -0700 (PDT)
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
Subject: [PATCH v4 00/16] Introduce SCMI VirtIO transport
Date:   Fri, 11 Jun 2021 17:59:21 +0100
Message-Id: <20210611165937.701-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm posting this V4 series starting from the work done up to V3 by
OpenSynergy.

I kept original autorship and mailing list distribution unchanged, even
though I'm not really sure if I'm allowed to post to all the original MLs.

The main aim of this rework is to simplify where possible the SCMI VirtIO
support added in V3 by adding upfront and then using some new mechanisms in
the SCMI Core Transport layer.

Indeed patches 01,02,03,04,05 add such additional mechanisms to the SCMI
core; these were previously posted separately in a distinct patchset, I
will retire that series and continue posting those here to ease testing.

In terms of rework I dropped original V3 patches 02,08,12 as no more needed
while keeping for now the rework distinct marking such patches as
[RFC][REWORK] in order to easily spot changes.
(they will be squashed into related original V3 patches next)

DT bindings patch has been ported on top of freshly YAML converted arm,scmi
bindings.

Patch 16 adds support for polling mode to virtio-scmi.

Known/open issues in V4:

 - possible violation by virtio-scmi transport of the order constraints on
   correlated response/delayed_response messages: this will be addressed
   next with changes in the SCMI core.

 - probing sequence simplification (if possible)

As such this series is anyway still work in progress, needing also some
general cleanup.

Moreover SCMI core reworks about atomicity and polling, posted as a
distinct series, is not included here either (even though tested against)
and it will kept separate instead for now, to avoid mixing too much stuff
together since not strictly needed for this series.

This V4 series is based on top of next20210610 in order to include all the
recent DT YAML-conversion changes and all the fixes queued as of today in
sudeep/for-next/scmi.

The series has been tested using an emulated fake SCMI device and also a
proper SCP-fw stack running through QEMU vhost-users, with the SCMI stack
compiled, in both cases, as builtin and as s loadable module, running tests
against mocked SCMI Sensors using HWMON and IIO interfaces to check the
functionality of notifications and sync/async commands.

Any feedback/testing is welcome :D

Thanks,
Cristian
---
V3 --> V4:
 - dropped V3 patches 02,08,12
 - using new delegated xfers support and monotonically increasing tokens
 - ported SCMI virtio transport DT bindings to YAML format
 - added virtio-scmi polling support

Cristian Marussi (8):
  firmware: arm_scmi: Fix max pending messages boundary check
  firmware: arm_scmi: Add support for type handling in common functions
  firmware: arm_scmi: Add transport optional init/exit support
  firmware: arm_scmi: Introduce monotonically increasing tokens
  firmware: arm_scmi: Introduce delegated xfers support
  [RFC][REWORK] firmware: arm_scmi: Add op to override max message #
  [RFC][REWORK] firmware: arm_scmi: make virtio-scmi use delegated xfers
  firmware: arm_scmi: Add polling mode to virtio transport

Igor Skalkin (4):
  firmware: arm_scmi, smccc, mailbox: Make shmem based transports
    optional
  firmware: arm_scmi: Add op to override max message #
  dt-bindings: arm: Add virtio transport for SCMI
  firmware: arm_scmi: Add virtio transport

Peter Hilber (4):
  firmware: arm_scmi: Add optional link_supplier() transport op
  firmware: arm_scmi: Add per-device transport private info
  firmware: arm_scmi: Add is_scmi_protocol_device()
  firmware: arm_scmi: Add message passing abstractions for transports

 .../bindings/firmware/arm,scmi.yaml           |   8 +-
 MAINTAINERS                                   |   1 +
 drivers/firmware/Kconfig                      |  26 +-
 drivers/firmware/arm_scmi/Makefile            |   4 +-
 drivers/firmware/arm_scmi/bus.c               |   5 +
 drivers/firmware/arm_scmi/common.h            |  91 ++-
 drivers/firmware/arm_scmi/driver.c            | 520 +++++++++++++++--
 drivers/firmware/arm_scmi/msg.c               | 148 +++++
 drivers/firmware/arm_scmi/virtio.c            | 541 ++++++++++++++++++
 drivers/firmware/smccc/Kconfig                |   1 +
 drivers/mailbox/Kconfig                       |   1 +
 include/uapi/linux/virtio_ids.h               |   1 +
 include/uapi/linux/virtio_scmi.h              |  25 +
 13 files changed, 1326 insertions(+), 46 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/msg.c
 create mode 100644 drivers/firmware/arm_scmi/virtio.c
 create mode 100644 include/uapi/linux/virtio_scmi.h

-- 
2.17.1

