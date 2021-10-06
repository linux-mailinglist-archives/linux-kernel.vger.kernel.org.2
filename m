Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9786423E93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhJFNXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhJFNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:23:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD80C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 06:21:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t2so8779304wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0GVxKKDaAwLgKY5s+A/pUoCd/nugZfzI2EHKjl1wVo=;
        b=ooQmfINl1i9PS00o+DMf5SMHvZvnme4PETOUREHu5DlcHrCFjtbtVzFP9cl56qqhXE
         d4DE1YindQWJ+pQ9r5Ns7k5VNXG1BMZnY3gtYOv9BipYDO+rov/izwviucmwEWA/9yiC
         XkG5HgKybK5IqEN2+IN+2/UPs6MfgqgfNrMpTuaY2bS1OC0q7VyoEOufZhmJF1HpM0Yf
         4An7MOACINsqNEsKX5EZHLQcZuRc0tAa5FzjkZ18V0R3HCr2aKzKJyHCbAjUeenuM4DJ
         pPeFX1wReLhmPD485W689qK2XgkmcQQhGoUAVMCub5Gn300LnFEJzh0+N1aS7GYIKEZO
         j8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0GVxKKDaAwLgKY5s+A/pUoCd/nugZfzI2EHKjl1wVo=;
        b=dDR0jT3E4YBR30+AGdvuUYfYjSKds4NHNUNbeEk3487Bg+p9oYO2uMRMj4kbQjrBW5
         ZHeXkBS7RJhKFsxOTok14ziMyldI8+d7rgwsLBBjTm5liLl6TStiCdR8kJxcgtBL8uRH
         uUEBy7aaV1CC2kVPFWcLDCKymKp6un1N6fayme7POhRV6AdDrtZO3pChZ+Da+PM9Ra9p
         0JY2HSTyRLbHjxOLAWilaaWXdT9EzVxGmsNR2f9YZdmpquhBhQI7WWS7FIEf1Hm8LUK1
         a4+chW3AQiX1UFKsLtuOb1q4JO1uw/X914uerjn5JnwFJUiy9d8ogUhcG04iYQySvYhZ
         +Q0Q==
X-Gm-Message-State: AOAM530X8KRjPWd7A2Pv1zi7lHntD3w5MGRLpIrMaymf+e1PsKpBJdP8
        PxrEqoCXkBwTAUPCZr8CACs=
X-Google-Smtp-Source: ABdhPJyOi0/FWXiz+dwYsjrDksb+UU7DZgNZujUhjbKd9KFD/17C/vwR3923FlrTw8NF5vlTXQ5iJA==
X-Received: by 2002:adf:ba03:: with SMTP id o3mr8271934wrg.242.1633526468366;
        Wed, 06 Oct 2021 06:21:08 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id k23sm2027066wrh.93.2021.10.06.06.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:21:07 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, Gioh Kim <gi-oh.kim@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] docs: typo fixes in Documentation/ABI/
Date:   Wed,  6 Oct 2021 15:20:56 +0200
Message-Id: <20211006132104.105288-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these changes are about to remove repeated words from severals place in the Documentation/ABI/ directory:

- In file stable/sysfs-module:41: "the the source"

- In file testing/sysfs-bus-rapidio:98: "that that owns"

- In file testing/sysfs-class-cxl:106: "the the lowest"

- In file testing/sysfs-class-cxl:107: "this this kernel"

- In file testing/sysfs-class-rnbd-client:131: "as as the"

- In file testing/sysfs-class-rtrs-client:81: "the the name"

- In file testing/sysfs-class-rtrs-server:27: "the the name"

- In file testing/sysfs-devices-platform-ACPI-TAD:77: "the the status"

- In file testing/sysfs-devices-power:306: "the the children"

- In file testing/sysfs-driver-ufs:986: "the The amount"

- In file testing/sysfs-firmware-acpi:115: "send send a Notify"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/stable/sysfs-module                     | 2 +-
 Documentation/ABI/testing/sysfs-bus-rapidio               | 2 +-
 Documentation/ABI/testing/sysfs-class-cxl                 | 4 ++--
 Documentation/ABI/testing/sysfs-class-rnbd-client         | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-client         | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-server         | 2 +-
 Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD | 2 +-
 Documentation/ABI/testing/sysfs-devices-power             | 2 +-
 Documentation/ABI/testing/sysfs-driver-ufs                | 2 +-
 Documentation/ABI/testing/sysfs-firmware-acpi             | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 560b4a3278df..41b1f16e8795 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -38,7 +38,7 @@ What:		/sys/module/<MODULENAME>/srcversion
 Date:		Jun 2005
 Description:
 		If the module source has MODULE_VERSION, this file will contain
-		the checksum of the the source code.
+		the checksum of the source code.
 
 What:		/sys/module/<MODULENAME>/version
 Date:		Jun 2005
diff --git a/Documentation/ABI/testing/sysfs-bus-rapidio b/Documentation/ABI/testing/sysfs-bus-rapidio
index f8b6728dac10..9e8fbff99b75 100644
--- a/Documentation/ABI/testing/sysfs-bus-rapidio
+++ b/Documentation/ABI/testing/sysfs-bus-rapidio
@@ -95,7 +95,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 		Alexandre Bounine <alexandre.bounine@idt.com>
 Description:
 		(RO) returns name of previous device (switch) on the path to the
-		device that that owns this attribute
+		device that owns this attribute
 
 What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/modalias
 Date:		Jul, 2013
diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 3c77677e0ca7..594fda254130 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -103,8 +103,8 @@ What:           /sys/class/cxl/<afu>/api_version_compatible
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
-                Decimal value of the the lowest version of the userspace API
-                this this kernel supports.
+                Decimal value of the lowest version of the userspace API
+                this kernel supports.
 Users:		https://github.com/ibm-capi/libcxl
 
 
diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
index 0b5997ab3365..e6cdc851952c 100644
--- a/Documentation/ABI/testing/sysfs-class-rnbd-client
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
@@ -128,6 +128,6 @@ Description:	For each device mapped on the client a new symbolic link is created
 		The <device_id> of each device is created as follows:
 
 		- If the 'device_path' provided during mapping contains slashes ("/"),
-		  they are replaced by exclamation mark ("!") and used as as the
+		  they are replaced by exclamation mark ("!") and used as the
 		  <device_id>. Otherwise, the <device_id> will be the same as the
 		  "device_path" provided.
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
index 49a4157c7bf1..fecc59d1b96f 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-client
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -78,7 +78,7 @@ What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.
 
 What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
index 3b6d5b067df0..b08601d80409 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-server
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
@@ -24,7 +24,7 @@ What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.
 
 What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
index f7b360a61b21..bc44bc903bc8 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
+++ b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
@@ -74,7 +74,7 @@ Description:
 
 		Reads also cause the AC alarm timer status to be reset.
 
-		Another way to reset the the status of the AC alarm timer is to
+		Another way to reset the status of the AC alarm timer is to
 		write (the number) 0 to this file.
 
 		If the status return value indicates that the timer has expired,
diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1b2a2d41ff80..54195530e97a 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -303,5 +303,5 @@ Date:		Apr 2010
 Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
 Description:
 		Reports the runtime PM children usage count of a device, or
-		0 if the the children will be ignored.
+		0 if the children will be ignored.
 
diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 863cc4897277..57aec11a573f 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -983,7 +983,7 @@ Description:	This file shows the amount of data that the host plans to
 What:		/sys/class/scsi_device/*/device/dyn_cap_needed
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
-Description:	This file shows the The amount of physical memory needed
+Description:	This file shows The amount of physical memory needed
 		to be removed from the physical memory resources pool of
 		the particular logical unit. The full information about
 		the attribute could be found at UFS specifications 2.1.
diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index 819939d858c9..39173375c53a 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -112,7 +112,7 @@ Description:
 		OS context.  GPE 0x12, for example, would vector
 		to a level or edge handler called _L12 or _E12.
 		The handler may do its business and return.
-		Or the handler may send send a Notify event
+		Or the handler may send a Notify event
 		to a Linux device driver registered on an ACPI device,
 		such as a battery, or a processor.
 
-- 
2.25.1

