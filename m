Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82192440CC7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 06:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhJaFCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 01:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhJaFCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 01:02:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7AC061746
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 22:00:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id k13so23728121ljj.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHYmDW4cj0b+fRWrxsqrvdCtE0TQdE4s+Q6FmaiNSFo=;
        b=jGdm0HMDHcggaMA20etNZfrVF20o5nK2DA3HYz/PNoVCj39osaITLJy3tn+/SNXhMW
         lJjnN10zEDklxTMLl3ShHUYptdNCmcR0WCKA59aDM+H+p19MjjQPpCQjsak3RK6Cuaya
         BEqED0slWnrYBzQa43SUW7PaxpVT5OUoJnKlNj1hXlm1Lc1BJvJr8EF0W4/ssZaTaKRu
         DDlyEHNKxs7x3ks2OdqsSR0hYigzzQM7QXe4keUt4hhm3bcyNBWUALAlqKQD1cGTWaGQ
         LJ2dNTyZmTBsWGA8p63AId0hadl0ddQruU0fRm5SA4/gYwMzmR2lADl5I8+ZtakJ21Yv
         hLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHYmDW4cj0b+fRWrxsqrvdCtE0TQdE4s+Q6FmaiNSFo=;
        b=h9yriMzqz9UmRqFcCjjAbNpF8GWwd33iDIxclKnrp+MaIDDr5okiYJWWU9YLp/znA+
         rAFeHxD8w881InI7W8QLATnETbCivvDkFIARxODUSzQ9ircXZWMfNKVnWOP3PfVomwtR
         vql2V7JMaGwCOyPh8Uw50usnpApB9r/IVETtKY5M0i22Ya8g8RrAAGfotGTFsOuUnKXx
         a4vsdrXl+laN36HTBZUuyO4BtSMkmxBUbGp0iibRHecF93nk2sKUuEAIyh+OSNgh88Jt
         Vdbqb/ho48n4klLnfV+hqOr3mx9CpxUfQcpevqh1e6o4cv9YEW7licGCJEk8fRILFR5x
         iovw==
X-Gm-Message-State: AOAM533aMIwXUm2z7TrbDMSBq8ncKz3GuZXyRcUSQgo9ENvjk/IevDS2
        CGzQjLJZcX7fgEp6R93VSo6Eq4uzJQRhQ517
X-Google-Smtp-Source: ABdhPJy51ImB5QnAwuNncoRDWpRUz75eZpfxmMKHik9fgjLWnlVke1HtCOQ2gW3SrAxudUpknxNK+g==
X-Received: by 2002:a2e:a812:: with SMTP id l18mr22358757ljq.487.1635656408266;
        Sat, 30 Oct 2021 22:00:08 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id v26sm444766lfo.125.2021.10.30.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 22:00:07 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
        yan@daynix.com
Subject: [RFC PATCH 1/4] drivers/net/virtio_net: Fixed vheader to use v1.
Date:   Sun, 31 Oct 2021 06:59:56 +0200
Message-Id: <20211031045959.143001-2-andrew@daynix.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211031045959.143001-1-andrew@daynix.com>
References: <20211031045959.143001-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header v1 provides additional info about RSS.
Added changes to computing proper header length.
In the next patches, the header may contain RSS hash info
for the hash population.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4ad25a8b0870..b72b21ac8ebd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -240,13 +240,13 @@ struct virtnet_info {
 };
 
 struct padded_vnet_hdr {
-	struct virtio_net_hdr_mrg_rxbuf hdr;
+	struct virtio_net_hdr_v1_hash hdr;
 	/*
 	 * hdr is in a separate sg buffer, and data sg buffer shares same page
 	 * with this header sg. This padding makes next sg 16 byte aligned
 	 * after the header.
 	 */
-	char padding[4];
+	char padding[12];
 };
 
 static bool is_xdp_frame(void *ptr)
@@ -1636,7 +1636,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	int num_sg;
-	unsigned hdr_len = vi->hdr_len;
+	unsigned int hdr_len = vi->hdr_len;
 	bool can_push;
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
-- 
2.33.1

