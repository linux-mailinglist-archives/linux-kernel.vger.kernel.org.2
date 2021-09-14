Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F340B02D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhINOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:04:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48053 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232989AbhINOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:04:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CACFB5C0115;
        Tue, 14 Sep 2021 10:02:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 14 Sep 2021 10:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=0ZwXiZhi1QvrQjegd1Fbj2eOT8
        sE6gEZauag+r4fBZA=; b=mVl9l/jsH6bPWuum34e9qxaaD/1Yo6p81jAOnw8kwe
        IlPgSIvCurASBPi0xbYYL3HdCJxNbfKV6+uObiRacQaGhI9oG8Yk+yu7svb4EgDn
        Ea+t1uaXPSPEndcxQBv6IekBCE73P5yQ7cFDCNConFB05ivphgioj0p8OgVLh2cI
        VcUTBirLnZNIEnIlzjxnMdsiWPGnd5JPlCYdl8SqK0z/qdMSBcSBwAEAFK5u64ju
        yqkHvRpePbqVP57AGR3GCogzHzjnqynvi77dWRaI1ZXcC4tXfNpv4cax6v29Goja
        H5REoeNQr7JT+AxKbxaS6+P+lxoMf5jBDDDUP2Q65rdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0ZwXiZhi1QvrQjegd
        1Fbj2eOT8sE6gEZauag+r4fBZA=; b=A679T0hg++tIr+hMnYrzytIOG3tVb/J7N
        saPp90aCdxt/J952eDfJKpfWYz6r3TERfIK4qWVW1fqfxzvQ1XR+GxM+QjuQZpZr
        XkzRjbYq2R40cUWFlvLIQp3Y1v3R3cf6B1ry7lT6JUzxWvqozyLszm7aDTLmw79/
        HU0GHKe8U9LIglm/MrNzGAY/vZpXjrt7xfgjTnZnjqeA0LjBfTz8uAC4UO5gSMEs
        HLW1NTGZHzCpL49d0Op/beiEDG2t+znnTPvoTFfbyriJPWd/wXOrtd6PK0xpCOtD
        DkYGlXknNT/pL+Ea0OVrDhwFHcmBcoiOC/KO47lcFW/7HGK4yCbwg==
X-ME-Sender: <xms:hatAYSd0A9uBW5rQT2jIUVRGg7sjGB6PrigRWBuwDvDnv5jEO8NLYQ>
    <xme:hatAYcOavYjZzh5d1PTtZ557C14tcVI8VMf62CANPagJAR0bfbuEPTeiGnbCWQ6IT
    59VvI2ZcVfBHhp66cw>
X-ME-Received: <xmr:hatAYThv6k6CDfs5RlUMhcIu-ZRCv-anzRFeXlwm6suPUWl4TDrdqZxzNdOGWV_4JDqes9Vp_zBcuZFrx8yDl_ThThtraG8G6dQo1VxZ0cCWxljBGuKNK9a_UDzTUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:hatAYf8WQZb3oxTim5TtIJY8Vg73qxkOHbbM4U9Ai2PR0--3zqNstw>
    <xmx:hatAYeuotwUIH44a2OznLJojG6j7CF5-2p4Gaii8fCpqAP2DWTiprg>
    <xmx:hatAYWGqgHRhjsIYb--_jXls2rBR8pWHMUzBWU_pWIGwjzFOPlab0w>
    <xmx:hatAYSKbFbNkeEBsPdlC-X3ZQV_11ZnKuNL0BG-KEhk1Hy9mQRsBYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 10:02:44 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH v2 1/3] usb: typec: tipd: Don't read/write more bytes than required
Date:   Tue, 14 Sep 2021 16:02:33 +0200
Message-Id: <20210914140235.65955-1-sven@svenpeter.dev>
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
no changes for v2

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

