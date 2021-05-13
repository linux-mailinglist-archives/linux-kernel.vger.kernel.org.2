Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524EF37F8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhEMNcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhEMNcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:32:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05812C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:31:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a2so25422888qkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT1dV6AjLP/QS60i88a5p7kaqLOLYLEelvnbSUxEIOg=;
        b=XxJNT17PrhUId+eibSxgEQ9ulf1wmyW1ibdlWYdY16qbUdbp4jXbkTdZR4BImRZgGP
         PwFh9sa1eA2Ry9uWr4xtuxdBTVmg9XPfdJrzxGN0yTQlb7V1oMWoyr0TSQlj8fMpMfoZ
         +7PnVdeNHFUKE+g4eJHh//zTGKTThftd0j5X9uulenp6/SGeg0TqkE/UYxJNRKWV/CFh
         Rj0/fa5kMJGleFtyshPIlGfQe8tr5f1nBKItfEWYJ6DsKAEdWLESNGKyJPWmS+prEJlr
         4TbgiYGG2yOweTocXvrZYP8nzFiMXRJsjinXwL/sclmfFoMkWK0NoSHmSwlE369GEK7D
         H7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VT1dV6AjLP/QS60i88a5p7kaqLOLYLEelvnbSUxEIOg=;
        b=NW7/1ih7xjsLo85xyObFlKylmYCg8Si1IR/4KvL8CUK/xG9lyrHTdREwtzSDs9I8Yy
         Dg49+l06q1RsNOi4h5pPHzpOjw8JPu6Dhd9wi5+VTTSE9hzb3QEshcM6//P32cKIaA+8
         dNla7S05DwXYhKQkov5M/rbkUTW9v9PBYfjyQR7kSKth8zqPBsTFxKw9Y83pQy3U36+r
         1RTKcaODqIBvVaEHg9SycvPGyoMqa6Heu9ToQaKRcEBITtdf8HpzWeWBm7AMQxqBDiQw
         cquJQuqKWe1zTl+s5jKwORmx3j8pVSa4t+wuuKCwlt5hbMFizH9VWSt3aKLhVPdybrq0
         1AAg==
X-Gm-Message-State: AOAM530LpRAAe1KZimFN2wLCHYfX+1l6eW87qAH8VjeAzJO0i6IgZw/R
        VRDq6E7cz6RRfEs/6T6qsQG/dQ==
X-Google-Smtp-Source: ABdhPJyzD/6JEG15j15/CTgocl47zxGwtho3stoAP/auRSfhPGTX3chIpwhIumrFlPWHeXARKVpW9g==
X-Received: by 2002:a37:a301:: with SMTP id m1mr38885330qke.491.1620912672001;
        Thu, 13 May 2021 06:31:12 -0700 (PDT)
Received: from iron-maiden.localnet ([2600:380:917d:9267:5528:eac3:c4c:5275])
        by smtp.gmail.com with ESMTPSA id v4sm169522qto.59.2021.05.13.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 06:31:11 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        corbet@lwn.net, hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        tytso@mit.edu, rdunlap@infradead.org
Subject: [PATCH v3.1] Fixed typos in all directories of Documentation/ABI/
Date:   Thu, 13 May 2021 09:31:10 -0400
Message-ID: <5710038.lOV4Wx5bFT@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <11748343.O9o76ZdvQC@iron-maiden>
References: <2219636.ElGaqSPkdT@iron-maiden> <20210506185109.1d5ac46d@coco.lan> <11748343.O9o76ZdvQC@iron-maiden>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following typos in the Documentation/ABI/ directory:

- In file obsolete/sysfs-cpuidle, change "obselete" for "obsolete".

- In file removed/sysfs-kernel-uids, change "propotional" for "proportional".

- In directory stable/, fix the following words: "associtated" for "associated",
  "hexidecimal" for "hexadecimal", "vlue" for "value", "csed" for "caused" and 
  "wrtie" for "write". This updates a total of five files.

- In directory testing/, fix the following words: "subystem" for "subsystem", 
  "isochrnous" for "isochronous", "Desctiptors" for "Descriptors", "picutre" for 
  "picture", "capture" for "capture", "occured" for "ocurred", "connnected" for 
  "connected","agressively" for "aggressively","manufacturee" for "manufacturer"
  and "transaction" for "transaction", "malformatted" for "incorrectly formated"
  ,"internel" for "internal", "writtento" for "written to", "specificed" for 
  "specified", "beyound" for "beyond", "Symetric" for "Symmetric". This updates
  a total of eleven files.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

v2: Removed change for "misconfiguration", fixed typos in file 
    Documentation/ABI/testing/sysfs-devices-system-cpu.

v3: Changed "malformatted" for "incorrectly formatted", which is more readable 
    than "malformed".
    |
    v3.1: Changed spaces for tabs in new line of file testing/sysfs-bus-pci.
---
 Documentation/ABI/obsolete/sysfs-cpuidle            |  2 +-
 Documentation/ABI/removed/sysfs-kernel-uids         |  2 +-
 Documentation/ABI/stable/sysfs-bus-vmbus            |  2 +-
 Documentation/ABI/stable/sysfs-bus-xen-backend      |  2 +-
 Documentation/ABI/stable/sysfs-driver-dma-idxd      |  2 +-
 Documentation/ABI/stable/sysfs-driver-mlxreg-io     |  4 ++--
 Documentation/ABI/testing/configfs-iio              |  2 +-
 Documentation/ABI/testing/configfs-most             |  8 ++++----
 Documentation/ABI/testing/configfs-usb-gadget       |  2 +-
 Documentation/ABI/testing/configfs-usb-gadget-uvc   |  4 ++--
 Documentation/ABI/testing/debugfs-driver-genwqe     |  2 +-
 Documentation/ABI/testing/debugfs-driver-habanalabs |  2 +-
 Documentation/ABI/testing/sysfs-bus-fsi             |  2 +-
 Documentation/ABI/testing/sysfs-bus-pci             |  4 ++--
 Documentation/ABI/testing/sysfs-devices-system-cpu  | 10 +++++-----
 Documentation/ABI/testing/sysfs-driver-ufs          |  4 ++--
 Documentation/ABI/testing/sysfs-fs-f2fs             |  2 +-
 17 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-cpuidle b/Documentation/ABI/obsolete/sysfs-cpuidle
index e398fb5e542f..972cc11d3434 100644
--- a/Documentation/ABI/obsolete/sysfs-cpuidle
+++ b/Documentation/ABI/obsolete/sysfs-cpuidle
@@ -6,4 +6,4 @@ Description:
 	with the update that cpuidle governor can be changed at runtime in default,
 	both current_governor and current_governor_ro co-exist under
 	/sys/devices/system/cpu/cpuidle/ file, it's duplicate so make
-	current_governor_ro obselete.
+	current_governor_ro obsolete.
diff --git a/Documentation/ABI/removed/sysfs-kernel-uids b/Documentation/ABI/removed/sysfs-kernel-uids
index dc4463f190a7..85a90b86ce1e 100644
--- a/Documentation/ABI/removed/sysfs-kernel-uids
+++ b/Documentation/ABI/removed/sysfs-kernel-uids
@@ -5,7 +5,7 @@ Contact:	Dhaval Giani <dhaval@linux.vnet.ibm.com>
 Description:
 		The /sys/kernel/uids/<uid>/cpu_shares tunable is used
 		to set the cpu bandwidth a user is allowed. This is a
-		propotional value. What that means is that if there
+		proportional value. What that means is that if there
 		are two users logged in, each with an equal number of
 		shares, then they will get equal CPU bandwidth. Another
 		example would be, if User A has shares = 1024 and user
diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 42599d9fa161..3066feae1d8d 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -61,7 +61,7 @@ Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Directory for per-channel information
-		NN is the VMBUS relid associtated with the channel.
+		NN is the VMBUS relid associated with the channel.
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
 Date:		September. 2017
diff --git a/Documentation/ABI/stable/sysfs-bus-xen-backend b/Documentation/ABI/stable/sysfs-bus-xen-backend
index e8b60bd766f7..480a89edfa05 100644
--- a/Documentation/ABI/stable/sysfs-bus-xen-backend
+++ b/Documentation/ABI/stable/sysfs-bus-xen-backend
@@ -19,7 +19,7 @@ Date:		April 2011
 KernelVersion:	3.0
 Contact:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 Description:
-                The major:minor number (in hexidecimal) of the
+                The major:minor number (in hexadecimal) of the
                 physical device providing the storage for this backend
                 block device.
 
diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 55285c136cf0..d431e2d00472 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -173,7 +173,7 @@ What:           /sys/bus/dsa/devices/wq<m>.<n>/priority
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
 Contact:        dmaengine@vger.kernel.org
-Description:    The priority value of this work queue, it is a vlue relative to
+Description:    The priority value of this work queue, it is a value relative to
 		other work queue in the same group to control quality of service
 		for dispatching work from multiple workqueues in the same group.
 
diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index fd9a8045bb0c..b2553df2e786 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -137,7 +137,7 @@ Contact:	Vadim Pasternak <vadimpmellanox.com>
 Description:	These files show the system reset cause, as following:
 		COMEX thermal shutdown; wathchdog power off or reset was derived
 		by one of the next components: COMEX, switch board or by Small Form
-		Factor mezzanine, reset requested from ASIC, reset cuased by BIOS
+		Factor mezzanine, reset requested from ASIC, reset caused by BIOS
 		reload. Value 1 in file means this is reset cause, 0 - otherwise.
 		Only one of the above causes could be 1 at the same time, representing
 		only last reset cause.
@@ -183,7 +183,7 @@ What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/vpd_wp
 Date:		January 2020
 KernelVersion:	5.6
 Contact:	Vadim Pasternak <vadimpmellanox.com>
-Description:	This file allows to overwrite system VPD hardware wrtie
+Description:	This file allows to overwrite system VPD hardware write
 		protection when attribute is set 1.
 
 		The file is read/write.
diff --git a/Documentation/ABI/testing/configfs-iio b/Documentation/ABI/testing/configfs-iio
index aebda53ec0f7..1637fcb50f56 100644
--- a/Documentation/ABI/testing/configfs-iio
+++ b/Documentation/ABI/testing/configfs-iio
@@ -31,4 +31,4 @@ Date:		April 2016
 KernelVersion:	4.7
 Description:
 		Dummy IIO devices directory. Creating a directory here will result
-		in creating a dummy IIO device in the IIO subystem.
+		in creating a dummy IIO device in the IIO subsystem.
diff --git a/Documentation/ABI/testing/configfs-most b/Documentation/ABI/testing/configfs-most
index bc6b8bd18da4..0a4b8649aa5a 100644
--- a/Documentation/ABI/testing/configfs-most
+++ b/Documentation/ABI/testing/configfs-most
@@ -20,7 +20,7 @@ Description:
 
 		subbuffer_size
 				configure the sub-buffer size for this channel
-				(needed for synchronous and isochrnous data)
+				(needed for synchronous and isochronous data)
 
 
 		num_buffers
@@ -75,7 +75,7 @@ Description:
 
 		subbuffer_size
 				configure the sub-buffer size for this channel
-				(needed for synchronous and isochrnous data)
+				(needed for synchronous and isochronous data)
 
 
 		num_buffers
@@ -130,7 +130,7 @@ Description:
 
 		subbuffer_size
 				configure the sub-buffer size for this channel
-				(needed for synchronous and isochrnous data)
+				(needed for synchronous and isochronous data)
 
 
 		num_buffers
@@ -196,7 +196,7 @@ Description:
 
 		subbuffer_size
 				configure the sub-buffer size for this channel
-				(needed for synchronous and isochrnous data)
+				(needed for synchronous and isochronous data)
 
 
 		num_buffers
diff --git a/Documentation/ABI/testing/configfs-usb-gadget b/Documentation/ABI/testing/configfs-usb-gadget
index dc351e9af80a..b7943aa7e997 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget
+++ b/Documentation/ABI/testing/configfs-usb-gadget
@@ -137,7 +137,7 @@ Description:
 		This group contains "OS String" extension handling attributes.
 
 		=============	===============================================
-		use		flag turning "OS Desctiptors" support on/off
+		use		flag turning "OS Descriptors" support on/off
 		b_vendor_code	one-byte value used for custom per-device and
 				per-interface requests
 		qw_sign		an identifier to be reported as "OS String"
diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
index ac5e11af79a8..889ed45be4ca 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
@@ -170,7 +170,7 @@ Description:	Default color matching descriptors
 		bMatrixCoefficients	  matrix used to compute luma and
 					  chroma values from the color primaries
 		bTransferCharacteristics  optoelectronic transfer
-					  characteristic of the source picutre,
+					  characteristic of the source picture,
 					  also called the gamma function
 		bColorPrimaries		  color primaries and the reference
 					  white
@@ -311,7 +311,7 @@ Description:	Specific streaming header descriptors
 					a hardware trigger interrupt event
 		bTriggerSupport		flag specifying if hardware
 					triggering is supported
-		bStillCaptureMethod	method of still image caputre
+		bStillCaptureMethod	method of still image capture
 					supported
 		bTerminalLink		id of the output terminal to which
 					the video endpoint of this interface
diff --git a/Documentation/ABI/testing/debugfs-driver-genwqe b/Documentation/ABI/testing/debugfs-driver-genwqe
index 1c2f25674e8c..b45b016545d8 100644
--- a/Documentation/ABI/testing/debugfs-driver-genwqe
+++ b/Documentation/ABI/testing/debugfs-driver-genwqe
@@ -31,7 +31,7 @@ What:           /sys/kernel/debug/genwqe/genwqe<n>_card/prev_regs
 Date:           Oct 2013
 Contact:        haver@linux.vnet.ibm.com
 Description:    Dump of the error registers before the last reset of
-                the card occured.
+                the card occurred.
                 Only available for PF.
 
 What:           /sys/kernel/debug/genwqe/genwqe<n>_card/prev_dbg_uid0
diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index c78fc9282876..e89c6351503c 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -153,7 +153,7 @@ KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
 Description:    Triggers an I2C transaction that is generated by the device's
                 CPU. Writing to this file generates a write transaction while
-                reading from the file generates a read transcation
+                reading from the file generates a read transaction
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_reg
 Date:           Jan 2019
diff --git a/Documentation/ABI/testing/sysfs-bus-fsi b/Documentation/ABI/testing/sysfs-bus-fsi
index d148214181a1..76e0caa0c2b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-fsi
+++ b/Documentation/ABI/testing/sysfs-bus-fsi
@@ -12,7 +12,7 @@ KernelVersion:  4.12
 Contact:        linux-fsi@lists.ozlabs.org
 Description:
 		Sends an FSI BREAK command on a master's communication
-		link to any connnected slaves.  A BREAK resets connected
+		link to any connected slaves.  A BREAK resets connected
 		device's logic and preps it to receive further commands
 		from the master.
 
diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ef00fada2efb..93f9c3789d0f 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -139,8 +139,8 @@ Description:
 		binary file containing the Vital Product Data for the
 		device.  It should follow the VPD format defined in
 		PCI Specification 2.1 or 2.2, but users should consider
-		that some devices may have malformatted data.  If the
-		underlying VPD has a writable section then the
+		that some devices may have incorrectly formatted data.  
+		If the underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
 
 What:		/sys/bus/pci/devices/.../virtfnN
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 0eee30b27ab6..187eb7e97c92 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -50,7 +50,7 @@ Description:	Dynamic addition and removal of CPU's.  This is not hotplug
 		architecture specific.
 
 		release: writes to this file dynamically remove a CPU from
-		the system.  Information writtento the file to remove CPU's
+		the system.  Information written to the file to remove CPU's
 		is architecture specific.
 
 What:		/sys/devices/system/cpu/cpu#/node
@@ -97,7 +97,7 @@ Description:	CPU topology files that describe a logical CPU's relationship
 		corresponds to a physical socket number, but the actual value
 		is architecture and platform dependent.
 
-		thread_siblings: internel kernel map of cpu#'s hardware
+		thread_siblings: internal kernel map of cpu#'s hardware
 		threads within the same core as cpu#
 
 		thread_siblings_list: human-readable list of cpu#'s hardware
@@ -280,7 +280,7 @@ Description:	Disable L3 cache indices
 		on a processor with this functionality will return the currently
 		disabled index for that node. There is one L3 structure per
 		node, or per internal node on MCM machines. Writing a valid
-		index to one of these files will cause the specificed cache
+		index to one of these files will cause the specified cache
 		index to be disabled.
 
 		All AMD processors with L3 caches provide this functionality.
@@ -295,7 +295,7 @@ Description:	Processor frequency boosting control
 
 		This switch controls the boost setting for the whole system.
 		Boosting allows the CPU and the firmware to run at a frequency
-		beyound it's nominal limit.
+		beyond it's nominal limit.
 
 		More details can be found in
 		Documentation/admin-guide/pm/cpufreq.rst
@@ -532,7 +532,7 @@ What:		/sys/devices/system/cpu/smt
 		/sys/devices/system/cpu/smt/control
 Date:		June 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-Description:	Control Symetric Multi Threading (SMT)
+Description:	Control Symmetric Multi Threading (SMT)
 
 		active:  Tells whether SMT is active (enabled and siblings online)
 
diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index d1bc23cb6a9d..eaac6898f0c0 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -168,7 +168,7 @@ Description:	This file shows the manufacturing date in BCD format.
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/manufacturer_id
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
-Description:	This file shows the manufacturee ID. This is one of the
+Description:	This file shows the manufacturer ID. This is one of the
 		UFS device descriptor parameters. The full information about
 		the descriptor could be found at UFS specifications 2.1.
 
@@ -521,7 +521,7 @@ Description:	This file shows maximum VCC, VCCQ and VCCQ2 value for
 What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/manufacturer_name
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
-Description:	This file contains a device manufactureer name string.
+Description:	This file contains a device manufacturer name string.
 		The full information about the descriptor could be found at
 		UFS specifications 2.1.
 
diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 4849b8e84e42..5d9ae27bd462 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -238,7 +238,7 @@ Description:	Shows current reserved blocks in system, it may be temporarily
 What:		/sys/fs/f2fs/<disk>/gc_urgent
 Date:		August 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:	Do background GC agressively when set. When gc_urgent = 1,
+Description:	Do background GC aggressively when set. When gc_urgent = 1,
 		background thread starts to do GC by given gc_urgent_sleep_time
 		interval. When gc_urgent = 2, F2FS will lower the bar of
 		checking idle in order to process outstanding discard commands
-- 
2.25.1




