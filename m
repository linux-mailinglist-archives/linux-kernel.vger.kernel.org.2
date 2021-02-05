Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146343111A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhBESQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:16:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:26074 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233212AbhBESL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:11:29 -0500
IronPort-SDR: tT1MC1H4TfNOpGsnZfGktKhJeCQSiQWW1J0W+wFMteTb8FSvOUFeh2nr+wVmTvOJtef9LgzD4h
 H51jPIf6T7pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200493376"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="200493376"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 11:52:05 -0800
IronPort-SDR: jOCpeYgTO7bJQxT/6j7bHS0YKuKW5VnLDgIMTW2dvbiqhqv0toy4zNDg/JdBmx2lkwKTy660lG
 Grh45VidIVrQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="434580881"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 05 Feb 2021 11:52:05 -0800
From:   Rajmohan Mani <rajmohan.mani@intel.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH 1/2] platform/chrome: cros_ec_typec: Skip port partner check in configure_mux()
Date:   Fri,  5 Feb 2021 11:51:12 -0800
Message-Id: <20210205195113.20277-2-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210205195113.20277-1-rajmohan.mani@intel.com>
References: <20210205195113.20277-1-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain needs like updating the USB4 retimer firmware when no
device are connected, the Type-C ports require mux configuration,
to be able to communicate with the retimer. So removed the above
check to allow for mux configuration of Type-C ports, to enable
retimer communication.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index e724a5eaef1c..3d8ff3f8a514 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -536,9 +536,6 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	enum typec_orientation orientation;
 	int ret;
 
-	if (!port->partner)
-		return 0;
-
 	if (mux_flags & USB_PD_MUX_POLARITY_INVERTED)
 		orientation = TYPEC_ORIENTATION_REVERSE;
 	else
-- 
2.30.0

