Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125FB3EF261
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhHQTCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:02:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:18728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhHQTCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:02:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203324516"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="203324516"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 12:01:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="488147322"
Received: from aaadelek-mobl3.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.12.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 12:01:28 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/2] driver core: kick deferred probe from delayed context
Date:   Tue, 17 Aug 2021 14:00:55 -0500
Message-Id: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deferred probe mechanism uses a successful driver probe/attach as
a trigger to revisit the list of deferred probe devices. This works in
most cases, except when the probe success is not a valid indicator of
resources being available.

In that case, a race condition may occur, where the device/driver core
framework will attempt to probe a device that depends on resources
before those resources are available, resulting in a -EPROBE_DEFER
error and a deferred probe device that will never be initialized.

The example provided in this RFC relies on the probe workqueue used
for the HDaudio support where we simultaneously:
a) need to use request_module()
b) cannot use an async probe due to the use of request_module()
c) cannot block the probe of other drivers
In this example, the deferred probe can be kicked when the workqueue
completes.

The use of request_firmware_nowait() is another conceptual example,
where a domain-specific callback can enable resources *after* the
probe returns, for example by downloading the firmware, booting a
processor and waiting for the processor to be ready for interaction
with the Linux host. In this second example, the deferred probe could
be kicked when the 'cont' callback completes.

This patchset suggests a 7-line change to solve race conditions in
these examples with delayed work.

Discussion:

a) During Intel internal reviews, Andy Shevchenko pointed out another
known issue with deferred probe [1]. This patchset is unrelated and
does not claim to solve the problem raised by Andy.

b) one possible objection is that this patchset does not suppress a
possibly unnecessary round of evaluation of deferred probe devices. It
did not feel necessary to any of us to minimize the occurrences of
EPROBE_DEFER but instead to make sure the device waiting for
resources successfully probes in the end.

c) another objection might be that the driver core should know about
such dependencies. It would be desirable but in the cases we've
encountered such dependencies are highly domain-specific and not
necessarily straightforward to describe. There's been multiple
endeavors to improve the description of dependencies, this patchset
only focuses on the deferred probe framework, with an improvement when
the provider of resources makes these resources available after its
probe returns.

[1] https://lore.kernel.org/lkml/20200324175719.62496-1-andriy.shevchenko@linux.intel.com/T/#u

Pierre-Louis Bossart (2):
  driver core: export driver_deferred_probe_trigger()
  ASoC: SOF: trigger re-probing of deferred devices from workqueue

 drivers/base/dd.c             | 3 ++-
 include/linux/device/driver.h | 1 +
 sound/soc/sof/core.c          | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)


base-commit: 8d1998893cd5e3488cd95529f60a187e3009d14b
-- 
2.25.1

