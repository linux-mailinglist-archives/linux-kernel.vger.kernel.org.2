Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADAE40D576
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhIPJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235466AbhIPJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8B0E61357;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782803;
        bh=swRIG9LljGAFZs0bx42creS9NDiqYNdO/6An/2Vp5co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtHVqXfk++jpAS6MXpWgh7MY7pSTIdyyadoG6DRbyB6jxtIBb0BClTETwUIwKzhKH
         oTs2fMHOJFHK5v232rBSPAr5yB8vxRj3o7PZDvCObuHc4kxwWoh1L9SD7Ib0OzkoAA
         fSQ6Uec1V9+7X1cB2XRPV7zZOHviPVte6D9TuubygKVSyj/LSIckHMyrrQ+XVYXnUz
         qM/KapNE7X397VG1EyG13eY0GlOlWXriqVuuUL2zYjYhr++GgHVJDD+tJ/3iqachZA
         jnz9qHir3THnFeWDH7zSALeZ2mCxxNlZKF9WjkuX0AhjoziuNUYY5cJ4d4bJPcnwG3
         t6x9j7E6XiT5A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFR-001qki-3N; Thu, 16 Sep 2021 11:00:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/30] ABI: sysfs-class-mei: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:45 +0200
Message-Id: <3789f936a637f1b4059400099ae7a592cd4df8f5.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like.
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-mei | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mei b/Documentation/ABI/testing/sysfs-class-mei
index 5c52372b43cb..1db36ddf8e58 100644
--- a/Documentation/ABI/testing/sysfs-class-mei
+++ b/Documentation/ABI/testing/sysfs-class-mei
@@ -6,7 +6,7 @@ Description:
 		The mei/ class sub-directory belongs to mei device class
 
 
-What:		/sys/class/mei/meiN/
+What:		/sys/class/mei/mei<N>/
 Date:		May 2014
 KernelVersion:	3.17
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -14,7 +14,7 @@ Description:
 		The /sys/class/mei/meiN directory is created for
 		each probed mei device
 
-What:		/sys/class/mei/meiN/fw_status
+What:		/sys/class/mei/mei<N>/fw_status
 Date:		Nov 2014
 KernelVersion:	3.19
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -29,7 +29,7 @@ Description:	Display fw status registers content
 		Also number of registers varies between 1 and 6
 		depending on generation.
 
-What:		/sys/class/mei/meiN/hbm_ver
+What:		/sys/class/mei/mei<N>/hbm_ver
 Date:		Aug 2016
 KernelVersion:	4.9
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -38,7 +38,7 @@ Description:	Display the negotiated HBM protocol version.
 		The HBM protocol version negotiated
 		between the driver and the device.
 
-What:		/sys/class/mei/meiN/hbm_ver_drv
+What:		/sys/class/mei/mei<N>/hbm_ver_drv
 Date:		Aug 2016
 KernelVersion:	4.9
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -46,7 +46,7 @@ Description:	Display the driver HBM protocol version.
 
 		The HBM protocol version supported by the driver.
 
-What:		/sys/class/mei/meiN/tx_queue_limit
+What:		/sys/class/mei/mei<N>/tx_queue_limit
 Date:		Jan 2018
 KernelVersion:	4.16
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -55,7 +55,7 @@ Description:	Configure tx queue limit
 		Set maximal number of pending writes
 		per opened session.
 
-What:		/sys/class/mei/meiN/fw_ver
+What:		/sys/class/mei/mei<N>/fw_ver
 Date:		May 2018
 KernelVersion:	4.18
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -66,7 +66,7 @@ Description:	Display the ME firmware version.
 		There can be up to three such blocks for different
 		FW components.
 
-What:		/sys/class/mei/meiN/dev_state
+What:		/sys/class/mei/mei<N>/dev_state
 Date:		Mar 2019
 KernelVersion:	5.1
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -81,7 +81,7 @@ Description:	Display the ME device state.
 		POWER_DOWN
 		POWER_UP
 
-What:		/sys/class/mei/meiN/trc
+What:		/sys/class/mei/mei<N>/trc
 Date:		Nov 2019
 KernelVersion:	5.5
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -91,7 +91,7 @@ Description:	Display trc status register content
 		status information into trc status register
 		for BIOS and OS to monitor fw health.
 
-What:		/sys/class/mei/meiN/kind
+What:		/sys/class/mei/mei<N>/kind
 Date:		Jul 2020
 KernelVersion:	5.8
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
-- 
2.31.1

