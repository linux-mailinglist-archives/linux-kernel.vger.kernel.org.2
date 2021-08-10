Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83663E57D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbhHJKBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238740AbhHJKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628589662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3O6UeGhFsy7rW8jX0eGX+Li4OjEY6vKq4ZNGc5mp7fM=;
        b=WIvZ5chB7Bu+Ti+Esn9yIt5Lp70XV5f7jynR7iOhEWBFgdf5VW3CCvQ3IdudL2D1FH8XYN
        7gvPPSlxhSPmRy0SSS/lUzXqdsmIcDi4AQe3kv+1kIPryS2+ZuFPZ4Gam8EIpWYobb87y1
        2luMoicRzlU6xaeWK4vnIJ32ak8cWVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-uAKlqRnVOzqWcMrDm-nizw-1; Tue, 10 Aug 2021 06:00:59 -0400
X-MC-Unique: uAKlqRnVOzqWcMrDm-nizw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E6F72E77;
        Tue, 10 Aug 2021 10:00:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.64.242.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0EF760BF1;
        Tue, 10 Aug 2021 10:00:51 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Subject: [PATCH 14/20] Move Intel SST driver to intel/ directory to improve readability.
Date:   Tue, 10 Aug 2021 17:58:26 +0800
Message-Id: <20210810095832.4234-15-hpa@redhat.com>
In-Reply-To: <20210810095832.4234-1-hpa@redhat.com>
References: <20210810095832.4234-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/Kconfig                                    | 2 --
 drivers/platform/x86/Makefile                                   | 2 +-
 drivers/platform/x86/intel/Kconfig                              | 1 +
 drivers/platform/x86/intel/Makefile                             | 1 +
 drivers/platform/x86/{ => intel}/intel_speed_select_if/Kconfig  | 0
 drivers/platform/x86/{ => intel}/intel_speed_select_if/Makefile | 0
 .../x86/{ => intel}/intel_speed_select_if/isst_if_common.c      | 0
 .../x86/{ => intel}/intel_speed_select_if/isst_if_common.h      | 0
 .../x86/{ => intel}/intel_speed_select_if/isst_if_mbox_msr.c    | 0
 .../x86/{ => intel}/intel_speed_select_if/isst_if_mbox_pci.c    | 0
 .../x86/{ => intel}/intel_speed_select_if/isst_if_mmio.c        | 0
 11 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/Kconfig (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/Makefile (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_common.c (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_common.h (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_mbox_msr.c (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_mbox_pci.c (100%)
 rename drivers/platform/x86/{ => intel}/intel_speed_select_if/isst_if_mmio.c (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f722f08cd89c..ff0a36a61404 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1028,8 +1028,6 @@ config INTEL_IMR
 
 
 
-source "drivers/platform/x86/intel_speed_select_if/Kconfig"
-
 config INTEL_TURBO_MAX_3
 	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
 	depends on X86_64 && SCHED_MC_PRIO
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index b809aaac300c..2ce50bae6b71 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -114,7 +114,7 @@ obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 
 # Intel uncore drivers
 
-obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
+
 obj-$(CONFIG_INTEL_TURBO_MAX_3)			+= intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
 
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 0ebc6e0a24ca..f6c326d33ea0 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -32,6 +32,7 @@ source "drivers/platform/x86/intel/telemetry/Kconfig"
 source "drivers/platform/x86/intel/ips/Kconfig"
 source "drivers/platform/x86/intel/rst/Kconfig"
 source "drivers/platform/x86/intel/smartconnect/Kconfig"
+source "drivers/platform/x86/intel/intel_speed_select_if/Kconfig"
 
 
 endif # X86_PLATFORM_DRIVERS_INTEL
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 5a916bb1512f..972076bdcd4e 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 obj-$(CONFIG_INTEL_IPS)				+= ips/
 obj-$(CONFIG_INTEL_RST)				+= rst/
 obj-$(CONFIG_INTEL_SMARTCONNECT)		+= smartconnect/
+obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)	+= intel_speed_select_if/
\ No newline at end of file
diff --git a/drivers/platform/x86/intel_speed_select_if/Kconfig b/drivers/platform/x86/intel/intel_speed_select_if/Kconfig
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/Kconfig
rename to drivers/platform/x86/intel/intel_speed_select_if/Kconfig
diff --git a/drivers/platform/x86/intel_speed_select_if/Makefile b/drivers/platform/x86/intel/intel_speed_select_if/Makefile
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/Makefile
rename to drivers/platform/x86/intel/intel_speed_select_if/Makefile
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/intel_speed_select_if/isst_if_common.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_common.c
rename to drivers/platform/x86/intel/intel_speed_select_if/isst_if_common.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/intel_speed_select_if/isst_if_common.h
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_common.h
rename to drivers/platform/x86/intel/intel_speed_select_if/isst_if_common.h
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/intel_speed_select_if/isst_if_mbox_msr.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
rename to drivers/platform/x86/intel/intel_speed_select_if/isst_if_mbox_msr.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel/intel_speed_select_if/isst_if_mbox_pci.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
rename to drivers/platform/x86/intel/intel_speed_select_if/isst_if_mbox_pci.c
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel/intel_speed_select_if/isst_if_mmio.c
similarity index 100%
rename from drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
rename to drivers/platform/x86/intel/intel_speed_select_if/isst_if_mmio.c
-- 
2.31.1

