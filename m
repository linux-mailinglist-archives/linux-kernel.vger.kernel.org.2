Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A036D7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhD1NFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:05:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:64175 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239723AbhD1NE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:04:58 -0400
IronPort-SDR: FFqRqqDgZTjV4xQ5T+gHQ/5pl0xN/nyeVMsVIvlqycKZ8QxwKi6ssklBm4Ef38Yi7krLyZru66
 IeMf6AfkhpDw==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="282071694"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="282071694"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 06:04:06 -0700
IronPort-SDR: NOx7yMHWmUOBBhSfjgXFCr4RtpmHQL/jCo43+MfUW2KfSPQEA9VmwK+iDeH2chmIpaDhrVoIb6
 3vmQtcQ450aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="386509052"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2021 06:04:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E1AE752A; Wed, 28 Apr 2021 16:04:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 4/4] staging: fbtft: Update TODO
Date:   Wed, 28 Apr 2021 16:04:15 +0300
Message-Id: <20210428130415.55406-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210428130415.55406-1-andriy.shevchenko@linux.intel.com>
References: <20210428130415.55406-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, after a few fixes we may consider the conversion to
the GPIO descriptor API is done.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/TODO | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/fbtft/TODO b/drivers/staging/fbtft/TODO
index a9f4802bb6be..e72a08bf221c 100644
--- a/drivers/staging/fbtft/TODO
+++ b/drivers/staging/fbtft/TODO
@@ -1,8 +1,3 @@
-* convert all uses of the old GPIO API from <linux/gpio.h> to the
-  GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
-  lines from device tree, ACPI or board files, board files should
-  use <linux/gpio/machine.h>
-
 * convert all these over to drm_simple_display_pipe and submit for inclusion
   into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any new
   drivers anymore.
-- 
2.30.2

