Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD83A1BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFIRXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:23:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:59862 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhFIRXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:23:41 -0400
IronPort-SDR: N88xRHU9ld/4lfnie5o8jflewYg3SsYjITxxbkdY06Bf5x8FB2oQPOZC0WlciGuzQznpWKsjLp
 CQeCkK3qL31g==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192230146"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192230146"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:21:46 -0700
IronPort-SDR: Er/IXdl5TxmffXNO7G1Tf/lT9M+JflXYpEisQVYctTf2MieXLpd8tgVqUTFB8ktGKh27PLaDz+
 ZZepVoItG6sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="419354068"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2021 10:21:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3CF3E7; Wed,  9 Jun 2021 20:22:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] usb: typec: wcove: Use LE to CPU conversion when accessing msg->header
Date:   Wed,  9 Jun 2021 20:22:02 +0300
Message-Id: <20210609172202.83377-1-andriy.shevchenko@linux.intel.com>
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
Fixes: 3c4fb9f16921 ("usb: typec: wcove: start using tcpm for USB PD support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added Rb tag (Heikki), amend Fixes tags (Greg)
 drivers/usb/typec/tcpm/wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 8072e222eb99..20917d85d6f4 100644
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

