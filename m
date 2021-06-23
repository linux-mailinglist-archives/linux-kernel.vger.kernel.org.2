Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255B83B17A9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhFWKFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:05:25 -0400
Received: from www.zeus03.de ([194.117.254.33]:52132 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFWKFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=XPrfcgwTlWv7hKIBZVC49IllNoi
        E8aL74vnq4wCcUak=; b=IAR2rlHnHrFtxoEJWB9tU0vfRvb0+JviGXAqDZZ8u4d
        LPUOqn1y9eYdqb4zz4ilcLeof/O4FzunFsR0k7eIxD3boVHP2owM/7h1+TmOezwq
        /mNRxRPMtwPvKaVM3wCxuWcpRfkq0bpP9ecRvlUzSNWsM11oCVaWv5rJksZXouJo
        =
Received: (qmail 2553713 invoked from network); 23 Jun 2021 12:03:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jun 2021 12:03:05 +0200
X-UD-Smtp-Session: l3s3148p1@5f44A2zFIqogARa4RfhaAavnjlTTqzSz
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] usb: renesas_usbhs: fifo: : use proper DMAENGINE API for termination
Date:   Wed, 23 Jun 2021 12:03:04 +0200
Message-Id: <20210623100304.3697-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmaengine_terminate_all() is deprecated in favor of explicitly saying if
it should be sync or async. Here, we want dmaengine_terminate_sync()
because there is no other synchronization code in the driver to handle
an async case.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Shimoda-san, can you please double check if this works with the
additional locking in this function? Thank you!

 drivers/usb/renesas_usbhs/fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index b5e7991dc7d9..6176f2325f03 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -121,7 +121,7 @@ struct usbhs_pkt *usbhs_pkt_pop(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt)
 		if (fifo)
 			chan = usbhsf_dma_chan_get(fifo, pkt);
 		if (chan) {
-			dmaengine_terminate_all(chan);
+			dmaengine_terminate_sync(chan);
 			usbhsf_dma_unmap(pkt);
 		}
 
-- 
2.30.2

