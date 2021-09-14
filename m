Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3120340B0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhINOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233818AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94A8D610F9;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=khkHTFCZzv02jdfwC6Of0Q3JW1xSILP59tRzCOX4+jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPnovU0i/22fJNRWU6egvINNHoCIYFERn48tFFSYguh72SVSVMPGJUeMipmt7Roon
         45qbmJQWMiXLCrtQIb3ms+yMojQ62lmFO0Rqss5eFrCeZFi4ADIIabqMcd+lyK1caN
         miZ6MTqpFMwCIsUrYPgeBvzEly4p0Ec2cKQYePv2ylSgy7KXM2ecLZHBZNDUoML7tG
         VaNFeOTN2KJqcrCGZdG0KPZoNSbNNwHyJJ2ZXXbQSRPp1112kdwty2XDKeI7h+PsTd
         BNgHivlqG2UO8YfD4FdmWgetfNYx8jOIuWJqvk4Agko8NyRB6K7Ow4R0+gJOVCe1l1
         zu/9rQlVwzfcA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000KkG-Ai; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/29] ABI: sysfs-bus-usb: better document variable argument
Date:   Tue, 14 Sep 2021 16:32:16 +0200
Message-Id: <cf40784dd4169897f7a28cc4d9393e8eaae5b873.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
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

