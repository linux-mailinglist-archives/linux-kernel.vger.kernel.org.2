Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297F43BA170
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhGBNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232718AbhGBNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:45:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E3626142B;
        Fri,  2 Jul 2021 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625233376;
        bh=YE/LCnkMIv6fwH7bk4ME2EQ7qcy5Vj5/29RRN5K4+ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jb1l3cakLEMvw7JpHXk4ANbsjYL2PcNp+wG6HalxrKxauY5FEJh7faOMGSA+UHerK
         iN2y96J6BxeiuKatGhCcvcq/3MaXALcE/qwRWzpITOMkBWArgFIU+cEmeOmh1v8Qt3
         aOGItxamv2ZdI6+4OtMHFqwEgOoMT7bXrwsy1pUN+nO3Zj2IBaYc+X9/CFV5ecYvfn
         dk0BqGXCRBEbaHmhQ1+K/wpz88bJzorMlUDcRV3M0rDpObxSkWEsZ36DcQug09dDtO
         A/u31QN7mQDjRscgUN9GLRoZgUqncNDnrWVBesLKDah648/mvpMZdXqfV8F3ZDjfzg
         ZpGydTmHTJi+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lzJRT-0006Q7-5j; Fri, 02 Jul 2021 15:42:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] USB: serial: cp210x: clean up control-request timeout
Date:   Fri,  2 Jul 2021 15:42:24 +0200
Message-Id: <20210702134227.24621-4-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210702134227.24621-1-johan@kernel.org>
References: <20210702134227.24621-1-johan@kernel.org>
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
index eb3be4f65603..c7cea86c659c 100644
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

