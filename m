Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE83EDC99
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhHPRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhHPRwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:52:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82773C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:51:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bo19so27656852edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQoek14OE4uQnpIv9Staft1AveAvACmD1pzwivfSdt0=;
        b=muXE14NSR2ajfttLttLt23nSwQdB/NjuGaDQDIGELGWI5dm5azHDDZ+MwxZSzSMTro
         VuXk5+H3yk8DknKzfRUleI9CcvkkL9Y+c7hl0yfDFiwSPLvoxFDVEPRZ4spkuwu7pLJi
         24NbedKuHD4FSohpnGwUgCYLp9j2WHZOD3RYtP4fPSZCjPT1m1FsYGD3ByvV/ZtcAO4F
         U3H0/6lWRzGL+8iuHXLo4TPnfj97L0RdgQytQEsz57Aaay7ocSBNd044pkJfXO0LsDIt
         jrcCaXrrfVc0+/vKPL/jAB7tRmkRHg4vS/io6F2lHtBilrJQN0TyZAF3nAAVXjarXGGx
         VhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQoek14OE4uQnpIv9Staft1AveAvACmD1pzwivfSdt0=;
        b=j8gVF16mo5J7+pLKryV7zySL92H3Z8icZj/i8O6iaP23Hi7C6Kl1Z0GiHs8o6m1JHt
         ZoSvIG6Qv7GcILtp4xk3Ks5LEHMx0q+mPYF/5MWvu5EEElXnsaJj1yk8tr6AXBAtobD1
         JHCmvk1/qOL6RWqNPTS4Ul3X2YrGIpkPwFukBu26Jz6J9e5DWz2oh//F/ODcqeSLY1Z0
         iPjFHXDQmViD7rV5UiIHX6Jt9zI0vG/KRjvacJmaUsrWpjFJ/iNlwmTsJE3hczR14BOd
         Ngh6NsABldvMKcwM2gE5hspsFnvc6ZeLaZi1QDuUee3XSilEYtWwF7O1YfL5c0v6SZWX
         UwBg==
X-Gm-Message-State: AOAM532WznSQoUmEHNGQNg7/789B0eJXDbCphAPPy962MfxQyN/okkCX
        xOhKGjEb36CyfQkLQJ5NPNs=
X-Google-Smtp-Source: ABdhPJw+y4UCCl9Qy2EGsLwyz3bQonhm12710XsPLFFcjV/6GBfwS5lIKqoZh+2xRfcPAj4vKNB+PA==
X-Received: by 2002:a05:6402:518f:: with SMTP id q15mr21709998edd.226.1629136303114;
        Mon, 16 Aug 2021 10:51:43 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id w13sm5319361ede.24.2021.08.16.10.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:51:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 2/3] staging: r8188eu: Remove code depending on NAT25_LOOKUP
Date:   Mon, 16 Aug 2021 19:51:38 +0200
Message-Id: <20210816175138.21633-1-fmdefrancesco@gmail.com>
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

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2: Patch rebased against the latest Greg K-H's tree.

 drivers/staging/r8188eu/core/rtw_br_ext.c    | 112 -------------------
 drivers/staging/r8188eu/include/rtw_br_ext.h |   1 -
 2 files changed, 113 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index e8eea95a52e3..0402f48319c4 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -484,27 +484,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 
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
@@ -536,20 +515,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
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
@@ -637,70 +602,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
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
@@ -713,8 +614,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			return -1;
 		case NAT25_INSERT:
 			return 0;
-		case NAT25_LOOKUP:
-			return 0;
 		default:
 			return -1;
 		}
@@ -727,8 +626,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			return -1;
 		case NAT25_INSERT:
 			return 0;
-		case NAT25_LOOKUP:
-			return 0;
 		default:
 			return -1;
 		}
@@ -775,15 +672,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
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

