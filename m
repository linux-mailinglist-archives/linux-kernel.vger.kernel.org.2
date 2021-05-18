Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497B738741C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347504AbhERIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:31:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:41124 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241148AbhERIbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:31:47 -0400
IronPort-SDR: Jezs7nX4c05NYIV7KFAj1YZ5I+of5IHHTKVIzZc9QezbkyfxShY3L9hCRHr6gkWzWZTcFwDOTV
 DCW9/1sH3uWQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221708571"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="221708571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 01:30:27 -0700
IronPort-SDR: zt2sBgdsOqQ116KehSNknN6qL5ZcC4U6p3iyBksb6jqXsFmZI4QRvjvAwyZyTqsPpk3b9yE/cZ
 Lh/FXD8Kp9Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="541658111"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2021 01:30:25 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] driver core: platform: Remove platform_device_add_properties()
Date:   Tue, 18 May 2021 11:30:44 +0300
Message-Id: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like there is only one place left that still uses the
function. Converting that last user and removing the thing.

Note, I'm actually resending the patch for board-paz00.c. I'm assuming
the original patch slipped through the cracks because it did not end
up anywhere.

I would imagine that it's OK to everybody if Greg takes these?

thanks,

Heikki Krogerus (2):
  ARM: tegra: paz00: Handle device properties with software node API
  driver core: platform: Remove platform_device_add_properties()

 arch/arm/mach-tegra/board-paz00.c |  2 +-
 drivers/base/platform.c           | 20 ++------------------
 include/linux/platform_device.h   |  2 --
 3 files changed, 3 insertions(+), 21 deletions(-)

-- 
2.30.2

