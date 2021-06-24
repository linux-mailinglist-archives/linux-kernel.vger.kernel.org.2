Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A903B344D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhFXRJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:09:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:10296 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFXRJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:09:40 -0400
IronPort-SDR: dS+DpvnuSiJe+0RdA3vlskudP9sZFWDt+Q7psJF0DkJomo48Vi5oG5+3yjhcdLqAbUaZNrsru8
 aJzWy+/jvwXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="194658398"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="194658398"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:07:17 -0700
IronPort-SDR: 4YaNWXvSoZxhHE00eYqe2ivgv06dinHwR+baBD0qMXNbLIznVH/ELq4VCyUNBGHrZhjK0i05bD
 mwObycS4HIQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="453501663"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 24 Jun 2021 10:07:17 -0700
Received: from [10.212.160.234] (kliang2-MOBL.ccr.corp.intel.com [10.212.160.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 28B035807E2;
        Thu, 24 Jun 2021 10:07:16 -0700 (PDT)
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
To:     Greg KH <greg@kroah.com>, Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <33bccec9-c4c4-d52b-9ee4-9a09e7353812@linux.intel.com>
Date:   Thu, 24 Jun 2021 13:07:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNSlVPcjHInk4un6@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2021 11:31 AM, Greg KH wrote:
> On Thu, Jun 24, 2021 at 08:24:29AM -0700, Andi Kleen wrote:
>>
>> On 6/24/2021 7:29 AM, Greg KH wrote:
>>> On Thu, Jun 24, 2021 at 07:24:31AM -0700, Andi Kleen wrote:
>>>>> But first off, why is this symlink suddenly needed?  What is so special
>>>>> about this new hardware that it breaks the existing model?
>>>> The driver can be in two modes:
>>>>
>>>> - Driver fully knows the hardware and puts in the correct Linux names
>>>>
>>>> - Driver doesn't know the hardware but is in a fallback mode where it only
>>>> looks at a discovery table. There we don't have the correct names, just an
>>>> numeric identifier for the different hardware sub components.
>>> Why does this matter?  Why would the driver not "know" the hardware?  If
>>> it doesn't know it, why would it bind to it?
>>
>> It's a similar concept as a PCI class. How to have a driver that can handle
>> future hardware, but with some restrictions
> 
> But this is NOT how busses work in the driver model.
> 
> PCI classes are great, but we do NOT suddenly add a symlink in sysfs if
> a driver goes from being handled by "generic_pci_type_foo" to
> "vendor_foo".  Userspace can handle the change and life goes on.
> 
>> The perf CPU PMU has had a similar concept for a long time. The driver can
>> be either in architectural mode (with a subset of features), or be fully
>> enabled. This allows users who are on an older kernel to still use at least
>> a subset of the functionality.
> 
> So a device name will move from "generic" to "specific", right?

We'd like to keep both names.

Here is the whole story.

This patch set provides platform-specific support for Sapphire Rapids 
server on top of the discovery mechanism which was recently introduced 
in the uncore driver.

https://lore.kernel.org/lkml/1616003977-90612-1-git-send-email-kan.liang@linux.intel.com/

The discovery mechanism is a mechanism of self-describing HW. By reading 
through an MMIO page worth of information, the uncore driver can 
‘discover’ all the standard uncore PMON registers. The driver "know" the 
hardware.
However, the discovery mechanism only provides basic uncore information. 
It doesn't provide a meaningful name for each uncore unit, but a type 
ID. So we can only name an uncore PMU by it's type ID (numeric name), 
e.g., uncore_type_0_0. End uses can use it to access the uncore counters.

With this platform-specific patch, the driver can "know" more about the 
hardware, e.g., the mapping between a type ID and an meaningful uncore 
name. It can creates an uncore PMU with a meaningful name just like the 
previous platforms.

It usually takes some time to implement a platform-specific patch. Some 
early user or users still have old drivers may have already wrote some 
scripts (which composed of many perf commands for core and uncore 
events) with the numeric name, and done some basic test. We don't want 
to bother them to update their scripts for the new driver. So we'd like 
to keep both names and add a symlink from a meaningful name to a type ID 
name. For example,

/sys/bus/event_source/devices/uncore_iio_0 -> 
../../../devices/uncore_type_1_0

> 
> Why does a bus have to do with any of this?

Both names should be created under /sys/bus/event_source/devices/

Exposing the bus_get_devices_kset() is to get the bus devices kset, 
which is used to create the symlink.

> 
>>>> In the later mode the numeric identifier is used in sysfs, in the former
>>>> case the full Linux name. But we want to keep some degree of Linux user
>>>> space compatibility between the two, that is why the full mode creates a
>>>> symlink from the "numeric" name. This way the (ugly) identifiers needed for
>>>> the fallback mode work everywhere.
>>> So what _exactly_ does the symlink do here?  What is it from->to?
>>
>> It's from numeric identifier to full perf name
>>
>> In fallback mode there is no symlink, only the numeric identifier.
> 
> Those two sentences do not describe a sysfs path to me.
> 
> Where are the Documentation/ABI/ entries for all of this?

The below patch created a file for uncore to explain the naming rules.
I also found that the current sysfs-devices-mapping is for uncore driver 
as well. So I move it into the uncore document.


> 
>>> And where is it being documented?  What userspace tool needs to be fixed
>>> up so that the symlink can be removed?
>>
>> The names are visible in the perf command lines. Perf supports either name
>> without changes. So it's not about fixing a specific tool, but about using
>> the drivers in both modes, with limited compatibility between the two.
> 
> But a driver does not caer.  And if perf does not care, who cares?
>

That's to facilitate the user's script which composed of many perf 
commands for core and uncore events.

They may run the script on both the old driver (without 
platform-specific support) and the new driver (with platform-specific 
support). The numeric name with the type ID is not deprecated. So they 
don't need to update the uncore PMU names in their scripts when updating 
the driver.



 From f6989d87988866994ed4e198be16aa44e3f682eb Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Thu, 24 Jun 2021 09:16:21 -0700
Subject: [PATCH] docs: ABI: testing: Add perf uncore PMU support

Document the naming rules for the uncore related PMUs.

Move the sysfs-devices-mapping into this uncore document. The attribute
is only available for uncore PMUs. Update the location of the attribute
to /sys/bus/event_source/devices/. Update the Contact which is not
available anymore.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  .../testing/sysfs-bus-event_source-devices-uncore  | 126 
+++++++++++++++++++++
  Documentation/ABI/testing/sysfs-devices-mapping    |  34 ------
  2 files changed, 126 insertions(+), 34 deletions(-)
  create mode 100644 
Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
  delete mode 100644 Documentation/ABI/testing/sysfs-devices-mapping

diff --git 
a/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore 
b/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
new file mode 100644
index 0000000..612fa19
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
@@ -0,0 +1,126 @@
+What:		/sys/bus/event_source/devices/uncore_<unit_name>[_<unit_idx>]
+Date:		June 2021
+KernelVersion:  3.5
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Generic Uncore performance monitoring unit (PMU)
+
+		A collection of uncore performance monitoring units that
+		may be supported. These units can be monitored using the
+		'perf(1)' tool.
+
+		The name of each uncore PMU would look like:
+
+			uncore_<unit_name>[_<unit_idx>]
+
+		Where <unit_name> is the name of the uncore PMU.
+		If the unit number is more than one, <unit_idx>
+		indicates the index.
+
+		Examples:
+
+			The second uncore PMU for the Caching/Home Agent.
+
+				uncore_cha_2
+
+			There is only one uncore PMU for the Power
+			Control Unit
+
+				uncore_pcu
+
+
+		A mechanism of self-describing HW for the uncore PMU has
+		been introduced since the Intel Sapphire Rapids server.
+		Perf can provide basic uncore support based on the
+		generic uncore unit information provided by the
+		discovery mechanism. But the discovery mechanism only
+		provides a unit type ID for an uncore PMU, not a unit
+		name. The unit name can only be parsed with the later
+		platform-specific support.
+
+		On a platform that supports the discovery mechanism,
+		but lacks platform-specific support, the type ID is used
+		to name a uncore PMU.
+
+			uncore_type_<type_ID>[_<unit_idx>]
+
+		Examples:
+
+			The second uncore PMU for the type 0 unit
+
+				uncore_type_0_2
+
+		When the platform-specific support is ready on the
+		platform that supports the discovery mechanism. The unit
+		name should be used to name the uncore PMU. But the
+		numeric name with the type ID is not deprecated. Both
+		names coexist. A symlink is created to link the two
+		names.
+
+		Examples:
+
+			/sys/bus/event_source/devices/uncore_iio_0 ->
+			../../../devices/uncore_type_1_0
+
+		For users, who may use both the old driver (without
+		platform-specific support) and the new driver (with
+		platform-specific support), the numeric name with the
+		type ID is recommended, since they don't need to update
+		the uncore PMU names in their scripts when updating the
+		driver.
+
+		The attribute groups created under the PMU are similar to
+		other core PMUs.
+		(See ABI/testing/sysfs-bus-event_source-devices-format and
+		 ABI/testing/sysfs-bus-event_source-devices-events).
+
+
+What:	 
/sys/bus/event_source/devices/uncore_<unit_name>_free_running_<unit_idx>
+Date:		June 2021
+KernelVersion:  4.17
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Uncore Free-running performance monitoring unit (PMU)
+
+		A collection of uncore Free-running performance
+		monitoring units that may be supported. These units can
+		be monitored using the 'perf(1)' tool.
+
+		The attribute groups created under the PMU are similar to
+		other core PMUs.
+		(See ABI/testing/sysfs-bus-event_source-devices-format and
+		 ABI/testing/sysfs-bus-event_source-devices-events).
+
+What:           /sys/bus/event_source/devices/uncore_iio_x/dieX
+Date:           February 2020
+Contact:        Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+                Each IIO stack (PCIe root port) has its own IIO PMON 
block, so
+                each dieX file (where X is die number) holds 
"Segment:Root Bus"
+                for PCIe root port, which can be monitored by that IIO PMON
+                block.
+                For example, on 4-die Xeon platform with up to 6 IIO 
stacks per
+                die and, therefore, 6 IIO PMON blocks per die, the 
mapping of
+                IIO PMON block 0 exposes as the following::
+
+		    $ ls /sys/bus/event_source/devices/uncore_iio_0/die*
+		    -r--r--r-- /sys/bus/event_source/devices/uncore_iio_0/die0
+		    -r--r--r-- /sys/bus/event_source/devices/uncore_iio_0/die1
+		    -r--r--r-- /sys/bus/event_source/devices/uncore_iio_0/die2
+		    -r--r--r-- /sys/bus/event_source/devices/uncore_iio_0/die3
+
+		    $ tail /sys/bus/event_source/devices/uncore_iio_0/die*
+		    ==> /sys/bus/event_source/devices/uncore_iio_0/die0 <==
+		    0000:00
+		    ==> /sys/bus/event_source/devices/uncore_iio_0/die1 <==
+		    0000:40
+		    ==> /sys/bus/event_source/devices/uncore_iio_0/die2 <==
+		    0000:80
+		    ==> /sys/bus/event_source/devices/uncore_iio_0/die3 <==
+		    0000:c0
+
+                Which means::
+
+		    IIO PMU 0 on die 0 belongs to PCI RP on bus 0x00, domain 0x0000
+		    IIO PMU 0 on die 1 belongs to PCI RP on bus 0x40, domain 0x0000
+		    IIO PMU 0 on die 2 belongs to PCI RP on bus 0x80, domain 0x0000
+		    IIO PMU 0 on die 3 belongs to PCI RP on bus 0xc0, domain 0x0000
+
diff --git a/Documentation/ABI/testing/sysfs-devices-mapping 
b/Documentation/ABI/testing/sysfs-devices-mapping
deleted file mode 100644
index 8d202ba..0000000
--- a/Documentation/ABI/testing/sysfs-devices-mapping
+++ /dev/null
@@ -1,34 +0,0 @@
-What:           /sys/devices/uncore_iio_x/dieX
-Date:           February 2020
-Contact:        Roman Sudarikov <roman.sudarikov@linux.intel.com>
-Description:
-                Each IIO stack (PCIe root port) has its own IIO PMON 
block, so
-                each dieX file (where X is die number) holds 
"Segment:Root Bus"
-                for PCIe root port, which can be monitored by that IIO PMON
-                block.
-                For example, on 4-die Xeon platform with up to 6 IIO 
stacks per
-                die and, therefore, 6 IIO PMON blocks per die, the 
mapping of
-                IIO PMON block 0 exposes as the following::
-
-		    $ ls /sys/devices/uncore_iio_0/die*
-		    -r--r--r-- /sys/devices/uncore_iio_0/die0
-		    -r--r--r-- /sys/devices/uncore_iio_0/die1
-		    -r--r--r-- /sys/devices/uncore_iio_0/die2
-		    -r--r--r-- /sys/devices/uncore_iio_0/die3
-
-		    $ tail /sys/devices/uncore_iio_0/die*
-		    ==> /sys/devices/uncore_iio_0/die0 <==
-		    0000:00
-		    ==> /sys/devices/uncore_iio_0/die1 <==
-		    0000:40
-		    ==> /sys/devices/uncore_iio_0/die2 <==
-		    0000:80
-		    ==> /sys/devices/uncore_iio_0/die3 <==
-		    0000:c0
-
-                Which means::
-
-		    IIO PMU 0 on die 0 belongs to PCI RP on bus 0x00, domain 0x0000
-		    IIO PMU 0 on die 1 belongs to PCI RP on bus 0x40, domain 0x0000
-		    IIO PMU 0 on die 2 belongs to PCI RP on bus 0x80, domain 0x0000
-		    IIO PMU 0 on die 3 belongs to PCI RP on bus 0xc0, domain 0x0000
-- 
2.7.4

Thanks,
Kan


