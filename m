Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0B44D2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhKKHvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:51:37 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55708 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhKKHvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:51:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Uw0LcRv_1636616924;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uw0LcRv_1636616924)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 15:48:45 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, osalvador@suse.de, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Support multiple target nodes demotion
Date:   Thu, 11 Nov 2021 15:48:33 +0800
Message-Id: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set is used to support multiple target nodes demotion
if a system has multiple slow memory nodes. Please help to review.
Thanks.

Changes from v1:
 - Add a new patch to allocate the node_demotion dynamically.
 - Update some comments.
 - Simplify some variables' name.

Changes from RFC v2:
 - Change to 'short' type for target nodes array.
 - Remove nodemask instead selecting target node directly.
 - Add WARN_ONCE() if the target nodes exceed the maximum value.

Changes from RFC v1:
 - Re-define the node_demotion structure.
 - Set up multiple target nodes by validating the node distance.
 - Add more comments.

Baolin Wang (2):
  mm: migrate: Support multiple target nodes demotion
  mm: migrate: Allocate the node_demotion structure dynamically

 mm/migrate.c | 158 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 122 insertions(+), 36 deletions(-)

-- 
1.8.3.1

