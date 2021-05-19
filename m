Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2A3889FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbhESI5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:57:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51173 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbhESI5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:57:51 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljI0F-00043c-Cb
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 08:56:31 +0000
Received: by mail-ej1-f70.google.com with SMTP id i8-20020a1709068508b02903d75f46b7aeso3091051ejx.18
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmvPHtHONXR6Q5Pk8szU8eM48ni/j0LVozxpp34KfeI=;
        b=OXVP/yEOP9GhENMnSAYK/Vi0ASjFh1dVVAxQA0YODERK66VTdqGyOaEoCJFvgzTnFS
         4ZYFB8ZtcpSFoPh563wXA7rZ0snJyeapis/1SQWrG9lqzavBl8WayTGJU8l7C4HkQPA1
         mrsTsVlakhzXcHj1+7o9ZHCsut0ZK7qbFXnX71E0prM3HFcsDMNY8g++MJ9tpT7QmD2m
         XY65N8uNQv6MZvoUtdPKhKlOU6Z1uTb9jeRVtfeTrmpCEerjQkf9SQ7GKs91UVTomt9g
         bv3cD3BfOhXbwW1Mx9Ile8v7w/RG/izntqLoCdwQfk3+dXjP2YcYDYZ2AX5GvNmuXn9N
         DpYg==
X-Gm-Message-State: AOAM531MBbeKCGBZ1rBZQ2MXmlCsUC21Hr/O/3lMzBzTnY4fbJz3Wnbv
        YUv45EC/hU1w9emnd3KGhvmPtNAdKSFsGnQrR7JCvcelKXZCgWFpUDA61zklHi3t7CFLzDi7Bgw
        Hp4IyMMTa2L81gPDw0zLJpc6jQlIMX2tNmJwwSRU5Nw==
X-Received: by 2002:a17:907:3f28:: with SMTP id hq40mr11578389ejc.283.1621414591053;
        Wed, 19 May 2021 01:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBGb0W65PbOTbOeVwVlYQYGkyxecZouc039D103GEEs8pqoH5DwjSWtElvjg6/M5XGZM19sA==
X-Received: by 2002:a17:907:3f28:: with SMTP id hq40mr11578369ejc.283.1621414590747;
        Wed, 19 May 2021 01:56:30 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l28sm1364816edc.29.2021.05.19.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:56:30 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 2/3] block/Kconfig: Whitespace and indentation cleanups
Date:   Wed, 19 May 2021 10:56:14 +0200
Message-Id: <20210519085615.12101-3-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519085615.12101-1-juergh@canonical.com>
References: <20210519085615.12101-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace multiple whitespaces with a tab and make the help text indendation
1 tab + 2 spaces which seems to be the convention.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 block/Kconfig | 132 +++++++++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index fbc4cf1a2075..89478184f9f1 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -3,26 +3,26 @@
 # Block layer core configuration
 #
 menuconfig BLOCK
-       bool "Enable the block layer" if EXPERT
-       default y
-       select SBITMAP
-       select SRCU
-       help
-	 Provide block layer support for the kernel.
+	bool "Enable the block layer" if EXPERT
+	default y
+	select SBITMAP
+	select SRCU
+	help
+	  Provide block layer support for the kernel.
 
-	 Disable this option to remove the block layer support from the
-	 kernel. This may be useful for embedded devices.
+	  Disable this option to remove the block layer support from the
+	  kernel. This may be useful for embedded devices.
 
-	 If this option is disabled:
+	  If this option is disabled:
 
-	   - block device files will become unusable
-	   - some filesystems (such as ext3) will become unavailable.
+	    - block device files will become unusable
+	    - some filesystems (such as ext3) will become unavailable.
 
-	 Also, SCSI character devices and USB storage will be disabled since
-	 they make use of various block layer definitions and facilities.
+	  Also, SCSI character devices and USB storage will be disabled since
+	  they make use of various block layer definitions and facilities.
 
-	 Say Y here unless you know you really don't want to mount disks and
-	 suchlike.
+	  Say Y here unless you know you really don't want to mount disks and
+	  suchlike.
 
 if BLOCK
 
@@ -67,14 +67,14 @@ config BLK_DEV_BSGLIB
 config BLK_DEV_INTEGRITY
 	bool "Block layer data integrity support"
 	help
-	Some storage devices allow extra information to be
-	stored/retrieved to help protect the data.  The block layer
-	data integrity option provides hooks which can be used by
-	filesystems to ensure better data integrity.
+	  Some storage devices allow extra information to be
+	  stored/retrieved to help protect the data.  The block layer
+	  data integrity option provides hooks which can be used by
+	  filesystems to ensure better data integrity.
 
-	Say yes here if you have a storage device that provides the
-	T10/SCSI Data Integrity Field or the T13/ATA External Path
-	Protection.  If in doubt, say N.
+	  Say yes here if you have a storage device that provides the
+	  T10/SCSI Data Integrity Field or the T13/ATA External Path
+	  Protection.  If in doubt, say N.
 
 config BLK_DEV_INTEGRITY_T10
 	tristate
@@ -85,64 +85,64 @@ config BLK_DEV_ZONED
 	bool "Zoned block device support"
 	select MQ_IOSCHED_DEADLINE
 	help
-	Block layer zoned block device support. This option enables
-	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
-	devices.
+	  Block layer zoned block device support. This option enables
+	  support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
+	  devices.
 
-	Say yes here if you have a ZAC, ZBC, or ZNS storage device.
+	  Say yes here if you have a ZAC, ZBC, or ZNS storage device.
 
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP=y
 	select BLK_CGROUP_RWSTAT
 	help
-	Block layer bio throttling support. It can be used to limit
-	the IO rate to a device. IO rate policies are per cgroup and
-	one needs to mount and use blkio cgroup controller for creating
-	cgroups and specifying per device IO rate policies.
+	  Block layer bio throttling support. It can be used to limit
+	  the IO rate to a device. IO rate policies are per cgroup and
+	  one needs to mount and use blkio cgroup controller for creating
+	  cgroups and specifying per device IO rate policies.
 
-	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
+	  See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
 
 config BLK_DEV_THROTTLING_LOW
 	bool "Block throttling .low limit interface support (EXPERIMENTAL)"
 	depends on BLK_DEV_THROTTLING
 	help
-	Add .low limit interface for block throttling. The low limit is a best
-	effort limit to prioritize cgroups. Depending on the setting, the limit
-	can be used to protect cgroups in terms of bandwidth/iops and better
-	utilize disk resource.
+	  Add .low limit interface for block throttling. The low limit is a best
+	  effort limit to prioritize cgroups. Depending on the setting, the limit
+	  can be used to protect cgroups in terms of bandwidth/iops and better
+	  utilize disk resource.
 
-	Note, this is an experimental interface and could be changed someday.
+	  Note, this is an experimental interface and could be changed someday.
 
 config BLK_CMDLINE_PARSER
 	bool "Block device command line partition parser"
 	help
-	Enabling this option allows you to specify the partition layout from
-	the kernel boot args.  This is typically of use for embedded devices
-	which don't otherwise have any standardized method for listing the
-	partitions on a block device.
+	  Enabling this option allows you to specify the partition layout from
+	  the kernel boot args.  This is typically of use for embedded devices
+	  which don't otherwise have any standardized method for listing the
+	  partitions on a block device.
 
-	See Documentation/block/cmdline-partition.rst for more information.
+	  See Documentation/block/cmdline-partition.rst for more information.
 
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
 	help
-	Enabling this option enables the block layer to throttle buffered
-	background writeback from the VM, making it more smooth and having
-	less impact on foreground operations. The throttling is done
-	dynamically on an algorithm loosely based on CoDel, factoring in
-	the realtime performance of the disk.
+	  Enabling this option enables the block layer to throttle buffered
+	  background writeback from the VM, making it more smooth and having
+	  less impact on foreground operations. The throttling is done
+	  dynamically on an algorithm loosely based on CoDel, factoring in
+	  the realtime performance of the disk.
 
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP=y
 	help
-	Enabling this option enables the .latency interface for IO throttling.
-	The IO controller will attempt to maintain average IO latencies below
-	the configured latency target, throttling anybody with a higher latency
-	target than the victimized group.
+	  Enabling this option enables the .latency interface for IO throttling.
+	  The IO controller will attempt to maintain average IO latencies below
+	  the configured latency target, throttling anybody with a higher latency
+	  target than the victimized group.
 
-	Note, this is an experimental interface and could be changed someday.
+	  Note, this is an experimental interface and could be changed someday.
 
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
@@ -150,40 +150,40 @@ config BLK_CGROUP_IOCOST
 	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
-	Enabling this option enables the .weight interface for cost
-	model based proportional IO control.  The IO controller
-	distributes IO capacity between different groups based on
-	their share of the overall weight distribution.
+	  Enabling this option enables the .weight interface for cost
+	  model based proportional IO control.  The IO controller
+	  distributes IO capacity between different groups based on
+	  their share of the overall weight distribution.
 
 config BLK_WBT_MQ
 	bool "Multiqueue writeback throttling"
 	default y
 	depends on BLK_WBT
 	help
-	Enable writeback throttling by default on multiqueue devices.
+	  Enable writeback throttling by default on multiqueue devices.
 
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
 	depends on DEBUG_FS
 	help
-	Include block layer debugging information in debugfs. This information
-	is mostly useful for kernel developers, but it doesn't incur any cost
-	at runtime.
+	  Include block layer debugging information in debugfs. This information
+	  is mostly useful for kernel developers, but it doesn't incur any cost
+	  at runtime.
 
-	Unless you are building a kernel for a tiny system, you should
-	say Y here.
+	  Unless you are building a kernel for a tiny system, you should
+	  say Y here.
 
 config BLK_DEBUG_FS_ZONED
-       bool
-       default BLK_DEBUG_FS && BLK_DEV_ZONED
+	bool
+	default BLK_DEBUG_FS && BLK_DEV_ZONED
 
 config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
 	help
-	Builds Logic for interfacing with Opal enabled controllers.
-	Enabling this option enables users to setup/unlock/lock
-	Locking ranges for SED devices using the Opal protocol.
+	  Builds Logic for interfacing with Opal enabled controllers.
+	  Enabling this option enables users to setup/unlock/lock
+	  Locking ranges for SED devices using the Opal protocol.
 
 config BLK_INLINE_ENCRYPTION
 	bool "Enable inline encryption support in block layer"
-- 
2.27.0

