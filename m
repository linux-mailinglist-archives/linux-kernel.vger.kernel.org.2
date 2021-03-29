Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1934CC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhC2JEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:04:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:14117 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235223AbhC2IoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:44:19 -0400
IronPort-SDR: A01djvKZGoG5mTpB1rHUh3IQVFfSB1JZ4ciXBbacrcSDsAeAyjpwkObdbjGqM3bTF+4Z//VbFN
 JZSJcNOkqmPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="252854816"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="252854816"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 01:44:15 -0700
IronPort-SDR: 9EtB6AHAXNFroLhREiM3x+bOlL+UhscSTSUkSM6yvDAtVkKuwf//ytCKOEWdq2kYPHI/1tYgER
 +r0dMA99DcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="515918659"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2021 01:44:12 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] usb: Linking ports to their Type-C connectors
Date:   Mon, 29 Mar 2021 11:44:20 +0300
Message-Id: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second version of this series. The "Iterator for ports"
patch is now moved to the end of the series (5/6).

I'm now using usb_for_each_dev() in usb_for_each_port like Alan
suggested, and I'm now using usb_port_peer_mutex to lock the ports
while we're dealing with them in __each_hub().


The original cover letter:

Adding a simple function typec_link_port() that can be used to create
a symlink "connector" that points to the USB Type-C connector of a
port. It is used with USB ports initially, but hopefully later also
with other things like DisplayPorts.

Being able to see which connector is connected to a port is important
in general, but it is really important when for example the data or
power role of a device needs to swapped. The user probable wants to
know which USB device is disconnected if role swap on a USB Type-C
connector is executed.

Hope these are OK.

thanks,

Heikki Krogerus (6):
  usb: typec: Organize the private headers properly
  usb: typec: Declare the typec_class static
  usb: typec: Port mapping utility
  usb: Link the ports to the connectors they are attached to
  usb: Iterator for ports
  usb: typec: Link all ports during connector registration

 Documentation/ABI/testing/sysfs-bus-usb |   9 +
 drivers/usb/core/port.c                 |   3 +
 drivers/usb/core/usb.c                  |  46 ++++
 drivers/usb/typec/Makefile              |   2 +-
 drivers/usb/typec/bus.c                 |   2 +
 drivers/usb/typec/bus.h                 |  19 +-
 drivers/usb/typec/class.c               | 101 +++------
 drivers/usb/typec/class.h               |  85 +++++++
 drivers/usb/typec/mux.c                 |   4 +-
 drivers/usb/typec/mux.h                 |  21 ++
 drivers/usb/typec/port-mapper.c         | 280 ++++++++++++++++++++++++
 include/linux/usb.h                     |   1 +
 include/linux/usb/typec.h               |  13 ++
 13 files changed, 490 insertions(+), 96 deletions(-)
 create mode 100644 drivers/usb/typec/class.h
 create mode 100644 drivers/usb/typec/mux.h
 create mode 100644 drivers/usb/typec/port-mapper.c

-- 
2.30.2

