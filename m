Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5042C3F39F4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhHUJnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:43:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8918 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhHUJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:43:31 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GsD393dZZz8sWy;
        Sat, 21 Aug 2021 17:38:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 21
 Aug 2021 17:42:50 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <minchan@kernel.org>,
        <cgoldswo@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 0/3] Cleanup and fixups for memory hotplug
Date:   Sat, 21 Aug 2021 17:42:43 +0800
Message-ID: <20210821094246.10149-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanup to use helper function to simplify the
code. Also we fix some potential bugs. More details can be found in
the respective changelogs. Thanks!

Miaohe Lin (3):
  mm/memory_hotplug: use helper zone_is_zone_device() to simplify the
    code
  mm/memory_hotplug: fix potential permanent lru cache disable
  mm/memory_hotplug: make HWPoisoned dirty swapcache pages unmovable

 mm/memory_hotplug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.23.0

