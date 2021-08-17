Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1E3EF257
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhHQS6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHQS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:58:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5CEC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:57:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w5so40607669ejq.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2bHROVgowt5nVRnHT+qhR1+7pPv+K83jf/rfH24yXo=;
        b=YfyoHnB0wze25o6HRQ0Avv4+kpd4NvVudO4lMIIUoZRlDjLMER9kY1ppAzVy6IetEs
         +/YdZ3lQarJtwb4LswGPADSfXPcVlCZeQUP9oWkO/YZnIExMnk2qQacE1kHBtvxaL6/T
         6787yXMuCW7HSqz9eXIFfhgq8VeGRCLegA9QsQCysMHwOCNkdhb+NpWbImPuXk+Pd3U5
         39/VKcudowX7aJe0xSAYDpN7wcf5ZZkmqm5TEEAf/O/PKeR5hDYZxaoKrokKgc6Vs/2Y
         ZcBjOE6JueasCxbjYmqfNnHx7ljqfCDljhvDzGRw0OFtY8ATwq7uj0xho845THjfaU4X
         x2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2bHROVgowt5nVRnHT+qhR1+7pPv+K83jf/rfH24yXo=;
        b=i9jo+8EZnQbbmrPj5l04/Ai3ngreHHc84Ngj08O8sOYzfxYt616jvcY1MvHmDAw78F
         D/qIEx1jfpNtMreOz5TwEx3S/Aj/kkyQQNLAzC2+8A6wPQDsdiPLzvyNQsNanJni21vQ
         ZSK0DNRL6lJFqJjJPdgGBoC9M00GGaA/ryHRq5UC9w0pr0hUUm1Bq1Ss9B5tKeQYIOwT
         IwnTdChe4V/FUh7ZpR1U9PP80Tvl0Y1Zy5VvGBFdzzkh7M+Z5+sKWNbf2MtEM5S6cbIq
         iFyRdxbEWxIkrh9K+dgM2FkaV4WaUiFCXx38eu/PSuEAo+aP5+fkcngOej/FzDSA4ftE
         mufw==
X-Gm-Message-State: AOAM533d4r9s0pcXOqVijoTnbTkXZNM1gd0xS4O9nPubRzjKa+Ccsizk
        igzc2ycRk5xXSPf64xoVnU0=
X-Google-Smtp-Source: ABdhPJzx5+JlgnThdnVX0hDL7P1uIBxNjx8EVJs6QKMar+kbfpUcH0XXuZMPOwRfUNAV4gKDzw+l8w==
X-Received: by 2002:a17:906:4a48:: with SMTP id a8mr5442926ejv.524.1629226647327;
        Tue, 17 Aug 2021 11:57:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id i6sm1459480edt.28.2021.08.17.11.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:57:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] staging: r8188eu: Remove code depending on NAT25_LOOKUP
Date:   Tue, 17 Aug 2021 20:57:23 +0200
Message-Id: <20210817185723.15192-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the code related to the management of the NAT25_LOOKUP
method in nat25_db_handle(). The only function that used that method was
the now deleted nat25_handle_frame(). Remove the NAT25_LOOKUP entry from
the NAT25_METHOD enum because it is not anymore used everywhere else in
the code of the driver.

Remove the 'sender' pointer to integer. Remove
__nat25_db_network_lookup_and_replace(). Following the deletion of the
code related to the NAT25_LOOKUP method, they are no more needed.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2->v3: Merged "[PATCH v2 2/3] staging: r8188eu: Remove code depending 
on NAT25_LOOKUP" and "[PATCH v2 3/3] staging: r8188eu: Remove no more 
used variable and function]" into one single patch. Asked by Greg K-H
because 2/3 introduced some intermediate build warnings that are then
fixed by 3/3. Adding build warnings, even within a series that fixes
them with following patches, is not allowed. For the above-mentioned
reasons I chose to drop the numbering of the patch in the series, 
first because now it is self-contained, second because neither 2/3 
or 2/2 would be anymore appropriate.

v1->v2: Patch rebased against the latest Greg K-H's tree.

 drivers/staging/r8188eu/core/rtw_br_ext.c    | 164 +------------------
 drivers/staging/r8188eu/include/rtw_br_ext.h |   1 -
 2 files changed, 1 insertion(+), 164 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index e8eea95a52e3..ee52f28a1e56 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -295,56 +295,6 @@ static void __network_hash_unlink(struct nat25_network_db_entry *ent)
 	ent->pprev_hash = NULL;
 }
 
-static int __nat25_db_network_lookup_and_replace(struct adapter *priv,
-				struct sk_buff *skb, unsigned char *networkAddr)
-{
-	struct nat25_network_db_entry *db;
-
-	spin_lock_bh(&priv->br_ext_lock);
-
-	db = priv->nethash[__nat25_network_hash(networkAddr)];
-	while (db) {
-		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
-			if (!__nat25_has_expired(priv, db)) {
-				/*  replace the destination mac address */
-				memcpy(skb->data, db->macAddr, ETH_ALEN);
-				atomic_inc(&db->use_count);
-
-				DEBUG_INFO("NAT25: Lookup M:%02x%02x%02x%02x%02x%02x N:%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
-							"%02x%02x%02x%02x%02x%02x\n",
-					db->macAddr[0],
-					db->macAddr[1],
-					db->macAddr[2],
-					db->macAddr[3],
-					db->macAddr[4],
-					db->macAddr[5],
-					db->networkAddr[0],
-					db->networkAddr[1],
-					db->networkAddr[2],
-					db->networkAddr[3],
-					db->networkAddr[4],
-					db->networkAddr[5],
-					db->networkAddr[6],
-					db->networkAddr[7],
-					db->networkAddr[8],
-					db->networkAddr[9],
-					db->networkAddr[10],
-					db->networkAddr[11],
-					db->networkAddr[12],
-					db->networkAddr[13],
-					db->networkAddr[14],
-					db->networkAddr[15],
-					db->networkAddr[16]);
-			}
-			spin_unlock_bh(&priv->br_ext_lock);
-			return 1;
-		}
-		db = db->next_hash;
-	}
-	spin_unlock_bh(&priv->br_ext_lock);
-	return 0;
-}
-
 static void __nat25_db_network_insert(struct adapter *priv,
 				unsigned char *macAddr, unsigned char *networkAddr)
 {
@@ -484,27 +434,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 
 			__nat25_db_print(priv);
 			return 0;
-		case NAT25_LOOKUP:
-			DEBUG_INFO("NAT25: Lookup IP, SA =%08x, DA =%08x\n", iph->saddr, iph->daddr);
-			tmp = be32_to_cpu(iph->daddr);
-			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
-
-			if (!__nat25_db_network_lookup_and_replace(priv, skb, networkAddr)) {
-				if (*((unsigned char *)&iph->daddr + 3) == 0xff) {
-					/*  L2 is unicast but L3 is broadcast, make L2 bacome broadcast */
-					DEBUG_INFO("NAT25: Set DA as boardcast\n");
-					memset(skb->data, 0xff, ETH_ALEN);
-				} else {
-					/*  forward unknow IP packet to upper TCP/IP */
-					DEBUG_INFO("NAT25: Replace DA with BR's MAC\n");
-					if ((*(u32 *)priv->br_mac) == 0 && (*(u16 *)(priv->br_mac+4)) == 0) {
-						printk("Re-init netdev_br_init() due to br_mac == 0!\n");
-						netdev_br_init(priv->pnetdev);
-					}
-					memcpy(skb->data, priv->br_mac, ETH_ALEN);
-				}
-			}
-			return 0;
 		default:
 			return -1;
 		}
@@ -514,7 +443,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		/*---------------------------------------------------*/
 		struct arphdr *arp = (struct arphdr *)(skb->data + ETH_HLEN);
 		unsigned char *arp_ptr = (unsigned char *)(arp + 1);
-		unsigned int *sender, *target;
+		unsigned int *sender;
 
 		if (arp->ar_pro != __constant_htons(ETH_P_IP)) {
 			DEBUG_WARN("NAT25: arp protocol unknown (%4x)!\n", be16_to_cpu(arp->ar_pro));
@@ -536,20 +465,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
 			__nat25_db_print(priv);
 			return 0;
-		case NAT25_LOOKUP:
-			DEBUG_INFO("NAT25: Lookup ARP\n");
-
-			arp_ptr += arp->ar_hln;
-			sender = (unsigned int *)arp_ptr;
-			arp_ptr += (arp->ar_hln + arp->ar_pln);
-			target = (unsigned int *)arp_ptr;
-			__nat25_generate_ipv4_network_addr(networkAddr, target);
-			__nat25_db_network_lookup_and_replace(priv, skb, networkAddr);
-			/*  change to ARP target mac address to Lookup result */
-			arp_ptr = (unsigned char *)(arp + 1);
-			arp_ptr += (arp->ar_hln + arp->ar_pln);
-			memcpy(arp_ptr, skb->data, ETH_ALEN);
-			return 0;
 		default:
 			return -1;
 		}
@@ -637,70 +552,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 					priv->pppoe_connection_in_progress = 0;
 			}
 			return 0;
-		case NAT25_LOOKUP:
-			if (ph->code == PADO_CODE || ph->code == PADS_CODE) {
-				if (priv->ethBrExtInfo.addPPPoETag) {
-					struct pppoe_tag *tag;
-					unsigned char *ptr;
-					unsigned short tagType, tagLen;
-					int offset = 0;
-
-					ptr = __nat25_find_pppoe_tag(ph, ntohs(PTT_RELAY_SID));
-					if (!ptr) {
-						DEBUG_ERR("Fail to find PTT_RELAY_SID in FADO!\n");
-						return -1;
-					}
-
-					tag = (struct pppoe_tag *)ptr;
-					tagType = (unsigned short)((ptr[0] << 8) + ptr[1]);
-					tagLen = (unsigned short)((ptr[2] << 8) + ptr[3]);
-
-					if ((tagType != ntohs(PTT_RELAY_SID)) || (tagLen < (MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN))) {
-						DEBUG_ERR("Invalid PTT_RELAY_SID tag length [%d]!\n", tagLen);
-						return -1;
-					}
-
-					pMagic = (unsigned short *)tag->tag_data;
-					if (ntohs(*pMagic) != MAGIC_CODE) {
-						DEBUG_ERR("Can't find MAGIC_CODE in %s packet!\n",
-							(ph->code == PADO_CODE ? "PADO" : "PADS"));
-						return -1;
-					}
-
-					memcpy(skb->data, tag->tag_data+MAGIC_CODE_LEN, ETH_ALEN);
-
-					if (tagLen > MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN)
-						offset = TAG_HDR_LEN;
-
-					if (skb_pull_and_merge(skb, ptr+offset, TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN-offset) < 0) {
-						DEBUG_ERR("call skb_pull_and_merge() failed in PADO packet!\n");
-						return -1;
-					}
-					ph->length = htons(ntohs(ph->length)-(TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN-offset));
-					if (offset > 0)
-						tag->tag_len = htons(tagLen-MAGIC_CODE_LEN-RTL_RELAY_TAG_LEN);
-
-					DEBUG_INFO("NAT25: Lookup PPPoE, forward %s Packet from %s\n",
-						(ph->code == PADO_CODE ? "PADO" : "PADS"),	skb->dev->name);
-				} else { /*  not add relay tag */
-					if (!priv->pppoe_connection_in_progress) {
-						DEBUG_ERR("Discard PPPoE packet due to no connection in progresss!\n");
-						return -1;
-					}
-					memcpy(skb->data, priv->pppoe_addr, ETH_ALEN);
-					priv->pppoe_connection_in_progress = WAIT_TIME_PPPOE;
-				}
-			} else {
-				if (ph->sid != 0) {
-					DEBUG_INFO("NAT25: Lookup PPPoE, lookup session packet from %s\n", skb->dev->name);
-					__nat25_generate_pppoe_network_addr(networkAddr, skb->data+ETH_ALEN, &ph->sid);
-					__nat25_db_network_lookup_and_replace(priv, skb, networkAddr);
-					__nat25_db_print(priv);
-				} else {
-					return -1;
-				}
-			}
-			return 0;
 		default:
 			return -1;
 		}
@@ -713,8 +564,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			return -1;
 		case NAT25_INSERT:
 			return 0;
-		case NAT25_LOOKUP:
-			return 0;
 		default:
 			return -1;
 		}
@@ -727,8 +576,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			return -1;
 		case NAT25_INSERT:
 			return 0;
-		case NAT25_LOOKUP:
-			return 0;
 		default:
 			return -1;
 		}
@@ -775,15 +622,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 				}
 			}
 			return 0;
-		case NAT25_LOOKUP:
-			DEBUG_INFO("NAT25: Lookup IP, SA =%4x:%4x:%4x:%4x:%4x:%4x:%4x:%4x, DA =%4x:%4x:%4x:%4x:%4x:%4x:%4x:%4x\n",
-				   iph->saddr.s6_addr16[0], iph->saddr.s6_addr16[1], iph->saddr.s6_addr16[2], iph->saddr.s6_addr16[3],
-				   iph->saddr.s6_addr16[4], iph->saddr.s6_addr16[5], iph->saddr.s6_addr16[6], iph->saddr.s6_addr16[7],
-				   iph->daddr.s6_addr16[0], iph->daddr.s6_addr16[1], iph->daddr.s6_addr16[2], iph->daddr.s6_addr16[3],
-				   iph->daddr.s6_addr16[4], iph->daddr.s6_addr16[5], iph->daddr.s6_addr16[6], iph->daddr.s6_addr16[7]);
-			__nat25_generate_ipv6_network_addr(networkAddr, (unsigned int *)&iph->daddr);
-			__nat25_db_network_lookup_and_replace(priv, skb, networkAddr);
-			return 0;
 		default:
 			return -1;
 		}
diff --git a/drivers/staging/r8188eu/include/rtw_br_ext.h b/drivers/staging/r8188eu/include/rtw_br_ext.h
index 00d461c4c6fa..69905d30c191 100644
--- a/drivers/staging/r8188eu/include/rtw_br_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_br_ext.h
@@ -31,7 +31,6 @@ enum NAT25_METHOD {
 	NAT25_MIN,
 	NAT25_CHECK,
 	NAT25_INSERT,
-	NAT25_LOOKUP,
 	NAT25_PARSE,
 	NAT25_MAX
 };
-- 
2.32.0

