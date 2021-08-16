Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD7E3ED298
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhHPKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236507AbhHPKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629111262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGEAoz3GqWa/YDU4qIuAVEYjSZtyjbvu2664YZ/+X58=;
        b=JtdNbQlB6q+erupXWis6YOJkEshbSXIyVWr1ztViSt1Av1QePHh0Efn8nXuHlENdEn/5SA
        H8m9uBTYaJXhmmZUoPYDM50OSTXEI/NS1PfUJyjrZvxgTuxRkAIUxBpMslX//snRtxhb6D
        fCoiUo0eeRx19W4Y+XAEc7GJZVkoAFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-1gWh7g15Nm6IxzyXXdguEQ-1; Mon, 16 Aug 2021 06:54:21 -0400
X-MC-Unique: 1gWh7g15Nm6IxzyXXdguEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36D9F192D785;
        Mon, 16 Aug 2021 10:54:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED5E518017;
        Mon, 16 Aug 2021 10:54:15 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v2 13/20] platform/x86: intel_speed_select_if: Move to intel sub-directory
Date:   Mon, 16 Aug 2021 18:51:12 +0800
Message-Id: <20210816105119.704302-14-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-1-hpa@redhat.com>
References: <20210816105119.704302-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move intel_speed_select_if to intel sub-directory to improve
readability and rename it from intel_speed_select_if to speed_select_if

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                                   | 2 --
 drivers/platform/x86/Makefile                                  | 2 --
 drivers/platform/x86/intel/Kconfig                             | 2 ++
 drivers/platform/x86/intel/Makefile                            | 3 ++-
 .../{intel_speed_select_if => intel/speed_select_if}/Kconfig   | 0
 .../{intel_speed_select_if => intel/speed_select_if}/Makefile  | 0
 .../speed_select_if}/isst_if_common.c                          | 0
 .../speed_select_if}/isst_if_common.h                          | 0
 .../speed_select_if}/isst_if_mbox_msr.c                        | 0
 .../speed_select_if}/isst_if_mbox_pci.c                        | 0
 .../speed_select_if}/isst_if_mmio.c                            | 0
 11 files changed, 4 insertions(+), 5 deletions(-)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Kconfig (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Makefile (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.h (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_msr.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_pci.c (100%)
 rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mmio.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f0e3d9dc71a4..b864e37c6781 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1109,8 +1109,6 @@ config INTEL_IMR
 
 	  If you are running on a Galileo/Quark say Y here.
 
-source "drivers/platform/x86/intel_speed_select_if/Kconfig"
-
 
 endif # X86_PLATFORM_DEVICES
 
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e028c8dbb7cc..f30cee767252 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -119,7 +119,5 @@ obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
-# Intel uncore drivers
-obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
 
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 3763ed816919..01c73d184461 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -98,6 +98,8 @@ config INTEL_SMARTCONNECT
 	  This driver checks to determine whether the device has Intel Smart
 	  Connect enabled, and if so disables it.
 
+source "drivers/platform/x86/intel/speed_select_if/Kconfig"
+
 config INTEL_TURBO_MAX_3
 	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
 	depends on X86_64 && SCHED_MC_PRIO
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 44b1fe372b44..ae2a3cec8d82 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -36,4 +36,5 @@ obj-$(CONFIG_INTEL_SMARTCONNECT)		+= intel-smartconnect.o
 intel_turbo_max_3-y						:= turbo_max_3.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 intel-uncore-frequency-y					:= uncore-frequency.o
-obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
\ No newline at end of file
+obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
+obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= speed_select_if/
\ No newline at end of file
diff --git a/drivers/platform/x86/intel_speed_select_if/Kconfig b/drivers/platform/x86/intel/speed_select_if/Kconfig
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/Kconfig
rename to drivers/platform/x86/intel/speed_select_if/Kconfig
diff --git a/drivers/platform/x86/intel_speed_select_if/Makefile b/drivers/platform/x86/intel/speed_select_if/Makefile
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/Makefile
rename to drivers/platform/x86/intel/speed_select_if/Makefile
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_common.c
rename to drivers/platform/x86/intel/speed_select_if/isst_if_common.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_common.h
rename to drivers/platform/x86/intel/speed_select_if/isst_if_common.h
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
rename to drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_pci.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
rename to drivers/platform/x86/intel/speed_select_if/isst_if_mbox_pci.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
rename to drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
-- 
2.31.1

