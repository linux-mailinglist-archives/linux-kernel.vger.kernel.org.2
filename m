Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6E39C215
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFDVMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:12:20 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50129 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhFDVMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:12:18 -0400
Received: by mail-qk1-f201.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso7379309qka.16
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XCMW74I69DeN8Z3kX5iYnnwjp70fgDZ7aIjMCwTUzeM=;
        b=Mw++crRiYfOUuxBBsYJaIjEa2wzFZ7uIymgYyHPMmfqTENGSHY2XJFEFHfB0uF7oKU
         q+30l4Moqzicat/BsS7qK98HMHFB/NLzIAJndkfQNTeAD2gynzn1R3KcC6ecx+103TBP
         GDOBRtGgHEnAavWAyXnjadC5RjL1xZKdJoiqVP9LX+Baz1NH8ZskxxPR83N7wSzYmGmy
         AzR1MNMkb9T8NXWXKltKXehqDno9ArTvpLAmBtZwsBDFWHY2DN8mTuZF85xYugPqWMzK
         yDR3nmN38QXxX3Feu5LZLFS1lswICuDdid9tBrfJEby3qDOgFQZQYjh0Whmxpid95T2Z
         py5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XCMW74I69DeN8Z3kX5iYnnwjp70fgDZ7aIjMCwTUzeM=;
        b=Ud1d8sEbtET0KRRImA5BJZUbtN2+y+ySiDSykBVpEpJEjDwbu2zbMr1Jz1fnLgkcV4
         NSbsWHqd2/tY8MRKy2AucXcB13zWtK3gC/eg6kuIcoPIJ59ss9HWOEnY9XwvVMpvauZ3
         6HmBJDXiEQcgDyUxU+RwCIyOX6auoUQiTLDDxH2lSs1O4NL2XCjPOdMYqm6yOb64AeCN
         1yjnEdwlFB1SPxfywDXuqJdLKXpfDOiv+nQbIUEPD9gx5gjBZxlp6xe9PQX03132wB5y
         Km0sSZNJpbzVQUMCRDmIay6kZ8te2s604dvGhxPUS3iv+VRMHzW3qGp4J+SlyT0742yl
         SkcQ==
X-Gm-Message-State: AOAM531jTi+8DEVHN5J5EklxdSeq2qJl/auDddpPms856/fVxmBfj018
        +dB4loH/ixxnWi1+et2tOeQDA0LwcK8=
X-Google-Smtp-Source: ABdhPJxiSLZqcPqUF+AidxN8J2rs3GJOT86onesJOcAIexrEcLNAzcay/hdWehQRGDOJrX95PrTmEboMFxw=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:2aa3:: with SMTP id
 js3mr6751098qvb.56.1622840959831; Fri, 04 Jun 2021 14:09:19 -0700 (PDT)
Date:   Fri,  4 Jun 2021 21:09:04 +0000
In-Reply-To: <20210604210908.2105870-1-satyat@google.com>
Message-Id: <20210604210908.2105870-6-satyat@google.com>
Mime-Version: 1.0
References: <20210604210908.2105870-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v9 5/9] block: Make bio_iov_iter_get_pages() respect bio_required_sector_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, bio_iov_iter_get_pages() wasn't used with bios that could have
an encryption context. However, direct I/O support using blk-crypto
introduces this possibility, so this function must now respect
bio_required_sector_alignment() (otherwise, xfstests like generic/465 with
ext4 will fail).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 32f75f31bb5c..99c510f706e2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1099,7 +1099,8 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * The function tries, but does not guarantee, to pin as many pages as
  * fit into the bio, or are requested in @iter, whatever is smaller. If
  * MM encounters an error pinning the requested pages, it stops. Error
- * is returned only if 0 pages could be pinned.
+ * is returned only if 0 pages could be pinned. It also ensures that the number
+ * of sectors added to the bio is aligned to bio_required_sector_alignment().
  *
  * It's intended for direct IO, so doesn't do PSI tracking, the caller is
  * responsible for setting BIO_WORKINGSET if necessary.
@@ -1107,6 +1108,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	int ret = 0;
+	unsigned int aligned_sectors;
 
 	if (iov_iter_is_bvec(iter)) {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
@@ -1121,6 +1123,15 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
+	/*
+	 * Ensure that number of sectors in bio is aligned to
+	 * bio_required_sector_align()
+	 */
+	aligned_sectors = round_down(bio_sectors(bio),
+				     bio_required_sector_alignment(bio));
+	iov_iter_revert(iter, (bio_sectors(bio) - aligned_sectors) << SECTOR_SHIFT);
+	bio_truncate(bio, aligned_sectors << SECTOR_SHIFT);
+
 	/* don't account direct I/O as memory stall */
 	bio_clear_flag(bio, BIO_WORKINGSET);
 	return bio->bi_vcnt ? 0 : ret;
-- 
2.32.0.rc1.229.g3e70b5a671-goog

