Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0860C3458BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCWHcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:32:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14067 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCWHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:31:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4NKW4nn0zNqWn;
        Tue, 23 Mar 2021 15:29:19 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 15:31:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <guohanjun@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH 0/3] arm64: lib: improve copy performance
Date:   Tue, 23 Mar 2021 15:34:29 +0800
Message-ID: <20210323073432.3422227-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset reduce instructions in copy_template.S
to improve the performance of copy memory, when size
is ge 64 bytes.

Yang Yingliang (3):
  arm64: lib: introduce ldp2/stp2 macro
  arm64: lib: improve copy performance when size is ge 128 bytes
  arm64: lib: improve copy performance when size is less than 128 and ge
    64 bytes

 arch/arm64/include/asm/asm-uaccess.h | 16 +++++++++
 arch/arm64/lib/copy_from_user.S      |  8 +++++
 arch/arm64/lib/copy_in_user.S        |  8 +++++
 arch/arm64/lib/copy_template.S       | 54 +++++++++++++++-------------
 arch/arm64/lib/copy_to_user.S        |  8 +++++
 arch/arm64/lib/memcpy.S              |  8 +++++
 6 files changed, 78 insertions(+), 24 deletions(-)

-- 
2.25.1

