Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C9324509
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhBXUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:14:43 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58505 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235461AbhBXUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:10:25 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 357A44D0;
        Wed, 24 Feb 2021 15:07:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Feb 2021 15:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=E/P5gV6zRUBQ4
        rUew5IDSwKzE8wQGU3wXlHM2U9z7ow=; b=DwhbqbjGe1e5kfBJopOJeP+Ej/ACp
        Jw3GSkuWTDM6n5xVt5g1Zdbwog+krvwrfFJOx8UEDbUndy7Y38QGOX+D4xs5jR8k
        xyPKnNTFaWCY6r6vHfXigeRHGd9IMrwLGvm3CST4AOSUAtZEt0sAuG381eXVa9oy
        CYGVrgo+sXzZFblBanRoNktNvfRSaqSCGNtrICIxFK23vh2E48ACE9jlyTYI7Lt5
        iK8bPuvn/xytFSUFABbuX1waPfpOncwz09xCsRGA5xwvK/fHa9Olw16ot0Xcj8Tu
        TA4Kj7BHjgtH5zzJuTSDJuuKHSob1cz5WfuQjHOJ6Q6ae7004LelRZ56Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=E/P5gV6zRUBQ4rUew5IDSwKzE8wQGU3wXlHM2U9z7ow=; b=cMrbh5gV
        ZhVDem+pDusM0l2qIDov+30r2mcmVvPAZVVisHA3kR1i9YKyByNfN1ebdQgSs5xq
        9WOSFNPC5Qi3xbeHGBcYZ1OQ4XwwYQhYoZnzSY48RKvN+vk76T1Qe0GW1+cvM+nO
        k5EfFTrjN7DJa0qyORdO/eyg9kX7HdDNy/Ks9QuMzfOUpsxo01xBIXByjtnF1ao1
        +fGgiqWfuiYYHmCutJQp9me6mMRJ9reCHZLrFmVk/KPucgsn1fmmvCVQbrU0VVO9
        UEZJf5dWbYaflGH7UjQ7Fmv1xSRkUgLl0+atBdLE0l4RdEHbu4l6flzWXwtXvaRL
        czels42QNVN7Mg==
X-ME-Sender: <xms:FLI2YHjFox3NG6TiCPNFvE_E9m85qI3B4IhYRruDtwx02BXIjWO3PA>
    <xme:FLI2YFgOZmKkv_lIgLcBD3xQjlAL5wklPCdCn6Mq_EXvuaik7rmJbqwPm58WyvB8Y
    iI1aO3-56QW_q_g-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:FLI2YHLojFRau8mZcQfPSi-R477nx-KmcYfx7inhYEp3cQZYdncqog>
    <xmx:FLI2YEG-6cEZJINizyHpq1Qa9pgE2dIvOmEBCh8sBnEscM0jkJ1SlQ>
    <xmx:FLI2YLSvmakTZfDh2FBSDkPCzuXmM3M7DjCf7UaVzCpbPs_LXXnyxA>
    <xmx:FLI2YGiYmxFsgINrXt7oh6qx0i0N_dV3d-chh_ZF1IqqSJX8ova99g>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5EB971080059;
        Wed, 24 Feb 2021 15:07:48 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] staging: rtl8192e: rename bdBandWidth to bd_bandwidth in bss_ht struct
Date:   Sat, 20 Feb 2021 17:29:04 +0000
Message-Id: <20210220172909.15812-9-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220172909.15812-1-will+git@drnd.me>
References: <20210220172909.15812-1-will+git@drnd.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename bdBandWidth to bd_bandwidth to silence a checkpatch warning about
CamelCase.

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

