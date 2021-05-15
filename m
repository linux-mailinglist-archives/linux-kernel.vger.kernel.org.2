Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99715381B05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhEOUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 16:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234937AbhEOUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 16:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621111138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RjAWv7j/zHfhk0YuuOMHIejR7YmGA5R8BOsaPxYr0kQ=;
        b=H+lM30IdFBsmZxmzvCwtjhFbXQvBbjoX8mq0tMh86NdA6dCKDgrqv2DiA25kuHfea9ahCX
        PX0iUgOB9IYeruLSAceQPP7Cro7AKxrf/Z7vd4cVQkieNGzg4YWXlra08/V4kVwAKtkXhn
        RqtK4VnKS1ZQDedBuOWDeiR5ToFNNns=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-14wNOyynP9CTk9aF0d1LbQ-1; Sat, 15 May 2021 16:38:54 -0400
X-MC-Unique: 14wNOyynP9CTk9aF0d1LbQ-1
Received: by mail-qv1-f72.google.com with SMTP id b5-20020a0cc9850000b02901eece87073bso479257qvk.21
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 13:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjAWv7j/zHfhk0YuuOMHIejR7YmGA5R8BOsaPxYr0kQ=;
        b=il7Gi8QzwY4EdovjzwH5pml43U1FBEHfYxHMWN04QmAcUiPqf0s7DBcK42DquZ94wc
         BUA6A16yqIhPr+zCmhiK10v5IebEnQB1xXZkshqC9WhzknSqiHprJ29pABDW4ECCwQhI
         9FgpDud78MCFaFNs3yazWE8jM1yJ4Yt9p0+YeIRyymynbESWwcn9xr3QcQKkRfUqmb3q
         8T5xOGl5TXWx9kWTqiXHBUTr09wMK/6RoTfVbTbInBc71KyrlpGoNNERIuUsJaPoTU0P
         tSamdpUSjWYHWEVex5lkCADL5LOUOLJkeFe1gIhDCKYFLjExpPcPL2XdmeaTNzpxksnb
         LKfw==
X-Gm-Message-State: AOAM530BYZeH7Sp6lfzNkgU4XSsmuv8Nj4LKN76SNHN8yDr8bR7G0DX4
        0E/IKmpdZN82fN74qTvcrNkBki+v+KhWnYUPZENEc1zdichu9l7UK5RXJajhDq6cGZcMJ3mNWzz
        vC+YXRhOb63R/c9keK+brW0rA
X-Received: by 2002:a37:ac7:: with SMTP id 190mr48255959qkk.452.1621111134140;
        Sat, 15 May 2021 13:38:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDfCuUeK5i/u8HhHnT8Ny2Fxo8BN52QD/hnQkLJapiZWuY6Bw27qHDHt1LbNXH7Dm/5CMhFg==
X-Received: by 2002:a37:ac7:: with SMTP id 190mr48255944qkk.452.1621111133948;
        Sat, 15 May 2021 13:38:53 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u27sm7379685qku.33.2021.05.15.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 13:38:53 -0700 (PDT)
From:   trix@redhat.com
To:     roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: bridge: fix signature of stub br_multicast_is_router
Date:   Sat, 15 May 2021 13:38:49 -0700
Message-Id: <20210515203849.1756371-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Building with CONFIG_IPV6 off causes this build error

br_input.c:135:8: error: too many arguments to function
  ‘br_multicast_is_router’
        br_multicast_is_router(br, skb)) {
        ^~~~~~~~~~~~~~~~~~~~~~
In file included from net/bridge/br_input.c:23:
net/bridge/br_private.h:1059:20: note: declared here
 static inline bool br_multicast_is_router(struct net_bridge *br)
                    ^~~~~~~~~~~~~~~~~~~~~~

Comparing the stub with the real function shows the stub needs
another parameter.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/bridge/br_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f9a381fcff094..9fd54626ca809 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1056,7 +1056,7 @@ static inline void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 {
 }
 
-static inline bool br_multicast_is_router(struct net_bridge *br)
+static inline bool br_multicast_is_router(struct net_bridge *br, struct sk_buff *skb)
 {
 	return false;
 }
-- 
2.26.3

