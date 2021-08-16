Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941353EDA70
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbhHPQAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbhHPQAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1FCC061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso280565wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaDoZ9cd4wKyWA5vDeDwaFSYNxtnkQxllG5bYdjWghU=;
        b=AsneMQsGmHDfLAmNdQZQnmMVitPkodXnBRlll2SrjwZMaXaCYcAiwGCO9U7xwHloCs
         TEhBAslFZKnvF2sExqgXgFybvpxty8Yt8bmJGmMnvNM63kp+WYDKUNyBc/egfGwkSpFu
         Bh3e09JsKMcYdPEPlCuNHlyLAOUKKpeZQO4Ds0ozgmBQKIPFA2YNKYmAfVSsHqTGKAQo
         nhWyjGUa+gWSrIEUA2Cb79hkjpWmyrFt1kgBf+HBd8p+P8guy2L1ULg7Xsemf1CNY3Gg
         ZUcqEwdH6P/4YjOU5mwI6jcq5UYhYUs0e+dfWaKXrDV4wqMHpmPf9hdWEp3u8+I9LPdp
         nbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaDoZ9cd4wKyWA5vDeDwaFSYNxtnkQxllG5bYdjWghU=;
        b=MzgFSxkCbSEq6vMkIOCxQHvCrxh9fPV0VYjz09yeCxVCd2Y+4J/JQUEJbQUWjfj37P
         74F8oAF/HNk9WrCPmV7gW7Pkc4v9EWMBQ7RQRlSWDRtTKaicYqGXOaVrZIepyENxhwG/
         gZLqwt5s4p3nwHdQtYzfT72gncOA04Z3tgimHlHnJ/PnUslW2w5n735PSx8B9r3bp3Hn
         W0sHn8VIZlIEXlvfkReeaQN9tC/SlA2WIRROVNyBohih9f7P9wi0XFqW1FmEohZmrhsK
         DoUMj8IM3PIMPCe/8OTGjMwWam+o9hPQwOF1PJgemlQpk7s6D7Zqcgtc/9yMXuG5kyhb
         lkIw==
X-Gm-Message-State: AOAM530fkRAcj0vXncZDRJrDYR+JJ2ORsfYzNl40zpqc1OiEBBxOzuY3
        XjHteOZeycBw09I3xLzbBCo=
X-Google-Smtp-Source: ABdhPJyah9bWWxQlTez9zW0AGwpL++GMW2sgv/jRkL3j5QGYfl9SuSimUeFlEdkh8/NpAC8JrGUN1A==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr16077324wmk.51.1629129586277;
        Mon, 16 Aug 2021 08:59:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 23/23] staging: r8188eu: add spaces around operators in core/rtw_br_ext.c
Date:   Mon, 16 Aug 2021 17:58:18 +0200
Message-Id: <20210816155818.24005-24-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces around operators in core/rtw_br_ext.c reported by
chackpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 104 +++++++++++-----------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 8be025992270..dffcad42a0d6 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -89,19 +89,19 @@ static int skb_pull_and_merge(struct sk_buff *skb, unsigned char *src, int len)
 	int tail_len;
 	unsigned long end, tail;
 
-	if ((src+len) > skb_tail_pointer(skb) || skb->len < len)
+	if ((src + len) > skb_tail_pointer(skb) || skb->len < len)
 		return -1;
 
 	tail = (unsigned long)skb_tail_pointer(skb);
-	end = (unsigned long)src+len;
+	end = (unsigned long)src + len;
 	if (tail < end)
 		return -1;
 
-	tail_len = (int)(tail-end);
+	tail_len = (int)(tail - end);
 	if (tail_len > 0)
-		memmove(src, src+len, tail_len);
+		memmove(src, src + len, tail_len);
 
-	skb_trim(skb, skb->len-len);
+	skb_trim(skb, skb->len - len);
 	return 0;
 }
 
@@ -109,7 +109,7 @@ static unsigned long __nat25_timeout(struct adapter *priv)
 {
 	unsigned long timeout;
 
-	timeout = jiffies - NAT25_AGEING_TIME*HZ;
+	timeout = jiffies - NAT25_AGEING_TIME * HZ;
 
 	return timeout;
 }
@@ -129,7 +129,7 @@ static void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr,
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_IPV4;
-	memcpy(networkAddr+7, (unsigned char *)ipAddr, 4);
+	memcpy(networkAddr + 7, (unsigned char *)ipAddr, 4);
 }
 
 static void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
@@ -138,8 +138,8 @@ static void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_PPPOE;
-	memcpy(networkAddr+1, (unsigned char *)sid, 2);
-	memcpy(networkAddr+3, (unsigned char *)ac_mac, 6);
+	memcpy(networkAddr + 1, (unsigned char *)sid, 2);
+	memcpy(networkAddr + 3, (unsigned char *)ac_mac, 6);
 }
 
 static  void __nat25_generate_ipv6_network_addr(unsigned char *networkAddr,
@@ -148,17 +148,17 @@ static  void __nat25_generate_ipv6_network_addr(unsigned char *networkAddr,
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_IPV6;
-	memcpy(networkAddr+1, (unsigned char *)ipAddr, 16);
+	memcpy(networkAddr + 1, (unsigned char *)ipAddr, 16);
 }
 
 static unsigned char *scan_tlv(unsigned char *data, int len, unsigned char tag, unsigned char len8b)
 {
 	while (len > 0) {
-		if (*data == tag && *(data+1) == len8b && len >= len8b*8)
-			return data+2;
+		if (*data == tag && *(data + 1) == len8b && len >= len8b * 8)
+			return data + 2;
 
-		len -= (*(data+1))*8;
-		data += (*(data+1))*8;
+		len -= (*(data + 1)) * 8;
+		data += (*(data + 1)) * 8;
 	}
 	return NULL;
 }
@@ -170,7 +170,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 
 	if (icmphdr->icmp6_type == NDISC_ROUTER_SOLICITATION) {
 		if (len >= 8) {
-			mac = scan_tlv(&data[8], len-8, 1, 1);
+			mac = scan_tlv(&data[8], len - 8, 1, 1);
 			if (mac) {
 				_DEBUG_INFO("Router Solicitation, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
 					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
@@ -181,7 +181,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		}
 	} else if (icmphdr->icmp6_type == NDISC_ROUTER_ADVERTISEMENT) {
 		if (len >= 16) {
-			mac = scan_tlv(&data[16], len-16, 1, 1);
+			mac = scan_tlv(&data[16], len - 16, 1, 1);
 			if (mac) {
 				_DEBUG_INFO("Router Advertisement, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
 					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
@@ -192,7 +192,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		}
 	} else if (icmphdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) {
 		if (len >= 24) {
-			mac = scan_tlv(&data[24], len-24, 1, 1);
+			mac = scan_tlv(&data[24], len - 24, 1, 1);
 			if (mac) {
 				_DEBUG_INFO("Neighbor Solicitation, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
 					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
@@ -203,7 +203,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		}
 	} else if (icmphdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
 		if (len >= 24) {
-			mac = scan_tlv(&data[24], len-24, 2, 1);
+			mac = scan_tlv(&data[24], len - 24, 2, 1);
 			if (mac) {
 				_DEBUG_INFO("Neighbor Advertisement, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
 					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
@@ -214,7 +214,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		}
 	} else if (icmphdr->icmp6_type == NDISC_REDIRECT) {
 		if (len >= 40) {
-			mac = scan_tlv(&data[40], len-40, 2, 1);
+			mac = scan_tlv(&data[40], len - 40, 2, 1);
 			if (mac) {
 				_DEBUG_INFO("Redirect,  replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
 					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
@@ -463,7 +463,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 	if (protocol == ETH_P_IP) {
 		struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
 
-		if (((unsigned char *)(iph) + (iph->ihl<<2)) >= (skb->data + ETH_HLEN + skb->len)) {
+		if (((unsigned char *)(iph) + (iph->ihl << 2)) >= (skb->data + ETH_HLEN + skb->len)) {
 			DEBUG_WARN("NAT25: malformed IP packet !\n");
 			return -1;
 		}
@@ -480,7 +480,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			DEBUG_INFO("NAT25: Insert IP, SA =%08x, DA =%08x\n", tmp, iph->daddr);
 			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
 			/* record source IP address and , source mac address into db */
-			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
+			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
 
 			__nat25_db_print(priv);
 			return 0;
@@ -497,7 +497,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 				} else {
 					/*  forward unknow IP packet to upper TCP/IP */
 					DEBUG_INFO("NAT25: Replace DA with BR's MAC\n");
-					if ((*(u32 *)priv->br_mac) == 0 && (*(u16 *)(priv->br_mac+4)) == 0) {
+					if ((*(u32 *)priv->br_mac) == 0 && (*(u16 *)(priv->br_mac + 4)) == 0) {
 						printk("Re-init netdev_br_init() due to br_mac == 0!\n");
 						netdev_br_init(priv->pnetdev);
 					}
@@ -533,7 +533,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			arp_ptr += arp->ar_hln;
 			sender = (unsigned int *)arp_ptr;
 			__nat25_generate_ipv4_network_addr(networkAddr, sender);
-			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
+			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
 			__nat25_db_print(priv);
 			return 0;
 		case NAT25_LOOKUP:
@@ -578,28 +578,28 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						pOldTag = (struct pppoe_tag *)__nat25_find_pppoe_tag(ph, ntohs(PTT_RELAY_SID));
 						if (pOldTag) { /*  if SID existed, copy old value and delete it */
 							old_tag_len = ntohs(pOldTag->tag_len);
-							if (old_tag_len+TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN > sizeof(tag_buf)) {
+							if (old_tag_len + TAG_HDR_LEN + MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN > sizeof(tag_buf)) {
 								DEBUG_ERR("SID tag length too long!\n");
 								return -1;
 							}
 
-							memcpy(tag->tag_data+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN,
+							memcpy(tag->tag_data + MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN,
 								pOldTag->tag_data, old_tag_len);
 
-							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN+old_tag_len) < 0) {
+							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN + old_tag_len) < 0) {
 								DEBUG_ERR("call skb_pull_and_merge() failed in PADI/R packet!\n");
 								return -1;
 							}
-							ph->length = htons(ntohs(ph->length)-TAG_HDR_LEN-old_tag_len);
+							ph->length = htons(ntohs(ph->length) - TAG_HDR_LEN - old_tag_len);
 						}
 
 						tag->tag_type = PTT_RELAY_SID;
-						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
+						tag->tag_len = htons(MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN + old_tag_len);
 
 						/*  insert the magic_code+client mac in relay tag */
 						pMagic = (unsigned short *)tag->tag_data;
 						*pMagic = htons(MAGIC_CODE);
-						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
+						memcpy(tag->tag_data + MAGIC_CODE_LEN, skb->data + ETH_ALEN, ETH_ALEN);
 
 						/* Add relay tag */
 						if (__nat25_add_pppoe_tag(skb, tag) < 0)
@@ -609,13 +609,13 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 										(ph->code == PADI_CODE ? "PADI" : "PADR"));
 					} else { /*  not add relay tag */
 						if (priv->pppoe_connection_in_progress &&
-								memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))	 {
+								memcmp(skb->data + ETH_ALEN, priv->pppoe_addr, ETH_ALEN)) {
 							DEBUG_ERR("Discard PPPoE packet due to another PPPoE connection is in progress!\n");
 							return -2;
 						}
 
 						if (priv->pppoe_connection_in_progress == 0)
-							memcpy(priv->pppoe_addr, skb->data+ETH_ALEN, ETH_ALEN);
+							memcpy(priv->pppoe_addr, skb->data + ETH_ALEN, ETH_ALEN);
 
 						priv->pppoe_connection_in_progress = WAIT_TIME_PPPOE;
 					}
@@ -627,13 +627,13 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 
 				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &ph->sid);
 
-				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
+				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
 
 				__nat25_db_print(priv);
 
 				if (!priv->ethBrExtInfo.addPPPoETag &&
 				    priv->pppoe_connection_in_progress &&
-				    !memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
+				    !memcmp(skb->data + ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
 					priv->pppoe_connection_in_progress = 0;
 			}
 			return 0;
@@ -655,7 +655,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 					tagType = (unsigned short)((ptr[0] << 8) + ptr[1]);
 					tagLen = (unsigned short)((ptr[2] << 8) + ptr[3]);
 
-					if ((tagType != ntohs(PTT_RELAY_SID)) || (tagLen < (MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN))) {
+					if ((tagType != ntohs(PTT_RELAY_SID)) || (tagLen < (MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN))) {
 						DEBUG_ERR("Invalid PTT_RELAY_SID tag length [%d]!\n", tagLen);
 						return -1;
 					}
@@ -667,18 +667,18 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						return -1;
 					}
 
-					memcpy(skb->data, tag->tag_data+MAGIC_CODE_LEN, ETH_ALEN);
+					memcpy(skb->data, tag->tag_data + MAGIC_CODE_LEN, ETH_ALEN);
 
-					if (tagLen > MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN)
+					if (tagLen > MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN)
 						offset = TAG_HDR_LEN;
 
-					if (skb_pull_and_merge(skb, ptr+offset, TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN-offset) < 0) {
+					if (skb_pull_and_merge(skb, ptr + offset, TAG_HDR_LEN + MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN - offset) < 0) {
 						DEBUG_ERR("call skb_pull_and_merge() failed in PADO packet!\n");
 						return -1;
 					}
-					ph->length = htons(ntohs(ph->length)-(TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN-offset));
+					ph->length = htons(ntohs(ph->length) - (TAG_HDR_LEN + MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN - offset));
 					if (offset > 0)
-						tag->tag_len = htons(tagLen-MAGIC_CODE_LEN-RTL_RELAY_TAG_LEN);
+						tag->tag_len = htons(tagLen - MAGIC_CODE_LEN - RTL_RELAY_TAG_LEN);
 
 					DEBUG_INFO("NAT25: Lookup PPPoE, forward %s Packet from %s\n",
 						(ph->code == PADO_CODE ? "PADO" : "PADS"),	skb->dev->name);
@@ -693,7 +693,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			} else {
 				if (ph->sid != 0) {
 					DEBUG_INFO("NAT25: Lookup PPPoE, lookup session packet from %s\n", skb->dev->name);
-					__nat25_generate_pppoe_network_addr(networkAddr, skb->data+ETH_ALEN, &ph->sid);
+					__nat25_generate_pppoe_network_addr(networkAddr, skb->data + ETH_ALEN, &ph->sid);
 					__nat25_db_network_lookup_and_replace(priv, skb, networkAddr);
 					__nat25_db_print(priv);
 				} else {
@@ -758,7 +758,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 
 			if (memcmp(&iph->saddr, "\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0", 16)) {
 				__nat25_generate_ipv6_network_addr(networkAddr, (unsigned int *)&iph->saddr);
-				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
+				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
 				__nat25_db_print(priv);
 
 				if (iph->nexthdr == IPPROTO_ICMPV6 &&
@@ -801,9 +801,9 @@ int nat25_handle_frame(struct adapter *priv, struct sk_buff *skb)
 		protocol = be16_to_cpu(*((__be16 *)(skb->data + 2 * ETH_ALEN)));
 		if (protocol == ETH_P_8021Q) {
 			is_vlan_tag = 1;
-			vlan_hdr = *((unsigned short *)(skb->data+ETH_ALEN*2+2));
+			vlan_hdr = *((unsigned short *)(skb->data + ETH_ALEN * 2 + 2));
 			for (i = 0; i < 6; i++)
-				*((unsigned short *)(skb->data+ETH_ALEN*2+2-i*2)) = *((unsigned short *)(skb->data+ETH_ALEN*2-2-i*2));
+				*((unsigned short *)(skb->data + ETH_ALEN * 2 + 2 - i * 2)) = *((unsigned short *)(skb->data + ETH_ALEN * 2 - 2 - i * 2));
 			skb_pull(skb, 4);
 		}
 
@@ -815,8 +815,8 @@ int nat25_handle_frame(struct adapter *priv, struct sk_buff *skb)
 			 *	corresponding network protocol is NOT support.
 			 */
 			if (!priv->ethBrExtInfo.nat25sc_disable &&
-			    (be16_to_cpu(*((__be16 *)(skb->data+ETH_ALEN*2))) == ETH_P_IP) &&
-			    !memcmp(priv->scdb_ip, skb->data+ETH_HLEN+16, 4)) {
+			    (be16_to_cpu(*((__be16 *)(skb->data + ETH_ALEN * 2))) == ETH_P_IP) &&
+			    !memcmp(priv->scdb_ip, skb->data + ETH_HLEN + 16, 4)) {
 				memcpy(skb->data, priv->scdb_mac, ETH_ALEN);
 
 				spin_unlock_bh(&priv->br_ext_lock);
@@ -826,10 +826,10 @@ int nat25_handle_frame(struct adapter *priv, struct sk_buff *skb)
 				retval = nat25_db_handle(priv, skb, NAT25_LOOKUP);
 			}
 		} else {
-			if (((be16_to_cpu(*((__be16 *)(skb->data+ETH_ALEN*2))) == ETH_P_IP) &&
-			    !memcmp(priv->br_ip, skb->data+ETH_HLEN+16, 4)) ||
-			    ((be16_to_cpu(*((__be16 *)(skb->data+ETH_ALEN*2))) == ETH_P_ARP) &&
-			    !memcmp(priv->br_ip, skb->data+ETH_HLEN+24, 4))) {
+			if (((be16_to_cpu(*((__be16 *)(skb->data + ETH_ALEN * 2))) == ETH_P_IP) &&
+			    !memcmp(priv->br_ip, skb->data + ETH_HLEN + 16, 4)) ||
+			    ((be16_to_cpu(*((__be16 *)(skb->data + ETH_ALEN * 2))) == ETH_P_ARP) &&
+			    !memcmp(priv->br_ip, skb->data + ETH_HLEN + 24, 4))) {
 				/*  for traffic to upper TCP/IP */
 				retval = nat25_db_handle(priv, skb, NAT25_LOOKUP);
 			}
@@ -838,9 +838,9 @@ int nat25_handle_frame(struct adapter *priv, struct sk_buff *skb)
 		if (is_vlan_tag) {
 			skb_push(skb, 4);
 			for (i = 0; i < 6; i++)
-				*((unsigned short *)(skb->data+i*2)) = *((unsigned short *)(skb->data+4+i*2));
-			*((__be16 *)(skb->data+ETH_ALEN*2)) = __constant_htons(ETH_P_8021Q);
-			*((unsigned short *)(skb->data+ETH_ALEN*2+2)) = vlan_hdr;
+				*((unsigned short *)(skb->data + i * 2)) = *((unsigned short *)(skb->data + 4 + i * 2));
+			*((__be16 *)(skb->data + ETH_ALEN * 2)) = __constant_htons(ETH_P_8021Q);
+			*((unsigned short *)(skb->data + ETH_ALEN * 2 + 2)) = vlan_hdr;
 		}
 
 		if (retval == -1) {
-- 
2.32.0

