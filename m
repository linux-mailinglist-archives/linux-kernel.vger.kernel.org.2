Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736633A807
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhCNUlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:41:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13922 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhCNUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:41:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DzBHn5NdmzkXV6;
        Mon, 15 Mar 2021 04:39:49 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.142) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 04:41:09 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <jan.kiszka@siemens.com>,
        <kbingham@kernel.org>
CC:     <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@openeuler.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [RESEND PATCH v2 0/2] scripts/gdb: clarify the platforms supporting lx_current and add arm64 support
Date:   Mon, 15 Mar 2021 09:34:42 +1300
Message-ID: <20210314203444.15188-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.142]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lx_current depends on per_cpu current_task variable which exists on x86 only.
so it actually works on x86 only. the 1st patch documents this clearly; the
2nd patch adds support for arm64.

-resend
 resending to Andrew as Kieran Bingham explained patches of scripts/gdb
 usually go through the tree of Andrew Morton;

Barry Song (2):
  scripts/gdb: document lx_current is only supported by x86
  scripts/gdb: add lx_current support for arm64

 .../dev-tools/gdb-kernel-debugging.rst        |  2 +-
 scripts/gdb/linux/cpus.py                     | 23 +++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.25.1

