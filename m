Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28245E29F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhKYVlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:41:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:25831 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235737AbhKYVjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:39:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216279362"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="216279362"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="554728833"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Nov 2021 13:32:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EE31F9F; Thu, 25 Nov 2021 23:32:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 00/10] misc: at25: Code cleanups and improvements
Date:   Thu, 25 Nov 2021 23:31:53 +0200
Message-Id: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code cleanups and improvements. Please read individual commit messages.

Series depends on the fixes series [1] sent earlier.

[1]: https://lore.kernel.org/lkml/20211125212729.86585-2-andriy.shevchenko@linux.intel.com/T/#u

Andy Shevchenko (10):
  misc: at25: Use at25->chip instead of local chip everywhere in
    ->probe()
  misc: at25: Unshadow error codes in at25_fw_to_chip()
  misc: at25: Check new property ("address-width") first
  misc: at25: Get platform data via dev_get_platdata()
  misc: at25: Get rid of intermediate storage for AT25 chip data
  misc: at25: Switch to use BIT() instead of custom approaches
  misc: at25: Factor out at_fram_to_chip()
  misc: at25: Reorganize headers for better maintenance
  misc: at25: Replace commas by spaces in the ID tables
  misc: at25: Align comment style

 drivers/misc/eeprom/at25.c | 210 +++++++++++++++++++------------------
 1 file changed, 110 insertions(+), 100 deletions(-)

-- 
2.33.0

