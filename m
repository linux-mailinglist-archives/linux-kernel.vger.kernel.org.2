Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D239C0F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFDUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:02:10 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:50944 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhFDUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:02:01 -0400
Received: by mail-yb1-f201.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so13209745ybp.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R3HMBFHospGnC9Opd1R53FLCvcJarpfKxQXd852tZKY=;
        b=o/e7RzBLKivm9MR0djmqRPiA7UqgFavlq7CZ6C7ujUQ4xJW9sKCvusYV8Wjv7azcNF
         GSRJO+oc7exvTHwGRccUsla+3cH6Shf4/mQDAFh9WuieKusx6AvCPFT6Mkzfa7Dbeucr
         PQNp/k/I52NavAo4qdqzFqBlFvxbHC5pXqZYRWw+PNyReppr7DMFz7PiVFXbtiB2ypiI
         xb+/l9Ws5QmVb1kNKnTCCUcdGwMPTr+vsHmSDpmwIRr/45Dr4tzkwhKOlyDodWPZVGjW
         ROv294W4itIH06Hmj6Ky0PXe7RWcKIL20UnO75KjzvtIaj+KEWiaOhB8PBIMk4feF6a9
         dsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R3HMBFHospGnC9Opd1R53FLCvcJarpfKxQXd852tZKY=;
        b=LrnJ9NsRDocdagdFddXf3R7KANwzGwsztDuSJx/XUM5g93T+PDnoL3DCU7UouJhJRr
         lMOekiRSU6MlyF9HBLg6Q5DuAFCVWDcF8XHGsnrK+RDLe0dyLSycPH8XRj/i843ySYe3
         R8PFs/OpwoferrUKiDvYrSmUDZ25xiq4mLCXxVIXBGGpEP5PLt8yFOUy1tAqH+PLGt+2
         nVK9uSTNdqQZtMXLLrXjnOM2tfdrVAssTacpQBgYTwXREzsYfOzpTmAgjiNm7fINHlJh
         66z+J7u1ai+KzdrV6/3ln4WQl+dv9m7zYP7z/5eE365FA8xiP370EM3585VWSUdS03Rz
         U2lQ==
X-Gm-Message-State: AOAM531rVN9ttEPfdRP49QQ4T7nU9bUQoXVzkj7h/OiwER9eWi2T59QA
        IvPIqMw4j5Lbv1YDN1cW508mjkRaFOI=
X-Google-Smtp-Source: ABdhPJzFZypqjRzJtlE+aOSTEjYGKn65clE50NBU5ELxH8iIHgXb/wJcszapXniKS65VqovIMY2D3B1Zvrs=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a5b:34a:: with SMTP id q10mr7679716ybp.224.1622836754233;
 Fri, 04 Jun 2021 12:59:14 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:53 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-4-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 03/10] block: introduce bio_required_sector_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function returns the required alignment for the number of sectors in
a bio. In particular, the number of sectors passed to bio_split() must be
aligned to this value.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 8b3591aee0a5..c8dcad7dde81 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -262,6 +262,20 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
 	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
 }
 
+/*
+ * The required sector alignment for a bio. The number of sectors in any bio
+ * must be aligned to this value.
+ */
+static inline unsigned int bio_required_sector_alignment(struct bio *bio)
+{
+	unsigned int alignmask =
+		(bdev_logical_block_size(bio->bi_bdev) >> SECTOR_SHIFT) - 1;
+
+	alignmask |= blk_crypto_bio_sectors_alignment(bio) - 1;
+
+	return alignmask + 1;
+}
+
 /*
  * The max bio size which is aligned to q->limits.discard_granularity. This
  * is a hint to split large discard bio in generic block layer, then if device
-- 
2.32.0.rc1.229.g3e70b5a671-goog

