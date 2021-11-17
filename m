Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256DE45495A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhKQO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:58:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:61796 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhKQO6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:58:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="214677481"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="214677481"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 06:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="505050504"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 Nov 2021 06:55:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A4547554; Wed, 17 Nov 2021 16:55:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 0/2] serial: 8250_pci patches to address issues with pericom_do_set_divisor()
Date:   Wed, 17 Nov 2021 16:55:00 +0200
Message-Id: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A series patches to address three issues one customer managed to hit
all at once.

1) Fourth port not being setup correctly on some Pericom chips. Fix
the entries in pci_serial_quirks array.

2) Rewrite pericom_do_set_divisor() to always calc divisor and to use
the uartclk instead of a hard coded value. Always calculate divisor
without passing control to serial8250_do_set_divisor().

Jay, can you retest this, please?

Changelog v2:
- dropped no-fixes patch, left only fixes here
- amended refactoring of the ->set_divisor()
- fixed Fixes tags

Jay Dolan (2):
  serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
  serial: 8250_pci: rewrite pericom_do_set_divisor()

 drivers/tty/serial/8250/8250_pci.c | 39 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

-- 
2.33.0

