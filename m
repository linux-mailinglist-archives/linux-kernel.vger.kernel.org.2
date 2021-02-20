Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1205932450C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhBXUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:15:57 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:35353 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235480AbhBXUKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:10:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 67DDEA30;
        Wed, 24 Feb 2021 15:07:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Feb 2021 15:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=doruJhczG0yJ4
        EN8JQu3N66tK/shwjEF6ktp55ZkXOM=; b=lSr2VG75LgUic+HDey7cnHvyp5j1O
        CT5pdZumoWISsVvRJ4+E+h+4yGbDaohixvEksAxBfP2G189j6FZhFkmTZTT2PLOv
        /fCwK0XmZ7V8kNCvktYT5A9SzhOOxpwgwjIvumNvVHXTdWRo+lNkXdFVIpXpZkau
        +1eM/+HVandEaFy5O8j7+0FGSyhIohiqJHd1VM10eFixwOQJyrPQSxyF1LUcMHY0
        RrTkfp7hV01QXnSyq/YoE2+6S7WlrhujQt6nUsqGG4H/c3oOf5D0rAs5TNWZcc+n
        vzMSfaWO5VfmfHLMI2eSq6KAjvvHJ7rAc6PlyeqrZtWNebCnUuxKHw1cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=doruJhczG0yJ4EN8JQu3N66tK/shwjEF6ktp55ZkXOM=; b=SyFxbbdi
        AlG6Y5ubSAvKlxeLSKmDkuiOr9pZT1yxoBIrdLHUZ9xiNQmyOnrrraGt4e8D4DHK
        9ZCEWuJUQZAsODUnrkmZFQ8KPi1dzJFu1SnOCf/DMAPcLkeyu7E431cJEVlGbjwX
        PGKsAqhW8A2Ts0gucwQFqa8QrvU7n2gihHt7NYfzMm0hmGERK7JWesZqwrtWHa3r
        pEaVJIQfgGyg5jTqyNS4Q4QXTutdfeBl5apoyasdmMR1ksVjUx7r57BudjLlOPgR
        xxXt8S4xPDtw9PG//RSU0vxz8BFmusP9yNeuy6DQDfPyRvIXuHKLJD8sPKRx1iek
        T2iAwYvpb9qGAw==
X-ME-Sender: <xms:F7I2YHs8ZRF1jq0vECQ3h_9N2tPwJCHHnGWdSfcXx6vmvwg5z3G5_w>
    <xme:F7I2YP243dUmWPYqEipxgjduFOlTkyLn-KFAZ2JMnp31Gzw1X-SVpZjA43mKOHcGl
    wVZW8qAaaMdrc4uyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    einecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:GLI2YAUWpTGFl6cMIhLYa9j0O2V7Snmkrjjs04kTS_dWYYdnTwBHHQ>
    <xmx:GLI2YCK68gJcORPpj0OOtsC3arZNv57x-O5hc2pPW3JoB5_QdvMl_w>
    <xmx:GLI2YK06m_bb4r2BIyYE6aJ96aXqBC5YAH2xIPJhHfveqUQfeZHjnw>
    <xmx:GLI2YG3vxGOBElbjscnlxOKB_5UgF0h4Dfn-WPofJBDeiH53JM4vWg>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89A1E1080059;
        Wed, 24 Feb 2021 15:07:51 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] staging: rtl8192e: reformat bss_ht struct
Date:   Sat, 20 Feb 2021 17:29:09 +0000
Message-Id: <20210220172909.15812-14-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220172909.15812-1-will+git@drnd.me>
References: <20210220172909.15812-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses a space instead of tabs between the type and name of
each member of the struct.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_HT.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 33a58c87f4c1..ce13b41074a7 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -179,20 +179,20 @@ struct rt_hi_throughput {
 } __packed;

 struct bss_ht {
-	u8				bd_support_ht;
+	u8 bd_support_ht;

-	u8					bd_ht_cap_buf[32];
-	u16					bd_ht_cap_len;
-	u8					bd_ht_info_buf[32];
-	u16					bd_ht_info_len;
+	u8 bd_ht_cap_buf[32];
+	u16 bd_ht_cap_len;
+	u8 bd_ht_info_buf[32];
+	u16 bd_ht_info_len;

 	enum ht_spec_ver bd_ht_spec_ver;
 	enum ht_channel_width bd_bandwidth;

-	u8					bd_rt2rt_aggregation;
-	u8					bd_rt2rt_long_slot_time;
-	u8					rt2rt_ht_mode;
-	u8					bd_ht_1r;
+	u8 bd_rt2rt_aggregation;
+	u8 bd_rt2rt_long_slot_time;
+	u8 rt2rt_ht_mode;
+	u8 bd_ht_1r;
 };

 extern u8 MCS_FILTER_ALL[16];
--
2.30.0

