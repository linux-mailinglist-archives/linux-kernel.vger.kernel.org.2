Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3764323279
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhBWUvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:51:33 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:55055 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233818AbhBWUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:49:28 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AE81DAFC;
        Tue, 23 Feb 2021 15:47:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Feb 2021 15:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=doruJhczG0yJ4
        EN8JQu3N66tK/shwjEF6ktp55ZkXOM=; b=LW7dQJvTCpEyDG1scV+oj2S07g0/9
        /0iXd4DwpKRewI8+DChUJzursfNOHANySUmHmHcvDk6/KvT6d2WrJAqTVX/UEbTO
        qVTctUyQIYSNUOA5y/fpQ2t9xIWX+bcSkCEJb1h7BINnDAY5KuwaarbKetjcZkWM
        Hqlf5mSP6zIV2A5/bc6dDdd3W2RrqRcpCcXBy6PM+wQMaWoDaH+XdHNQoTjJeVRq
        o27/Kg9zsFxDPcmw/ZrMtIl/GgJzxnGRBxStKN4cDMRqI+0f2zdLURwZWfc0gaXv
        2APRevw+Zgg646T/H3zApeGL/7XNP9x1x5Azz6rVT3EtFgqdzCuFHbuPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=doruJhczG0yJ4EN8JQu3N66tK/shwjEF6ktp55ZkXOM=; b=O7X2YT1U
        GcMNQBfJXxgkrl9vamyrvh7hoQlro7WgFCl9GYCP1PvsdvUePKUY7bhnH0jaReXL
        qiuhocp+yHPoyqHy7PFxQ8gabJjOdCfZzRjNUvzP4uKXHRjyo9PCZkD5QpDzAwt1
        iObbsmmYSWP4IXnl/Vgfl/d7d+astDqm/sj7vMGD2SkVggJdLWL1Ekq6x17HaKvd
        XuYzI5lfm7Ln2csUG1uA5XOWfNIYYnryMGIPuzVnXDnXlqwIKSlvdaYWNKUj0CmB
        g5M6++JLmqbl03C+H7cY7pb5KVLoI0ezhAb2NU32qjDkfupODa4GzT3tG0LHKtpO
        AMda+DlKHDERBQ==
X-ME-Sender: <xms:6Wk1YI4W4nYPxbwYWWtSeuWCr0rJBcNPv-vFQE775uNAO7MuN4dRRA>
    <xme:6Wk1YNI27eF2ReM0bez-TSlJT0-dBBT_lXWIKp2UVVFa5WNnvY-b4KJhXSScuCclD
    pKfEMPu9_Y5L6xV6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhi
    rghmucffuhhrrghnugcuoeifihhllhdoghhithesughrnhgurdhmvgeqnecuggftrfgrth
    htvghrnhepjedvgeffieeivdefleekvddvudffvefhiefgueeujedvgfegfeelkeduffel
    ffefnecukfhppedvudejrddvfeekrddvtdekrdejgeenucevlhhushhtvghrufhiiigvpe
    ehnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:6Wk1YA6Ho9-_NG1wkf1C-lbC3h4edd_MNsNZrfY_H6xteG15XMhdJA>
    <xmx:6Wk1YIyQQDOkZNATG-_FtlCBQtuzgFYLWNCfou4aJwuvkulLvrzlgw>
    <xmx:6Wk1YMbU_If7O8Ggef1aJzl7isad5p9UWTOtA9waZ6KGIxDSBu-9Ew>
    <xmx:6Wk1YLCtNHT1jTpGKRpKul8WVWAs_-MruQCvtxEzLDMCKqlKGtPSkA>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id D0AD7240062;
        Tue, 23 Feb 2021 15:47:36 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] staging: rtl8192e: reformat bss_ht struct
Date:   Sat, 20 Feb 2021 15:54:17 +0000
Message-Id: <20210220155418.12282-14-will+git@drnd.me>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220155418.12282-1-will+git@drnd.me>
References: <20210220155418.12282-1-will+git@drnd.me>
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

