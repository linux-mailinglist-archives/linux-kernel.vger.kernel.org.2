Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50538323273
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhBWUuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:50:23 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:52679 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234479AbhBWUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:49:22 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 38B99A9F;
        Tue, 23 Feb 2021 15:47:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Feb 2021 15:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=28LP/PewbhgaC
        RSaoZFWUgacs94ZhHAs8MTWrhWs8Ok=; b=KJzuOhkR2TLDQliUbo3Z/ZBa6Z4kK
        399Xb9IKXifwSt349Kq0vvJmQf95vmvkkfEkkwJI5xh5PUvLah4fohJbndS4Ck4U
        /YGG/TgCUc1le7FaR01xyTsZHodG8/p5snfiZaFkVaI8jbwiBuC0Xvkfr7ebQ8Is
        6pTAAqqcH4k+wpftgX82K7wCa/mG0Pqgx/zV3dlUfECoRrHNyZyJpeG+jJVKfqFM
        008Wrrp6B5/bIwC482IplKqMKK7SMoE/xn3KsnIPkBKK1XdOy5cpPar9DzyMRPjD
        oZcfJsOZ18FdReRSfJTT6BZjtD3K2ATFcIdbWBvAE6zew7p0cg4y/nStg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=28LP/PewbhgaCRSaoZFWUgacs94ZhHAs8MTWrhWs8Ok=; b=oeOXOdtr
        +gcccfOYTqYGi+sF1/1TsofSrwrBEJCjQ+yNGYaU9z6jZuOflJ4rlGSOxyc+8J2y
        b9TGs9e4vaxjpj3HScBXgNC1DVWaCtA73VHiUyrJFAJhSfttKtR3abjzQNBUtEsM
        o1JVTCdbh809H4Xz/CWyYWODC1617W+sSoJvR3KU8bSSpP/Cak25LYH2w8Lh3i0X
        PIeM5zN3h7cB2bto2bKIJc+xruK0ZedUc5qXwf1dMFCzlXzIZLHntORkB9/WXJDB
        RLXyy0hffot1G1g2SVjqcUPR6gcsvW33g5kmmrEiQbfekgL8/p8X9k4vXEKQrqza
        T+joOoCdGQwzDw==
X-ME-Sender: <xms:5Wk1YMhYIiky5Ikmud0qnB0BgV9NklepUvA_wPHgnI5tps7zE4n6NA>
    <xme:5Wk1YCI62dwWskUTgWxLzKiLm_DcLv5GwXIOr0JcGOMpUPVLjlsGBwvFwoVq33hsF
    hnfncrIfJiJaa4vrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:5Wk1YDGmDEr2KnDpTmsJt2jj-_V1ceHauFvMX7cDGudwenWenCeyag>
    <xmx:5Wk1YOQQGO4i8Lugbcu0JGetvfhCpb6uNY5NetWQf8GGF2FdhYgNsg>
    <xmx:5Wk1YHdKDUG_ag4vdeQJF8snHI9a6MYkdsFgx79Q5AomXMVL1DeVSA>
    <xmx:5Wk1YIROGcmEKyaRBbblRc3uaLbDGSz8dXDMQAot4fmaXllic-pEQw>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6361E24005A;
        Tue, 23 Feb 2021 15:47:33 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] staging: rtl8192e: rename bdBandWidth to bd_bandwidth in bss_ht struct
Date:   Sat, 20 Feb 2021 15:54:12 +0000
Message-Id: <20210220155418.12282-9-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220155418.12282-1-will+git@drnd.me>
References: <20210220155418.12282-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a checkpatch CHECK issue.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_HT.h | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index b3856044b52f..b44fd8e39263 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -187,7 +187,7 @@ struct bss_ht {
 	u16					bd_ht_info_len;

 	enum ht_spec_ver bd_ht_spec_ver;
-	enum ht_channel_width bdBandWidth;
+	enum ht_channel_width bd_bandwidth;

 	u8					bdRT2RTAggregation;
 	u8					bdRT2RTLongSlotTime;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 0b2618df86aa..e95be64edffb 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2031,13 +2031,13 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
 		ht->bdHT1R = ((((struct ht_capab_ele *)
 				ht->bd_ht_cap_buf))->MCS[1]) == 0;

-		ht->bdBandWidth = (enum ht_channel_width)
+		ht->bd_bandwidth = (enum ht_channel_width)
 					     (((struct ht_capab_ele *)
 					     (ht->bd_ht_cap_buf))->ChlWidth);
 	} else {
 		ht->bd_support_ht = false;
 		ht->bdHT1R = false;
-		ht->bdBandWidth = HT_CHANNEL_WIDTH_20;
+		ht->bd_bandwidth = HT_CHANNEL_WIDTH_20;
 	}
 }

--
2.30.0

