Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCE83EC21D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhHNKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:52:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13422 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbhHNKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:52:01 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gmxw63gPszdZPG;
        Sat, 14 Aug 2021 18:47:50 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 14
 Aug 2021 18:51:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <sfr@canb.auug.org.au>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 0/4] Cleanups and fixup for memcontrol
Date:   Sat, 14 Aug 2021 18:51:27 +0800
Message-ID: <20210814105131.48814-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove unneeded variable, fix some
obsolete comments and so on. Also we fix potential pte_unmap_unlock
on wrong pte. More details can be found in the respective changelogs.
Thanks!

Miaohe Lin (4):
  mm/hwpoison: remove unneeded variable unmap_success
  mm/hwpoison: fix potential pte_unmap_unlock pte error
  mm/hwpoison: change argument struct page **hpagep to *hpage
  mm/hwpoison: fix some obsolete comments

 mm/memory-failure.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
2.23.0

