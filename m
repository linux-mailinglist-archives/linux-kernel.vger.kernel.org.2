Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CD543B495
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhJZOqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:46:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:13756 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236885AbhJZOpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:45:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253467432"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="253467432"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 07:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="635200303"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2021 07:33:52 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] USB Power Delivery character device interface
Date:   Tue, 26 Oct 2021 17:33:48 +0300
Message-Id: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the proposal for USB PD character devices that we could use to
communicate USB PD messages directly with the USB PD capable partners,
ports and cable plugs from user space. Originally I proposed this idea
here as a better way to get the PDOs from the partners (and ports and
plugs): https://lkml.org/lkml/2021/10/8/331

Initially you could read the PDOs with this, but it of course is not
only limited to PDOs - any messages should potentetially be suported.

This is in any case really just a draft, and most likely does not work
if you try it, but it should give an idea about what I'm proposing
(hopefully).

In this proposal I'm placing each device that you can have
behind a single USB PD capable Type-C port (so port, partner
and plugs) under its own folder, so you would end up with
something like this if also both plugs are supported:

	/dev/pd0/port
	/dev/pd0/plug0
	/dev/pd0/plug1
	/dev/pd0/partner

I'm also including an ugly test tool that you can try out to dump the
PDOs depending on the role of the device - tools/usb/pd-test.c. This
is what I got from a charger (and the port at the same time):

	% pd-test /dev/pd0/port
	Sink Capabilities:
	  PDO1: 0x3601912c
	  PDO2: 0x000640e1
	  PDO3: 0x9901912c

	% pd-test /dev/pd0/partner
	Source Capabilities:
	  PDO1: 0x0801912c
	  PDO2: 0x0003c12c

But please note that this whole series is really just meant to be PoC!
Don't assume it will work!

The core code that adds the character devices is here:

	drivers/usb/typec/pd-dev.c.

It's actually really simple, and I don't think it would ever need to
be much more complicated than that.

Example driver support I added to UCSI:

	drivers/usb/typec/ucsi/pd-dev.c

thanks,

Heikki Krogerus (4):
  usb: pd: uapi header split
  usb: typec: Character device for USB Power Delivery devices
  usb: typec: ucsi: Add support for PD cdev
  tools: usb: Hideous test tool for USB PD char device

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/usb/typec/Makefile                    |   2 +-
 drivers/usb/typec/class.c                     |  42 ++
 drivers/usb/typec/class.h                     |   4 +
 drivers/usb/typec/pd-dev.c                    | 210 ++++++++
 drivers/usb/typec/pd-dev.h                    |  15 +
 drivers/usb/typec/ucsi/Makefile               |   2 +-
 drivers/usb/typec/ucsi/pd-dev.c               | 125 +++++
 drivers/usb/typec/ucsi/ucsi.c                 |  37 +-
 drivers/usb/typec/ucsi/ucsi.h                 |   7 +
 include/linux/usb/pd.h                        | 487 +----------------
 include/linux/usb/pd_dev.h                    |  22 +
 include/linux/usb/typec.h                     |   8 +
 include/uapi/linux/usb/pd.h                   | 496 ++++++++++++++++++
 include/uapi/linux/usb/pd_dev.h               |  55 ++
 tools/usb/Build                               |   1 +
 tools/usb/Makefile                            |   8 +-
 tools/usb/pd-test.c                           | 123 +++++
 18 files changed, 1147 insertions(+), 498 deletions(-)
 create mode 100644 drivers/usb/typec/pd-dev.c
 create mode 100644 drivers/usb/typec/pd-dev.h
 create mode 100644 drivers/usb/typec/ucsi/pd-dev.c
 create mode 100644 include/linux/usb/pd_dev.h
 create mode 100644 include/uapi/linux/usb/pd.h
 create mode 100644 include/uapi/linux/usb/pd_dev.h
 create mode 100644 tools/usb/pd-test.c

-- 
2.33.0

