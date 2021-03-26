Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8920D34ABFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhCZPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhCZPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:52:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6EFC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:16 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id c17so5407289ilj.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3EKLjKkkRDyuhjHErOaTe+JpmWOCkVYfmQHbnU0kHI=;
        b=Q1n38aK+c3uamMZgFIc52ESkgPLBNxfDOGN7cty0ag6K+9uXQQt8jsruCvD/gYKN+t
         +kdItJ4kmtALD5eZzPiP2L1gFkR0F54a1kMbVVa65L1FM3qbBZZu8wiHl6LqrRKyUUTm
         nOQLogXH/Fa+o9sIL9hFjdET6GD18bBlkXSSVjm20oSMAqx6mDRkFJ8i2NSmz7nxZFRK
         fsptYBAowRRYz8tNWlGQ9DeIMyufh/rQVIL8GWaRxuilhHtE9ZhRE2v0ZkR88Wjv4rpJ
         YyxoaljHyNoTrYhrlRhF/wmb1Jcb9xlO+yDgttrYCwXXuQ7EdM1M4htKWdcnqtsMYe93
         ygFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3EKLjKkkRDyuhjHErOaTe+JpmWOCkVYfmQHbnU0kHI=;
        b=d93VrxTJBwA2T9/mrWNGJVjlfkWtjp3cEANrxn8ivmCkN/MUExWUH9ObXYuTkiA6s/
         /Mla8LLCMAn1jT055Qe/5tooMYbOO10ePzb8X4ob0IbN/QOzXuYXciepKIr5QQ3DccQM
         8NeqNtO+K/I0SUxC69JC55bNVT2EZaBIvGEQPwN6GJir5JTiAbGr9r1somCG94dY6AQE
         siuYsaPKIrUkrPkKsOF58WBt7PYUyOa6dag9KTNCJEO+k5TjRPhSmN2cdwqYsp4lgh3v
         VGpHp75Dt2QTWLuAS74VDQk5+vR02NBMSGRTua07gk/SbNf9mSLQGlBs1eT1aG0srUA+
         QZMg==
X-Gm-Message-State: AOAM532v2TeWBktllNRzMXngiPtiNLNF/4pyQV3y5inkgfoBmLmAcT0E
        0jPu9eHTUK/jjE0mVml5Ug9U5YpmZvrmgw==
X-Google-Smtp-Source: ABdhPJzKUpNoS4pw8KCPWFEvmW62Pe4ry7Ir9wj1n+5XszzM0F7ROsSkdti+mcIBm/8GcFiCQduIkQ==
X-Received: by 2002:a92:c748:: with SMTP id y8mr9218586ilp.37.1616773936005;
        Fri, 26 Mar 2021 08:52:16 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm4456337ilj.64.2021.03.26.08.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:52:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/10] io_uring: don't cancel extra on files match
Date:   Fri, 26 Mar 2021 09:51:28 -0600
Message-Id: <20210326155128.1057078-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326155128.1057078-1-axboe@kernel.dk>
References: <20210326155128.1057078-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

As tasks always wait and kill their io-wq on exec/exit, files are of no
more concern to us, so we don't need to specifically cancel them by hand
in those cases. Moreover we should not, because io_match_task() looks at
req->task->files now, which is always true and so leads to extra
cancellations, that wasn't a case before per-task io-wq.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/0566c1de9b9dd417f5de345c817ca953580e0e2e.1616696997.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4189e1b684e1..66ae46874d85 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1094,8 +1094,6 @@ static bool io_match_task(struct io_kiocb *head,
 	io_for_each_link(req, head) {
 		if (req->flags & REQ_F_INFLIGHT)
 			return true;
-		if (req->task->files == files)
-			return true;
 	}
 	return false;
 }
-- 
2.31.0

