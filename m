Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3D3EDCCB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhHPSGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhHPSGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:06:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15413C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:05:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gt38so12185694ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7OUDigLFUsZqHC4kvxYuv61rT87pgpSVgATSRhFwRI=;
        b=rI1w81YGiE0DQSS5K5gm3Ai7rloEIsbXbu8cHjHzj9UQeO6/1aPf6LtX0Z76xPygAu
         jN5n8+jMneN6WaTMAW/mfwiTRwNd+OxoGczB4MDBsAve8Vyy03JqXG98mvKRC0Wy0ZJq
         ZtT0uX3KgcmhjAkfh5bAdsnV6AdMw9iFBTOQY9QhHmZeGfBRLUQlYgeoDnSAT+ZeeAdT
         /HvP3aN2rY1Ly3/nnEu/fPTQ2xa8zIRbQ1qZzTjAKbPKLj1fvBb0Yl4y3ThHi4a5jPUy
         2JSc4hM3yIP1Bzc+gM3xwy+I2o+tmE6I6njOiDZLuWlNIFsZHr62BHgxddf2qgO7KIXN
         Y1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7OUDigLFUsZqHC4kvxYuv61rT87pgpSVgATSRhFwRI=;
        b=RTvJ3g1P/j5YoYsZ3GJA9fSzcgrS05KlwuZQDKw4KNtTnCGqXf2qyM+j/7/859FRd9
         15+QMI4nVEB/p3bCOMWwvN+CQPj4PIrOm/P2M1Gvz0b9gkioIngJrvzLPi+H5at7KQpT
         t+nIfFvYOEqZcrFk2hj6LTVGgdhZNVEGPLFJw5xecj5ZbwN7WJrj8zr++ltaBz3e8y3d
         4bltyoSKOCninvfINJ1OWKF0S4kMEOVW4CrJep7TPQbTkjbxDG+UPDu1fktPsktHh6U/
         z+M8SNU8OZ3RDW6RFMlQdBy/5mdNAKZ5lG7wqytr/azX6TUZAUON5yEU2tO/E06zoRgx
         iSaQ==
X-Gm-Message-State: AOAM530ytm3+Y6BvOnKK82o+OINMmSZrwR7wuT3GBXC7jsvsc1O8QX5K
        g4AeQit29JX9Hu8pCJQretc=
X-Google-Smtp-Source: ABdhPJxuT6rKxUMB0xSzgIuSVzpBSVZLN4B0H1uvAGV28E8nDl4QGisAqK1NVOjn/MYgbmKkuwMmkA==
X-Received: by 2002:a17:906:5a98:: with SMTP id l24mr16742622ejq.540.1629137143636;
        Mon, 16 Aug 2021 11:05:43 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id c21sm3947402ejz.69.2021.08.16.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 11:05:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 3/3] staging: r8188eu: Remove no more used variable and function
Date:   Mon, 16 Aug 2021 20:05:40 +0200
Message-Id: <20210816180540.29734-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 'sender' pointer to integer. Remove
__nat25_db_network_lookup_and_replace(). Following the deletion of the
code related to the NAT25_LOOKUP method, they are no more needed.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2: Rebased against latest version of Greg K-H's tree.

 drivers/staging/r8188eu/core/rtw_br_ext.c | 52 +----------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 0402f48319c4..ee52f28a1e56 100644
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
@@ -493,7 +443,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		/*---------------------------------------------------*/
 		struct arphdr *arp = (struct arphdr *)(skb->data + ETH_HLEN);
 		unsigned char *arp_ptr = (unsigned char *)(arp + 1);
-		unsigned int *sender, *target;
+		unsigned int *sender;
 
 		if (arp->ar_pro != __constant_htons(ETH_P_IP)) {
 			DEBUG_WARN("NAT25: arp protocol unknown (%4x)!\n", be16_to_cpu(arp->ar_pro));
-- 
2.32.0

