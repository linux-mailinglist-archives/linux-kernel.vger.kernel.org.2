Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90D357AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhDHD5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:57:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16821 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHD5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:57:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FG6ph4Vh3z7tpg;
        Thu,  8 Apr 2021 11:54:52 +0800 (CST)
Received: from huawei.com (10.67.174.142) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 11:56:54 +0800
From:   <johnny.chenyi@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <aneesh.kumar@linux.ibm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yuehaibing@huawei.com>, <heying24@huawei.com>
Subject: [PATCH-next] powerpc/interrupt: Remove duplicate header file
Date:   Thu, 8 Apr 2021 11:56:44 +0800
Message-ID: <20210408035644.2417002-1-johnny.chenyi@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.142]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yi <johnny.chenyi@huawei.com>

Delete one of the header files <asm/interrupt.h> that are included
twice.

Signed-off-by: Chen Yi <johnny.chenyi@huawei.com>
---
 arch/powerpc/kernel/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index c4dd4b8f9cfa..f64ace0208b7 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -7,7 +7,6 @@
 #include <asm/asm-prototypes.h>
 #include <asm/kup.h>
 #include <asm/cputime.h>
-#include <asm/interrupt.h>
 #include <asm/hw_irq.h>
 #include <asm/interrupt.h>
 #include <asm/kprobes.h>
-- 
2.31.0

