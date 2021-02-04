Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B85630F4CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhBDOUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:20:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:58183 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236541AbhBDOTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:19:02 -0500
IronPort-SDR: PUVi+kWwbLf8HR+Hc6Myvybs0HEN4MXQhS5GWOp4yyyeHYDsJL6Eh7/ouq40LM3ObOjul9+UFJ
 7UeFOl3OA/ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160410013"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="160410013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 06:17:13 -0800
IronPort-SDR: la72V9P5+yXesPGNQ4AS6+gToQhZG77ubAEPui2BDRK7SUU/C9EpsSu8KuMSQfNEcwC+km1h3V
 aBxDwjRQoVSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="483254604"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2021 06:17:11 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 0/6] usb: Handle device properties with software node API
Date:   Thu,  4 Feb 2021 17:17:05 +0300
Message-Id: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've now rewritten the commit message of the first patch introducing
the new function device_create_managed_software_node(). It should now
explanation why we need that function in more detail. I think
that is what Rafael wanted. Also, everything should now compile.


v1 cover letter:

Currently it is not possible to take full advantage of software
fwnodes in the drivers because device_del() is calling
device_remove_properties() (that removes the software node attached to
the device) unconditionally which prevents the software nodes from
being reused or shared, and because subsystems are dealing with device
properties instead of software nodes which in many cases prevents the
drivers from using software nodes at all.

To fix the situation, the device_remove_properties() call in
device_del() has to be removed, and later the subsystems need to be
converted so that they deal with software nodes instead of just device
properties. But before that can be done, the drivers must be prepared
for those changes. These patches do that for the USB drivers.

The first patch introduces device_create_managed_software_node()
function that can be used as a drop-in replacement for
device_add_properties(). The rest of the patches simply use that
function, or convert the drivers in some other way to use software
nodes instead of just the device properties in them.

thanks,

Heikki Krogerus (6):
  software node: Provide replacement for device_add_properties()
  usb: dwc2: pci: Drop the empty quirk function
  usb: dwc3: haps: Constify the software node
  usb: dwc3: qcom: Constify the software node
  usb: dwc3: host: Use software node API with the properties
  xhci: ext-caps: Use software node API with the properties

 drivers/base/swnode.c            | 43 ++++++++++++++++++++++++++++++++
 drivers/usb/dwc2/pci.c           | 18 -------------
 drivers/usb/dwc3/dwc3-haps.c     |  8 +++++-
 drivers/usb/dwc3/dwc3-qcom.c     | 12 ++++++---
 drivers/usb/dwc3/host.c          |  2 +-
 drivers/usb/host/xhci-ext-caps.c |  3 ++-
 include/linux/property.h         |  4 +++
 7 files changed, 66 insertions(+), 24 deletions(-)

-- 
2.30.0

