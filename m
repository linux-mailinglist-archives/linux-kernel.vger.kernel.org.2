Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F45454966
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhKQPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:01:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:60145 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhKQPA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:00:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="257726565"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="257726565"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 06:58:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="506951242"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2021 06:57:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 23D18554; Wed, 17 Nov 2021 16:58:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
Date:   Wed, 17 Nov 2021 16:57:48 +0200
Message-Id: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split Pericom driver to a separate module.
While at it, re-enable high baud rates.

Jay, can you, please, test this on as many hardware as you have?

The series depends on the fix-series: https://lore.kernel.org/linux-serial/20211117145502.43645-1-andriy.shevchenko@linux.intel.com/T/#u

Andy Shevchenko (1):
  serial: 8250_pci: Split out Pericom driver

Jay Dolan (1):
  serial: 8250_pericom: Re-enable higher baud rates

 drivers/tty/serial/8250/8250_pci.c     | 405 +------------------------
 drivers/tty/serial/8250/8250_pericom.c | 217 +++++++++++++
 drivers/tty/serial/8250/Kconfig        |   8 +
 drivers/tty/serial/8250/Makefile       |   1 +
 4 files changed, 231 insertions(+), 400 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pericom.c

-- 
2.33.0

