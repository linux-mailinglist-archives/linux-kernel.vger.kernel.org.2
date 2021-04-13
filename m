Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4635E0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbhDMOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:06:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:37931 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237475AbhDMOGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:06:18 -0400
IronPort-SDR: 5hGLPxg0ULmLlKlZFHXDaVod2LvboQtB44VXw0e8VuKgZDq1zXfb3P00kDMWTGMEhTKQTZxDI2
 ynjXqkFwLgpw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="174519350"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208,223";a="174519350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 07:05:58 -0700
IronPort-SDR: N+KLgbEaZusAYcnSRnNcuKaMQLVZZC5/EZi0G40w4tBopFJl4wQPdrd0zrjapa/iR3qDM4GbIC
 TlJf1h/o/utw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208,223";a="521609415"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Apr 2021 07:05:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 13 Apr 2021 17:05:54 +0300
Date:   Tue, 13 Apr 2021 17:05:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Handle device properties with software node
 API
Message-ID: <YHWlQooPtrTjyq+i@kuha.fi.intel.com>
References: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
 <786795eb-6832-fd7d-4674-65be394c083d@linux.intel.com>
 <YFm0u9k/DNy5URsR@kuha.fi.intel.com>
 <39e2ab87-3b70-8659-6282-5b03d30f901b@linux.intel.com>
 <YHWMmR5gBvlpd7rl@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fBYxI++DDE8HNukO"
Content-Disposition: inline
In-Reply-To: <YHWMmR5gBvlpd7rl@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fBYxI++DDE8HNukO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2021 at 03:20:45PM +0300, Heikki Krogerus wrote:
> On Mon, Apr 12, 2021 at 03:36:20PM -0500, Pierre-Louis Bossart wrote:
> > I took the code and split it in two for BYT/CHT (modified to remove devm_)
> > and SoundWire parts (added as is).
> > 
> > https://github.com/thesofproject/linux/pull/2810
> > 
> > Both cases result in a refcount error on device_remove_sof when removing the
> > platform device. I don't understand the code well enough to figure out what
> > happens, but it's likely a case of the software node being removed twice?
> 
> Right. Because you are injecting the node to an already existing
> device, the node does not get linked with the device in sysfs. That
> would increment the reference count in a normal case. It all happens
> in the function software_node_notify(). Driver core calls it when a
> device is added and also when it's removed. In this case it is only
> called when it's removed.
> 
> I think the best way to handle this now is to simply not decrementing
> the ref count when you add the properties, so don't call
> fwnode_handle_put() there (but add a comment explaining why you are
> not calling it).

No, sorry... That's just too hacky. Let's not do that after all.

We can also fix this in the software node code. I'm attaching a patch
that should make it possible to inject the software nodes also
afterwards safely. This is definitely also not without its problems,
but we can go with that if it works. Let me know.


> For a better solution you would call device_reprobe() after you have
> injected the software node, but before that you need to modify
> device_reprobe() so it calls device_platform_notify() (which it really
> should call in any case). But this should probable be done later,
> separately.
> 
> thanks,
> 
> P.S.
> 
> Have you guys considered the possibility of describing the connections
> between all these components by using one of the methods that we now
> have for that in kernel, for example device graph? It can now be
> used also with software nodes (OF graph and ACPI device graph are of
> course already fully supported).

Br,

-- 
heikki

--fBYxI++DDE8HNukO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-software-node-Allow-node-addition-to-already-existin.patch"

From 3d3dca1f80941f8975390bc8f488176d00acef22 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Tue, 13 Apr 2021 16:28:34 +0300
Subject: [PATCH] software node: Allow node addition to already existing device

If the node is added to an already exiting device, the node
needs to be also linked to the device separately.

This will make sure the reference count is kept in balance
also when the node is injected to a device afterwards.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Fixes: e68d0119e328 ("software node: Introduce device_add_software_node()")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index fa3719ef80e4d..88310ac9ce906 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1032,6 +1032,7 @@ int device_add_software_node(struct device *dev, const struct software_node *nod
 	}
 
 	set_secondary_fwnode(dev, &swnode->fwnode);
+	software_node_notify(dev, KOBJ_ADD);
 
 	return 0;
 }
@@ -1105,8 +1106,8 @@ int software_node_notify(struct device *dev, unsigned long action)
 
 	switch (action) {
 	case KOBJ_ADD:
-		ret = sysfs_create_link(&dev->kobj, &swnode->kobj,
-					"software_node");
+		ret = sysfs_create_link_nowarn(&dev->kobj, &swnode->kobj,
+					       "software_node");
 		if (ret)
 			break;
 
-- 
2.30.2


--fBYxI++DDE8HNukO--
