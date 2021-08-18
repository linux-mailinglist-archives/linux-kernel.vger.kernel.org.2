Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0493F0876
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhHRPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbhHRPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:53:17 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F947C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:52:42 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y23so2673705pgi.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7joQz/hOZYHbWQ9qAx5++37t6jQRt6wCbSFQEQk4D+4=;
        b=U4JNeZa2IJQ3lNZ25s0B9ssli4sJSz30z/iSzkApoIxvb0Ne3wwBiGh2rpE/QKtReZ
         ByOzgP6uMZDSkO5k6TwR1IodurtURiC1IiYiC9zswcpBuxY4WxVqrYrNTYoRDpeXDZnX
         KT76J6AXxrUaROmR8MUhVUvIWRSUOqSSXX4UBlCzkPYWyKHXP6TCC5cSvnuOA01nORNW
         qPHExQTNoKYicBYK3ehzKnSLjrsqfPLzlcO8m7phKEmuLGB60nDhBPngSTMEO6bN8/nq
         NcbKf1EmlsC3UdRP8D3JdXCTVydF9HZn0/zsybXf7fNLYgJWxl8dY4MI7YwQX2penW99
         pwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7joQz/hOZYHbWQ9qAx5++37t6jQRt6wCbSFQEQk4D+4=;
        b=hYOjvoDyNklKnw2MwzgU2hNnyErJBARGEozUnXc0QOBAKX1Ssf/Q9IbTMIHhMYeK1W
         bo0PIV35YZJcmylqt98KeEb9vtfmCIuUToTCbd3WhrF/aqeJtJkbZMRo36TfxOhM0WDH
         SORHNiBaUG0f1oLpjyAYnC6AXJUd5B1n3wjKjC5TSzkbRO2M/ez1kHX8qf/iMW9n/HI7
         A3JYAJmm9xCg3QltXXorsC0OK7JYAMAvsWlTFF20vpqPl4vywKWLtgIKFnYDh9UljjL4
         Awu+A6YIBlD/vrHLHMOHHltveMM7ghdQBsKQYafjVff7lj2rsaZfib4/iymCmE57Ogzl
         tD9A==
X-Gm-Message-State: AOAM531i2NvyhHBKV5vK4B6vcb8iIklnM0WLDZpZtVi34p3tteV4002F
        vU7mfUGRFc0/dBZnRupYyYEkZcwMy9v2bA==
X-Google-Smtp-Source: ABdhPJzZ4nccoyG4Ic1nRVbpyrH2juSNM44U7HNyj4JeHDQfXwFXgte8i4EmtUTRRmozJVBYpsQj4Q==
X-Received: by 2002:a63:100e:: with SMTP id f14mr9671256pgl.188.1629301961761;
        Wed, 18 Aug 2021 08:52:41 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id e26sm159272pfj.46.2021.08.18.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:52:41 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] staging: r8188eu: clean up endianness issues
Date:   Wed, 18 Aug 2021 21:22:36 +0530
Message-Id: <8a3fca82d9ec5dde9e42d40f0268a324cc87ebc6.1629301854.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix these sparse warnings:

> rtw_br_ext.c:73:23: warning: restricted __be16 degrades to integer

Here tag->tag_len is be16, use ntohs()

> rtw_br_ext.c:601:57: warning: incorrect type in assignment (different base types)
> rtw_br_ext.c:601:57:    expected unsigned short
> rtw_br_ext.c:601:57:    got restricted __be16 [usertype]

> rtw_br_ext.c:664:45: warning: cast to restricted __be16
> rtw_br_ext.c:771:84: warning: incorrect type in argument 3 (different base types)
> rtw_br_ext.c:771:84:    expected unsigned int [usertype] len

Cast MAGIC_CODE as unsigned short

> rtw_br_ext.c:771:84:    got restricted __be16 [usertype] payload_len
> rtw_br_ext.c:773:110: warning: incorrect type in argument 2 (different base types)
> rtw_br_ext.c:773:110:    expected int len
> rtw_br_ext.c:773:110:    got restricted __be16 [usertype] payload_len

> rtw_br_ext.c:836:54: warning: cast to restricted __be32

Unnecessary double cast?

> rtw_br_ext.c:839:70: warning: restricted __be16 degrades to integer
> rtw_br_ext.c:845:70: warning: invalid assignment: |=
> rtw_br_ext.c:845:70:    left side has type unsigned short
> rtw_br_ext.c:845:70:    right side has type restricted __be16

dhcp->flag is u16

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index e8eea95a52e3..8eb7475726e1 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
 	int data_len;
 
-	data_len = tag->tag_len + TAG_HDR_LEN;
+	data_len = ntohs(tag->tag_len) + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len) {
 		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
 		return -1;
@@ -598,7 +598,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 
 						/*  insert the magic_code+client mac in relay tag */
 						pMagic = (unsigned short *)tag->tag_data;
-						*pMagic = htons(MAGIC_CODE);
+						*pMagic = (unsigned short)MAGIC_CODE;
 						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
 
 						/* Add relay tag */
@@ -661,7 +661,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 					}
 
 					pMagic = (unsigned short *)tag->tag_data;
-					if (ntohs(*pMagic) != MAGIC_CODE) {
+					if (*pMagic != (unsigned short)MAGIC_CODE) {
 						DEBUG_ERR("Can't find MAGIC_CODE in %s packet!\n",
 							(ph->code == PADO_CODE ? "PADO" : "PADS"));
 						return -1;
@@ -768,9 +768,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						struct icmp6hdr  *hdr = (struct icmp6hdr *)(skb->data + ETH_HLEN + sizeof(*iph));
 						hdr->icmp6_cksum = 0;
 						hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
-										iph->payload_len,
+										ntohs(iph->payload_len),
 										IPPROTO_ICMPV6,
-										csum_partial((__u8 *)hdr, iph->payload_len, 0));
+										csum_partial((__u8 *)hdr, ntohs(iph->payload_len), 0));
 					}
 				}
 			}
@@ -833,16 +833,16 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
 					struct dhcpMessage *dhcph =
 						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
-					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
+					u32 cookie = dhcph->cookie;
 
 					if (cookie == DHCP_MAGIC) { /*  match magic word */
-						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
+						if (!(dhcph->flags & BROADCAST_FLAG)) {
 							/*  if not broadcast */
 							register int sum = 0;
 
 							DEBUG_INFO("DHCP: change flag of DHCP request to broadcast.\n");
 							/*  or BROADCAST flag */
-							dhcph->flags |= htons(BROADCAST_FLAG);
+							dhcph->flags |= BROADCAST_FLAG;
 							/*  recalculate checksum */
 							sum = ~(udph->check) & 0xffff;
 							sum += be16_to_cpu(dhcph->flags);

base-commit: cbfa6f33e3a685c329d78e06b0cf1dcb23c9d849
-- 
2.32.0

