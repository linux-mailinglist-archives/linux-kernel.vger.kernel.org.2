Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FCE412387
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbhITSZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377345AbhITSSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:18:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45166632A3;
        Mon, 20 Sep 2021 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632158575;
        bh=XWkpzJb/KnyqQR8Y4OpztpvxB+7uORp6FVnCibL+cqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVy0IPO0bKq2Jh0YUSB1O353GMekBM3PQD2fyMJSKflaZJ0LPNdoxKHxJ/nHjFzmx
         Woq20ID6+MXh87srv4vLbdwnRuM2VDTIMee7KBeVGGFbFyaS8EQglEV7Km68z2vhTq
         D7clqJu1vxZtsejGVZWmDrsxWbFU8h+m6OaKDCB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5.4 218/260] net/mlx5: Fix potential sleeping in atomic context
Date:   Mon, 20 Sep 2021 18:43:56 +0200
Message-Id: <20210920163938.515016657@linuxfoundation.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920163931.123590023@linuxfoundation.org>
References: <20210920163931.123590023@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

commit ee27e330a953595903979ffdb84926843595a9fe upstream.

Fixes the below flow of sleeping in atomic context by releasing
the RCU lock before calling to free_match_list.

build_match_list() <- disables preempt
-> free_match_list()
   -> tree_put_node()
      -> down_write_ref_node() <- take write lock

Fixes: 693c6883bbc4 ("net/mlx5: Add hash table for flow groups in flow table")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1606,9 +1606,9 @@ static int build_match_list(struct match
 
 		curr_match = kmalloc(sizeof(*curr_match), GFP_ATOMIC);
 		if (!curr_match) {
+			rcu_read_unlock();
 			free_match_list(match_head, ft_locked);
-			err = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 		if (!tree_get_node(&g->node)) {
 			kfree(curr_match);
@@ -1617,7 +1617,6 @@ static int build_match_list(struct match
 		curr_match->g = g;
 		list_add_tail(&curr_match->list, &match_head->list);
 	}
-out:
 	rcu_read_unlock();
 	return err;
 }


