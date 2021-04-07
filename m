Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519DE356AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351760AbhDGLNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:13:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37627 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhDGLNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:13:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lU67J-0007qD-OW; Wed, 07 Apr 2021 11:13:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: drivers: Fix spelling mistake "nubmer" -> "number"
Date:   Wed,  7 Apr 2021 12:13:01 +0100
Message-Id: <20210407111301.486853-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a comment. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/comedi/drivers/addi_apci_16xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/addi_apci_16xx.c b/drivers/staging/comedi/drivers/addi_apci_16xx.c
index 9bbef3b15f3f..c306aa41df97 100644
--- a/drivers/staging/comedi/drivers/addi_apci_16xx.c
+++ b/drivers/staging/comedi/drivers/addi_apci_16xx.c
@@ -110,7 +110,7 @@ static int apci16xx_auto_attach(struct comedi_device *dev,
 	dev->iobase = pci_resource_start(pcidev, 0);
 
 	/*
-	 * Work out the nubmer of subdevices needed to support all the
+	 * Work out the number of subdevices needed to support all the
 	 * digital i/o channels on the board. Each subdevice supports
 	 * up to 32 channels.
 	 */
-- 
2.30.2

