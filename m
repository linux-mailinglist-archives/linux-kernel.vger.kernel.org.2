Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAFB410646
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbhIRMMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:12:08 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58109 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236698AbhIRMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:47 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id D0DDD580AA0;
        Sat, 18 Sep 2021 08:10:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 18 Sep 2021 08:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=7EC26pNkFUOEe
        vhoWNPRSgdTWMwHLt1pj4bP1NJMakM=; b=hUUL3t3I/5uBIMQTuE6/4O+iR1Ohh
        YL5pc0Cd3FuYlOKtOw3lUH74YGsdbVjWGoT2P6fkRMaEktTTAkXPNmrhcj4ougWv
        +4WLL92wP2CQSWJa7u31TweCGu/oCvfP2xyCa+c+XZRUc/TQNs8m19lIkOyt3rAK
        0vM+coIA3CWN7lZnNmH+A66tdpxsn5fCFvfX/qd7000aR5h9qitzw9WjeajXfhGC
        iy+gXXepgirtwN93XJnuxAMTaa+nyWMBspuBGk+GpOT4xMtMt/0b4k0bisItauHZ
        VAM+cxHza0dC89y4E2762auiUKkueLJqdcckwF9qJtengRfxykn+OCtNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7EC26pNkFUOEevhoWNPRSgdTWMwHLt1pj4bP1NJMakM=; b=t2mzvL8p
        HAutOtz5LQ9GqO7OEfbhS1XoUeJP0nShmDqTK90lx7nuhSlWCs725rSsRt/1ScZ4
        pl9vB+Yok1Vn0BJ8WlDkcpI9UT0Y1HWN0dJGs0ucUnXUM0EGXIksX+sTlr42myn3
        33YiUA8VkShucnBVSV4urieugLdJhNPOJfQI67pBuf9YNq5G+9+PpMdl+ngWtmZg
        8De3mwo2wYdduHHkZ2Be9iySXnlYCezBHORJaEx0OQ6T1QlLrrLUTtK3ZU3X/Uyn
        2Fnn9Z5A9q2kspv2aax5FUf1OqeeqG/pSt5Z37i4NaOr6rjJ114tnPLJ4TnqpsZS
        y1ZPRlT216ngsA==
X-ME-Sender: <xms:HNdFYd1NAhLGlvSdwETeVOrD0l27KIuIDsnxWqyCoIfKIUsEi8SO_Q>
    <xme:HNdFYUHRoXIDgVm81Lp-4G8WWfCWcU_T8pTt9gvOA6mZ2iIL5CIwKGu4_PFbkzp40
    QedEbzVMEsG7i2c-u8>
X-ME-Received: <xmr:HNdFYd7WMm45G0UDMWzTlzFzrmtrER69g6JTqwhN5LBewFQ2gyq_IY9wAbMWVBpIZVL2E0cz8rq0nIBPGlOAnWcGg3AfTlRlQoAlWyn7pfi7FnZ44geuADyZisS0QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:HNdFYa1cPHYnaLKSlMyUDf_MSL6Bid7LYeburZs9orUtJ_qykBtwlA>
    <xmx:HNdFYQGotkTG41C-Gv6xq7GePQzFtOgVSb_2INW8zOX4X-LCxuJJHw>
    <xmx:HNdFYb8KiZxxTvLFu1lRjlAXJ-fOz0BfNioqI49_kUXUmFgdPQxqFg>
    <xmx:HNdFYT9LA45loUY1Za1NvMc2RUre9Xw6Y8IzPPjJZYqLRrcJjBvJpA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:10:02 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [RFT PATCH 6/9] usb: typec: tipd: Setup IntMask explicitly
Date:   Sat, 18 Sep 2021 14:09:31 +0200
Message-Id: <20210918120934.28252-7-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210918120934.28252-1-sven@svenpeter.dev>
References: <20210918120934.28252-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the code relies on the bootloader to set up the interrupt mask
correctly. This usually works but let's make sure to do it explicitly to
guarantee it will always work.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index d191e7435018..2058e8cca631 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -728,6 +728,24 @@ static int tps6598x_probe(struct i2c_client *client)
 			dev_err(&client->dev, "failed to register partner\n");
 	}
 
+	if (tps->hw->use_int1) {
+		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
+					tps->hw->irq_power_status_update |
+					tps->hw->irq_data_status_update |
+					tps->hw->irq_plug_event);
+		if (ret)
+			goto err_role_put;
+	}
+
+	if (tps->hw->use_int2) {
+		ret = tps6598x_write64(tps, TPS_REG_INT_MASK2,
+					tps->hw->irq_power_status_update |
+					tps->hw->irq_data_status_update |
+					tps->hw->irq_plug_event);
+		if (ret)
+			goto err_role_put;
+	}
+
 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 					tps6598x_interrupt,
 					IRQF_SHARED | IRQF_ONESHOT,
-- 
2.25.1

