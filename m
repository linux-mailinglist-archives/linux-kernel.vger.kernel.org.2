Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF433F27F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhCQOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:23:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14364 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhCQOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:23:17 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F0slb2WyHz90YY;
        Wed, 17 Mar 2021 22:21:15 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 22:23:01 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rui.xiang@huawei.com>
Subject: [PATCH 0/2] Fix page_owner broken on arm64
Date:   Wed, 17 Mar 2021 14:20:48 +0000
Message-ID: <20210317142050.57712-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, cat /sys/kernel/debug/page_owner
All pages return the same stack
 stack_trace_save+0x4c/0x78
 register_early_stack+0x34/0x70
 init_page_owner+0x34/0x230
 page_ext_init+0x1bc/0x1dc

The reason is arch_stack_walk save 2 more entries than before.

To fix it, add skip in arch_stack_walk

*** BLURB HERE ***

1. Prepare for 2, move stacktrace_cookie to .h
2. Fix the problem

Chen Jun (2):
  stacktrace: Move struct stacktrace_cookie to stacktrace.h
  arm64: stacktrace: Add skip when task == current

 arch/arm64/kernel/stacktrace.c | 5 +++--
 include/linux/stacktrace.h     | 7 +++++++
 kernel/stacktrace.c            | 7 -------
 3 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.9.4

