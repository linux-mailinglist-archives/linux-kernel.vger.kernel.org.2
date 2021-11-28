Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D294646076B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358409AbhK1QUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358232AbhK1QSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:18:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A6C061748
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 08:15:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84374B80D28
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E6C004E1;
        Sun, 28 Nov 2021 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638116107;
        bh=rYqEjOuhGRt60uVjKCwFcGC7KuRPU2ovghUYTYMOErM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7yBUNy4YNqqt2EydCYUmsGMQ/ojOhslhaUmhU5tXwVdmjLil5xgf0uZJ6Nbs090h
         0bW0t+JSb51IT20MZS6N4mVaCt0QaCKTvMvoy98JVknxwOhbHJ+N0WW4PIGWtNj+7s
         6XUGqtlAhdc4fFhGpspCAstMMIFOA0SDPRWIaG3knab7fSmrcKX6qInGhG9O8Yb2xq
         lgslqsIDdjtdIpoLdJ2oJSBZ0sq4rsEk91ay0iQDVkMKVGZIa+J7zVbYSq3jktSuwE
         qMITcarSVQH/s3enr6eCAxzaqteTA4HXhTp6e5ChkGL4mN8gorHKexwO2KEDAtmC13
         Dsn62e1ySBtgQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 4/5] riscv: errata: alternative: mark vendor_patch_func __initdata
Date:   Mon, 29 Nov 2021 00:07:40 +0800
Message-Id: <20211128160741.2122-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128160741.2122-1-jszhang@kernel.org>
References: <20211128160741.2122-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function pointer vendor_patch_func is only used during init, so
mark it as __initdata.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/errata/alternative.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/errata/alternative.c b/arch/riscv/errata/alternative.c
index 3b15885db70b..e8b4a0fe488c 100644
--- a/arch/riscv/errata/alternative.c
+++ b/arch/riscv/errata/alternative.c
@@ -22,7 +22,8 @@ static struct cpu_manufacturer_info_t {
 } cpu_mfr_info;
 
 static void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
-				 unsigned long archid, unsigned long impid);
+				 unsigned long archid,
+				 unsigned long impid) __initdata;
 
 static inline void __init riscv_fill_cpu_mfr_info(void)
 {
-- 
2.34.0

