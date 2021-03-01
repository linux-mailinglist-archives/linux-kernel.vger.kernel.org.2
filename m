Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64D328BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhCASiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 13:38:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233518AbhCAQlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:41:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 315DE64DF5;
        Mon,  1 Mar 2021 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614616129;
        bh=ugIPlnR3uZHy1NSFOnPp5bkhtRS0yi4mhFhfoLYbLl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLhjUj6ld6TbR9WqObxO5XgCKAce+LXoh5SxdaCEAFo6iyQ9KotNR2yhKoSYx+WyE
         PiAvexD1U6lpaFbfLsY485xJlgePms9/IVCbpyEZR2z9DaOu0/xX6AwJej8UwSnjI5
         4H9uIiu5oRguiRa15iQqHNrTrbNxWXLd6xBVVNlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 045/176] MIPS: c-r4k: Fix section mismatch for loongson2_sc_init
Date:   Mon,  1 Mar 2021 17:11:58 +0100
Message-Id: <20210301161023.207590677@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161020.931630716@linuxfoundation.org>
References: <20210301161020.931630716@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit c58734eee6a2151ba033c0dcb31902c89e310374 ]

When building with clang, the following section mismatch warning occurs:

WARNING: modpost: vmlinux.o(.text+0x24490): Section mismatch in
reference from the function r4k_cache_init() to the function
.init.text:loongson2_sc_init()

This should have been fixed with commit ad4fddef5f23 ("mips: fix Section
mismatch in reference") but it was missed. Remove the improper __init
annotation like that commit did.

Fixes: 078a55fc824c ("MIPS: Delete __cpuinit/__CPUINIT usage from MIPS code")
Link: https://github.com/ClangBuiltLinux/linux/issues/787
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/mm/c-r4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e4de107bf7fd8..c1afed6b1ce72 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1665,7 +1665,7 @@ static int probe_scache(void)
 	return 1;
 }
 
-static void __init loongson2_sc_init(void)
+static void loongson2_sc_init(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
-- 
2.27.0



