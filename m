Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E9D41C29B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbhI2KWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:22:07 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33466 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245125AbhI2KWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:22:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uq0ghvM_1632910824;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uq0ghvM_1632910824)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 18:20:24 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Support hugetlb charge moving at task migration
Date:   Wed, 29 Sep 2021 18:19:26 +0800
Message-Id: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now in the hugetlb cgroup, charges associated with a task aren't moved
to the new hugetlb cgroup at task migration, which is odd for hugetlb
cgroup usage. This patch set adds hugetlb cgroup charge moving when
migrate tasks among cgroups, which are based on the memcg charge moving.

Please help to review. Thanks.

Baolin Wang (2):
  hugetlb_cgroup: Add interfaces to move hugetlb charge at task
    migration
  hugetlb_cgroup: Add post_attach interface for tasks migration

 mm/hugetlb_cgroup.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

-- 
1.8.3.1

