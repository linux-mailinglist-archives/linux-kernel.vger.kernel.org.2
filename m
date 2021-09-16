Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812FF40D53D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhIPJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233839AbhIPJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F16B861164;
        Thu, 16 Sep 2021 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=SqZchVqZxkW6t0zHPuYku3hO4ezMbv0eEJe0nexpu94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDldzzMujLRsTxLsX7x6Bm5XrDfob99F/57kkQVOyB4o+PvMJRU7O/UgPeONnGQd/
         3hrCbYSlJuJiyk1Er+JQReYPrhS/8Orl7M8n2k05Py1pOxLUdfMdm11nub9jpKQ35E
         W3inI59JrUh+QKanlug8WsaIDSpVuV9Mwe6C1PHBO0DHsxtQdyTGB347FdYvlP4tib
         /RoW8hJu3tORpFhLRKx1oKz9yqj/ey152R3upB12ndXz3VNUIRk7vuYslTKqzOwxSx
         aJWFgGOkvWq06vig5Z1pKmDaWofEgkNBwUdFq++Jz9Xbf5USvn+k1ax3P2GQ5D3Xpz
         ddRHIoDuTy10g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFQ-001qjW-7Z; Thu, 16 Sep 2021 11:00:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/30] ABI: sysfs-bus-usb: better document variable argument
Date:   Thu, 16 Sep 2021 10:59:28 +0200
Message-Id: <2f7e4e874677dbd82693a6b219decefa18802e8f.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On almost all ABI documents, variable arguments are declared
as <foo_bar>. Change it here too, in order to allow replacing
such wildcards by regexes on a scriptable way.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Rajat Jain <rajatja@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-usb | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 73eb23bc1f34..42103f0f54d6 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -166,14 +166,14 @@ Description:
 		The file will be present for all speeds of USB devices, and will
 		always read "no" for USB 1.1 and USB 2.0 devices.
 
-What:		/sys/bus/usb/devices/.../(hub interface)/portX
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>
 Date:		August 2012
 Contact:	Lan Tianyu <tianyu.lan@intel.com>
 Description:
-		The /sys/bus/usb/devices/.../(hub interface)/portX
+		The /sys/bus/usb/devices/.../<hub_interface>/port<X>
 		is usb port device's sysfs directory.
 
-What:		/sys/bus/usb/devices/.../(hub interface)/portX/connect_type
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/connect_type
 Date:		January 2013
 Contact:	Lan Tianyu <tianyu.lan@intel.com>
 Description:
@@ -182,7 +182,7 @@ Description:
 		The file will read "hotplug", "hardwired" and "not used" if the
 		information is available, and "unknown" otherwise.
 
-What:		/sys/bus/usb/devices/.../(hub interface)/portX/location
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/location
 Date:		October 2018
 Contact:	Bjørn Mork <bjorn@mork.no>
 Description:
@@ -192,7 +192,7 @@ Description:
 		raw location value as a hex integer.
 
 
-What:		/sys/bus/usb/devices/.../(hub interface)/portX/quirks
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/quirks
 Date:		May 2018
 Contact:	Nicolas Boichat <drinkcat@chromium.org>
 Description:
@@ -216,7 +216,7 @@ Description:
 		   used to help make enumeration work better on some high speed
 		   devices.
 
-What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/over_current_count
 Date:		February 2018
 Contact:	Richard Leitner <richard.leitner@skidata.com>
 Description:
@@ -230,10 +230,10 @@ Description:
 		Any time this value changes the corresponding hub device will send a
 		udev event with the following attributes::
 
-		  OVER_CURRENT_PORT=/sys/bus/usb/devices/.../(hub interface)/portX
+		  OVER_CURRENT_PORT=/sys/bus/usb/devices/.../<hub_interface>/port<X>
 		  OVER_CURRENT_COUNT=[current value of this sysfs attribute]
 
-What:		/sys/bus/usb/devices/.../(hub interface)/portX/usb3_lpm_permit
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/usb3_lpm_permit
 Date:		November 2015
 Contact:	Lu Baolu <baolu.lu@linux.intel.com>
 Description:
-- 
2.31.1

