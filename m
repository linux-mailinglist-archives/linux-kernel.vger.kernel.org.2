Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C124230B404
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhBBAUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:20:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:27803 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBAUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:20:11 -0500
IronPort-SDR: EfTBTZZSfc5TXItJUyEJ7IIWzyoBjPyFd4lVzNwoh6Xkso0YNXPSRRh7ad5hRRJY8qg+/99ClA
 SLCEs57OzAUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="178213566"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="178213566"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:19:28 -0800
IronPort-SDR: 0el/ZUFk2oKZckT92Xih4Vw1AKkdg8qJ1n/L+8UYAMOCSKxgvGMphrbZkj4Mw7Cf38P0W1qH62
 VGks2eAzFX6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="432589261"
Received: from unknown (HELO coxu-arch-shz.sh.intel.com) ([10.239.160.26])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2021 16:19:26 -0800
From:   Colin Xu <colin.xu@intel.com>
To:     kraxel@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, colin.xu@intel.com
Subject: [PATCH V2] virtio_input: Prevent EV_MSC/MSC_TIMESTAMP loop storm for MT.
Date:   Tue,  2 Feb 2021 08:19:23 +0800
Message-Id: <20210202001923.6227-1-colin.xu@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'commit 29cc309d8bf1 ("HID: hid-multitouch: forward MSC_TIMESTAMP")',
EV_MSC/MSC_TIMESTAMP is added to each before EV_SYN event. EV_MSC is
configured as INPUT_PASS_TO_ALL.
In case of a touch device which report MSC_TIMESTAMP:
  BE pass EV_MSC/MSC_TIMESTAMP to FE on receiving event from evdev.
  FE pass EV_MSC/MSC_TIMESTAMP back to BE.
  BE writes EV_MSC/MSC_TIMESTAMP to evdev due to INPUT_PASS_TO_ALL.
  BE receives extra EV_MSC/MSC_TIMESTAMP and pass to FE.
>>> Each new frame becomes larger and larger.

Disable EV_MSC/MSC_TIMESTAMP forwarding for MT.

V2: Rebase.

Signed-off-by: Colin Xu <colin.xu@intel.com>
---
 drivers/virtio/virtio_input.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index f1f6208edcf5..244965c20d9b 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -64,6 +64,21 @@ static int virtinput_send_status(struct virtio_input *vi,
 	unsigned long flags;
 	int rc;
 
+	/*
+	 * Since 29cc309d8bf1 (HID: hid-multitouch: forward MSC_TIMESTAMP),
+	 * EV_MSC/MSC_TIMESTAMP is added to each before EV_SYN event.
+	 * EV_MSC is configured as INPUT_PASS_TO_ALL.
+	 * In case of touch device:
+	 *   BE pass EV_MSC/MSC_TIMESTAMP to FE on receiving event from evdev.
+	 *   FE pass EV_MSC/MSC_TIMESTAMP back to BE.
+	 *   BE writes EV_MSC/MSC_TIMESTAMP to evdev due to INPUT_PASS_TO_ALL.
+	 *   BE receives extra EV_MSC/MSC_TIMESTAMP and pass to FE.
+	 *   >>> Each new frame becomes larger and larger.
+	 * Disable EV_MSC/MSC_TIMESTAMP forwarding for MT.
+	 */
+	if (vi->idev->mt && type == EV_MSC && code == MSC_TIMESTAMP)
+		return 0;
+
 	stsbuf = kzalloc(sizeof(*stsbuf), GFP_ATOMIC);
 	if (!stsbuf)
 		return -ENOMEM;
-- 
2.30.0

