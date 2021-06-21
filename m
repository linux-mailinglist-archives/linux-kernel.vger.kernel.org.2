Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC73AE73E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFUKkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:40:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:19756 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUKkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:40:16 -0400
IronPort-SDR: /x0XUXdtXMdcSu63aD7ZMFmhueVPM1Q/5hgfRDdvlL5961p69G3OZw6QGijX67l1Vc7JQPF+Gg
 q0sPLKwAdu0g==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="187192984"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208,223";a="187192984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 03:38:02 -0700
IronPort-SDR: sy5gDF9Gq5G92YANc7zNj+jUlB3Edt4JFFqBdQFsjpaoFCvuk9Hyv1liJZ7AvXfyiSc2RT7TVC
 xsiz7CaxDKVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208,223";a="556202435"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Jun 2021 03:37:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Jun 2021 13:37:59 +0300
Date:   Mon, 21 Jun 2021 13:37:59 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNBsB6zIo4A4vD4w@kuha.fi.intel.com>
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
 <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net>
 <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net>
 <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="td8fQmGGYj1nswxy"
Content-Disposition: inline
In-Reply-To: <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--td8fQmGGYj1nswxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2021 at 01:00:06PM +0300, Andy Shevchenko wrote:
> Can you, please, attach this to the bug report?
> 
> Long story here is that the device creation fails but we already have added
> swnode to it. Meanwhile, device itself is not completely instantiated (yet)
> and dev_name(dev) is NULL. The software_node_notify() is called with such
> device and Oopses in the following line
> 
> 	sysfs_remove_link(&swnode->kobj, dev_name(dev));
> 
> My patch fixes another issue that might happen before this and in the code
> that retrieves swnode itself in the device_remove_software_node().
> 
> Of course my patch won't fix this issue.
> 
> I have heard that Heikki is looking how to fix the issue in your case and
> potentially in any other cases where device_add_software_node() is called
> against not formed object instance.

Dominik, can you test the attached patch to confirm if this really is
the case.

thanks,

-- 
heikki

--td8fQmGGYj1nswxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-software-node-Handle-software-node-injection-to-an-e.patch"

From 0cddd29f5d5d41d1b7fa38b0f927f4e755a1bcd0 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Mon, 21 Jun 2021 13:31:51 +0300
Subject: [PATCH] software node: Handle software node injection to an existing
 device properly

Interim, work-in-progress.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 3cc11b813f28c..33c8f31dbab4f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1045,7 +1045,15 @@ int device_add_software_node(struct device *dev, const struct software_node *nod
 	}
 
 	set_secondary_fwnode(dev, &swnode->fwnode);
-	software_node_notify(dev, KOBJ_ADD);
+
+	/*
+	 * In some special cases the software node has to be injected to an
+	 * already existing device. In these cases software_node_node() has to
+	 * be called separate from here. Using the device name here to check was
+	 * the device already added or not.
+	 */
+	if (dev_name(dev))
+		software_node_notify(dev, KOBJ_ADD);
 
 	return 0;
 }
@@ -1065,7 +1073,8 @@ void device_remove_software_node(struct device *dev)
 	if (!swnode)
 		return;
 
-	software_node_notify(dev, KOBJ_REMOVE);
+	if (dev_name(dev))
+		software_node_notify(dev, KOBJ_REMOVE);
 	set_secondary_fwnode(dev, NULL);
 	kobject_put(&swnode->kobj);
 }
@@ -1119,8 +1128,7 @@ int software_node_notify(struct device *dev, unsigned long action)
 
 	switch (action) {
 	case KOBJ_ADD:
-		ret = sysfs_create_link_nowarn(&dev->kobj, &swnode->kobj,
-					       "software_node");
+		ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
 		if (ret)
 			break;
 
-- 
2.30.2


--td8fQmGGYj1nswxy--
