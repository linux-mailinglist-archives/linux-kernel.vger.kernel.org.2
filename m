Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5D335140B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhDAK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:58:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:51275 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhDAK6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:58:35 -0400
IronPort-SDR: nWdfVZ1dwpEcXs4MPcdIRQoKc3xxpisTd0jbj7bJ+aJkPFLGEHEkE5hGV27roUT4ZP9ZW0PvJc
 T4pNltCqM9zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171637240"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="171637240"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 03:58:34 -0700
IronPort-SDR: KhfHZulw7zaFspF6z4VjJqREmGGfAFj/am1itRIhg8Ysw71s59yypLygw1Ozm2vq7ZtoMuo9Ez
 krHhM7oRhObw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517295758"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2021 03:58:32 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] usb: Linking ports to their Type-C connectors
Date:   Thu,  1 Apr 2021 13:58:41 +0300
Message-Id: <20210401105847.13026-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have to use IS_REACHABLE() instead of IS_ENABLED() also in
include/linux/usb.h. Otherwise compilation will fail if the Type-C
class is build-in while USB is a module.

I'm sorry for re-sending these so fast, immediately after v4. Normally
I would wait, but I'll be taking a short vacation starting from right
now, and I'm still hoping to get these into v5.13.


v4 cover letter:

One more version. I used #ifdef when I should have used #if
IS_DEFINED(). Thanks Guenter for pointing that out.

I'm sending this version right away because of the holidays. I'm not
changing anything else except that one fix.


v3: cover letter:

Third version: ifdefs now in the header files as they should be.


v2 cover letter:

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
 drivers/usb/typec/class.h               |  85 ++++++++
 drivers/usb/typec/mux.c                 |   4 +-
 drivers/usb/typec/mux.h                 |  21 ++
 drivers/usb/typec/port-mapper.c         | 277 ++++++++++++++++++++++++
 include/linux/usb.h                     |   9 +
 include/linux/usb/typec.h               |  13 ++
 13 files changed, 495 insertions(+), 96 deletions(-)
 create mode 100644 drivers/usb/typec/class.h
 create mode 100644 drivers/usb/typec/mux.h
 create mode 100644 drivers/usb/typec/port-mapper.c

-- 
2.30.2

