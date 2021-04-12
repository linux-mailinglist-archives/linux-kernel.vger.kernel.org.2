Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0BB35C2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbhDLJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238880AbhDLJjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37BCF61249;
        Mon, 12 Apr 2021 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220314;
        bh=t9qOhZ9FiANoiUN/D2w9FYQpykHnyvkO6VLNd1kcNIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQl7zFERbr4YPhig/YkCw5KTqMJtSP0h1rInTvaAR84TTkMLUukYVaItTHyOMoZeK
         hk9vXcxyU4LC3HaMYxadVi9I/PXIaEdMlvjttyDVddiFGPnEbnAL5ZmESVOf0CFI//
         YHNn3mpSMjbJ5E10sRoPZME7IW0BnbqSSDUYdkcLCbHGw3O/6qPCUnRSyJ4XN9Ahtm
         RLZRYhlFAUAla+YYwJJALqgNlccOglrZAkNwQnDCSjWsf7whzSBq7CjOKe5t7FHYQm
         8MJNIkdblGc/+XJvw31HFEt40XMMziLlYmRZgiobLe0pdYsf2WedGAC+4CFV54KgPU
         QUDnrVtgfxXdQ==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVt1Y-0000Ck-E3; Mon, 12 Apr 2021 11:38:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] USB: serial: io_ti: document reason for drain delay
Date:   Mon, 12 Apr 2021 11:38:13 +0200
Message-Id: <20210412093815.736-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412093815.736-1-johan@kernel.org>
References: <20210412093815.736-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document that the device line-status register doesn't tell when the
transmitter shift register has emptied and that this is why the
one-character drain delay is needed.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_ti.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index 75325c2b295e..17720670e06c 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2590,6 +2590,10 @@ static int edge_port_probe(struct usb_serial_port *port)
 	if (ret)
 		goto err;
 
+	/*
+	 * The LSR does not tell when the transmitter shift register has
+	 * emptied so add a one-character drain delay.
+	 */
 	port->port.drain_delay = 1;
 
 	return 0;
-- 
2.26.3

