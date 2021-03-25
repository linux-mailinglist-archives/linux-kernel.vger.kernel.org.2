Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8073491F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhCYM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:29:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:31183 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhCYM3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:29:15 -0400
IronPort-SDR: qEKyoLQF4hmYBIJbzIK688Xna97Vdmmig7z3KrxErBim9s/d4RcavhhHYhtHL/Dmkrl4gFgH49
 ZTG+aHGmrKKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170895468"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170895468"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 05:29:14 -0700
IronPort-SDR: e33qbh8QHajFNMSwD+bDkSzV/Gg+xqfWHcjUY4UtyimbrQPGTXdM2m/vTDM3k946wgGx28qUDk
 tiRS/B9Ybf9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="514623120"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2021 05:29:12 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] usb: Linking ports to their Type-C connectors
Date:   Thu, 25 Mar 2021 15:29:20 +0300
Message-Id: <20210325122926.58392-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
  usb: Iterator for ports
  usb: typec: Organize the private headers properly
  usb: typec: Declare the typec_class static
  usb: typec: Port mapping utility
  usb: Link the ports to the connectors they are attached to
  usb: typec: Link all ports during connector registration

 Documentation/ABI/testing/sysfs-bus-usb |   9 +
 drivers/usb/core/port.c                 |   3 +
 drivers/usb/core/usb.c                  |  43 ++++
 drivers/usb/typec/Makefile              |   1 +
 drivers/usb/typec/bus.c                 |   2 +
 drivers/usb/typec/bus.h                 |  19 +-
 drivers/usb/typec/class.c               | 101 +++------
 drivers/usb/typec/class.h               |  94 ++++++++
 drivers/usb/typec/mux.c                 |   4 +-
 drivers/usb/typec/mux.h                 |  21 ++
 drivers/usb/typec/port-mapper.c         | 283 ++++++++++++++++++++++++
 include/linux/usb.h                     |   1 +
 include/linux/usb/typec.h               |  13 ++
 13 files changed, 499 insertions(+), 95 deletions(-)
 create mode 100644 drivers/usb/typec/class.h
 create mode 100644 drivers/usb/typec/mux.h
 create mode 100644 drivers/usb/typec/port-mapper.c

-- 
2.30.2

