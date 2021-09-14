Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0451440B02F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhINOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:04:06 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51613 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233550AbhINOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:04:04 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 41C3B5C01C0;
        Tue, 14 Sep 2021 10:02:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 14 Sep 2021 10:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=wLpknvgdOyW6A
        0yW8l9BGg3ldSZFzQqA07ke3tiZCkY=; b=G/G6AZlq7M6KNE68rloL5gKhhboOu
        15yU7TxQchD7JBBLMmkYJVBzkvvpOGZkSs7RUBsQy+DBOWLExqZGrZ3V/Aw2T4iL
        bVAEzpCIchVEXU2sOitsH1vSLXroRExvPYGhEoHI+k60YEf3RIWynNVbpD4aGtf/
        zB6Z3PQR5ISyLlBnPGuqOS+G1hiagb0dVPQ6x9+7H5EAja/L8Nzwb/qo5CM8CXuq
        R1cJ6jGZ/dlHuY4dcevesgrD1ivAjo9+iJmK+H29boKxKDZqefbQVG3bIYrmSBmA
        UAH0/Vnn4yGosVODNW5Bl4Ds0Y3WxCFCm+xqHKtE08NhyhaipbZoc31Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wLpknvgdOyW6A0yW8l9BGg3ldSZFzQqA07ke3tiZCkY=; b=ekyFh0hd
        5e1n/msTTWiP8z40ZRMbnS4SPqks+VA+ulQwhkV3KWe+OT574n0KrhMsTaR6y0sh
        3ocrujen29xhCz2YHpipjC2Kuci0gsbyooeVIWo9i0gLmuubEczo01OgKKV3FfSc
        zuGHk3u8JxcmWO/UFFPbdzughDKm3obWVlD95AHL8KydEXeOmHUjJ5Vw55yLwDba
        g0F9o0hDW8R1hoOF86UzuZWKd9Kzg7DMfkTebK9GRupVgcjwyx4w5d0CuC75SYlZ
        K6vvVPpkmCHrsXXuuuH0Ir/HHcGM8lFPu9HO3JIKev3QQY8Cs82O+lkALrpI1KLf
        sC+JnpG9+e2I7Q==
X-ME-Sender: <xms:hqtAYSM-u5BCv4OtNEaPWHE6_Ng7-p8Enuh0gzQg76akp2VtxxYuFw>
    <xme:hqtAYQ8Dx8ML-FJ1XkKTVw67yss3Oi1wds1wH-_X70PuuHkQDgptvG_9iSyGin10Z
    k2ZJxa_dMaGCjwqyOE>
X-ME-Received: <xmr:hqtAYZQfsPM3b2nWYul58C9t4GItHLXy5-ivT1CSmB09kwXahc4_7kriA_O0dkkWdvbPhTGHcua0LsNnHTIw02-wDV4c5UF5SplhJqqOOBdS6FTiz8MBVSqC__SrlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:hqtAYSvWr7cHApHxZyoYcDCf4SfxJaa1-iVQ49qs3QIA94PmJvdjNg>
    <xmx:hqtAYaeWMCbhOxeSarj4G_rj_Hq0MS99celQUXxQVWOhRNOQ_6H7mg>
    <xmx:hqtAYW3L5B54Y2Waejabii2KRACkQgYyA2Aw41YEK6tt8NrxwjLtRA>
    <xmx:h6tAYa5RQBUneyDUKEim1rEeWl0Dlj0J5VRqPd88fwBJQesk84dt8g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 10:02:45 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH v2 2/3] usb: typec: tipd: Add an additional overflow check
Date:   Tue, 14 Sep 2021 16:02:34 +0200
Message-Id: <20210914140235.65955-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210914140235.65955-1-sven@svenpeter.dev>
References: <20210914140235.65955-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tps6598x_block_read already checks for the maximum length of the read
but tps6598x_block_write does not. Add the symmetric check there as
well.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v1 -> v2:
 - removed the WARN_ON to not crash machines running with panic-on-warn
   as pointed out by greg k-h

 drivers/usb/typec/tipd/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c18ec3785592..8c79ba17a157 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -139,6 +139,9 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
 {
 	u8 data[TPS_MAX_LEN + 1];
 
+	if (len + 1 > sizeof(data))
+		return -EINVAL;
+
 	if (!tps->i2c_protocol)
 		return regmap_raw_write(tps->regmap, reg, val, len);
 
-- 
2.25.1

