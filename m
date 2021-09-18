Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C73410647
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbhIRMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:12:27 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33867 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239483AbhIRMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:48 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id B238D580AAF;
        Sat, 18 Sep 2021 08:10:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 18 Sep 2021 08:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2BUNai60PAsqa
        HL0XWy7FY7EGOOjnzZDxxMpH7rQ3Q4=; b=cVOv97tqGpyIKyv/WBxbBDWMhKaDS
        IbkB6ysOE+JWR2uz8bpqaINpYd4BoMZSXSmNprFA8wpMclhuDgxHeDRVGLQXrVQH
        8XvfLhLDH0CooiZ+qOW4xSh64LAYe1U30Gi9kwQ0shgRaDP22EpueKs72Gf25+49
        2+aNb12N79YhnNFuCtkFpUJ5WyShfRpLF9a+20KRVuIv1kQsG0OFMWpUBBtJPDUa
        w/zjyco0rWTZaLOoNyYXtHdQ6+0GZIgezabYqpJXyHbbJOECKfVSksM3BCypDRIw
        wrqdgwWdGeIJ3wEYAFLWIR9LAjmqPc08bgRBucyp1EbCnfMvjxonO238g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2BUNai60PAsqaHL0XWy7FY7EGOOjnzZDxxMpH7rQ3Q4=; b=rAOhEJaM
        b+VawphzSWGyilbd5N/OZzKVXbohQubTWXVoLyH7HLZSmY/Tz1Lh94ffobzmJEr8
        DGui+HCRH185pDcpQL84iYtZK5LIVypfKIZAqP0bFSnKS2B9BW7RLbO9Ua5Mmh8H
        gtS9YqoeBf4rMpge8Zu/BA9R5naxmGznVTsYu9jZM8jknHD1gX/2dDrS+X5JUC+c
        cCv+ziWP5CZYvkuqcgqfIBJmLD3c5Hmqd9RhKZOeoPu9Y6IMUABP5H/cInWCMfyg
        hWZHuwe8B/PZO9sKBkU9DXeSXqFFQ3jfdjnp8Aekg6DDwqbFsdsrE7zy7tFt2JqL
        /c/D7glsV6jEOQ==
X-ME-Sender: <xms:I9dFYb8i9xrLgZKHFdbEdxlIIopYm8r8nYDteszZn6kblTuCakSygw>
    <xme:I9dFYXuBe3ZiklGnt8lWRrVUoInTq-5ak3TMBRkuqnJbNEZPfG6d6nfMm256KzOuh
    dSU07CBJzagCWRROBM>
X-ME-Received: <xmr:I9dFYZD7rmf04NG4SVShLbFQ1cBg_MvOfDYbxmuokadjLXJAAEpa5Vvol-IMKlD95SLOkB6HrAerP-2qJXBqad34VFEq-sBPrpxwtBai2nALyUEwqO0sUyEEIS4rHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:I9dFYXfoJ2nTU7_lLKFVztw8fid6sYfqfj4bBonKWXcV4kqLyvIBag>
    <xmx:I9dFYQOp0FwhnU29U6hKJyO4bb5Fwcv1eZlYJxqgmbMnh3xhK8L3IA>
    <xmx:I9dFYZlEW-YCa0x_RTnxw3Pzr-ysSDNjeFIwCpuIJqOmdXJfrZfJWA>
    <xmx:I9dFYZmvn-cZGqHzT5RnRP7FhEZS7dNgEzQxTB84kFDKtSJuRNgjLw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:10:09 -0400 (EDT)
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
Subject: [RFT PATCH 9/9] usb: typec: tipd: Remove FIXME about testing with I2C_FUNC_I2C
Date:   Sat, 18 Sep 2021 14:09:34 +0200
Message-Id: <20210918120934.28252-10-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210918120934.28252-1-sven@svenpeter.dev>
References: <20210918120934.28252-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple i2c bus uses I2C_FUNC_I2C and I've tested this quite
extensivly in the past days. Remove the FIXME about that testing :-)

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 26807c050662..3b6878e22ce9 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -673,9 +673,6 @@ static int tps6598x_probe(struct i2c_client *client)
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

