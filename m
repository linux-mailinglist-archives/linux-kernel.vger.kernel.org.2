Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53C530F93F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhBDRLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:11:24 -0500
Received: from foss.arm.com ([217.140.110.172]:33854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238292AbhBDRBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:01:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 125B711D4;
        Thu,  4 Feb 2021 09:00:22 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EEC23F73B;
        Thu,  4 Feb 2021 09:00:20 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh@kernel.org
Subject: [PATCH v5 0/3] Introduce SCMI System Power Control driver
Date:   Thu,  4 Feb 2021 16:59:10 +0000
Message-Id: <20210204165913.42582-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This series, building on top of the recently introduced SCMI System Power
Protocol support, adds a new SCMI driver which, registering for SystemPower
notifications, acts accordingly to satisfy SCMI plaform system transitions
requests like shutdown/reboot both of graceful and forceful kind. (possibly
involving userspace when the request is of the graceful kind)

Interaction with userspace boils down to the same orderly_ Kernel methods
used by ACPI to handle similar shutdown requests.

As a part of the series, patch 1/3 enforces, at the SCMI core level, the
creation of one single SCMI SystemPower device, to avoid promoting the
design of systems in which multiple SCMI platforms can advertise the
concurrent support of SystemPower protocol: when multiple SCMI platform
are defined, only one of them should be in charge of SystemPower comms
with the OSPM, so only one such SystemPower device across all platforms
is allowed to be created.

The series has been rebased in v5 on top of:

https://lore.kernel.org/linux-arm-kernel/20210202221555.41167-1-cristian.marussi@arm.com/

since this last series about SCMI modularization carries also a few changes
in the SCMI interface exposed to drivers like this one.

This whole series, rebased as above specified, can be found (with some messy
DEBUG patches on top) at [1].

Thanks

Cristian

[1]: https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_system_power_control_ext_V5

---
v4 --> v5
 - rebased on SCMI Modules v5 series to use new SCMI protocols interface
 - removed signal based shutdown/reboot
 - removed all module parameters
 - added 60secs fixed timeout to shutdwon/reboot requests
 - make it modularizable to cope with SCMI core modularization
 - refactored all data config structs
 - using dev_* instead of pr_*
    
v3 --> v4
 - rebased v5.11-rc2
 - removed unneeded ugly usage of atomics and barriers
 - simplfied SysPower shutdown state machine
 - split out macro definition to different patch
    
v2 --> v3
 - rebased
 - some minor cleanup in codestyle and commit message
    
v1 --> v2
 - split out of SCMI System Power Protocol series now merged


Cristian Marussi (3):
  firmware: arm_scmi: support only one single SystemPower device
  firmware: arm_scmi: add System Power utility macro
  firmware: arm_scmi: add SCMI System Power Control driver

 drivers/firmware/Kconfig                      |  12 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 drivers/firmware/arm_scmi/bus.c               |  25 ++
 .../firmware/arm_scmi/scmi_power_control.c    | 347 ++++++++++++++++++
 include/linux/scmi_protocol.h                 |   1 +
 5 files changed, 386 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/scmi_power_control.c

-- 
2.17.1

