Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF5440CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 06:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhJaFCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 01:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhJaFCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 01:02:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C35C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 22:00:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u11so29693038lfs.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ac2A+saDFSrL4WFPXx7obgKV7OBZXWGHHh/Jb1Knu3A=;
        b=XgTo86nFEDxuYlBHZ8Ex/lUcNqT+IBUDagTX/h05JsJRbDmf/VD0AxXwlctC8yY7z8
         chpmci1SemrnUVfl5+TYJ0CSxhwqpS9LlVCL+GvnmyYIwUULAU+7Zad2Dmug2kbr3v4k
         z9aciBwNy7leyYcEexhVMZ5SwmfQRPV4YIR92ggSy5wOR2b/GPr886GWNQpHreb42WLc
         22snkjhagk+eVZ+Q+HnukV/oBhOEHtN1qd50nZWbc+VmTMVcaHMkGc8kpw0kfU/junUL
         0fB0ODvHK1NRvN+f+yOJ2R3iUgChJ+H7tx+wAZ8vHtp0oa7haGhsO5wajRozLRr1u0id
         zDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ac2A+saDFSrL4WFPXx7obgKV7OBZXWGHHh/Jb1Knu3A=;
        b=R2/1raJsN/JK00Q10R6FtXfg0pJYMyaKbTM7EurT8DJAx3m8u23of6jFA4La6HLeYo
         a/Am3LPUs5Gkc+TU0BgVVw/BECW9eL2Ia4M2g7nUnmKTP9fNdfbtf/0Pxvi9jrZSkw9e
         jIto2tHNQpMtDoYt5jM+0glugXBYDysOKN84nQqR/uzvF1BU9Fgar5bjHJ/y7n3RLqB+
         GG+bBLjRFOc458YIbnWzxx29mdYADcy1l9U8qLi4gKB8Rp1EaOwIK2kMIsQkTITTIneV
         1OzY28W9EyJF/tSD22EMBw+cnEGP5yqvRgbdCHcq3H5BQ+AMf/wBc3XTuJBS6w2+R+Pu
         00Dg==
X-Gm-Message-State: AOAM530zwiATLIDxobn/+lg7ImIGMNORDzem4OYDa/taB/6ua98gwLj2
        ZBHg7w+y/TCt98OTAhun7LGZqQ==
X-Google-Smtp-Source: ABdhPJz2f0KObqWRUWYzUB5tvEZYrjAQO7kPeBXmXhuNvmt861oIX1XGH/g2l+H77FteOVLvylsvzQ==
X-Received: by 2002:a05:6512:1102:: with SMTP id l2mr20307442lfg.181.1635656409250;
        Sat, 30 Oct 2021 22:00:09 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id v26sm444766lfo.125.2021.10.30.22.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 22:00:08 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
        yan@daynix.com
Subject: [RFC PATCH 2/4] drivers/net/virtio_net: Changed mergeable buffer length calculation.
Date:   Sun, 31 Oct 2021 06:59:57 +0200
Message-Id: <20211031045959.143001-3-andrew@daynix.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211031045959.143001-1-andrew@daynix.com>
References: <20211031045959.143001-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now minimal virtual header length is may include the entire v1 header
if the hash report were populated.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b72b21ac8ebd..abca2e93355d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -393,7 +393,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	hdr_p = p;
 
 	hdr_len = vi->hdr_len;
-	if (vi->mergeable_rx_bufs)
+	if (vi->has_rss_hash_report)
+		hdr_padded_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (vi->mergeable_rx_bufs)
 		hdr_padded_len = sizeof(*hdr);
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
@@ -1252,7 +1254,7 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 					  struct ewma_pkt_len *avg_pkt_len,
 					  unsigned int room)
 {
-	const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	const size_t hdr_len = ((struct virtnet_info *)(rq->vq->vdev->priv))->hdr_len;
 	unsigned int len;
 
 	if (room)
@@ -2817,7 +2819,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
  */
 static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqueue *vq)
 {
-	const unsigned int hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	const unsigned int hdr_len = vi->hdr_len;
 	unsigned int rq_size = virtqueue_get_vring_size(vq);
 	unsigned int packet_len = vi->big_packets ? IP_MAX_MTU : vi->dev->max_mtu;
 	unsigned int buf_len = hdr_len + ETH_HLEN + VLAN_HLEN + packet_len;
-- 
2.33.1

