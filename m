Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3502F34E9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhC3ODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:03:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15045 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhC3ODV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:03:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8rgq679xzPmtQ;
        Tue, 30 Mar 2021 22:00:39 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 22:03:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/4] Cleanup and fixup for ksm
Date:   Tue, 30 Mar 2021 10:02:24 -0400
Message-ID: <20210330140228.45635-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove unnecessary VM_BUG_ON_PAGE and
dedicated macro KSM_FLAG_MASK. Also this fixes potential missing rmap_item
for stable_node which would result in failed rmap_walk_ksm(). More details
can be found in the respective changelogs. Thanks!

Miaohe Lin (4):
  ksm: remove redundant VM_BUG_ON_PAGE() on stable_tree_search()
  ksm: use GET_KSM_PAGE_NOLOCK to get ksm page in
    remove_rmap_item_from_tree()
  ksm: remove dedicated macro KSM_FLAG_MASK
  ksm: fix potential missing rmap_item for stable_node

 mm/ksm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.19.1

