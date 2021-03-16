Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C051D33D430
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhCPMtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:49:52 -0400
Received: from foss.arm.com ([217.140.110.172]:37600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhCPMtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:49:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B08B1D6E;
        Tue, 16 Mar 2021 05:49:14 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB24A3F792;
        Tue, 16 Mar 2021 05:49:12 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 00/38] SCMI vendor protocols and modularization
Date:   Tue, 16 Mar 2021 12:48:25 +0000
Message-Id: <20210316124903.35011-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The current SCMI implementation does not provide an interface to easily
develop and include a custom vendor protocol implementation as prescribed
by the SCMI standard, also because, there is not currently any custom
protocol in the upstream to justify the development of a custom interface
and its maintenance.

Moreover the current interface exposes protocol operations to the SCMI
driver users attaching per-protocol operations directly to the handle
structure, which, in this way, tends to grow indefinitely for each new
protocol addition.

Beside this, protocols private data are also exposed via handle *_priv
pointers, making such private data accessible also to the SCMI drivers
even if neither really needed nor advisable.

This series wants to address this by simplifying the SCMI protocols
interface and reducing it, roughly, to these common generic operations:

	- handle->devm_protocol_get()
	- handle->devm_protocol_put()
	- handle->notify_ops->*

All protocols' private data pointers are removed from handle too and made
accessible only to the protocols code through dedicated internal helpers.

The concept of protocol handle is also introduced in the SCMI protocol code
to represent a protocol instance initialized against a specific SCMI
instance (handle), so that all the new protocol code uses such protocol
handles wherever previously SCMI handle was used: this enable tighter
control of what is exposed to the protocol code vs the SCMI drivers.

Moreover protocol initialization is moved away from device probe and now
happens on demand when the first user shows up (first .protocol_get), while
de-initialization is performed once the last user of the protocol, even in
terms of registered notifications callback, is gone, with the SCMI core
taking care to perform all the needed underlying resource accounting.

This way any new future standard or custom protocol implementation will
expose a common unified interface which does not need to be extended
endlessly: no need to maintain a custom interface only for vendor protos.
SCMI drivers written on top of standard or custom protocols will use this
same common interface to access any protocol operations.

All existent upstream SCMI drivers are converted to this new interface.

In order to make this migration painless and to avoid the need of a big
un-mergeable jumbo patch touching all over the protocols and drivers (like
it was in v2), since v3 the migration process has been heavily split with a
bit of transient code added along the way (to preserve bisectability) and
finally removed towards the ends of the series.
Protocols and SCMI drivers migration to the new interface happens along
patches 10->30.

Leveraging this new centralized and common initialization flow we took
care also to refactor and simplify protocol-events registration and remove
*notify_priv from the handle interface making it accessible only to the
notification core.

Patch 37 builds on top of this new interface and introduces a mechanism to
define an SCMI protocol as a full blown module (possibly loadable) while
leaving the core dealing with proper resource accounting.
Standard protocols are still kept as builtins in this series, though.

Finally, patch 38 introduces dynamic SCMI devices creation to avoid having
to update the static module device table in the core each time a new driver
is added.

The whole SCMI stack can still be built alternatively as a module, with all
the standard protocols included in scmi-module.ko in such a case.

On top of this series an example SCMI Custom protocol 0x99 and related
SCMI Custom Dummy driver has been built and it is available at [1] as a
series of DEBUG patches on top this same series.

The series is currently based on sudeep/for-next/scmi [2] on top of:

commit 908a4f778dc7 ("Merge branch 'ib-iio-scmi-5.12-rc2-take3' of
	 git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into
	 for-next/scmi")

Any feedback welcome.

Thanks,

Cristian

---
v6 --> v7
- rebased on top of sudeep/for-next/scmi incudling IIO immutable branch
  containing scmi_iio driver
- ported scmi_iio driver to the new API
- renamed some functions to use a naming pattern exposing the action verb
  as last token (including API methods rooted at handle->)
- reverted scmi_available_protocols to scmi_protocols
- constified src_id param in events notifier registration helper
- removed devm_acquire_protocol API
- refactored scmi_get_protocol_instance()
- fixed checkpatch CHECK on MACROS params side effects
- added missing .woner to voltage.c

v5 --> v6
- rebased on top of for-next/scmi
- added devm_acquire_protocol() helper
- added Cc:

v4 --> v5
- using standard kernel list instead of ad-hoc lists in 36/36
- renamed devm_get/put_ops to devm_get/put_protocol
- dropped RFC patch on non devres get/put_ops

v3 --> v4
- rebased on sudeep/for-next/scmi v5.11-rc1
- added a few comments more

v2 --> v3
- added dynamic SCMI devices creation (getting rid of static device table)
- heavy split of protocols and drivers migrations to the new interface
- rebased on top of next-20201201 so migrating also:
  + SCMIv3.0 Voltage Domain protocol & SCMI Regulator
  + SCMIv3.0 Sensor Extensions

v1 --> v2
- rebased on for-next/scmi v5.10-rc1
- introduced protocol handles
- added devres managed devm_ variant for protocols operations
- made all scmi_protocol refs const
- introduced IDR to handle protocols instead of static array
- refactored code around fast path

[1]:https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_modules_ext_V7/
[2]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi


Cristian Marussi (38):
  firmware: arm_scmi: review protocol registration interface
  firmware: arm_scmi: introduce protocol handle definitions
  firmware: arm_scmi: introduce devres get/put protocols operations
  firmware: arm_scmi: make notifications aware of protocols users
  firmware: arm_scmi: introduce new devres notification ops
  firmware: arm_scmi: refactor events registration
  firmware: arm_scmi: convert events registration to protocol handles
  firmware: arm_scmi: add new protocol handle core xfer ops
  firmware: arm_scmi: add helper to access revision area memory
  firmware: arm_scmi: port Base protocol to new interface
  firmware: arm_scmi: port Perf protocol to new protocols interface
  cpufreq: scmi: port driver to the new scmi_perf_proto_ops interface
  firmware: arm_scmi: remove legacy scmi_perf_ops protocol interface
  firmware: arm_scmi: port Power protocol to new protocols interface
  firmware: arm_scmi: port GenPD driver to the new scmi_power_proto_ops
    interface
  firmware: arm_scmi: remove legacy scmi_power_ops protocol interface
  firmware: arm_scmi: port Clock protocol to new protocols interface
  clk: scmi: port driver to the new scmi_clk_proto_ops interface
  firmware: arm_scmi: remove legacy scmi_clk_ops protocol interface
  firmware: arm_scmi: port Reset protocol to new protocols interface
  reset: reset-scmi: port driver to the new scmi_reset_proto_ops
    interface
  firmware: arm_scmi: remove legacy scmi_reset_ops protocol interface
  firmware: arm_scmi: port Sensor protocol to new protocols interface
  hwmon: (scmi) port driver to the new scmi_sensor_proto_ops interface
  iio/scmi: port driver to the new scmi_sensor_proto_ops interface
  firmware: arm_scmi: remove legacy scmi_sensor_ops protocol interface
  firmware: arm_scmi: port SystemPower protocol to new protocols
    interface
  firmware: arm_scmi: port Voltage protocol to new protocols interface
  regulator: scmi: port driver to the new scmi_voltage_proto_ops
    interface
  firmware: arm_scmi: remove legacy scmi_voltage_ops protocol interface
  firmware: arm_scmi: make references to handle const
  firmware: arm_scmi: cleanup legacy protocol init code
  firmware: arm_scmi: cleanup unused core xfer wrappers
  firmware: arm_scmi: cleanup events registration transient code
  firmware: arm_scmi: make notify_priv really private
  firmware: arm_scmi: rename non devres notify_ops
  firmware: arm_scmi: add protocol modularization support
  firmware: arm_scmi: add dynamic scmi devices creation

 drivers/clk/clk-scmi.c                     |  27 +-
 drivers/cpufreq/scmi-cpufreq.c             |  39 +-
 drivers/firmware/arm_scmi/base.c           | 142 ++--
 drivers/firmware/arm_scmi/bus.c            | 100 ++-
 drivers/firmware/arm_scmi/clock.c          | 129 ++--
 drivers/firmware/arm_scmi/common.h         | 133 +++-
 drivers/firmware/arm_scmi/driver.c         | 798 +++++++++++++++++++--
 drivers/firmware/arm_scmi/notify.c         | 328 +++++++--
 drivers/firmware/arm_scmi/notify.h         |  40 +-
 drivers/firmware/arm_scmi/perf.c           | 262 +++----
 drivers/firmware/arm_scmi/power.c          | 134 ++--
 drivers/firmware/arm_scmi/reset.c          | 146 ++--
 drivers/firmware/arm_scmi/scmi_pm_domain.c |  26 +-
 drivers/firmware/arm_scmi/sensors.c        | 232 +++---
 drivers/firmware/arm_scmi/system.c         |  63 +-
 drivers/firmware/arm_scmi/voltage.c        | 126 ++--
 drivers/hwmon/scmi-hwmon.c                 |  24 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c |  91 ++-
 drivers/regulator/scmi-regulator.c         |  42 +-
 drivers/reset/reset-scmi.c                 |  33 +-
 include/linux/scmi_protocol.h              | 200 +++---
 21 files changed, 2118 insertions(+), 997 deletions(-)

-- 
2.17.1

