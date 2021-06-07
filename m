Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B439DD6E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFGNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:17614 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhFGNQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:22 -0400
IronPort-SDR: mk52y3lIzpqqsuxivELXE7AesZGZ2IzfASfzT17nQpkAfDQH7ATeBeQbORLXrgZk3EJ5NgesMY
 ht2d/ES7jGSA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265774000"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265774000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 06:14:30 -0700
IronPort-SDR: G7vQsWiA/NyYqrg2pxgdz/zVX2MYeCaZWAhQdACyfC0c62EV/Y7wao2mn4wX2QZbkaSc/g7moF
 9FkRONsaikdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551881931"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 06:14:29 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] usb: typec: ucsi: Filter out spurious events
Date:   Mon,  7 Jun 2021 16:14:41 +0300
Message-Id: <20210607131442.20121-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignoring events without changes.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a4123f77d1f16..ce80a433ef9db 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -839,6 +839,11 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		goto out_ack;
 	}
 
+	if (!status.change) {
+		dev_dbg(con->ucsi->dev, "con%d: spurious event\n", con->num);
+		goto out_ack;
+	}
+
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
 		goto out_ack;
-- 
2.30.2

