Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20547408AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbhIMMMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:12:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19034 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbhIMMMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:12:32 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7QFp6K86zbmT8;
        Mon, 13 Sep 2021 20:07:10 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 20:11:15 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 13 Sep 2021 20:11:15 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Chen Huang <chenhuang5@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] riscv: improve unaligned memory accesses
Date:   Mon, 13 Sep 2021 12:19:54 +0000
Message-ID: <20210913121956.1776656-1-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema756-chm.china.huawei.com (10.1.198.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISCV ISA can support unaligned memory accesses, so the patchset
selects HAVE_EFFICIENT_UNALIGNED_ACCESS and supports DCACHE_WORD_ACCESS
to improve the efficiency of unaligned memory accesses.

Chen Huang (2):
  riscv: Kconfig: select HAVE_EFFICIENT_UNALIGNED_ACCESS
  riscv: Support DCACHE_WORD_ACCESS

 arch/riscv/Kconfig                      |  2 ++
 arch/riscv/include/asm/word-at-a-time.h | 36 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.18.0.huawei.25

