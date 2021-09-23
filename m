Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6941650D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbhIWSPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:15:52 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43255 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242858AbhIWSPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:15:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 92352580C1A;
        Thu, 23 Sep 2021 14:13:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Sep 2021 14:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=y5cXdn5TG30ct
        gUM3idfkxKAvngMhxBoi4mQOhq6uUM=; b=r40Otg6qMtjG6gXzlCjBP8PVgteax
        n05G3w/lMSU7p1HBrcy2HFIBvyM/lEgH96dMhOhf8V55wnno9d6xQsI2LMpbKVhA
        wSvdQh3ysHPBlmLU35P36LBjV3CGM7Dx+fNPXhIEDWvnYiJPG5Wj9snTgyJLfsr8
        cGUHbZh4DjKg2HDfRpgtcdSUPEIDDcnvQE7wit4oKuP4IJ5bSgp3+aG7B0F+c3pq
        OXacAAY3X12lZB86aNRhl2UlBX2BiO4ArasDZxxGN4IxzH7qtdrui+fkeaI2+6wy
        N4ewKF0RPtGNBeNexjP0IibriLB4TEFbJC/d75Ab2KWFrS+iRcGJm2pBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=y5cXdn5TG30ctgUM3idfkxKAvngMhxBoi4mQOhq6uUM=; b=NX0COu24
        2iFpRIF0yGf6vzVJdLdipvxcSzLSL/cB8RNBiCZHUPQNOJBEip/d4upwsxSpuA6V
        TjONNOccXROu+7d7SC03RHSWzo5ME9q+dCw5M08hoUu1cUu9Hy6+rjrkNJiLcNE8
        KOh2zbbQCgWqRzeGn93FsEJg24ol2X77Ce71NAGKiLt6nD0gmsbAvWTqcN3v/Mx1
        dWyAHLNYZCiJjFKFpUH9GzlTMbb7iJaA3LpaOS7pazPLsTnedr+Qc4KuNrMseZGa
        TnT/AJKZ4ZHXRdzA+cHH0GG3vNNMm1Oru/3BfrhpBwTQAGyWkg8RWgT7/yzuud5d
        DOPcOtgrfwbJzg==
X-ME-Sender: <xms:2MNMYUzIhDLNPbob0-k7wIIXnIAK4hxLhzMZAwh7NjMgC7wt-FMyHQ>
    <xme:2MNMYYSsg6ReGju7EungIY7blbBKjqhFwkfpiNymShDRG3vnPc21dH-uxp75SkaDS
    _n6N29GCCzJ5ipMB9M>
X-ME-Received: <xmr:2MNMYWVkH9LviPe4gG5ubGN7hFeEywcdWWzMaJHulSGtgaukPnESuse-Y-y-V6rFFOcfRiuW4wn1HFOutgxkY4tPpmW8oO2P97LiGrEoRgOzZ8KQgfjS2sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:2MNMYSjpjxPfTuoEL4wRKu2ry8MzAiCeQFgtcMJ-1TpdDm7IuN450g>
    <xmx:2MNMYWD643y53M-A4iJbU7WX_l2HpLDOuhDVqOOdbC6Rk0G-YfGZDQ>
    <xmx:2MNMYTJ3apFUcdTRdbLmFVFqywac8HJrV6ursUDmJwJ_mZbuq0Yb1Q>
    <xmx:2MNMYXK6NMIXl82ski-QeVfLqbOFWQbheCSAh77OIRid8UsoXu_ugQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Sep 2021 14:13:42 -0400 (EDT)
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
Subject: [PATCH v2 6/6] usb: typec: tipd: Remove FIXME about testing with I2C_FUNC_I2C
Date:   Thu, 23 Sep 2021 20:13:21 +0200
Message-Id: <20210923181321.3044-7-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210923181321.3044-1-sven@svenpeter.dev>
References: <20210923181321.3044-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple i2c bus uses I2C_FUNC_I2C and I've tested this quite
extensivly in the past days. Remove the FIXME about that testing :-)

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
changes since v1:
  - added r-b tags

 drivers/usb/typec/tipd/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 20d9f89208ff..51cebb41884c 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -746,9 +746,6 @@ static int tps6598x_probe(struct i2c_client *client)
 	/*
 	 * Checking can the adapter handle SMBus protocol. If it can not, the
 	 * driver needs to take care of block reads separately.
-	 *
-	 * FIXME: Testing with I2C_FUNC_I2C. regmap-i2c uses I2C protocol
-	 * unconditionally if the adapter has I2C_FUNC_I2C set.
 	 */
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		tps->i2c_protocol = true;
-- 
2.25.1

