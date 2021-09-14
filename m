Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE540ABF2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhINKoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:44:39 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40779 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231879AbhINKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:44:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DAA7A3200945;
        Tue, 14 Sep 2021 06:43:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 14 Sep 2021 06:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Su2k6lQGldk0p
        FcRl4+KIHIh66ay0zLQAuWtpWetnYo=; b=sbNZK/DkE15NRGYNbt0PPXP5EtUmE
        zH3QCwodG0SjYqkuIcLwpZnRmrAyDzfHdKxgJDSx4954+Nt4b0SfbtZlt7q18Jco
        EEIFduJAXiB50R9bKd6+MkHnaK+w9PORHUYuxIYZHwcXNyPzyC001tJIZbhoG9FE
        7FRX3Ih2GB7MuKr/JNCx6RJRUuu3sE9n5CnwA4XCbUWLNBFg7kqZIfSgAYpR3Mli
        O3Pqnb34OAnrU51gwzAQQrk/004gO0faSGEjChuicAPQ1xMQtOmKSNCx7w5X//7W
        4XdQu1PNCk+Z/UW4RcVZrtfpYTcvqvEH3f2vthKN7+EotQxs3RxEzRXRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Su2k6lQGldk0pFcRl4+KIHIh66ay0zLQAuWtpWetnYo=; b=dGui1k43
        bhqwvtUsBNmoK1nggikSZJr+cHE7/ySDPM1eJOdFNvd9INciyqXtCjRtsemnZBqj
        MtFkmAqFYmxFgZ9plJzK2IVXxrj5UcpWfn5jvIkWJC/UqrOh3tjudKC+Kld/utCQ
        iwhNT9grHdnok2evAZKX//dThp8EKiX+DK1vn2KpENJ3x89blZZ78rX+EYPyu0PA
        7SChvh6p7oUjeDh9T757lpBCNl9NrsNaTYEz6RWDipV0tiMNzwayKVPL6Mwtm/80
        WRx2F6poYJ3PC+q5lNLF/t0I7wnvlaBy9Ea7Sa8XthC6CELBpM8KF/SE6gAXhepf
        zH4K8VjpHCFshA==
X-ME-Sender: <xms:vnxAYbNcR2hqfHjPwMcLolGdywcrSzJuA9C53dGjOGLupu7JXdDCLg>
    <xme:vnxAYV9mpXpXoK4y5h03zl5l0S0gBp39hXJtxcEUw_mpRYxY5zIlkF9fb2afUXH2E
    yoqyqe1korRJXL2Ypw>
X-ME-Received: <xmr:vnxAYaRIWouDqIEQD-1JqNw0sq7tPCpkAMfvDswrFv7YrotrA3nkpFl2C9OMfX231j0dlGcT3Y-_DmSSlBKsXnSdQ9qFRSutivgRwCrh5f9_GTas1RCaydX4c6NNLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:vnxAYfuxx-a_5gIag7FlAx3LBGv9jxPfEwCffOGe0cxvAcjWh5vPhg>
    <xmx:vnxAYTcOlqZL87VxVO7XFj4hnQhDUv5BP9lRqA7qt8EzCIvYGoFvDA>
    <xmx:vnxAYb0TRAzKCVh4HNqqSa_NmGTvyky1SOXkr5yqI5hLLIVIDsBl0g>
    <xmx:vnxAYf5TAgASgCeRuTyTnv_AWNAPxIgvdbXHkGguOXYynxpTDFK82A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 06:43:09 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH 2/2] usb: typec: tipd: Add an additional overflow check
Date:   Tue, 14 Sep 2021 12:42:53 +0200
Message-Id: <20210914104253.61365-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210914104253.61365-1-sven@svenpeter.dev>
References: <20210914104253.61365-1-sven@svenpeter.dev>
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
 drivers/usb/typec/tipd/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c18ec3785592..70e2d0d410c9 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -139,6 +139,9 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
 {
 	u8 data[TPS_MAX_LEN + 1];
 
+	if (WARN_ON(len + 1 > sizeof(data)))
+		return -EINVAL;
+
 	if (!tps->i2c_protocol)
 		return regmap_raw_write(tps->regmap, reg, val, len);
 
-- 
2.25.1

