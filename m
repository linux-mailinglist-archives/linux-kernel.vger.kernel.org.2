Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655739C6AE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhFEHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 03:54:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7113 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhFEHyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 03:54:17 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxsGs2x84zYq74;
        Sat,  5 Jun 2021 15:49:41 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 5 Jun
 2021 15:52:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/2] Cleanups for zbud
Date:   Sat, 5 Jun 2021 15:51:39 +0800
Message-ID: <20210605075141.1359969-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains just cleanups to save some possible memory in
zbud_pool and avoid exporting any unneeded zbud API. More details
can be found in the respective changelogs. Thanks!

Miaohe Lin (2):
  mm/zbud: reuse unbuddied[0] as buddied in zbud_pool
  mm/zbud: don't export any zbud API

 MAINTAINERS          |   1 -
 include/linux/zbud.h |  23 ---
 mm/zbud.c            | 372 ++++++++++++++++++++++---------------------
 3 files changed, 189 insertions(+), 207 deletions(-)
 delete mode 100644 include/linux/zbud.h

-- 
2.23.0

