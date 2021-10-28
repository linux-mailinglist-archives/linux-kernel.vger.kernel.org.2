Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6212343F197
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhJ1V1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1V1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:27:07 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F20FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:24:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t21so5345718plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RV1ktiVcOk2gvvVNArK5GYNQ8lDVGFTjyNsc061OS3M=;
        b=p2qREbmzgn5dh+hYNVQrRuLqFwyRcSRWlq+K7saPHT6ji70p47ER6c9hiK1dd8Z67Z
         gEUdwaviAdAX1z/YYtXznixHlOnGG8THpeBMx629ZaNJZsVCtQtsYdlR8Hhq/tfmt9im
         rd1qHrnO7BOwYJlFJaspMkEHdtmjixa5f/q06Q9dtPM28/RNpqlGh23V6ZJEu9vM/5nG
         i966B6ej6PLRP5RbTdnJM0qL2CNLtFxX/nwxaI5ufuscsrWMcS5YxWumiVjkzrPjAMiW
         3zqtrxeVm1YPtz2gLChi7dHXgTUMuPW6T51kUGBxMhqw0wtHug1fNwK9q7W1c2lIolNz
         3Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RV1ktiVcOk2gvvVNArK5GYNQ8lDVGFTjyNsc061OS3M=;
        b=4t0K1QZSWXQFwMY+Bff78rgzOfx10Pz7LbKNFe7h4Th5JivcxktmIrx2cyc2XmZX2G
         VTKEyFHxzVXLzm3Q7PJk9O7lULL+XtxF1I5d1QsfOwV8Lo6bMkhvTTRzDXFV8yyHkz61
         W504welwjDZHcvafbE1V2RsrJyMOtUequV73U7g4GOfN1m+27TvMei1gk7Ju9JG9S3i0
         5xN9e5Th0GQKE0lJvnRE4b133ZzmhMRlDqFcNbxORvc7TLDUyLShZB3PCgC+damiiOKZ
         eTQvPeRPuaa0b21zykekmTS/sB9sAe0xzsL25Pb3yvn0wZ7FZcKriUP49DROKYg19cei
         iQxg==
X-Gm-Message-State: AOAM533qlu6GFp0wPtY9fuXCWEJ/8Je+afnzGL17OgZLubCfJzQ1PaBR
        c/OsWpgI0E0FhKkdsSkxgfNe0bR6zm0=
X-Google-Smtp-Source: ABdhPJxl7YrmUpyTkcg6SXLznrX02zwRXMTUGSeNAXpHNCF01ta+O+3L5vlySEyxPTGr9FQriUoiWQ==
X-Received: by 2002:a17:90a:4509:: with SMTP id u9mr15718342pjg.79.1635456279909;
        Thu, 28 Oct 2021 14:24:39 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id y21sm4378583pfb.184.2021.10.28.14.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 14:24:39 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, Hao Xu <haoxu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Subject: [BUG] About "io_uring: add more uring info to fdinfo for debug"
Message-ID: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
Date:   Thu, 28 Oct 2021 14:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I was looking at commit 83f84356bc8f2d
("io_uring: add more uring info to fdinfo for debug") after receiving
syzbot reports.

I suspect that the following :

+       for (i = cached_sq_head; i < sq_tail; i++) {
+               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
+
+               if (likely(sq_idx <= sq_mask)) {
+                       struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
+
+                       seq_printf(m, "%5u: opcode:%d, fd:%d, flags:%x, user_data:%llu\n",
+                                  sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
+               }
+       }


Can loop around ~2^32 times if sq_tail is close to ~0U

I see various READ_ONCE(), which are probably not good enough.

At very minimum I would handling wrapping...

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f37de99254bf8e0b8364b267388d1056fce436a4..50493f5c004b70cff103e20bf4b1ba92304eddb9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -10117,7 +10117,7 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
        struct io_overflow_cqe *ocqe;
        struct io_rings *r = ctx->rings;
        unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
-       unsigned int cached_sq_head = ctx->cached_sq_head;
+       unsigned int cached_sq_head = READ_ONCE(ctx->cached_sq_head);
        unsigned int cached_cq_tail = ctx->cached_cq_tail;
        unsigned int sq_head = READ_ONCE(r->sq.head);
        unsigned int sq_tail = READ_ONCE(r->sq.tail);
@@ -10139,7 +10139,7 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
        seq_printf(m, "CqTail:\t%u\n", cq_tail & cq_mask);
        seq_printf(m, "CachedCqTail:\t%u\n", cached_cq_tail & cq_mask);
        seq_printf(m, "SQEs:\t%u\n", sq_tail - cached_sq_head);
-       for (i = cached_sq_head; i < sq_tail; i++) {
+       for (i = cached_sq_head; (int)(i - sq_tail) < 0; i++) {
                unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
 
                if (likely(sq_idx <= sq_mask)) {
