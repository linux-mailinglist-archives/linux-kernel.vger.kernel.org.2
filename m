Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01454355BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhDFSpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 14:45:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43379 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbhDFSpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:45:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lTqhL-0008Js-3L; Tue, 06 Apr 2021 18:45:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>,
        Paul Mundt <lethal@linux-sh.org>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: r8a66597: Add missing null check on return from platform_get_resource
Date:   Tue,  6 Apr 2021 19:45:10 +0100
Message-Id: <20210406184510.433497-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to platform_get_resource can potentially return a NULL pointer
on failure, so add this check and return -EINVAL if it fails.

Addresses-Coverity: ("Dereference null return")
Fixes: c41442474a26 ("usb: gadget: R8A66597 peripheral controller support.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index 896c1a016d55..65cae4883454 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1849,6 +1849,8 @@ static int r8a66597_probe(struct platform_device *pdev)
 		return PTR_ERR(reg);
 
 	ires = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!ires)
+		return -EINVAL;
 	irq = ires->start;
 	irq_trigger = ires->flags & IRQF_TRIGGER_MASK;
 
-- 
2.30.2

