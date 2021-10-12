Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2D429D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhJLGKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhJLGKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:10:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E5F661076;
        Tue, 12 Oct 2021 06:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634018926;
        bh=G5sKg3ur0G15l4uMWAUDfX+JPW8gLjBXoFrTph+IFjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1ktLpcAI9KZGTeL7NeSwH7jPpYd2Nob8gRqAjbdt/jKfcXjbg3QXtXxmIK7ULuu2
         xXIsenm5rCQplL+v6lb72J0ua4mQ6Z/IA+q17UKjFEH+KXw4NHF79btjJXtIGxIU1F
         b46TpYoS9QX1DPmuX/AGsM9XwSBrANNORc4xlzJV8zcamevi8K1Ft1SJJ3lFMLYrA6
         P2BKnEixcKDleXTCAb5GCVvjMK9OpwyaDLchCT1HJUudiZCC4w+dNxLodLukQfK9u3
         x0qEr9KGM5CmM0FRssOFkmt9hIHiIsklpzbeBhWGbM6iqVDaRzvfgyM+VptB6sA5TJ
         1E0NCTxrY9lSQ==
Date:   Tue, 12 Oct 2021 09:08:41 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Panic on kmemleak scan
Message-ID: <YWUmaV7pDBX9zSOl@kernel.org>
References: <8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added Catalin)

On Mon, Oct 11, 2021 at 02:23:31PM +0300, Vladimir Zapolskiy wrote:
> Hello Mike,
> 
> commit a7259df767 ("memblock: make memblock_find_in_range method private") [1]
> invokes a kernel panic while running kmemleak on OF platforms with nomaped
> regions, basically it's similar to an issue reported and fixed earlier by [2]:
> 
>   Unable to handle kernel paging request at virtual address ffff000021e00000

Does this virtual address correspond to a nomap area?

Can you check if this patch helps:

diff --git a/mm/memblock.c b/mm/memblock.c
index 184dcd2e5d99..5c3503c98b2f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -936,7 +936,12 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
+	int ret = memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
+
+	if (!ret)
+		kmemleak_free_part_phys(base, size);
+
+	return ret;
 }
 
 /**

>   [...]
>     scan_block+0x64/0x170
>     scan_gray_list+0xe8/0x17c
>     kmemleak_scan+0x270/0x514
>     kmemleak_write+0x34c/0x4ac
> 
> I believe it would be a trivial problem to correct for you, thank you in
> advance!
> 
> [1] https://lore.kernel.org/all/20210816122622.30279-1-rppt@kernel.org/T/#u
> [2] https://lore.kernel.org/lkml/20190119132832.GA29881@MBP.local/t/#m032124f36c07
> 
> --
> Best wishes,
> Vladimir

-- 
Sincerely yours,
Mike.
