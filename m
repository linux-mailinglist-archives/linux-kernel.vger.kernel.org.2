Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C940B100
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhINOhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233870AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C878A61242;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=omLihTTkbbmL7wIzlqe8Cy3U+pVQfVA1OrggMS33ax4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mcjjl1/mIuLKA5wTDc8SGCaPui4mak+DTZPM3c5wtPbMXXp6i6UjOauzyyU+z97Es
         /fTbvoCedhKymDn8KRRIIar5cyzueQaDRCfwIwgWy3quqZXLbV1TLjX5YmmkKOEx1O
         NDX3fLQkXvbeGKGq0kvr41OAl9tlypqnskiQM2OP6Ej4ZBkVTR18XkwX7PUU2MPHbc
         A4sf6y4RoVZ/3Dgt3fkaukYMM95ZhJ41LJGuh8uUh+p56Du2PvKOa7cy4A7J8ku75h
         4Xig/0pqmuv8Xdmk1DWnMS1idSVKY0e04n7r0MexHHo7YSmB/Rd8Jqzp6L8CaW9GtL
         Gze/SXJ3VEwYQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000Kka-Iw; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/29] ABI: sysfs-bus-rapidio: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:21 +0200
Message-Id: <e66677d1473dd275b7386f971e0d9fb9eec40ca0.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While humans may be able to understand that something like:

	/sys/bus/rapidio/devices/nn:d:iiii

could actually mean:

	/sys/bus/rapidio/devices/00:e:0000

This is something that computers can't easily identify. As
get_abi.pl needs to convert it into a regex, change What: lines
to:

	/sys/bus/rapidio/devices/<nn>:<d>:<iiii>

Which is the commonly-used pattern on ABI files for wildcards.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-rapidio | 32 ++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rapidio b/Documentation/ABI/testing/sysfs-bus-rapidio
index 634ea207a50a..f8b6728dac10 100644
--- a/Documentation/ABI/testing/sysfs-bus-rapidio
+++ b/Documentation/ABI/testing/sysfs-bus-rapidio
@@ -1,4 +1,4 @@
-What:		/sys/bus/rapidio/devices/nn:d:iiii
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>
 Description:
 		For each RapidIO device, the RapidIO subsystem creates files in
 		an individual subdirectory with the following name format of
@@ -29,7 +29,7 @@ Description:
 Attributes Common for All RapidIO Devices
 -----------------------------------------
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/did
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/did
 Date:		Nov, 2005
 KernelVersion:	v2.6.15
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -37,7 +37,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 Description:
 		(RO) returns the device identifier
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/vid
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/vid
 Date:		Nov, 2005
 KernelVersion:	v2.6.15
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -45,7 +45,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 Description:
 		(RO) returns the device vendor identifier
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/device_rev
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/device_rev
 Date:		Nov, 2005
 KernelVersion:	v2.6.15
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -53,7 +53,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 Description:
 		(RO) returns the device revision level
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/asm_did
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/asm_did
 Date:		Nov, 2005
 KernelVersion:	v2.6.15
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -61,7 +61,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 Description:
 		(RO) returns identifier for the assembly containing the device
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/asm_rev
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/asm_rev
 Date:		Nov, 2005
 KernelVersion:	v2.6.15
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -70,7 +70,7 @@ Description:
 		(RO) returns revision level of the assembly containing the
 		device
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/asm_vid
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/asm_vid
 Date:		Nov, 2005
 KernelVersion:	v2.6.15
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -79,7 +79,7 @@ Description:
 		(RO) returns vendor identifier of the assembly containing the
 		device
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/destid
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/destid
 Date:		Mar, 2011
 KernelVersion:	v2.6.3
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -88,7 +88,7 @@ Description:
 		(RO) returns device destination ID assigned by the enumeration
 		routine
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/lprev
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/lprev
 Date:		Mar, 2011
 KernelVersion:	v2.6.39
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -97,7 +97,7 @@ Description:
 		(RO) returns name of previous device (switch) on the path to the
 		device that that owns this attribute
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/modalias
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/modalias
 Date:		Jul, 2013
 KernelVersion:	v3.11
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -105,7 +105,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 Description:
 		(RO) returns the device modalias
 
-What:		/sys/bus/rapidio/devices/nn:d:iiii/config
+What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/config
 Date:		Nov, 2005
 KernelVersion:	v2.6.15
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -128,7 +128,7 @@ device-specific sysfs attributes by specifying a callback function that may be
 set by the switch initialization routine during enumeration or discovery
 process.
 
-What:		/sys/bus/rapidio/devices/nn:s:iiii/routes
+What:		/sys/bus/rapidio/devices/<nn>:<s>:<iiii>/routes
 Date:		Nov, 2005
 KernelVersion:	v2.6.15
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -138,7 +138,7 @@ Description:
 		This attribute reports only valid routing table entries, one
 		line for each entry.
 
-What:		/sys/bus/rapidio/devices/nn:s:iiii/destid
+What:		/sys/bus/rapidio/devices/<nn>:<s>:<iiii>/destid
 Date:		Mar, 2011
 KernelVersion:	v2.6.3
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -147,7 +147,7 @@ Description:
 		(RO) device destination ID of the associated device that defines
 		a route to the switch
 
-What:		/sys/bus/rapidio/devices/nn:s:iiii/hopcount
+What:		/sys/bus/rapidio/devices/<nn>:<s>:<iiii>/hopcount
 Date:		Mar, 2011
 KernelVersion:	v2.6.39
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -155,7 +155,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 Description:
 		(RO) number of hops on the path to the switch
 
-What:		/sys/bus/rapidio/devices/nn:s:iiii/lnext
+What:		/sys/bus/rapidio/devices/<nn>:<s>:<iiii>/lnext
 Date:		Mar, 2011
 KernelVersion:	v2.6.39
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
@@ -172,7 +172,7 @@ Device-specific Switch Attributes
 
 IDT_GEN2-
 
-What:		/sys/bus/rapidio/devices/nn:s:iiii/errlog
+What:		/sys/bus/rapidio/devices/<nn>:<s>:<iiii>/errlog
 Date:		Oct, 2010
 KernelVersion:	v2.6.37
 Contact:	Matt Porter <mporter@kernel.crashing.org>,
-- 
2.31.1

