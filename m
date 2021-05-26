Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B05391C23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhEZPhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:37:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:51469 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235296AbhEZPhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:37:03 -0400
IronPort-SDR: vaE8ZH5GmMUAtI4q27qMm+UWSoGuEEvzviHQsWMedUualxolKROwe3sPEbSfQeJu2qlXKlzBFd
 QusG+TuGhaoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202529825"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="202529825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 08:35:31 -0700
IronPort-SDR: KMQ/U1VUnap67JZlgyALdvRU736CADvj4LQ4nREOf6IfOIOINY1JLn/vtRrD9kfeTlgoid2QEn
 x8EkCumttniQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="547236505"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2021 08:35:30 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: mux: Remove requirement for the "orientation-switch" device property
Date:   Wed, 26 May 2021 18:35:48 +0300
Message-Id: <20210526153548.61276-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The additional boolean device property "orientation-switch"
is not needed when the connection is described with device
graph, so removing the check and the requirement for it.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index e40a555724fb6..603f3e698cc0b 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -30,9 +30,6 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
 {
 	struct device *dev;
 
-	if (id && !fwnode_property_present(fwnode, id))
-		return NULL;
-
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				switch_fwnode_match);
 
-- 
2.30.2

