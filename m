Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2833435AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJUGdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:33:51 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33628 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231336AbhJUGds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:33:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ut6a8TI_1634797890;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ut6a8TI_1634797890)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Oct 2021 14:31:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     mhocko@kernel.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Some cleanups and improvements for hugetlb
Date:   Thu, 21 Oct 2021 14:31:15 +0800
Message-Id: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset did some cleanups and improvements for the hugetlb and
hugetlb_cgroup. Please help to review. Thanks.

Baolin Wang (4):
  hugetlb_cgroup: Remove unused hugetlb_cgroup_from_counter macro
  hugetlb: Replace the obsolete hugetlb_instantiation_mutex in the
    comments
  hugetlb: Remove redundant validation in has_same_uncharge_info()
  hugetlb: Remove redundant VM_BUG_ON() in add_reservation_in_range()

 mm/hugetlb.c        | 6 ++----
 mm/hugetlb_cgroup.c | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

-- 
1.8.3.1

