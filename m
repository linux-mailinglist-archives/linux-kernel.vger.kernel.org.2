Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1ED3F8768
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbhHZM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:27:48 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:40008
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234321AbhHZM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:27:47 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 010C03F051;
        Thu, 26 Aug 2021 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629980819;
        bh=qTmiDvDlAU0GlgPB8TPRAtXI2em1asDn/cxSyM9O4IU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=A1MP1K/EdSgaASXjb148/FmL/TS/0CQpFlx6DOWQzvQCdMI7omSXfToziyl7vffsH
         8qY4FLDuoQUZFT6ve4Q7Bz19wjMu/rhcdLsGYX91CvVJGRgsqzChfCD3NZ8+NNIvAw
         CJd+eJ/NvZs1bcFt+Lsggb5s2y5d7sY2gunYYG+c9xa0qYD8VTWTK76kFFqBQP4c5V
         StIqLhbkiEZEcZM6x2Nx+b1nYwvxNbHZrtDC/F8JkfjwAlFfb9nTmur9K/ThoAXx8Y
         PWrhvPOQHZ64k85kv8802E/Jkgbijsz/+WteizQbOPIIl6ar6F1k66cK+P+bqLdVLi
         dP3cJfOmQoTKw==
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: renesas_usbhs: Fix spelling mistake "faile" -> "failed"
Date:   Thu, 26 Aug 2021 13:26:58 +0100
Message-Id: <20210826122658.13914-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/renesas_usbhs/fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index a3c2b01ccf7b..10607e273879 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -366,7 +366,7 @@ static int usbhs_dcp_dir_switch_to_write(struct usbhs_pkt *pkt, int *is_done)
 
 	ret = usbhsf_fifo_select(pipe, fifo, 1);
 	if (ret < 0) {
-		dev_err(dev, "%s() faile\n", __func__);
+		dev_err(dev, "%s() failed\n", __func__);
 		return ret;
 	}
 
-- 
2.32.0

