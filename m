Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06E94147D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhIVLc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235617AbhIVLcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C863F61131;
        Wed, 22 Sep 2021 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632310282;
        bh=uZXNMNASKFddL6r7ZZODAI5KQi/OlxqrQ03zxMQP4ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tzji9CyP6hhE3WXyLfSfWOaxTETZhGNv2VcX3UwuTHYDCC9L6I27/nyGSXNLAG1RA
         ugjQQa2B6v4f9fsB7VlCYh/MOaMwfBZhU+x3PxPNzR56LGUeN8G2oLaMAi9oj37Q5m
         pHUP2xA1o7XMkw/TrwoSL7WhFVp/L5dqwW048BHOoHhymvfxhkn7aloSjcrPpELj1v
         SvqX9vUxmlLwbABRWXt91LRJekjC7sARU6YtRclx8D4atHqjXZkqiT0tC30rEOT/Cs
         P11PprnjxRhcFZ6roj8qlCYNr1LXeHoPFz5qi2Ri+Mjk0wmhBhEmOboiIC3gOu/QuA
         PnoV46fVmTOtw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mT0TC-0005Rz-RE; Wed, 22 Sep 2021 13:31:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Malte Di Donato <malte@neo-soft.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] USB: serial: cp210x: add part-number debug printk
Date:   Wed, 22 Sep 2021 13:31:00 +0200
Message-Id: <20210922113100.20888-2-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210922113100.20888-1-johan@kernel.org>
References: <YUsTYFOdMH/kQEyE@hovoldconsulting.com>
 <20210922113100.20888-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a part-number debug printk to facilitate debugging.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index b98454fe08ea..fd51498ab108 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -2140,6 +2140,8 @@ static void cp210x_determine_type(struct usb_serial *serial)
 		return;
 	}
 
+	dev_dbg(&serial->interface->dev, "partnum = 0x%02x\n", priv->partnum);
+
 	switch (priv->partnum) {
 	case CP210X_PARTNUM_CP2102:
 		cp2102_determine_quirks(serial);
-- 
2.32.0

