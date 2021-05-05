Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93C5374994
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhEEUpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhEEUo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:44:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:44:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x8so2964932qkl.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=bYpXp+rxNeIx+Yy7gsDa2e7gON8Fmosae9VxictDqSA=;
        b=ChzjzlD/PLsU7gisCTxb7Wp+rgINg5zgLmaRsegQLf4l2vCuS2CuZnx+lMxej6Tq+e
         WiS8Z+vvEJiAb3k4JWg6Aj+oBYvRL3e2xrEwwd+fC+1pDLySrJI0eyxoo+TvIwZ77uXd
         nGSfr8rlo7vT8ZnJudP6BaW1eE+CNPPI6HpxOjx09JAjUBuhduJIR5fR4ox5JqrkE2aw
         +NIaeXWfjPbRBVFMnCSZyovtjje2cFJ+0YU9uHbMdgScTPb/zhmdlDQ9jVv05OSk47Om
         nVngTGbaaAkHNy3axCjtjHb5YuWUWfwTQvpzNynzKFNBQBnwH7Cke4W1Tc9aSdJqVmgY
         wp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=bYpXp+rxNeIx+Yy7gsDa2e7gON8Fmosae9VxictDqSA=;
        b=HCkX827nxvvHGK8Lwd547zL9W62LD/ukMRN5KTJJLaGUlOL2jYz+lzbx+b7FQnYTHf
         kv6IRGNwUvgL2BM8WTZ2yKb9J3F2QFQfLAlo9VYaLmfStS7Pn1U8Z71Cp0LLD7z8WvJR
         gM0L6zAqmk+yF3NFj4tQzwZqB9aiioQutvJ0Ld6tS08bJhpf5As8US118qVbSnBiVmwL
         DAgbNqkrGd45ChpvW8j/gUN4NAM1uxwXd75eYS/icFNGomoj7sKJnafAwoK+CMyJBVFe
         79tRnsNVF08E9+tApzLj95l8Zt9yZtW2MRmjoovpDfbYSUkcdP3Uxlv+GBPo50D+T+eS
         QCWA==
X-Gm-Message-State: AOAM533oZNFJsuW3GHY2Utf82V/IYg80ZMuNBcbY42bbAAVuDM5kcS0a
        TOb7RQ1KYsxluHi19SgUpbAT7g==
X-Google-Smtp-Source: ABdhPJy46Siibk+yU4vAEaLWIdaY9oj1QJDJ/GE7lqyq3XkoaDGwPhCH8emFqR2gANQ6qJy8T4wwWw==
X-Received: by 2002:ae9:dc41:: with SMTP id q62mr656103qkf.22.1620247440570;
        Wed, 05 May 2021 13:44:00 -0700 (PDT)
Received: from iron-maiden.localnet ([66.199.90.164])
        by smtp.gmail.com with ESMTPSA id n15sm319997qti.51.2021.05.05.13.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:44:00 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     corbet@lwn.net, hdegoede@redhat.com, mchehab+huawei@kernel.org,
        Jonathan.Cameron@huawei.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed typos in all directories of Documentation/ABI/
Date:   Wed, 05 May 2021 16:43:59 -0400
Message-ID: <2219636.ElGaqSPkdT@iron-maiden>
Organization: Virginia Tech
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
  isochrnous" for "isochronous", "Desctiptors" for "Descriptors", "picutre" for 
  "picture", "capture" for "capture", "occured" for "ocurred", "connnected" for 
  "connected","agressively" for "aggressively","manufacturee" for "manufacturer"
  and "transaction" for "transaction" and "malformatted" for "malformed". This 
  updates a total of ten files.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 Documentation/ABI/obsolete/sysfs-cpuidle            | 2 +-
 Documentation/ABI/removed/sysfs-kernel-uids         | 2 +-
 Documentation/ABI/stable/sysfs-bus-vmbus            | 4 ++--
 Documentation/ABI/stable/sysfs-bus-xen-backend      | 2 +-
 Documentation/ABI/stable/sysfs-class-infiniband     | 2 +-
 Documentation/ABI/stable/sysfs-driver-dma-idxd      | 2 +-
 Documentation/ABI/stable/sysfs-driver-mlxreg-io     | 4 ++--
 Documentation/ABI/testing/configfs-iio              | 2 +-
 Documentation/ABI/testing/configfs-most             | 8 ++++----
 Documentation/ABI/testing/configfs-usb-gadget       | 2 +-
 Documentation/ABI/testing/configfs-usb-gadget-uvc   | 4 ++--
 Documentation/ABI/testing/debugfs-driver-genwqe     | 2 +-
 Documentation/ABI/testing/debugfs-driver-habanalabs | 2 +-
 Documentation/ABI/testing/sysfs-bus-fsi             | 2 +-
 Documentation/ABI/testing/sysfs-bus-pci             | 2 +-
 Documentation/ABI/testing/sysfs-driver-ufs          | 4 ++--
 Documentation/ABI/testing/sysfs-fs-f2fs             | 2 +-
 17 files changed, 24 insertions(+), 24 deletions(-)

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
index 42599d9fa161..f2bcb719f1d9 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -61,13 +61,13 @@ Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Directory for per-channel information
-		NN is the VMBUS relid associtated with the channel.
+		NN is the VMBUS relid associated with the channel.
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
 Date:		September. 2017
 KernelVersion:	4.14
 Contact:	Stephen Hemminger <sthemmin@microsoft.com>
-Description:	VCPU (sub)channel is affinitized to
+Description:	PCP (sub)channel is affinitized to
 Users:		tools/hv/lsvmbus and other debugging tools
 
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/in_mask
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
 
diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
index 348c4ac803ad..bbaa7bab8af4 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -140,7 +140,7 @@ Description:
 		by LocalPhyErrors
 
 		excessive_buffer_overrun_errors: (RO) This counter, indicates an
-		input buffer overrun. It indicates possible misconfiguration of
+		input buffer overrun. It indicates possible missconfiguration of
 		a port, either by the Subnet Manager (SM) or by user
 		intervention. It can also indicate hardware issues or extremely
 		poor link signal integrity
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
index ef00fada2efb..bfd017204563 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -139,7 +139,7 @@ Description:
 		binary file containing the Vital Product Data for the
 		device.  It should follow the VPD format defined in
 		PCI Specification 2.1 or 2.2, but users should consider
-		that some devices may have malformatted data.  If the
+		that some devices may have malformed data.  If the
 		underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
 
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




