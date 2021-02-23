Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B693233ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhBWWtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:49:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12568 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbhBWWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:32:59 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DlYdV2rLnzMcwR;
        Wed, 24 Feb 2021 06:29:50 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.133) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Feb 2021 06:31:44 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <jan.kiszka@siemens.com>, <kbingham@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 0/2] scripts/gdb: clarify the platforms supporting lx_current and add arm64 support
Date:   Wed, 24 Feb 2021 11:25:38 +1300
Message-ID: <20210223222540.9120-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lx_current depends on per_cpu current_task variable which exists on x86 only.
so it actually works on x86 only. the 1st patch documents this clearly; the
2nd patch adds support for arm64.

Barry Song (2):
  scripts/gdb: document lx_current is only supported by x86
  scripts/gdb: add lx_current support for arm64

 .../dev-tools/gdb-kernel-debugging.rst        |  2 +-
 scripts/gdb/linux/cpus.py                     | 23 +++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.25.1

