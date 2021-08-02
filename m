Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E6F3DDE3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhHBRMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHBRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:12:31 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E92C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 10:12:21 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so13349305qvt.20
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jZFzYHXod7OpBLYTKlRMhUmj+6abMSIaNfjrddghXyY=;
        b=uhcjSUqLz/6psUYVI6Jcbm07ZkU/bGiFIckSbfwcpt6KCKtHk2k+NZXns/KacxCTq6
         q+EG73meC5Rd/1kwLkNyBgEcPNXXr8TRP6UFr2xD223Qs+q8107hQK5Hb1SCoxSBz9PR
         ZTmrcQSaGXYBhv5tgHs+43JlVYjWD9XFIeMVO3ytEu+gL2AdO6Q8WlDyuv6VRjDtRuM+
         ZIYWpTKPF2CUiRKJDe+KrtLKZoGoS6e3/HAiRnanK+hYIiMFADKt5V3hslDEtpJk/D6V
         s6G1hhlXlJgYh6mfX6jpo2gC8jJsXvhmRfQyeNy+6CD0XGyXdbERV6iNOgHYPgdzyPX6
         4WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jZFzYHXod7OpBLYTKlRMhUmj+6abMSIaNfjrddghXyY=;
        b=n4hSUJzAFSHOYne1qirlJJj7qArVTE7BAwTN1gMiTZ94zP9vfLxWzpwnqZ1VWtrdoJ
         OfXi+hGo2iw4C3/jINsT/dVucA+20I0LV0nYJUdPQ3/cy2ym+EGiIIeo3UOEJtJ09er+
         nWqi946uS2coP3LQ9xcPNQx8GejZa8Cm4v6WY/7EZGCHq1t615nrD8jyKGtuaVZXCCCD
         513flU4qNK+kPqMm6g3jeesdjsW8/788SEOfF0m0iVVUncXU1lUsAcf5r7SXBhs04OXM
         QsJuT0LBEfOlzZ3UBxyHHg4yUrewLEcbHVpLVAaBdA4v86w8mgbvtbQoaow2GNuBanqb
         Mm4w==
X-Gm-Message-State: AOAM533QVPRNTBSjXwShGYVL5VuPbZD+bqIxzEdBirYq3WkVSUdRrR13
        48RAp7JyHoMDLMExZ9OwjphxSRJV+sdYA7bqNFNOoQ==
X-Google-Smtp-Source: ABdhPJz+49x/XOu51g5xapRbSw4WXzY/gzksEXm1f/yFPCCxyry4k/fhS0t1tZRzhqCwMMNrYzxkRIPVeS3Cyg33Ecf7KA==
X-Received: from mustash.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:337b])
 (user=richardsonnick job=sendgmr) by 2002:a05:6214:1d0a:: with SMTP id
 e10mr2554088qvd.15.1627924340783; Mon, 02 Aug 2021 10:12:20 -0700 (PDT)
Date:   Mon,  2 Aug 2021 17:12:07 +0000
In-Reply-To: <20210802071126.3b311638@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-Id: <20210802171210.2191096-1-richardsonnick@google.com>
Mime-Version: 1.0
References: <20210802071126.3b311638@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2] pktgen: Fix invalid clone_skb override
From:   Nicholas Richardson <richardsonnick@google.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     nrrichar@ncsu.edu, arunkaly@google.com,
        Nick Richardson <richardsonnick@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leesoo Ahn <dev@ooseel.net>, Di Zhu <zhudi21@huawei.com>,
        Yejune Deng <yejune.deng@gmail.com>,
        Ye Bin <yebin10@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Richardson <richardsonnick@google.com>

When the netif_receive xmit_mode is set, a line is supposed to set
clone_skb to a default 0 value. This line is not reached due to a line
that checks if clone_skb is more than zero and returns -ENOTSUPP.

Removes line that defaults clone_skb to zero. -ENOTSUPP is returned
if clone_skb is more than zero. If clone_skb is equal to zero then the
xmit_mode is set to netif_receive as usual and no error is returned.

Signed-off-by: Nick Richardson <richardsonnick@google.com>
---
 net/core/pktgen.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7e258d255e90..314f97acf39d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1190,11 +1190,6 @@ static ssize_t pktgen_if_write(struct file *file,
 			 * pktgen_xmit() is called
 			 */
 			pkt_dev->last_ok = 1;
-
-			/* override clone_skb if user passed default value
-			 * at module loading time
-			 */
-			pkt_dev->clone_skb = 0;
 		} else if (strcmp(f, "queue_xmit") == 0) {
 			pkt_dev->xmit_mode = M_QUEUE_XMIT;
 			pkt_dev->last_ok = 1;
-- 
2.32.0.554.ge1b32706d8-goog

