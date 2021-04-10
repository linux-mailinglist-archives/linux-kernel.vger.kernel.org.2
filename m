Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D135AC92
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhDJJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbhDJJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:52:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3212C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:51:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a6so7914951wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15ioqRn6Fo545fxwUFF9JCSdykE1utM0Wbzea0PS/lI=;
        b=DUaQJScvbKkaGH6B3Vx4t/g/QjX87xQS1im5Q1eY/4J+pfm+nzXhzwVd/Kz5MFdd/E
         x9VZBDHqFNn/nL4z3vRBGL15J2Df+jmrbo2Iw3GKpKh912OgADO8XpJN+XFjqBQ74cFt
         PV+TrHgaNUxs9hfZnLvibDWaS967mShOaS8q3Rr6oaiCg9UbIWD8PJD8eWyLVGzx/1V4
         fs7e+yQarLPt+CLJo49vIfFsoCX4Kqzz3HDG60Ctjv39rgZk+03IqTpSjwdkERtx8i6z
         PxBcq2MQPqalFbUJPPTCIr8smpsL2XZGrUxVpW6rofuccJy/ABgtrjKUIUt9Tgm2t7oe
         1vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15ioqRn6Fo545fxwUFF9JCSdykE1utM0Wbzea0PS/lI=;
        b=D28YCaz6nptZvkdaharrsGyCIc28wQlxkGGQvPhAj3FxNajuPEKRjaE71OiJpRuK9/
         mQBtpQWZMOux+KIrs7hEI/GJbNGZuaZxpwknex4s5vcpVjBKPua9qzbcNlHxvSR2v0QC
         G9UAaFbXJFy+cByBddiYQ7xtstATOy/zxpq+UOwO/CXLOA+1v65/p+cDZQMU/EOSmdXf
         ip87/LpO3LFaLEGlg56R+BFI32PXmLqrc83u/SPTeSVrWYFbThDPcVlVyZ7Xo7ShmwSQ
         XOTWRqK8VxE7YxsR62soyppwYY6i1KH5Cc7pQ7jHCOzVhujJnx6sX8149/loXBlGhUi/
         4fRw==
X-Gm-Message-State: AOAM531NZJlhAuUpvbQsT23+yIA90rnPoD/knDMI6LwcfSQuNUdyBjBl
        9XpaVd1J4R895fPBDXhmLxZpXw==
X-Google-Smtp-Source: ABdhPJyTN5i5EroR3M7DHUs2wFQPU+62meiESddNXbvdJ4KK8ZR2T41u6Jb6tLz84EyV/EDXId7kbA==
X-Received: by 2002:a5d:5152:: with SMTP id u18mr21196851wrt.289.1618048310745;
        Sat, 10 Apr 2021 02:51:50 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id h9sm7183469wmb.35.2021.04.10.02.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 02:51:50 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, willemb@google.com, linmiaohe@huawei.com,
        edumazet@google.com, linyunsheng@huawei.com, alobakin@pm.me,
        elver@google.com, gnault@redhat.com, dseok.yi@samsung.com,
        viro@zeniv.linux.org.uk, vladimir.oltean@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: core: sk_buff: zero-fill skb->data in __alloc_skb function
Date:   Sat, 10 Apr 2021 10:51:49 +0100
Message-Id: <20210410095149.3708143-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-fill skb->data in __alloc_skb function of net/core/skbuff.c,
up to start of struct skb_shared_info bytes. Fixes a KMSAN-found
uninit-value bug reported by syzbot at:
https://syzkaller.appspot.com/bug?id=abe95dc3e3e9667fc23b8d81f29ecad95c6f106f

Reported-by: syzbot+2e406a9ac75bb71d4b7a@syzkaller.appspotmail.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 785daff48030..9ac26cdb5417 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -215,6 +215,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * to allow max possible filling before reallocation.
 	 */
 	size = SKB_WITH_OVERHEAD(ksize(data));
+	memset(data, 0, size);
 	prefetchw(data + size);
 
 	/*
-- 
2.30.2

