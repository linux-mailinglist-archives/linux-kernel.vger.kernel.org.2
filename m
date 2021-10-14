Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0A42CFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhJNBfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:35:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13737 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNBfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:35:19 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HVBh75YmzzWk31;
        Thu, 14 Oct 2021 09:31:35 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 09:33:14 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 14
 Oct 2021 09:33:13 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v4 0/2] optimize the bfq queue idle judgment
Date:   Thu, 14 Oct 2021 09:45:54 +0800
Message-ID: <20211014014556.3597008-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V4:
 - fix a compile warning when CONFIG_BLK_CGROUP is not enabled.

Changes in V3:
 - Instead of tracking each queue in root group, tracking root group
 directly just like non-root group does.
 - remove patch 3,4 from these series.

Chagnes in V2:
 - as suggested by Paolo, add support to track if root_group have any
 pending requests, and use that to handle the situation when only one
 group is activated while root group doesn't have any pending requests.
 - modify commit message in patch 2

Yu Kuai (2):
  block, bfq: counted root group into 'num_groups_with_pending_reqs'
  block, bfq: do not idle if only one cgroup is activated

 block/bfq-iosched.c | 40 ++++++++++++++++++++++++++++--------
 block/bfq-wf2q.c    | 50 +++++++++++++++++++++++++++++++++------------
 2 files changed, 69 insertions(+), 21 deletions(-)

-- 
2.31.1

