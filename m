Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419983E4747
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhHIOOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:14:12 -0400
Received: from mx21.baidu.com ([220.181.3.85]:41056 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233274AbhHIOOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:14:10 -0400
Received: from BJHW-Mail-Ex01.internal.baidu.com (unknown [10.127.64.11])
        by Forcepoint Email with ESMTPS id 3B6D844BDE39BEAF316F;
        Mon,  9 Aug 2021 22:13:47 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 9 Aug 2021 22:13:47 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 9 Aug 2021 22:13:46 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <gregkh@linuxfoundation.org>, <Larry.Finger@lwfinger.net>,
        <phil@philpotter.co.uk>, <fmdefrancesco@gmail.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH] staging: r8188eu: Remove the dependency on ipx network layer
Date:   Mon, 9 Aug 2021 22:13:39 +0800
Message-ID: <20210809141339.2593-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit <47595e32869f> ("<MAINTAINERS: Mark some staging directories>")
indicated the ipx network layer as obsolete in Jan 2018,
updated in the MAINTAINERS file

now, after being exposed for 3 years to refactoring,
so to delete the ipx net layer related code for good.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 173 +++-------------------
 1 file changed, 21 insertions(+), 152 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 8f434768dd15..9076fa06bbd0 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -5,7 +5,6 @@
 
 #include "../include/linux/if_arp.h"
 #include "../include/net/ip.h"
-#include "../include/net/ipx.h"
 #include "../include/linux/atalk.h"
 #include "../include/linux/udp.h"
 #include "../include/linux/if_pppox.h"
@@ -26,7 +25,6 @@
 
 #define NAT25_IPV4		01
 #define NAT25_IPV6		02
-#define NAT25_IPX		03
 #define NAT25_APPLE		04
 #define NAT25_PPPOE		05
 
@@ -42,8 +40,6 @@
 	   0    1    2    3    4    5    6    7    8    9   10
 	|----|----|----|----|----|----|----|----|----|----|----|
   IPv4  |type|                             |      IP addr      |
-  IPX   |type|      Net addr     |          Node addr          |
-  IPX   |type|      Net addr     |Sckt addr|
   Apple |type| Network |node|
   PPPoE |type|   SID   |           AC MAC            |
 -----------------------------------------------------------------*/
@@ -133,40 +129,6 @@ static inline void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr
 	memcpy(networkAddr+7, (unsigned char *)ipAddr, 4);
 }
 
-static inline void __nat25_generate_ipx_network_addr_with_node(unsigned char *networkAddr,
-				__be32 *ipxNetAddr, unsigned char *ipxNodeAddr)
-{
-	union {
-                unsigned int f0;
-                unsigned char f1[IPX_NODE_LEN];
-        } addr;
-
-	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
-
-	networkAddr[0] = NAT25_IPX;
-	addr.f0 = be32_to_cpu(*ipxNetAddr);
-	memcpy(networkAddr+1, addr.f1, 4);
-	memcpy(networkAddr+5, ipxNodeAddr, 6);
-}
-
-static inline void __nat25_generate_ipx_network_addr_with_socket(unsigned char *networkAddr,
-				__be32 *ipxNetAddr, __be16 *ipxSocketAddr)
-{
-	union {
-		unsigned int f0;
-		unsigned char f1[4];
-	} addr;
-
-	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
-
-	networkAddr[0] = NAT25_IPX;
-	addr.f0 = be32_to_cpu(*ipxNetAddr);
-	memcpy(networkAddr+1, addr.f1, 4);
-	addr.f0 ^= addr.f0;
-	addr.f0 = be16_to_cpu(*ipxSocketAddr);
-	memcpy(networkAddr+5, addr.f1, 2);
-}
-
 static inline void __nat25_generate_apple_network_addr(unsigned char *networkAddr,
 				__be16 *network, unsigned char *node)
 {
@@ -291,13 +253,6 @@ static inline int __nat25_network_hash(unsigned char *networkAddr)
 
 		x = networkAddr[7] ^ networkAddr[8] ^ networkAddr[9] ^ networkAddr[10];
 
-		return x & (NAT25_HASH_SIZE - 1);
-	} else if (networkAddr[0] == NAT25_IPX) {
-		unsigned long x;
-
-		x = networkAddr[1] ^ networkAddr[2] ^ networkAddr[3] ^ networkAddr[4] ^ networkAddr[5] ^
-			networkAddr[6] ^ networkAddr[7] ^ networkAddr[8] ^ networkAddr[9] ^ networkAddr[10];
-
 		return x & (NAT25_HASH_SIZE - 1);
 	} else if (networkAddr[0] == NAT25_APPLE) {
 		unsigned long x;
@@ -610,129 +565,43 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		default:
 			return -1;
 		}
-	} else if ((protocol == ETH_P_IPX) ||
-		   (protocol <= ETH_FRAME_LEN)) {
+	} else if (protocol <= ETH_FRAME_LEN) {
 		/*---------------------------------------------------*/
-		/*         Handle IPX and Apple Talk frame           */
+		/*         Handle Apple Talk frame           */
 		/*---------------------------------------------------*/
-		unsigned char ipx_header[2] = {0xFF, 0xFF};
-		struct ipxhdr	*ipx = NULL;
 		struct elapaarp	*ea = NULL;
 		struct ddpehdr	*ddp = NULL;
 		unsigned char *framePtr = skb->data + ETH_HLEN;
 
-		if (protocol == ETH_P_IPX) {
-			DEBUG_INFO("NAT25: Protocol = IPX (Ethernet II)\n");
-			ipx = (struct ipxhdr *)framePtr;
-		} else if (protocol <= ETH_FRAME_LEN) {
-			if (!memcmp(ipx_header, framePtr, 2)) {
-				DEBUG_INFO("NAT25: Protocol = IPX (Ethernet 802.3)\n");
-				ipx = (struct ipxhdr *)framePtr;
-			} else {
-				unsigned char ipx_8022_type =  0xE0;
-				unsigned char snap_8022_type = 0xAA;
+		unsigned char snap_8022_type = 0xAA;
 
-				if (*framePtr == snap_8022_type) {
-					unsigned char ipx_snap_id[5] = {0x0, 0x0, 0x0, 0x81, 0x37};		/*  IPX SNAP ID */
-					unsigned char aarp_snap_id[5] = {0x00, 0x00, 0x00, 0x80, 0xF3};	/*  Apple Talk AARP SNAP ID */
-					unsigned char ddp_snap_id[5] = {0x08, 0x00, 0x07, 0x80, 0x9B};	/*  Apple Talk DDP SNAP ID */
+		if (*framePtr == snap_8022_type) {
+			/*  Apple Talk AARP SNAP ID */
+			unsigned char aarp_snap_id[5] = {0x00, 0x00, 0x00, 0x80, 0xF3};
+			/*  Apple Talk DDP SNAP ID */
+			unsigned char ddp_snap_id[5] = {0x08, 0x00, 0x07, 0x80, 0x9B};
 
-					framePtr += 3;	/*  eliminate the 802.2 header */
+			framePtr += 3;	/*  eliminate the 802.2 header */
 
-					if (!memcmp(ipx_snap_id, framePtr, 5)) {
-						framePtr += 5;	/*  eliminate the SNAP header */
+			if (!memcmp(aarp_snap_id, framePtr, 5)) {
+				framePtr += 5;	/*  eliminate the SNAP header */
 
-						DEBUG_INFO("NAT25: Protocol = IPX (Ethernet SNAP)\n");
-						ipx = (struct ipxhdr *)framePtr;
-					} else if (!memcmp(aarp_snap_id, framePtr, 5)) {
-						framePtr += 5;	/*  eliminate the SNAP header */
+				ea = (struct elapaarp *)framePtr;
+			} else if (!memcmp(ddp_snap_id, framePtr, 5)) {
+				framePtr += 5;	/*  eliminate the SNAP header */
 
-						ea = (struct elapaarp *)framePtr;
-					} else if (!memcmp(ddp_snap_id, framePtr, 5)) {
-						framePtr += 5;	/*  eliminate the SNAP header */
-
-						ddp = (struct ddpehdr *)framePtr;
-					} else {
-						DEBUG_WARN("NAT25: Protocol = Ethernet SNAP %02x%02x%02x%02x%02x\n", framePtr[0],
-							framePtr[1], framePtr[2], framePtr[3], framePtr[4]);
-						return -1;
-					}
-				} else if (*framePtr == ipx_8022_type) {
-					framePtr += 3;	/*  eliminate the 802.2 header */
-
-					if (!memcmp(ipx_header, framePtr, 2)) {
-						DEBUG_INFO("NAT25: Protocol = IPX (Ethernet 802.2)\n");
-						ipx = (struct ipxhdr *)framePtr;
-					} else {
-						return -1;
-					}
-				} else {
-					return -1;
-				}
+				ddp = (struct ddpehdr *)framePtr;
+			} else {
+				DEBUG_WARN("NAT25: Protocol = Ethernet SNAP %02x%02x%02x%02x%02x\n",
+					   framePtr[0], framePtr[1], framePtr[2], framePtr[3],
+					   framePtr[4]);
+				return -1;
 			}
 		} else {
 			return -1;
 		}
 
-		/*   IPX   */
-		if (ipx != NULL) {
-			switch (method) {
-			case NAT25_CHECK:
-				if (!memcmp(skb->data+ETH_ALEN, ipx->ipx_source.node, ETH_ALEN))
-				DEBUG_INFO("NAT25: Check IPX skb_copy\n");
-				return 0;
-			case NAT25_INSERT:
-				DEBUG_INFO("NAT25: Insert IPX, Dest =%08x,%02x%02x%02x%02x%02x%02x,%04x Source =%08x,%02x%02x%02x%02x%02x%02x,%04x\n",
-					ipx->ipx_dest.net,
-					ipx->ipx_dest.node[0],
-					ipx->ipx_dest.node[1],
-					ipx->ipx_dest.node[2],
-					ipx->ipx_dest.node[3],
-					ipx->ipx_dest.node[4],
-					ipx->ipx_dest.node[5],
-					ipx->ipx_dest.sock,
-					ipx->ipx_source.net,
-					ipx->ipx_source.node[0],
-					ipx->ipx_source.node[1],
-					ipx->ipx_source.node[2],
-					ipx->ipx_source.node[3],
-					ipx->ipx_source.node[4],
-					ipx->ipx_source.node[5],
-					ipx->ipx_source.sock);
-
-				if (!memcmp(skb->data+ETH_ALEN, ipx->ipx_source.node, ETH_ALEN)) {
-					DEBUG_INFO("NAT25: Use IPX Net, and Socket as network addr\n");
-
-					__nat25_generate_ipx_network_addr_with_socket(networkAddr, &ipx->ipx_source.net, &ipx->ipx_source.sock);
-
-					/*  change IPX source node addr to wlan STA address */
-					memcpy(ipx->ipx_source.node, GET_MY_HWADDR(priv), ETH_ALEN);
-				} else {
-					__nat25_generate_ipx_network_addr_with_node(networkAddr, &ipx->ipx_source.net, ipx->ipx_source.node);
-				}
-				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
-				__nat25_db_print(priv);
-				return 0;
-			case NAT25_LOOKUP:
-				if (!memcmp(GET_MY_HWADDR(priv), ipx->ipx_dest.node, ETH_ALEN)) {
-					DEBUG_INFO("NAT25: Lookup IPX, Modify Destination IPX Node addr\n");
-
-					__nat25_generate_ipx_network_addr_with_socket(networkAddr, &ipx->ipx_dest.net, &ipx->ipx_dest.sock);
-
-					__nat25_db_network_lookup_and_replace(priv, skb, networkAddr);
-
-					/*  replace IPX destination node addr with Lookup destination MAC addr */
-					memcpy(ipx->ipx_dest.node, skb->data, ETH_ALEN);
-				} else {
-					__nat25_generate_ipx_network_addr_with_node(networkAddr, &ipx->ipx_dest.net, ipx->ipx_dest.node);
-
-					__nat25_db_network_lookup_and_replace(priv, skb, networkAddr);
-				}
-				return 0;
-			default:
-				return -1;
-			}
-		} else if (ea != NULL) {
+		if (ea != NULL) {
 			/* Sanity check fields. */
 			if (ea->hw_len != ETH_ALEN || ea->pa_len != AARP_PA_ALEN) {
 				DEBUG_WARN("NAT25: Appletalk AARP Sanity check fail!\n");
-- 
2.25.1

