Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AF135DE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbhDMMVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:21:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:33073 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhDMMVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:21:04 -0400
IronPort-SDR: qTWGQHDbT0MJjB7eYo4rY/nPbaaWwU/OwTS11eb7F50GZAZvGf6w4hqqBUPnXhWAvTCD7w/bsd
 ccUe4NLVTpaw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="173891937"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="173891937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 05:20:45 -0700
IronPort-SDR: Z7bA1j7jkyVDLB8y+D1HMUEnWYRwrRWxYQ3a2xSzv5qVl/Ztlwvao5G5bfXwrTg2vzcO7KnNHD
 /GOjmhdXbBWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="521581070"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Apr 2021 05:20:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 13 Apr 2021 15:20:41 +0300
Date:   Tue, 13 Apr 2021 15:20:41 +0300
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
Message-ID: <YHWMmR5gBvlpd7rl@kuha.fi.intel.com>
References: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
 <786795eb-6832-fd7d-4674-65be394c083d@linux.intel.com>
 <YFm0u9k/DNy5URsR@kuha.fi.intel.com>
 <39e2ab87-3b70-8659-6282-5b03d30f901b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e2ab87-3b70-8659-6282-5b03d30f901b@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 03:36:20PM -0500, Pierre-Louis Bossart wrote:
> I took the code and split it in two for BYT/CHT (modified to remove devm_)
> and SoundWire parts (added as is).
> 
> https://github.com/thesofproject/linux/pull/2810
> 
> Both cases result in a refcount error on device_remove_sof when removing the
> platform device. I don't understand the code well enough to figure out what
> happens, but it's likely a case of the software node being removed twice?

Right. Because you are injecting the node to an already existing
device, the node does not get linked with the device in sysfs. That
would increment the reference count in a normal case. It all happens
in the function software_node_notify(). Driver core calls it when a
device is added and also when it's removed. In this case it is only
called when it's removed.

I think the best way to handle this now is to simply not decrementing
the ref count when you add the properties, so don't call
fwnode_handle_put() there (but add a comment explaining why you are
not calling it).

For a better solution you would call device_reprobe() after you have
injected the software node, but before that you need to modify
device_reprobe() so it calls device_platform_notify() (which it really
should call in any case). But this should probable be done later,
separately.

thanks,

P.S.

Have you guys considered the possibility of describing the connections
between all these components by using one of the methods that we now
have for that in kernel, for example device graph? It can now be
used also with software nodes (OF graph and ACPI device graph are of
course already fully supported).

-- 
heikki
