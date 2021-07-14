Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4DA3C8151
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhGNJVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbhGNJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:20:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8E1C061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:18:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j15-20020ac84c8f0000b0290257b7db4a28so1524278qtv.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2Vsop99W4s6lWe8cK6l6K/rAGWgwPIdctdVvFKdP78M=;
        b=gBWgeFsqhwyu8Jg81RyLQeBBc5OyHx3T2DyqBT5xMSWP5u5/8hgXt/tFSvdf2LdCQx
         zzqCaMFvdWy0J8rUZn3igwZy5Rq/6TdfdQUCyIjLqk35niAxH7dUOQ4cJLOtj822FTBA
         a/eG17vn4rYw3uvIctBrV3IgB6lR1ob60rYJMPtzG+y1S51c1jX5UKSiL5YFvSeALlP8
         +zWzDnC7BOM2KiQtvZa0JlGSLzrcWKpgAda3ShRleqK1F1sXg1oDAVzNUudQ/i1gE8Kp
         qa5jxEsymw+Vqz6SYtVlhDXzpC3193/d8W3zfiHKeBjEFbvcEyo2MpU3oWQM1pF5l2+F
         PWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Vsop99W4s6lWe8cK6l6K/rAGWgwPIdctdVvFKdP78M=;
        b=dArKZBx2jMrlmUEDDrgdZqz3/eBOWwHRCaT7pGUv25hPxA2GQuqzSpyDDo6Aw0KPvV
         NioNp3V3/7xg8TvvbuoBB2f/GJ9J2PrleFegMjCmzLvcdOCm4luEVtlow+8UjR2DxJUa
         ufObgyl7PIewr9ctJrex4dPHao6c2PJJfzSlo8im6oHEfVBv4T600LU0+o5+fu7v0m3N
         +RXPneo+IWNo9SH7s9Qp/733e75dUsqj+3bgvWgrNMm9TTXBPVqJiIj1dPDmD3sUju7L
         NgkYfjG5qW4pJjf+VqFWQjc+2Osit0GC7d6re/v1pO4mc1jWm8Opyv1AwDXaIKWjohhk
         NcbQ==
X-Gm-Message-State: AOAM531Ih6gdcFWZofR5G4FSaC+NppLKEctsk+JTzK37mkkrhzTXd3g+
        NNNKdKQ7pfp0UyA9Lf1xVqasUbtvGXkGV8M30xteqnKWYfVG+N0A/JLPsnJCNh4BFjBpFvyVxVg
        z/jU9Evs6ITouMBG7mqn4QIdslpD5YPn8BD0PXvhhK/JJrEt2XW02WfSjcUxslSEbnA==
X-Google-Smtp-Source: ABdhPJz2zt8lgNfZwPq++YTRg/x0pRYZOreTyrN/SaoKpaUvB2iz4ecDed9ZSeyCXEGf6kLf3iB0YGDsCQ==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:c569:463c:c488:ac2])
 (user=morbo job=sendgmr) by 2002:a05:6214:13c8:: with SMTP id
 cg8mr9613493qvb.23.1626254284377; Wed, 14 Jul 2021 02:18:04 -0700 (PDT)
Date:   Wed, 14 Jul 2021 02:17:46 -0700
In-Reply-To: <20210714091747.2814370-1-morbo@google.com>
Message-Id: <20210714091747.2814370-3-morbo@google.com>
Mime-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 2/3] bnx2x: remove unused variable 'cur_data_offset'
From:   Bill Wendling <morbo@google.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        "David S . Miller" <davem@davemloft.net>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the clang build warning:

  drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:1862:13: error: variable 'cur_data_offset' set but not used [-Werror,-Wunused-but-set-variable]
        dma_addr_t cur_data_offset;

Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 27943b0446c2..f255fd0b16db 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -1858,7 +1858,6 @@ void bnx2x_iov_adjust_stats_req(struct bnx2x *bp)
 {
 	int i;
 	int first_queue_query_index, num_queues_req;
-	dma_addr_t cur_data_offset;
 	struct stats_query_entry *cur_query_entry;
 	u8 stats_count = 0;
 	bool is_fcoe = false;
@@ -1879,10 +1878,6 @@ void bnx2x_iov_adjust_stats_req(struct bnx2x *bp)
 	       BNX2X_NUM_ETH_QUEUES(bp), is_fcoe, first_queue_query_index,
 	       first_queue_query_index + num_queues_req);
 
-	cur_data_offset = bp->fw_stats_data_mapping +
-		offsetof(struct bnx2x_fw_stats_data, queue_stats) +
-		num_queues_req * sizeof(struct per_queue_stats);
-
 	cur_query_entry = &bp->fw_stats_req->
 		query[first_queue_query_index + num_queues_req];
 
@@ -1933,7 +1928,6 @@ void bnx2x_iov_adjust_stats_req(struct bnx2x *bp)
 			       cur_query_entry->funcID,
 			       j, cur_query_entry->index);
 			cur_query_entry++;
-			cur_data_offset += sizeof(struct per_queue_stats);
 			stats_count++;
 
 			/* all stats are coalesced to the leading queue */
-- 
2.32.0.93.g670b81a890-goog

