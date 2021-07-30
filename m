Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6443DBE2D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhG3SPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhG3SPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:15:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C87FC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:14:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so14394710ede.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLzGmg23wIZLMApLuoWPPi+Aep//XD12yszpCHUj1tU=;
        b=dtilBrvGD4Paiw5gtN95xp+rtU8nDFhHQEQh9n8pNS7e0IRW05ywg0na2P1Gw0MpDO
         MMw1ba8EPu1FCEvBUY3RIO8oZGf57gmSV89cR+S3wroFGPgd4nvu2wU+l5RrXtBgtI9K
         zaeAV+AJqrbhoiydjFA3qn+V4Bm4E3bHEJ/1MMZ520zgCzsno6fLb/MFcqEcqw1h5DJY
         iAsTxROnNdA1APDuuNccrzgSpVRJeO73QbNUYgBk8bAZzgMcC5X5DbhS1DheWpW2Op4w
         xy4eQUZnkCOWJ48ZdqBEs2X4E4iUyhka7osiqGLSnWCbZEQ2VvU4g2as2zMFIQPN4Qm/
         ec5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLzGmg23wIZLMApLuoWPPi+Aep//XD12yszpCHUj1tU=;
        b=PL4ZnbuG8AeFc4rRxxQCnJJan9dVYX9nqVspRcUYH8H/XOoeEYfE6WVqENSauF563w
         8UTZ9FrvZ2oQUQYWxTbQ5geWaQTU4QXCY4tvp4aTGItEaY7lMl6vz/1UBIT4a4IJhgPv
         mU099cdrt9K/hfDbYdF/knC3wV2/XLxE28xYBHMggbp6PlpdAbha25+YOXNXPGM5YqZ3
         kJ3ci4aiDZ06tB71595uRWJzGeYJ4IqrEaXV9Kwoy0kTQgSxhvMwO4Izc2Bj0lk0lKsX
         /NRq8au0XfNx9IsyLZSywbQ8Qjvbgynpo9F8XblOp0jRT5HnJ0o1OVp3EUvjzsYbPw9i
         OpaQ==
X-Gm-Message-State: AOAM530GBcIQLVP9HsNrIbnJxvgFjhiegBGO+6tDdAUnvF8vcYGemdGY
        HMveZpZfyICqrdKUIvTKzKg=
X-Google-Smtp-Source: ABdhPJxx5K1MTv2lyaSEQT9WQlWlEBXpUucttGaqcRBZ299ooz10Gy3aZl6zE+A+dVc3BcOsdMHPeA==
X-Received: by 2002:a05:6402:280e:: with SMTP id h14mr4403812ede.187.1627668896126;
        Fri, 30 Jul 2021 11:14:56 -0700 (PDT)
Received: from localhost.localdomain (host-79-26-32-124.retail.telecomitalia.it. [79.26.32.124])
        by smtp.gmail.com with ESMTPSA id a35sm1036984edf.80.2021.07.30.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 11:14:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Fix different base types in assignments and parameters
Date:   Fri, 30 Jul 2021 20:14:52 +0200
Message-Id: <20210730181452.23062-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings of different base types in assignments
and in passing function parameters.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 46 ++++++++++++++++++-----
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index e00302137a60..31ca2e548555 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -71,7 +71,7 @@ static inline int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *t
 	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
 	int data_len;
 
-	data_len = tag->tag_len + TAG_HDR_LEN;
+	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len) {
 		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
 		return -1;
@@ -134,42 +134,68 @@ static inline void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr
 }
 
 static inline void __nat25_generate_ipx_network_addr_with_node(unsigned char *networkAddr,
-				unsigned int *ipxNetAddr, unsigned char *ipxNodeAddr)
+				__be32 *ipxNetAddr, unsigned char *ipxNodeAddr)
 {
+	union {
+                unsigned int f0;
+                unsigned char f1[IPX_NODE_LEN];
+        } addr;
+
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_IPX;
-	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
+	addr.f0 = be32_to_cpu(*ipxNetAddr);
+	memcpy(networkAddr+1, addr.f1, 4);
 	memcpy(networkAddr+5, ipxNodeAddr, 6);
 }
 
 static inline void __nat25_generate_ipx_network_addr_with_socket(unsigned char *networkAddr,
-				unsigned int *ipxNetAddr, unsigned short *ipxSocketAddr)
+				__be32 *ipxNetAddr, __be16 *ipxSocketAddr)
 {
+	union {
+		unsigned int f0;
+		unsigned char f1[4];
+	} addr;
+
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_IPX;
-	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
-	memcpy(networkAddr+5, (unsigned char *)ipxSocketAddr, 2);
+	addr.f0 = be32_to_cpu(*ipxNetAddr);
+	memcpy(networkAddr+1, addr.f1, 4);
+	addr.f0 ^= addr.f0;
+	addr.f0 = be16_to_cpu(*ipxSocketAddr);
+	memcpy(networkAddr+5, addr.f1, 2);
 }
 
 static inline void __nat25_generate_apple_network_addr(unsigned char *networkAddr,
-				unsigned short *network, unsigned char *node)
+				__be16 *network, unsigned char *node)
 {
+	union {
+                unsigned short f0;
+                unsigned char f1[2];
+        } addr;
+
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_APPLE;
-	memcpy(networkAddr+1, (unsigned char *)network, 2);
+	addr.f0 = be16_to_cpu(*network);
+	memcpy(networkAddr+1, addr.f1, 2);
 	networkAddr[3] = *node;
 }
 
 static inline void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
-				unsigned char *ac_mac, unsigned short *sid)
+				unsigned char *ac_mac, __be16 *sid)
 {
+	union {
+                unsigned short f0;
+                unsigned char f1[2];
+        } addr;
+
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_PPPOE;
-	memcpy(networkAddr+1, (unsigned char *)sid, 2);
+	addr.f0 = be16_to_cpu(*sid);
+	memcpy(networkAddr+1, addr.f1, 2);
 	memcpy(networkAddr+3, (unsigned char *)ac_mac, 6);
 }
 
-- 
2.32.0

