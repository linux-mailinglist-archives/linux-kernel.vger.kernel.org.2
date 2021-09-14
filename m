Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFF40B102
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhINOhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233867AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C54E461222;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=Gte8UaRM2J4G1pHxecj1ex46V96WgBtr85RhT9C+zxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DgGde/4J1dj4weyJpQuU70nPayYK3n5dpKpT1Sm/nLDc+FQp2PRzaLPmp553DDawH
         kH8vyyCXUzwjMEXKftB+iySxCZN0PdW03IpvK+Ll/MH+XwLEFwH0xyvhW91Kk4kDsi
         OYInDeaokJ+5AcY5giSWedceOGcMI1eXePt0GYOHHN8mQ7A78LVef/w/rrxxecKch/
         dmBYuDHmy9FpVbo4WutgcRQmxPMf7e8Qpws2Xennw8SMV4yvZ2HJ6Irkz3pxo+xKVm
         02AWpvroi2FOhQR/V2z/4rcKAbliXIkEW6Oan8+u51nLGXIBOnqktYblqmBAQpda2Q
         YF1ctulMnVpyA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000Klo-GF; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/29] ABI: sysfs-devices-platform-dock: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:40 +0200
Message-Id: <8bd1a4dda53291b1b22a12162c8673b6152175fb.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
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
 Documentation/ABI/testing/sysfs-devices-platform-dock | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-dock b/Documentation/ABI/testing/sysfs-devices-platform-dock
index 1d8c18f905c7..411c174de830 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-dock
+++ b/Documentation/ABI/testing/sysfs-devices-platform-dock
@@ -1,4 +1,4 @@
-What:		/sys/devices/platform/dock.N/docked
+What:		/sys/devices/platform/dock.<N>/docked
 Date:		Dec, 2006
 KernelVersion:	2.6.19
 Contact:	linux-acpi@vger.kernel.org
@@ -6,7 +6,7 @@ Description:
 		(RO) Value 1 or 0 indicates whether the software believes the
 		laptop is docked in a docking station.
 
-What:		/sys/devices/platform/dock.N/undock
+What:		/sys/devices/platform/dock.<N>/undock
 Date:		Dec, 2006
 KernelVersion:	2.6.19
 Contact:	linux-acpi@vger.kernel.org
@@ -14,14 +14,14 @@ Description:
 		(WO) Writing to this file causes the software to initiate an
 		undock request to the firmware.
 
-What:		/sys/devices/platform/dock.N/uid
+What:		/sys/devices/platform/dock.<N>/uid
 Date:		Feb, 2007
 KernelVersion:	v2.6.21
 Contact:	linux-acpi@vger.kernel.org
 Description:
 		(RO) Displays the docking station the laptop is docked to.
 
-What:		/sys/devices/platform/dock.N/flags
+What:		/sys/devices/platform/dock.<N>/flags
 Date:		May, 2007
 KernelVersion:	v2.6.21
 Contact:	linux-acpi@vger.kernel.org
@@ -30,7 +30,7 @@ Description:
 		request has been made by the user (from the immediate_undock
 		option).
 
-What:		/sys/devices/platform/dock.N/type
+What:		/sys/devices/platform/dock.<N>/type
 Date:		Aug, 2008
 KernelVersion:	v2.6.27
 Contact:	linux-acpi@vger.kernel.org
-- 
2.31.1

