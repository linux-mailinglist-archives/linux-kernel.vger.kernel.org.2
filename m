Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A163EEAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhHQKZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:25:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:56026 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhHQKZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:25:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="195621129"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="195621129"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 03:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="593304560"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2021 03:24:48 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] driver core: platform: Remove platform_device_add_properties()
Date:   Tue, 17 Aug 2021 13:24:47 +0300
Message-Id: <20210817102449.39994-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems Rafael never took these. Let's try again.

The original cover letter:

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

