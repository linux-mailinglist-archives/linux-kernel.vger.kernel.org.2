Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E83BB8F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhGEIXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhGEIXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E009B6141C;
        Mon,  5 Jul 2021 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625473240;
        bh=s65G1mh9EOwBbfyl45BNCxFhJTfkQYqTSqxwr7Uqpio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTlgWc39cXODirNmd2mHbb849K4kdnGt/MQwDXdQnqpbWhBnQMU+9YrN7r+FMfoX0
         /luC4Nivp/vuALhOVKLFsykd49TzeoCGRLIsgX48ZSSy9/kSd/iO7qTRpuMQCF3Qqu
         4FWXhdU3H5ZJaKtc7krezSJTV1x+o3fieyGNdDlLs5zuzNKHfhr9hRCX/x2061WLpV
         QIigUbTXEtuyupx17OECDVmljEUlCsRq2wn5TZJhYY8C0UiqWeOjsSCm92qVFL2JNe
         VpOq7cXkJ2BHFU5QGn0N06FkBO8d6PoedvFhg45R5q5Qm+GmQAuVOcNKdkFvP2q185
         2/ngEGROpL9Lw==
Received: from johan by xi with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m0JqF-0004lu-9r; Mon, 05 Jul 2021 10:20:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] USB: serial: cp210x: clean up control-request timeout
Date:   Mon,  5 Jul 2021 10:20:12 +0200
Message-Id: <20210705082015.18286-4-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210705082015.18286-1-johan@kernel.org>
References: <20210705082015.18286-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency use the USB_CTRL_GET_TIMEOUT define for the
read-register request timeout (same value as USB_CTRL_SET_TIMEOUT).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fd6bd574e2a5..e560608afb1e 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -637,7 +637,7 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
 	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
 			req, REQTYPE_INTERFACE_TO_HOST, 0,
 			port_priv->bInterfaceNumber, dmabuf, bufsize,
-			USB_CTRL_SET_TIMEOUT);
+			USB_CTRL_GET_TIMEOUT);
 	if (result == bufsize) {
 		memcpy(buf, dmabuf, bufsize);
 		result = 0;
-- 
2.31.1

