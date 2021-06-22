Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FDE3B06F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFVONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:13:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:51989 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231417AbhFVONE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:13:04 -0400
IronPort-SDR: 3q/6M4fNKHHgqNl1IfPUGh5dWbUjsPRa7d8Eu8uJzeWOytHuAkgK15ttFcG4z9qIKN61RVTZLX
 PMg88P67Xxlw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="207101845"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208,223";a="207101845"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 07:10:47 -0700
IronPort-SDR: XwMrvo22xFp8Tq/kpWM74fIWz1w5k/BkLWfidv+tyiAQyf0J0vaim1urcIr/1BdOEsxB5s2u2M
 6Et0IGdTQVlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208,223";a="556628734"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 22 Jun 2021 07:10:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 22 Jun 2021 17:10:44 +0300
Date:   Tue, 22 Jun 2021 17:10:44 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNHvZGLE9lgS/FRe@kuha.fi.intel.com>
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
 <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net>
 <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net>
 <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
 <YNBsB6zIo4A4vD4w@kuha.fi.intel.com>
 <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
 <YNGa021IIj+C8H7h@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3SPjdNkkrV0/DJ7d"
Content-Disposition: inline
In-Reply-To: <YNGa021IIj+C8H7h@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3SPjdNkkrV0/DJ7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 22, 2021 at 11:09:58AM +0300, Heikki Krogerus wrote:
> On Mon, Jun 21, 2021 at 05:31:50PM +0200, Dominik Brodowski wrote:
> > Am Mon, Jun 21, 2021 at 01:37:59PM +0300 schrieb Heikki Krogerus:
> > > On Mon, Jun 21, 2021 at 01:00:06PM +0300, Andy Shevchenko wrote:
> > > > Can you, please, attach this to the bug report?
> > > > 
> > > > Long story here is that the device creation fails but we already have added
> > > > swnode to it. Meanwhile, device itself is not completely instantiated (yet)
> > > > and dev_name(dev) is NULL. The software_node_notify() is called with such
> > > > device and Oopses in the following line
> > > > 
> > > > 	sysfs_remove_link(&swnode->kobj, dev_name(dev));
> > > > 
> > > > My patch fixes another issue that might happen before this and in the code
> > > > that retrieves swnode itself in the device_remove_software_node().
> > > > 
> > > > Of course my patch won't fix this issue.
> > > > 
> > > > I have heard that Heikki is looking how to fix the issue in your case and
> > > > potentially in any other cases where device_add_software_node() is called
> > > > against not formed object instance.
> > > 
> > > Dominik, can you test the attached patch to confirm if this really is
> > > the case.
> > 
> > With this patch applied, the panic disappears.
> 
> Thanks Dominik. I'll clean it and send it out today.

Before I send the patch to Rafael and Greg, can you confirm that the
appropriate API (device_is_registered()) also works? I'm attaching
patch that should be the final version (if it works).

I'm sorry to bother you with this.

thanks,

-- 
heikki

--3SPjdNkkrV0/DJ7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-software-node-Handle-software-node-injection-to-an-e.patch"

From 9dcfc8e6bae658288fa6f112efc18246285f0f27 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Mon, 21 Jun 2021 13:31:51 +0300
Subject: [PATCH] software node: Handle software node injection to an existing
 device properly

The function software_node_notify(), which creates and
removes the symlinks between the software node and the
device, must be called conditionally. In normal case
software_node_notify() is called automatically when the
device that the software node is assigned to is registered,
and only in the special cases where the software node has to
be added to an already existing device it needs to be called
separately.

This fixes NULL pointer dereference that happenes if
device_remove_software_node() is called with device that
was never registered.

Fixes: b622b24519f5 ("software node: Allow node addition to already existing device")
Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 3cc11b813f28c..042eef31b182a 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1045,7 +1045,16 @@ int device_add_software_node(struct device *dev, const struct software_node *nod
 	}
 
 	set_secondary_fwnode(dev, &swnode->fwnode);
-	software_node_notify(dev, KOBJ_ADD);
+
+	/*
+	 * Software nodes are also allowed to be added to already existing
+	 * devices. If the device has been fully registered by the time this
+	 * function is called, software_node_notify() must be called separately
+	 * so that the symlinks get created and the reference count of the node
+	 * is kept in balance.
+	 */
+	if (device_is_registered(dev))
+		software_node_notify(dev, KOBJ_ADD);
 
 	return 0;
 }
@@ -1065,7 +1074,8 @@ void device_remove_software_node(struct device *dev)
 	if (!swnode)
 		return;
 
-	software_node_notify(dev, KOBJ_REMOVE);
+	if (device_is_registered(dev))
+		software_node_notify(dev, KOBJ_REMOVE);
 	set_secondary_fwnode(dev, NULL);
 	kobject_put(&swnode->kobj);
 }
-- 
2.30.2


--3SPjdNkkrV0/DJ7d--
