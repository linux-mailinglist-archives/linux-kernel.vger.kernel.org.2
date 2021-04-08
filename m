Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6153A357AD4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhDHDkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:40:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16029 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhDHDkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:40:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FG6QC0MGLzNtq1;
        Thu,  8 Apr 2021 11:37:07 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 11:39:46 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <jniethe5@gmail.com>,
        <alistair@popple.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yangjihong1@huawei.com>, <zhangjinhao2@huawei.com>,
        <lihuafei1@huawei.com>
Subject: [PATCH -next] powerpc/security: Make symbol 'stf_barrier' static
Date:   Thu, 8 Apr 2021 11:39:51 +0800
Message-ID: <20210408033951.28369-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

arch/powerpc/kernel/security.c:253:6: warning:
 symbol 'stf_barrier' was not declared. Should it be static?

This symbol is not used outside of security.c, so this commit marks it
static.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/powerpc/kernel/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index e4e1a94ccf6a..4de6bbd9672e 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -250,7 +250,7 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 
 static enum stf_barrier_type stf_enabled_flush_types;
 static bool no_stf_barrier;
-bool stf_barrier;
+static bool stf_barrier;
 
 static int __init handle_no_stf_barrier(char *p)
 {
-- 
2.17.1

