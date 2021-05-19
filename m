Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABC3889F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbhESI4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:56:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:36698 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343679AbhESI43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:56:29 -0400
IronPort-SDR: vK5WTufI+iNy5WFWtxRpid1AjcN6j4EoLJY6XOWu1S/N2QS+f/V6moHHhiyB0attKFYzV+yh+D
 AbNkgb16LPog==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200621690"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="200621690"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 01:55:10 -0700
IronPort-SDR: kToaMcwcqCE3xxLHQCvC1Z8F+SFsUdEP5XPo122DyWBTJl8efChBC9pxZDKmM6dSvfjZ5t+zaK
 fDYtoP9rc4Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="433411092"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2021 01:55:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB31A12F; Wed, 19 May 2021 11:55:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: typec: wcove: Fx wrong kernel doc format
Date:   Wed, 19 May 2021 11:55:27 +0300
Message-Id: <20210519085527.48657-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top comment in the file wrongly uses kernel doc format:

.../typec/tcpm/wcove.c:17: warning: expecting prototype for typec_wcove.c - WhiskeyCove PMIC USB Type(). Prototype was for WCOVE_CHGRIRQ0() instead

Fix this by converting it to plain comment.

Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/tcpm/wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 5d125339687a..20917d85d6f4 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * typec_wcove.c - WhiskeyCove PMIC USB Type-C PHY driver
  *
  * Copyright (C) 2017 Intel Corporation
-- 
2.30.2

