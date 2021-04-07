Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F08356493
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349233AbhDGGzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:55:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:62003 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhDGGzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:55:50 -0400
IronPort-SDR: 2ZqEAkFGtaxh35VJs+07rKoZsVV6+T0FEaw558QRncadnC+fvLFQG07RBlYnvCZCeF7RCkfIOf
 Yn7fRSkxu9sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180372030"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="180372030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 23:55:41 -0700
IronPort-SDR: KOWsaMNHIVxtlXZLDWqEImsiHAR9OAkPzHYWuYNtuLV1/Rj0I2nDcErpuATp6R/CgY3Hinl8I1
 QKMqGg9aRj4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="519326269"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2021 23:55:39 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] usb: Linking ports to their Type-C connectors
Date:   Wed,  7 Apr 2021 09:55:51 +0300
Message-Id: <20210407065555.88110-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are the remaining four patches of the series, now rebased on top
of the latest usb-next. No other changes.


v5 cover letter:

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

Heikki Krogerus (4):
  usb: typec: Port mapping utility
  usb: Link the ports to the connectors they are attached to
  usb: Iterator for ports
  usb: typec: Link all ports during connector registration

 Documentation/ABI/testing/sysfs-bus-usb |   9 +
 drivers/usb/core/port.c                 |   3 +
 drivers/usb/core/usb.c                  |  46 ++++
 drivers/usb/typec/Makefile              |   2 +-
 drivers/usb/typec/class.c               |  12 +-
 drivers/usb/typec/class.h               |   9 +
 drivers/usb/typec/port-mapper.c         | 277 ++++++++++++++++++++++++
 include/linux/usb.h                     |   9 +
 include/linux/usb/typec.h               |  13 ++
 9 files changed, 377 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/typec/port-mapper.c

-- 
2.30.2

