Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D466D3D5A08
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhGZM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232240AbhGZM0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:26:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E69460F37;
        Mon, 26 Jul 2021 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627304842;
        bh=G9j9y/zf+hVoRoj9wYD/rhzh4hnVhF96K10Ra/6XWiM=;
        h=From:To:Cc:Subject:Date:From;
        b=KGKbi5EAnucz1X5d0zWoou6APh+vgPc1QzdXF7Si4l+CW9TJsyprtJiNnoj5R9Ovx
         31Rd9VLFYHFMY9eIk17Tzq7UVuPwpcWmiVaA+DobMbEOv6+Mk/nmZJ+lVMvCJER/H1
         HXLiMuSR1U27hka15xJLyiu+9wF/o5v7Eib+Fuqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jordy Zomer <jordy@pwning.systems>
Subject: [PATCH] serial: 8250_pci: make setup_port() parameters explicitly unsigned
Date:   Mon, 26 Jul 2021 15:07:17 +0200
Message-Id: <20210726130717.2052096-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; h=from:subject; bh=G9j9y/zf+hVoRoj9wYD/rhzh4hnVhF96K10Ra/6XWiM=; b=owGbwMvMwCRo6H6F97bub03G02pJDAn/Njeqe316US4zs1uv5rGIpM2Zlet+9QZcSdS8f1VCYfe2 L+dcOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiK1czzA+xL2tf+aT98bJMxwl+x6 b2RnbX2TDMzzg279L1gPrtNXH3lSdo104/GPXiBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bar and offset parameters to setup_port() are used in pointer math,
and while it would be very difficult to get them to wrap as a negative
number, just be "safe" and make them unsigned so that static checkers do
not trip over them unintentionally.

Cc: Jiri Slaby <jirislaby@kernel.org>
Reported-by: Jordy Zomer <jordy@pwning.systems>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 75827b608fdb..fe64f77a9789 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -87,7 +87,7 @@ static void moan_device(const char *str, struct pci_dev *dev)
 
 static int
 setup_port(struct serial_private *priv, struct uart_8250_port *port,
-	   int bar, int offset, int regshift)
+	   u8 bar, unsigned int offset, int regshift)
 {
 	struct pci_dev *dev = priv->dev;
 
-- 
2.32.0

