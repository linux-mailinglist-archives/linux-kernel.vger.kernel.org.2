Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9861137FE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEMTec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhEMTe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:34:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E0F161408;
        Thu, 13 May 2021 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620934396;
        bh=HmOeK1hNNFR134NlruI1h+LOfJJnvZEyFJJQ8JsA/Xo=;
        h=Date:From:To:Cc:Subject:From;
        b=KsljFerXmta0Fh9boGxGKLWZmdE4+ETQ7UZDgjS4wEKc0pZMsC97GZp3CZ/Hs1ORK
         MfGk3j5ZPmblGxHu5IIbuCHc6+/SoXVNXHCTY4TRFp3kIVXBYNLqs5DjmojZ1ZNBf2
         QIn+5B0Rc8ZxIA3/s05vwy/xtBnYzkK76rcOaW4fRxaSJrppTLQmtfE0h6MUZiedYH
         0gJrsQkuTUnbWfdmSvE9ZslgehYQqmZKRwpLn+UVFmPMwHICaDPOrrs6gAzjzHPmii
         v2iVD2mr6orGX3DLw7q38Vtc/j3NvMqOIrp5gyHBQR/URIdtlD3SHHnMfvCr5Nn/B7
         t9ac13qzUntjg==
Date:   Thu, 13 May 2021 14:33:53 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: gadget: s3c-hsudc: Use struct_size() in
 devm_kzalloc()
Message-ID: <20210513193353.GA196565@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows
that, in the worse scenario, could lead to heap overflows.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/gadget/udc/s3c-hsudc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 7bd5182ce3ef..89f1f8c9f02e 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -1220,9 +1220,8 @@ static int s3c_hsudc_probe(struct platform_device *pdev)
 	struct s3c24xx_hsudc_platdata *pd = dev_get_platdata(&pdev->dev);
 	int ret, i;
 
-	hsudc = devm_kzalloc(&pdev->dev, sizeof(struct s3c_hsudc) +
-			sizeof(struct s3c_hsudc_ep) * pd->epnum,
-			GFP_KERNEL);
+	hsudc = devm_kzalloc(&pdev->dev, struct_size(hsudc, ep, pd->epnum),
+			     GFP_KERNEL);
 	if (!hsudc)
 		return -ENOMEM;
 
-- 
2.27.0

