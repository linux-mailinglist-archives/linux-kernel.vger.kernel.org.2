Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A715640B0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhINOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233836AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A08E061165;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=rsagThLGknwU91UW+wq7iwL8KzIpjk7Uz5TTbN5z6wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxxBjqtUr5BzEsBi7poyCNuZU8OZ4EXanOLXeBYKiUL1CPEx5KfMMtRyyrTxwEj6c
         RtNmqfTiRoDPGArPs7spcsC3N8BG7qZBJPUr6RFf7B3PcYvO2Z1A5IUAsRwHz7EzWD
         N8ESPcDYTVBoiqLcafk3cElJHavpvzNWMXrF89tcLk3G1hqP2EzsItHXK9HwdNYut/
         k2wP9CfeRHHZbni3lRdQ39zErgg0wsD5MeY/TddNeA0rDQHr31HC3Ojy60zL//HCiV
         ag9eg+BoI2hAL0/XHapwbfmXGnSoC5+eBaRZe1rhHSWje+3AcdDvd+LW+d0Qr2Gns3
         mg5i9X2iTVXOw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000Kkm-ON; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/29] ABI: sysfs-class-mic: use the right wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:24 +0200
Message-Id: <321f36fe60fdd0d51013fbf79e5116decca5a4a2.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most ABI files, the wildcards are used as <x>, instead of (x).

Replace it to make it using a more standard wildcard. That helps
get_abi.pl to convert it into a regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-mic | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mic b/Documentation/ABI/testing/sysfs-class-mic
index bd0e780c3760..5e5f36d10055 100644
--- a/Documentation/ABI/testing/sysfs-class-mic
+++ b/Documentation/ABI/testing/sysfs-class-mic
@@ -8,7 +8,7 @@ Description:
 		PCIe form factor add-in Coprocessor card based on the Intel Many
 		Integrated Core (MIC) architecture that runs a Linux OS.
 
-What:		/sys/class/mic/mic(x)
+What:		/sys/class/mic/mic<X>
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -17,7 +17,7 @@ Description:
 		represent MIC devices (0,1,..etc). Each directory has
 		information specific to that MIC device.
 
-What:		/sys/class/mic/mic(x)/family
+What:		/sys/class/mic/mic<X>/family
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -25,7 +25,7 @@ Description:
 		Provides information about the Coprocessor family for an Intel
 		MIC device. For example - "x100"
 
-What:		/sys/class/mic/mic(x)/stepping
+What:		/sys/class/mic/mic<X>/stepping
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -33,7 +33,7 @@ Description:
 		Provides information about the silicon stepping for an Intel
 		MIC device. For example - "A0" or "B0"
 
-What:		/sys/class/mic/mic(x)/state
+What:		/sys/class/mic/mic<X>/state
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -69,7 +69,7 @@ Description:
 		"shutdown"  Initiates card OS shutdown.
 		==========  ===================================================
 
-What:		/sys/class/mic/mic(x)/shutdown_status
+What:		/sys/class/mic/mic<X>/shutdown_status
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -88,7 +88,7 @@ Description:
 		"restart"   Shutdown because of a restart command.
 		==========  ===================================================
 
-What:		/sys/class/mic/mic(x)/cmdline
+What:		/sys/class/mic/mic<X>/cmdline
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -104,7 +104,7 @@ Description:
 		or modify existing ones and then write the whole kernel command
 		line back to this entry.
 
-What:		/sys/class/mic/mic(x)/firmware
+What:		/sys/class/mic/mic<X>/firmware
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -114,7 +114,7 @@ Description:
 		card can be found. The entry can be written to change the
 		firmware image location under /lib/firmware/.
 
-What:		/sys/class/mic/mic(x)/ramdisk
+What:		/sys/class/mic/mic<X>/ramdisk
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -124,7 +124,7 @@ Description:
 		OS boot can be found. The entry can be written to change
 		the ramdisk image location under /lib/firmware/.
 
-What:		/sys/class/mic/mic(x)/bootmode
+What:		/sys/class/mic/mic<X>/bootmode
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -135,7 +135,7 @@ Description:
 		a) linux - Boot a Linux image.
 		b) flash - Boot an image for flash updates.
 
-What:		/sys/class/mic/mic(x)/log_buf_addr
+What:		/sys/class/mic/mic<X>/log_buf_addr
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -149,7 +149,7 @@ Description:
 		log buffer address to be written can be found in the System.map
 		file of the card OS.
 
-What:		/sys/class/mic/mic(x)/log_buf_len
+What:		/sys/class/mic/mic<X>/log_buf_len
 Date:		October 2013
 KernelVersion:	3.13
 Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
@@ -163,7 +163,7 @@ Description:
 		buffer length address to be written can be found in the
 		System.map file of the card OS.
 
-What:		/sys/class/mic/mic(x)/heartbeat_enable
+What:		/sys/class/mic/mic<X>/heartbeat_enable
 Date:		March 2015
 KernelVersion:	4.4
 Contact:	Ashutosh Dixit <ashutosh.dixit@intel.com>
-- 
2.31.1

