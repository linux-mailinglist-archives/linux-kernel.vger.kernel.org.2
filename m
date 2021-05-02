Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE604370F5E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 23:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhEBVfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 17:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhEBVfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 17:35:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA6C061756
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 14:34:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so3581823wrr.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eT16swlrr7V0yk/vpturYS4zHwpq7otI2bnMDaE41sM=;
        b=NxBuQaEcDi4ylLsQ9QSNzGtAtuFY/hwtIEudKSWa+NHTOG8aFZTQUFmUqWPoPtAruT
         Vw9sLJc1KA8U6g38LNpfFmlc97inKSCB45cXYVJHWy9I9AHOEPknkK0g74kvlBf283eT
         QGEVmncN1hq5CIfct3azBQemO2qdGGWBWNQ1cD+PUk6fC4pdXjpl8jIddVoKDVr48O6v
         Cj+PHIp8yJ8EDTzP6glQq/YFZX9PzlCnk4pBkzeH1wQz9lijLhSbw1hXc0bA8jjkLjs4
         6VIM1UI2sJr+oz1XqNliPsA8R+LeEQrAJ1N+Ygx0R09Z7P33IQM2RvHzeaaVPaxwP0fa
         lp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eT16swlrr7V0yk/vpturYS4zHwpq7otI2bnMDaE41sM=;
        b=S1bxh90lrLGao7iQTlqTtfgrvxw+UlB7g5A7Ee7RYrY6HmofwNt5AjqavVDYNoaSaM
         D5TauYrIb2Hcos3fa3YG3eh2Vq7NaSr/lzGmfiZX4AoMEkJDwdBZCfjZVZV+xS42qElk
         xDBQPBjSNrz3TsgjlWn+GM2v7CKO8fIIfjGCwaSfc/whA6OxBsA0VUGlb1ghC8JiWAP9
         8X/xOpBEwCpPNSGcAs3m7VqebVN3VlppkYZ7dz94Z/NrctVTtrLd+d2NRr8LVE920x0v
         xS5XPImPCnQtlgwNL+p9NrAPWXsXiSocwz5GFo65WW/HbUoKz/ITyCgASKeXafdRgST9
         7ggw==
X-Gm-Message-State: AOAM530jNDQ6YcbFXqMrpwPu5bgS8VRe7qbKP+v1lWxN/Jpv5eAMLai7
        wDjCKxWt9UXog7ZLW7iaimfoCw==
X-Google-Smtp-Source: ABdhPJyRH2xRno0DlqKnCKDhjfE3lqrZ9gPXH3FyXeAsmsI6ojhl3vx4pq8RUq2ht8AXF2UZYztUpQ==
X-Received: by 2002:adf:c587:: with SMTP id m7mr20869861wrg.369.1619991285184;
        Sun, 02 May 2021 14:34:45 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id i11sm10029681wrp.56.2021.05.02.14.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 14:34:44 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, m-karicheri2@ti.com, olteanv@gmail.com,
        george.mccollister@gmail.com, ap420073@gmail.com,
        wanghai38@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: hsr: check skb can contain struct hsr_ethhdr in fill_frame_info
Date:   Sun,  2 May 2021 22:34:42 +0100
Message-Id: <20210502213442.2139-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check at start of fill_frame_info that the MAC header in the supplied
skb is large enough to fit a struct hsr_ethhdr, as otherwise this is
not a valid HSR frame. If it is too small, return an error which will
then cause the callers to clean up the skb. Fixes a KMSAN-found
uninit-value bug reported by syzbot at:
https://syzkaller.appspot.com/bug?id=f7e9b601f1414f814f7602a82b6619a8d80bce3f

Reported-by: syzbot+e267bed19bfc5478fb33@syzkaller.appspotmail.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 net/hsr/hsr_forward.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index ed82a470b6e1..f86cdd83e9a8 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -520,6 +520,10 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 	struct ethhdr *ethhdr;
 	__be16 proto;
 
+	/* Check if skb contains hsr_ethhdr */
+	if (skb->mac_len < sizeof(struct hsr_ethhdr))
+		return -EINVAL;
+
 	memset(frame, 0, sizeof(*frame));
 	frame->is_supervision = is_supervision_frame(port->hsr, skb);
 	frame->node_src = hsr_get_node(port, &hsr->node_db, skb,
-- 
2.30.2

