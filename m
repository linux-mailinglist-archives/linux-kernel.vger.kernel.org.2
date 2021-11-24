Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB1745CF12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhKXVeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:34:19 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:50781 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhKXVeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:34:14 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pzqFmS0vwBazopzqPmFOlN; Wed, 24 Nov 2021 22:30:54 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 22:30:55 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] Cleanup and optimize a few bitmap operations
Date:   Wed, 24 Nov 2021 22:30:08 +0100
Message-Id: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 and 2 are just cleanups that uses 'bitmap_zalloc()' and 'bitmap_set()'
instead of hand-writing these functions.

Patch 3 is more questionable. It replaces calls to '[set|clear]_bit()' by their
non-atomic '__[set|clear]_bit()' alternatives.
It looks safe to do so because accesses to the corresponding bitmaps are
protected by spinlocks.
However, this patch is compile-tested only. It is not sure that it worth
changing the code just for saving a few atomic operations.
So review, test and apply only if it make sense.

Christophe JAILLET (3):
  RDMA/cxgb4: Use bitmap_zalloc() when applicable
  RDMA/cxgb4: Use bitmap_set() when applicable
  RDMA/cxgb4: Use non-atomic bitmap functions when possible

 drivers/infiniband/hw/cxgb4/id_table.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

-- 
2.30.2

