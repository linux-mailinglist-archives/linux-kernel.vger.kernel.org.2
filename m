Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7BE40ABF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhINKoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:44:46 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58649 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231886AbhINKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:44:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BFDAF3200911;
        Tue, 14 Sep 2021 06:43:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 14 Sep 2021 06:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=suCzZdKpoToDlnBCP6NGEN1LsB
        HmOIbbzYoo8UpE3Ag=; b=s54OMhV7Lkhksb9Ck2+/IjFk+VLR4Bglv/PFisjAYl
        0Ez5uJqlbFYCAswj6paZnSkVxpBkY1YFycdxeGSWHpm00krcXLEi9IDo6Tkv9LU/
        hoW7mDhScTbDaRiddOto7rFVCx93zX5V1OQkm0ePaGnYb0hmX5y7XRr3Bs0upbaH
        GjacuYi8IRbiyx1H0Q0lChcDcdgTTojlTkSzGTMfQP4oRcmhqFaUfxXZseR6l5YG
        0l9vePRK8i2IsB8YsfFEKGUmNO4C/wg53r2NV2G9MN7jIujvfCC2Aav6/O7wEj8Q
        Ns43CoFZHm0UATuTJ7uPP4I6R7qmoHeUezkTYok8gdFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=suCzZdKpoToDlnBCP
        6NGEN1LsBHmOIbbzYoo8UpE3Ag=; b=USIM50X7NX7ThJkm3P3n8clDHIpshaJB6
        q5WhjPStuVXOP1+fVRXijZfKpui8a+dGs2VADRn/GfDDDjonYx2FV7UPOxA6fzyL
        BAJ55USuUgnP4SntlfYMzw3hpb/ycov93x4ftYQouATGc4X39C45n0Bus6omYjia
        tXRFqprzVKo/3VhvzeZEGO7OJqJUoxnmeTbFzWsGtANJNwTdlY4rE6WFD5x51L1P
        1oATjuOwZ21RKXM4oKR/WhKpPNHLPTvNwRbjoIC9TpmsGu258kNJHcnp/Mlv+lfe
        PTN6BrYmijnDmPlX2m6VFNPMBRJM0B9RPzbBSh8N+Ay8A+67ARcWQ==
X-ME-Sender: <xms:u3xAYQqzNiqBiCQAx7atSOvOvh0Fd28LqP_jRfFc51Ni8UXvQjMcIw>
    <xme:u3xAYWpTUx_ebSVgnq2XqQRrx-yfi2O7nJvwjFvpaSmvYUwQb8SJyLxEPJfNP8Wm5
    JwMHL4Ae8SxfZ871SY>
X-ME-Received: <xmr:u3xAYVMYhPx4H46MOW3QSbhzgzhekWtJwOagY5UiDE3gi1WGGzVBHfJPiBqYNXLIVEY17DZFQ5isih0lp0-6DsEp8gfXntfnLU9ngoKJEGIPQ_eNvDQ3oHXb73BrbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:u3xAYX5ZgN09hC1IGREsgSsFdFlYZDZUEirFfsMCXNKUEyKDUCjMwg>
    <xmx:u3xAYf4SeaBORogDG2txb4Q3cVLfzilbd9VOFLSN-2O9iMwy0Lrp_g>
    <xmx:u3xAYXjmq2F-O-vP3vMGGM2ltBfU6sNH1Okl5OHwncR3NB7oqxTi5Q>
    <xmx:vHxAYRmjTRjjUctU5yaGU5IvW0GOgLDhfgMFJwTXepzm18WLrXdLIw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 06:43:06 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH 1/2] usb: typec: tipd: Don't read/write more bytes than required
Date:   Tue, 14 Sep 2021 12:42:52 +0200
Message-Id: <20210914104253.61365-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tps6598x_block_read/write always read 65 bytes of data even when much
less is required when I2C_FUNC_I2C is used. Reduce this to the correct
number.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 21b3ae25c76d..c18ec3785592 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -123,7 +123,7 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
 	if (!tps->i2c_protocol)
 		return regmap_raw_read(tps->regmap, reg, val, len);
 
-	ret = regmap_raw_read(tps->regmap, reg, data, sizeof(data));
+	ret = regmap_raw_read(tps->regmap, reg, data, len + 1);
 	if (ret)
 		return ret;
 
@@ -145,7 +145,7 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
 	data[0] = len;
 	memcpy(&data[1], val, len);
 
-	return regmap_raw_write(tps->regmap, reg, data, sizeof(data));
+	return regmap_raw_write(tps->regmap, reg, data, len + 1);
 }
 
 static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
-- 
2.25.1

