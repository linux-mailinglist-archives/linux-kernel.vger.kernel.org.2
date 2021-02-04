Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DBD30F7FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbhBDQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:31:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238080AbhBDQal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:30:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F4D164F4E;
        Thu,  4 Feb 2021 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612456200;
        bh=5u67ptNkdxaGAQvRlrEAa8lGm8Pk/wldZO7QHXF4NaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HWQ4ciV1H8O/Sga0MqrjJLnXLv+NzHDk61tUdxG6SbWZfEpAFIJjw/A9wgroQBOsM
         bKm4eF+jO2gfUQ30e3PQT72T/RfjnSBiKTJA3eJRRzhllbCx1oYF9bGfSohAqYPGks
         3iqXF9RVep4SmFtrl2YS7vK5LzcNCsLBpV1ipQrVL5aJuqWFG6QggI1aqCWLR8j0K8
         n+fIPNegvOD/QZ4ei3G/t1Hm4+Wt8bZ2VfQtMkCzb/TmcURXSyfTu2mbtoscUUSu7Q
         KvIAd8OwChv6+LjZrdsEJ6BPSPMhJjtHfcJly8ogj4A+Y0utpx7qT5RU79w1zb1L+I
         JPf6eKuK+HqGg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Lukasz Szczesny <luk@wybcz.pl>, Fox Chen <foxhlchen@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove unused structures
Date:   Thu,  4 Feb 2021 17:29:48 +0100
Message-Id: <20210204162956.3276523-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building this with 'make W=1' produces a couple of warnings:

rtl8723bs/include/ieee80211.h:730:1: warning: alignment 1 of 'struct ieee80211_assoc_request_frame' is less than 2 [-Wpacked-not-aligned]
rtl8723bs/include/ieee80211.h:737:1: warning: alignment 1 of 'struct ieee80211_assoc_response_frame' is less than 2 [-Wpacked-not-aligned]

The warnings are in dead code, so just remove the bits that
are obviously broken like this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 79 -------------------
 1 file changed, 79 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index d9ff8c8e7f36..f80db2c984a4 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -667,85 +667,6 @@ struct ieee80211_header_data {
 #define MFIE_TYPE_RATES_EX   50
 #define MFIE_TYPE_GENERIC    221
 
-struct ieee80211_info_element_hdr {
-	u8 id;
-	u8 len;
-} __attribute__ ((packed));
-
-struct ieee80211_info_element {
-	u8 id;
-	u8 len;
-	u8 data[0];
-} __attribute__ ((packed));
-
-/*
- * These are the data types that can make up management packets
- *
-	u16 auth_algorithm;
-	u16 auth_sequence;
-	u16 beacon_interval;
-	u16 capability;
-	u8 current_ap[ETH_ALEN];
-	u16 listen_interval;
-	struct {
-		u16 association_id:14, reserved:2;
-	} __attribute__ ((packed));
-	u32 time_stamp[2];
-	u16 reason;
-	u16 status;
-*/
-
-#define IEEE80211_DEFAULT_TX_ESSID "Penguin"
-#define IEEE80211_DEFAULT_BASIC_RATE 10
-
-
-struct ieee80211_authentication {
-	struct ieee80211_header_data header;
-	u16 algorithm;
-	u16 transaction;
-	u16 status;
-	/* struct ieee80211_info_element_hdr info_element; */
-} __attribute__ ((packed));
-
-
-struct ieee80211_probe_response {
-	struct ieee80211_header_data header;
-	u32 time_stamp[2];
-	u16 beacon_interval;
-	u16 capability;
-	struct ieee80211_info_element info_element;
-} __attribute__ ((packed));
-
-struct ieee80211_probe_request {
-	struct ieee80211_header_data header;
-	/*struct ieee80211_info_element info_element;*/
-} __attribute__ ((packed));
-
-struct ieee80211_assoc_request_frame {
-	struct ieee80211_hdr_3addr header;
-	u16 capability;
-	u16 listen_interval;
-	/* u8 current_ap[ETH_ALEN]; */
-	struct ieee80211_info_element_hdr info_element;
-} __attribute__ ((packed));
-
-struct ieee80211_assoc_response_frame {
-	struct ieee80211_hdr_3addr header;
-	u16 capability;
-	u16 status;
-	u16 aid;
-} __attribute__ ((packed));
-
-struct ieee80211_txb {
-	u8 nr_frags;
-	u8 encrypted;
-	u16 reserved;
-	u16 frag_size;
-	u16 payload_size;
-	struct sk_buff *fragments[0];
-};
-
-
 /* SWEEP TABLE ENTRIES NUMBER*/
 #define MAX_SWEEP_TAB_ENTRIES		  42
 #define MAX_SWEEP_TAB_ENTRIES_PER_PACKET  7
-- 
2.29.2

