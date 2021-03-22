Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB733449E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCVPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhCVPxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:53:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E539A619B4;
        Mon, 22 Mar 2021 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616428395;
        bh=s3XS9YGp3yirmpuzyX0/v+esTxrw11dcDwqSBc2f1fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f770zkeQAXn33pPTlotkaYXR4dq3UoNrBGol822TLNfm6QcyN3KeZKONRU7Gf6kML
         sA9nY0EeqoqtVyOIG5sSbPtbTo9om/rkF9aYBd8KsWXnQE9/N4UHWtCu55SjdpGghz
         4PmhFn+OBk0WB3C+g24C4eJJCUX53B39QCXKL94Crdi1/jTGmwnkuVwDcL4UvnJtU2
         zrsGjz6dLMepMmv+Rtdj3m61m5/a3M/KcAsCeif7rLLa9+H1PgyaXc5J7ArKN812Mr
         JuiDuHZUXI5jxWdp5LbPZKWR88NlJmmRgLXB4KVnARtrCDutZRUY5RwEGuHV6Oc3BT
         9SERgoBbUuylg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOMs1-0002Zt-7f; Mon, 22 Mar 2021 16:53:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 8/8] USB: cdc-acm: do not log successful probe on later errors
Date:   Mon, 22 Mar 2021 16:53:18 +0100
Message-Id: <20210322155318.9837-9-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210322155318.9837-1-johan@kernel.org>
References: <20210322155318.9837-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not log the successful-probe message until the tty device has been
registered.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 914486d0f68c..337ffced9c40 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1473,8 +1473,6 @@ static int acm_probe(struct usb_interface *intf,
 	acm->nb_index = 0;
 	acm->nb_size = 0;
 
-	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
-
 	acm->line.dwDTERate = cpu_to_le32(9600);
 	acm->line.bDataBits = 8;
 	acm_set_line(acm, &acm->line);
@@ -1497,6 +1495,8 @@ static int acm_probe(struct usb_interface *intf,
 		usb_clear_halt(usb_dev, acm->out);
 	}
 
+	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
+
 	return 0;
 
 err_release_data_interface:
-- 
2.26.3

