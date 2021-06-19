Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ABC3AD8FA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhFSJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 05:35:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5402 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbhFSJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:34:57 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G6Vqc2zJ7z71R6;
        Sat, 19 Jun 2021 17:29:32 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 17:32:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vitalywool@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 0/6] Cleanup and fixup for z3fold
Date:   Sat, 19 Jun 2021 17:31:45 +0800
Message-ID: <20210619093151.1492174-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove unused function, redefine macro
to improve readability and so on. Also this fixes several bugs in z3fold,
such as memory leak in z3fold_destroy_pool(). More details can be found
in the respective changelogs. Thanks!

Miaohe Lin (6):
  mm/z3fold: define macro NCHUNKS as TOTAL_CHUNKS - ZHDR_CHUNKS
  mm/z3fold: avoid possible underflow in z3fold_alloc()
  mm/z3fold: remove magic number in z3fold_create_pool()
  mm/z3fold: remove unused function handle_to_z3fold_header()
  mm/z3fold: fix potential memory leak in z3fold_destroy_pool()
  mm/z3fold: use release_z3fold_page_locked() to release locked z3fold
    page

 mm/z3fold.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

-- 
2.23.0

