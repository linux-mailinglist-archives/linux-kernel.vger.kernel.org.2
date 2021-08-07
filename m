Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFB3E345A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhHGJgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:36:37 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13245 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhHGJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:36:36 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ghcfc0MYhz1CSrQ;
        Sat,  7 Aug 2021 17:36:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 7 Aug
 2021 17:36:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <imbrenda@linux.ibm.com>, <kirill.shutemov@linux.intel.com>,
        <jack@suse.cz>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 0/5] Cleanups and fixup for gup
Date:   Sat, 7 Aug 2021 17:36:15 +0800
Message-ID: <20210807093620.21347-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove unneeded variable, useless
BUG_ON and use helper to improve readability. Also we fix a potential
pgmap refcnt leak. More details can be found in the respective
changelogs. Thanks!

Miaohe Lin (5):
  mm: gup: remove set but unused local variable major
  mm: gup: remove unneed local variable orig_refs
  mm: gup: remove useless BUG_ON in __get_user_pages()
  mm: gup: fix potential pgmap refcnt leak in __gup_device_huge()
  mm: gup: use helper PAGE_ALIGNED in populate_vma_page_range()

 mm/gup.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

-- 
2.23.0

