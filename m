Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20838B02B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhETNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:42:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3605 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhETNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:42:27 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fm9ld4nzWzQqHM;
        Thu, 20 May 2021 21:37:33 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 21:41:04 +0800
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 21:41:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/4] Cleanups for swap
Date:   Thu, 20 May 2021 21:40:18 +0800
Message-ID: <20210520134022.1370406-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains just cleanups to remove some unused variables, delete
meaningless forward declarations and so on. More details can be found in
the respective changelogs. Thanks!

v1->v2:
  collect Reviewed-by tag
  get rid of patch "mm/swap: simplify the code of find_get_incore_page()"

Miaohe Lin (4):
  mm/swapfile: move get_swap_page_of_type() under CONFIG_HIBERNATION
  mm/swap: remove unused local variable nr_shadows
  mm/swap_slots.c: delete meaningless forward declarations
  mm/swap: remove unused global variable nr_swapper_spaces

 mm/swap_slots.c |  2 --
 mm/swap_state.c |  8 --------
 mm/swapfile.c   | 48 ++++++++++++++++++++++++------------------------
 3 files changed, 24 insertions(+), 34 deletions(-)

-- 
2.23.0

