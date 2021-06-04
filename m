Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38BA39C0E6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhFDUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhFDUBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:01:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC695C061768
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 12:59:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so13210882ybp.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CrvB+067/I+CxLLg5RI6y2+/auWfNk2l0qpau+BMbco=;
        b=K3j5LwA4O8C/vL99eQGQ0tGLMUIZpSoXyyrsmYczwJFjEtEXne1IRUnR1Tmeecqq3f
         CKDu3ca7OKlE4hozFKVOA2tgtpIW9mwzj+Ykf4tS1w6le5spKOHwnUhciOQXa1LQ+fkD
         Fl7oQg1vxQmJSZDSDjR/62PqI5sGiLG/rjBILcpSeCxjzXIWBdgzlaS/9cRsCerSIS7A
         8C46TVhK+bEMbWW2yVrl4z3hZp01Z9+TNVOxUdnL6btYGTwYDGWoAbaeKRgrx2L4bBkw
         KVPRQNmjxiRdE6ewFIPTop8MTUD86m1zZ9Qt+dR+y7gPhcJKP2WesNdZ3vi8SIJqyEIJ
         usVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CrvB+067/I+CxLLg5RI6y2+/auWfNk2l0qpau+BMbco=;
        b=U4NdjtQ3uUE/YZZsvK+x1Ns3G06/+kdX4rqZM4cn/mNWyAJSCBkWzs/broJ3sM3Jhf
         9Y8GzYN6L+Z18D0tcudBLpDn5jHmZivnvkGz7j1uFLvYIVcGQOLdWQo1pz4C3wcqfACZ
         XC6kli7bRQLpF0ySdvkcPpV71ht+vFlPNwgYxsjS1QMrcdwoxFdNK1VdJ7qn8F2R1HXv
         nysTtLQbEHcGcQ32aPux3jnSjfPUBIrcNcI3P/YAfb3pTIy4J0Xp8UFOd+t/ZT1TmUAV
         HInym/zDF6G8Xh+whCeH7IVt+IwFvpssEff3eaVz46mftFYdzeHRUOshqn4vSiqW1N/L
         0Umw==
X-Gm-Message-State: AOAM533IoHc4sKRj1AIHqpagm0XzScFN7PQnS5S+gvpjiexHjJYAK3Ml
        znaGWfoIVcMY4X/RE7t5HFHlN6m+8LA=
X-Google-Smtp-Source: ABdhPJwRpwAf7i+p+qPOvbpLnxp6faKw5GUkn35qPs//LLow4O922a8pO0+n/57Cx+JXfX6OXE4kFyKGRr4=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:824f:: with SMTP id d15mr7687638ybn.273.1622836755998;
 Fri, 04 Jun 2021 12:59:15 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:54 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-5-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 04/10] block: respect bio_required_sector_alignment() in blk-crypto-fallback
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make blk_crypto_split_bio_if_needed() respect
bio_required_sector_alignment() when calling bio_split(). Without this,
blk-crypto-fallback could possibly split a bio in the middle of a data
unit, and the resulting bios can no longer be encrypted (since encryption
can only be done on complete crypto data units).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-fallback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c322176a1e09..85c813ef670b 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 
+#include "blk.h"
 #include "blk-crypto-internal.h"
 
 static unsigned int num_prealloc_bounce_pg = 32;
@@ -225,6 +226,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
 
+		num_sectors = round_down(num_sectors,
+					 bio_required_sector_alignment(bio));
 		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
 				      &crypto_bio_split);
 		if (!split_bio) {
-- 
2.32.0.rc1.229.g3e70b5a671-goog

