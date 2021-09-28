Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23B41B360
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbhI1P5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:57:20 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55821 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241729AbhI1P5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:57:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5BDD8580C2C;
        Tue, 28 Sep 2021 11:55:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Sep 2021 11:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=tioV3w1us2lR+
        k7Bn3CrlkUcCREi0bHyi5Rh0GFTTMY=; b=acOT0Vy30SAM0oxpv/aisxLns3l1t
        BJo13UWxgqRnHR+Es2BHozcf970I7jkdnuFHcYcJg6gcfv2aA7MCbBw5X1qQUVTe
        QPSRz0pPh0R2nJ3UwwbQ0EqCA4wQE+Sr4QZCbljutZpZ3UDB8sz/Rwe7TNCfQE63
        LmUghPmwuyb2IEs1+cbDt9B5CWRs+iat3W0n9iVDOWLjWPG83+RW9fsb16814RRE
        qjpm6uUVVuoDDm4fN2CCjMuQJsRN+WPDCmg1d773xtgX6GiWpYgV+PW5GWMEXdfx
        s+FvhRPSjLfXJnX9LGoO6Rn0MRQ7+etC3M3OUrp0jlCEfzjqczrIkoJtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tioV3w1us2lR+k7Bn3CrlkUcCREi0bHyi5Rh0GFTTMY=; b=dtFI6iEt
        3uwRWSnuw6VUc8ZScaqU0RvrZSq2BQlN3ifMGqia9s0laL4T07rgaNWflru+hWeR
        Ux6yNFVo/LNq2X02RRpV2bJiAnbHSIk6fYwg+fAebCqLcQfx0sezbhjxds+cYAtQ
        RU+q+1oYSH+u0XPxjGdI646DxQvOdGgf309dXL6w/ysMLXIUtkmfpr0R5fAVQqFM
        MEZsyjrXqPiT1XnuDJjhsXwKokK1VL3O0mClvi/pHzzt+oz7ROFmGwGF1exugosw
        OqL2vh4wB2zPIGmlPmjxytTKm8dNDplJJ7fWfREfajogOxXq7Vt2S69XdC61a8+Q
        Zvmvxvbc/DpKww==
X-ME-Sender: <xms:9DpTYUp9DVwMwlfKO6jIcp_Bqrkv7U8O6ayMQs6cb_Qb5lNhcd4JDA>
    <xme:9DpTYarwfEQNkDW9jqk6sQLmzgSTTufZysN-CRZrD6WMe_O50CK9a30s336G8r6Nb
    D0PiX6084M7PjMOuvY>
X-ME-Received: <xmr:9DpTYZOMg6lnf0gZ69AwU7Ll6JWfgd844hsiW714SQ9Lw7uO88ols7rvQ4Lpocsma6eHsfgzQD5sA9A_J0m2eeHLGxHVyFukYzBqznomIIe2fAmIvssv5nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:9DpTYb5YtrPAJNj6ELeNjiLU_Hq3V3FR02Muf2R1jC4Qf20VsHK5hw>
    <xmx:9DpTYT5Byidu5Cfef3A7-pgWgI3YZ49NW0oYdVgv4uLwW-1t7hdBYA>
    <xmx:9DpTYbgXyhFrrRbQbNMsonLbDVBPnSK_AptOf7s2b4C6S8DtO7padQ>
    <xmx:9DpTYXiIdRZyOzsCRAlDcaiYG_57MRfPIljDCgAZJke4v6IGe0tKIg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 11:55:30 -0400 (EDT)
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
Subject: [PATCH v3 6/6] usb: typec: tipd: Remove FIXME about testing with I2C_FUNC_I2C
Date:   Tue, 28 Sep 2021 17:55:02 +0200
Message-Id: <20210928155502.71372-7-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210928155502.71372-1-sven@svenpeter.dev>
References: <20210928155502.71372-1-sven@svenpeter.dev>
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
no changes sinve v2

changes since v1:
  - added r-b tags

 drivers/usb/typec/tipd/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c74fc9ae1686..4e1a31f88c2a 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -726,9 +726,6 @@ static int tps6598x_probe(struct i2c_client *client)
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

