Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED83F4798
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhHWJd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:33:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:59059 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhHWJdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="280788710"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="280788710"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="535272874"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2021 02:32:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF7ECD1; Mon, 23 Aug 2021 12:32:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [RFT, PATCH v2 0/2] platform/x86: hp_accel: Clean up and convert
Date:   Mon, 23 Aug 2021 12:32:20 +0300
Message-Id: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pure ACPI drivers are not needed since we have a platform glue layer in
place. This allow to drop a lot of boiler plate code and duplication.

Patch 1 remove confusing call to _INI method and citing myself from v1:
  "Not sure what buys us to run _INI on PM calls. It's against the spec
   AFAICT. In any case ACPICA runs _INI as per specification when devices are
   instantiated."

Patch 2 converts to platform driver.

Both needs to be tested, that's why Hans mentioned Kai-Heng.

Changelog v2:
- split to two patches (Hans)
- Cc'ed to Kai-Heng (Hans)
- removed stale data structure field in the header file

Andy Shevchenko (2):
  platform/x86: hp_accel: Remove _INI method call
  platform/x86: hp_accel: Convert to be a platform driver

 drivers/misc/lis3lv02d/lis3lv02d.h |  1 -
 drivers/platform/x86/hp_accel.c    | 78 ++++++------------------------
 2 files changed, 15 insertions(+), 64 deletions(-)

-- 
2.32.0

