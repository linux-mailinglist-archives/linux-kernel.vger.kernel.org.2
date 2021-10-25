Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F8439111
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhJYIX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhJYIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:23:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55642C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:21:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y26so7677413lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1eGsGvSupt9keTxPYnbOs6SIupFozzDdx1fHvMuh2A=;
        b=Kc2WfddgrbdOM5M6itU0cenw9rjcU6/6XnRDC8Zwv7sQi9ycnqZhBft49kEbo9YykX
         Ral/IUibv2TT6eBr721BhIi/oUar/vSxay6ecQmMZ2pSC3kw7AkzLjJ0TtBMclhJeAAm
         zXj0BD6RpSTa6Pn8JlBDLdCtdExWgdcp+j8e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1eGsGvSupt9keTxPYnbOs6SIupFozzDdx1fHvMuh2A=;
        b=NraYRuxLdx/HRY/IKOlGuZZRBZRYVxkL8YqVmrG/dbjxOj+PzEAE6VpLiUd4yaE2I6
         TVnawYZ38f72irrFbELgO0Of6+T7LxAsRYohTe73m801R/8Viv3f2CHpfn38S+HDoqHT
         lbEpdjP/8WNKNusvTbW9v3rBoMxZP2tQ5/0PpSF0JQluie7BB+TpJzsZg7CohJ1IyjA3
         3wVG1NDNowsupzhTQQmoHTijfTp4CE4zjJI0wymCg+kxsMWuywHovkNDhIKB4a3f7OHM
         XouL6XlAct06nMMWHWS2+/P7x72VUanUt5uTTaNOX5B0DLyc1mc7RvDbOHKOgnXCtSRW
         eqdw==
X-Gm-Message-State: AOAM532Md+S2nq2PwDr1Khj0Q/zHddya0ABF1ipQFbxn7e2+zHzYKOBd
        p75o6I06wxqJ4CjqFhTDMVKEfaOszW34BQ==
X-Google-Smtp-Source: ABdhPJxrsjGQLvgUzp7Jvo+PWFDeMkRjiBjcN4X8rgX4SKtcLuMxjqbB305MCTHD7Lz67nn3YMC7RA==
X-Received: by 2002:a05:6512:39d1:: with SMTP id k17mr766967lfu.79.1635150092678;
        Mon, 25 Oct 2021 01:21:32 -0700 (PDT)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id n13sm239189lfi.127.2021.10.25.01.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 01:21:32 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtdchar: prevent unbounded allocation in MEMWRITE ioctl
Date:   Mon, 25 Oct 2021 10:21:04 +0200
Message-Id: <20211025082104.8017-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the mtdchar_write_ioctl() function, memdup_user() is called with its
'len' parameter set to verbatim values provided by user space via a
struct mtd_write_req.  Both the 'len' and 'ooblen' fields of that
structure are 64-bit unsigned integers, which means the MEMWRITE ioctl
can trigger unbounded kernel memory allocation requests.

Fix by iterating over the buffers provided by user space in a loop,
processing at most mtd->erasesize bytes in each iteration.  Adopt some
checks from mtd_check_oob_ops() to retain backward user space
compatibility.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
Fixing this problem was suggested last month, during a discussion about
a new MEMREAD ioctl. [1] [2]

My primary objective was to not break user space, i.e. to not change
externally visible behavior compared to the current code.  The main
problem I faced was that splitting the input data into chunks makes the
MEMWRITE ioctl a _wrapper_ for mtd_write_oob() rather than a direct
_interface_ to it and yet from the user space perspective it still needs
to behave as if nothing changed.

Despite my efforts, the patch does _not_ retain absolute backward
compatibility and I do not know whether this is acceptable.
Specifically, multi-eraseblock-sized writes (requiring multiple loop
iterations to be processed) which succeeded with the original code _may_
now return errors and/or write different contents to the device than the
original code, depending on the MTD mode of operation requested and on
whether the start offset is page-aligned.  The documentation for struct
mtd_oob_ops warns about even multi-page write requests, but...

Example:

    MTD device parameters:

      - mtd->writesize = 2048
      - mtd->erasesize = 131072
      - 64 bytes of raw OOB space per page

    struct mtd_write_req req = {
        .start = 2048,
        .len = 262144,
        .ooblen = 64,
        .usr_data = ...,
        .usr_oob = ...,
        .mode = MTD_OPS_RAW,
    };

    (This is a 128-page write with OOB data supplied for just one page.)

    Current mtdchar_write_ioctl() returns 0 for this request and writes
    128 pages of data and 1 page's worth of OOB data (64 bytes) to the
    MTD device.

    Patched mtdchar_write_ioctl() may return an error because the
    original request gets split into two chunks (<data_len, oob_len>):

        <131072, 64>
        <131072, 0>

    and the second chunk with zero OOB data length may make the MTD
    driver unhappy in raw mode (resulting in only the first 64 pages of
    data and 1 page's worth of OOB data getting written to the MTD
    device).

    Is an ioctl like this considered a "degenerate" one and therefore
    acceptable to break or not?

At any rate, the revised code feels brittle to me and I would not be
particularly surprised if I missed more cases in which it produces
different results than the original code.

I keep on wondering whether the benefits of this change are worth the
extra code complexity, but fortunately it is not my call to make :)
Perhaps I am missing something and my proposal can be simplified?  Or
maybe the way I approached this is completely wrong?  Any thoughts on
this are welcome.

As the outcome of the discussion around this patch will have a
significant influence on the shape of the v2 of the MEMREAD ioctl, I
decided to submit this one first as a standalone patch.

[1] https://lists.infradead.org/pipermail/linux-mtd/2021-September/088485.html
[2] https://lists.infradead.org/pipermail/linux-mtd/2021-September/088544.html

 drivers/mtd/mtdchar.c | 93 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 155e991d9d75..a3afc390e254 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -578,9 +578,10 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_write_req req;
-	struct mtd_oob_ops ops = {};
 	const void __user *usr_data, *usr_oob;
-	int ret;
+	uint8_t *datbuf = NULL, *oobbuf = NULL;
+	size_t datbuf_len, oobbuf_len;
+	int ret = 0;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -590,33 +591,79 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 
 	if (!master->_write_oob)
 		return -EOPNOTSUPP;
-	ops.mode = req.mode;
-	ops.len = (size_t)req.len;
-	ops.ooblen = (size_t)req.ooblen;
-	ops.ooboffs = 0;
-
-	if (usr_data) {
-		ops.datbuf = memdup_user(usr_data, ops.len);
-		if (IS_ERR(ops.datbuf))
-			return PTR_ERR(ops.datbuf);
-	} else {
-		ops.datbuf = NULL;
+
+	if (!usr_data)
+		req.len = 0;
+
+	if (!usr_oob)
+		req.ooblen = 0;
+
+	if (req.start + req.len > mtd->size)
+		return -EINVAL;
+
+	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
+	if (datbuf_len > 0) {
+		datbuf = kmalloc(datbuf_len, GFP_KERNEL);
+		if (!datbuf)
+			return -ENOMEM;
 	}
 
-	if (usr_oob) {
-		ops.oobbuf = memdup_user(usr_oob, ops.ooblen);
-		if (IS_ERR(ops.oobbuf)) {
-			kfree(ops.datbuf);
-			return PTR_ERR(ops.oobbuf);
+	oobbuf_len = min_t(size_t, req.ooblen, mtd->erasesize);
+	if (oobbuf_len > 0) {
+		oobbuf = kmalloc(oobbuf_len, GFP_KERNEL);
+		if (!oobbuf) {
+			kfree(datbuf);
+			return -ENOMEM;
 		}
-	} else {
-		ops.oobbuf = NULL;
 	}
 
-	ret = mtd_write_oob(mtd, (loff_t)req.start, &ops);
+	while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
+		struct mtd_oob_ops ops = {
+			.mode = req.mode,
+			.len = min_t(size_t, req.len, datbuf_len),
+			.ooblen = min_t(size_t, req.ooblen, oobbuf_len),
+			.datbuf = req.len ? datbuf : NULL,
+			.oobbuf = req.ooblen ? oobbuf : NULL,
+		};
 
-	kfree(ops.datbuf);
-	kfree(ops.oobbuf);
+		/*
+		 * For writes which are not OOB-only, adjust the amount of OOB
+		 * data written according to the number of data pages written.
+		 * This is necessary to prevent OOB data from being skipped
+		 * over in data+OOB writes requiring multiple mtd_write_oob()
+		 * calls to be completed.
+		 */
+		if (ops.len > 0 && ops.ooblen > 0) {
+			u32 oob_per_page = mtd_oobavail(mtd, &ops);
+			uint32_t pages_to_write = mtd_div_by_ws(ops.len, mtd);
+
+			if (mtd_mod_by_ws(req.start + ops.len, mtd))
+				pages_to_write++;
+
+			ops.ooblen = min_t(size_t, ops.ooblen,
+					   pages_to_write * oob_per_page);
+		}
+
+		if (copy_from_user(datbuf, usr_data, ops.len) ||
+		    copy_from_user(oobbuf, usr_oob, ops.ooblen)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = mtd_write_oob(mtd, req.start, &ops);
+		if (ret)
+			break;
+
+		req.start += ops.retlen;
+		req.len -= ops.retlen;
+		usr_data += ops.retlen;
+
+		req.ooblen -= ops.oobretlen;
+		usr_oob += ops.oobretlen;
+	}
+
+	kfree(datbuf);
+	kfree(oobbuf);
 
 	return ret;
 }
-- 
2.33.1

