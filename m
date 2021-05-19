Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEA3889F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbhESI4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:56:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:22692 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238728AbhESI4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:56:38 -0400
IronPort-SDR: hN7xVaLZ1onLVLFHOVnDPi13fRQ84mB675Q+/WxL28dZkglWVcBtoH8R7ItH1eyXa3cSOxdowd
 b1OpdXcTDNMA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188336043"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="188336043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 01:55:18 -0700
IronPort-SDR: v9/MsFE4cc7o27b+cWhtxhaTCe948D1EswZbDBokaesYNBtVsPM8TWHCk1Lla4Ojgi/25gjKpf
 o2hOHXxYayZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="474309943"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2021 01:55:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30BA612F; Wed, 19 May 2021 11:55:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] usb: typec: wcove: Use LE to CPU conversion when accessing msg->header
Date:   Wed, 19 May 2021 11:55:34 +0300
Message-Id: <20210519085534.48732-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As LKP noticed the Sparse is not happy about strict type handling:
   .../typec/tcpm/wcove.c:380:50: sparse:     expected unsigned short [usertype] header
   .../typec/tcpm/wcove.c:380:50: sparse:     got restricted __le16 const [usertype] header

Fix this by switching to use pd_header_cnt_le() instead of pd_header_cnt()
in the affected code.

Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/tcpm/wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 79ae63950050..5d125339687a 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -378,7 +378,7 @@ static int wcove_pd_transmit(struct tcpc_dev *tcpc,
 		const u8 *data = (void *)msg;
 		int i;
 
-		for (i = 0; i < pd_header_cnt(msg->header) * 4 + 2; i++) {
+		for (i = 0; i < pd_header_cnt_le(msg->header) * 4 + 2; i++) {
 			ret = regmap_write(wcove->regmap, USBC_TX_DATA + i,
 					   data[i]);
 			if (ret)
-- 
2.30.2

