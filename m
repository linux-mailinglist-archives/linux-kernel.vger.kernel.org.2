Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07303324503
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhBXUM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:12:57 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:49797 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235409AbhBXUKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:10:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B9D4AA2F;
        Wed, 24 Feb 2021 15:07:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Feb 2021 15:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Er3Hmi5TJeUs0
        D80aahpd5IOahIX1qazBhjPJ3/Qn6o=; b=bXhDJJXLmVrKbVXJUIMqYbuYRxuuc
        /kAgCPhuvVNAKqzfCFQDnTFQValMd18xCrHbVddeFp2J8CSJlRUmX+m5mtEP1pHA
        TpdTRwCH7JYFPBoE9fLCoFK+CJMLOiLwVtZ7JVTE37SwPyY5FAwK+RRgAYrjzjdi
        UG25V8pdrUfXmRZgOnwYC0N579webgDPl2sTmN10+REjyGnkG+v0cHMRnF0zDTr1
        F/hQ4AnibNAhj3/Ja48De9hze5mNE7g4ZnFbpcF3Rn5ixYUJZY8b/QSNxOACwi6o
        ikoqZxAhsPFonEB/YDQ3pbRQJLJ9fKAMdIucboRded7CQIULnBdZasHYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Er3Hmi5TJeUs0D80aahpd5IOahIX1qazBhjPJ3/Qn6o=; b=I8rKcqWd
        fkzvYY8sdUThvA8A2aA5CtxFSc0nYiNrnfyP1gJamHGlJ7W/LQyqrzPy76GFZcKk
        s+aNfIgmXQmYZxY9QwRyzt1w7944+cbMQ53l/RQru2Xu0YUPx+ihwgO7GOMA+aUU
        Rer/WmrzBhHyLdJ7f6EQDUfnhjhB6U/0mVU+yB9GZn6r8kWz3W6zoLNnx4ROZQfC
        tvjIizDArfZkEH3ulBUtGiGMxW5OCf9EmGfNnG9EnMY2TFm40O13FTt76CazxUZW
        Y+h0alzQdw8FxA2zqjRlb2vcyoMruYpPbIIWG74Lh6cnmuJILP+ZcJHHc4W2NVwO
        wezDozjoW/57mA==
X-ME-Sender: <xms:F7I2YNytT8WwyDcPcBn7tieITjyYvpNNO1KpcLewXnWqhdGcNtrKuw>
    <xme:F7I2YK2KNJO-AxhA1SEItmu32mSen34PDDN4hEqeQ_ld5zsvmmbTVHHj1ObaXX4qk
    YU3wqLBl7-I7DFcLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    einecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:F7I2YNznIU6pMAGfdHFuxdYyKk9WL4Fe4Gfgkda4d1xp32TYGotOCQ>
    <xmx:F7I2YBE1RIlA3FdMPBBD7dbc0_IQGdXim67fp3n-DPd3YfnMlnbo6A>
    <xmx:F7I2YAY-sbWISPpkt5yFdjrCphJbvHELP6D6mNj4YKdIOMeyaUuxFg>
    <xmx:F7I2YAskeWs68IiwyY_94rvjDkKNWgEUGe8B0r4wrqWWLhyeRgDhtw>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1414108005F;
        Wed, 24 Feb 2021 15:07:50 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] staging: rtl8192e: rename bdHT1R to bd_ht_1r in bss_ht struct
Date:   Sat, 20 Feb 2021 17:29:08 +0000
Message-Id: <20210220172909.15812-13-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220172909.15812-1-will+git@drnd.me>
References: <20210220172909.15812-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename bdHT1R to bd_ht_1r to silence a checkpatch warning about
CamelCase.

Signed-off-by: William Durand <will+git@drnd.me>
---
 drivers/staging/rtl8192e/rtl819x_HT.h | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 0b4ff153fdb6..33a58c87f4c1 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -192,7 +192,7 @@ struct bss_ht {
 	u8					bd_rt2rt_aggregation;
 	u8					bd_rt2rt_long_slot_time;
 	u8					rt2rt_ht_mode;
-	u8					bdHT1R;
+	u8					bd_ht_1r;
 };

 extern u8 MCS_FILTER_ALL[16];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index af93eee57038..b8ab34250e6a 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1860,10 +1860,10 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 		}
 		if (*tmp_htcap_len != 0) {
 			network->bssht.bd_support_ht = true;
-			network->bssht.bdHT1R = ((((struct ht_capab_ele *)(network->bssht.bd_ht_cap_buf))->MCS[1]) == 0);
+			network->bssht.bd_ht_1r = ((((struct ht_capab_ele *)(network->bssht.bd_ht_cap_buf))->MCS[1]) == 0);
 		} else {
 			network->bssht.bd_support_ht = false;
-			network->bssht.bdHT1R = false;
+			network->bssht.bd_ht_1r = false;
 		}
 	}

@@ -2028,7 +2028,7 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
 		memcpy(ht->bd_ht_cap_buf, info_element->data, ht->bd_ht_cap_len);

 		ht->bd_support_ht = true;
-		ht->bdHT1R = ((((struct ht_capab_ele *)
+		ht->bd_ht_1r = ((((struct ht_capab_ele *)
 				ht->bd_ht_cap_buf))->MCS[1]) == 0;

 		ht->bd_bandwidth = (enum ht_channel_width)
@@ -2036,7 +2036,7 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_info_element *info_element,
 					     (ht->bd_ht_cap_buf))->ChlWidth);
 	} else {
 		ht->bd_support_ht = false;
-		ht->bdHT1R = false;
+		ht->bd_ht_1r = false;
 		ht->bd_bandwidth = HT_CHANNEL_WIDTH_20;
 	}
 }
--
2.30.0

