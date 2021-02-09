Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA28315A94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhBJAFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhBIUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:37:00 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20983C0698C1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 12:24:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id k204so19262282oih.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=omhYG+lo9klTl1GoqrXchqkTTUQQQ+tSlhhIlc+D/Po=;
        b=VMz8+0o2dsNDrOKOBkaDXmdsFb3pKdUdrohR3sJY9GjOqGRoE4WF/VAs2TvUFchFbR
         xKzC2SaNE5eLzsJV9m3eEBrfGn7ka0UGaHms/SODzMrHYZlSECIzmgco6cL1EXVvLEjR
         k0HwNd+x77/jBjrD3ZDYFdj1VcnALKxkq8D8ZVdITj+E6kLudRmz2MPSH28/Es+3x8rO
         5O/YLcubsYOiGfkTtxR/fIEEr9WLiQTQKAkF/A5CjU8bDxCAC+d31FAfjfQMNFjVN1XV
         dw63JA4c1l1TxoeTpQ+CY1UFsHsxdBS10BqAp5W9lZE390MfJThS2Rhg8JyQn71Oc9td
         RnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=omhYG+lo9klTl1GoqrXchqkTTUQQQ+tSlhhIlc+D/Po=;
        b=YWpwlSrQIWbn3YQ1n7VB4Z7pU6aPcTB2FFEogDLSeQm9YNBtVQ2UBUwV2Nnr5T/kfv
         teddBs0L05z333CqAJkHGX9A9/tjO74DHkFAXkh2Jx8TTZEtFBNDq86PdxDwjXsGwk3S
         OdExKOX7AIYmfvDei1UdyrtFK2DObmyCayvajMKmE4tZ32JhtMgocD2yE027Zaysec71
         Z01d4Y2/KQks2WsOp6JyFnOfL4rZi0mw6euqUksVZzCdYvVYJBscKfDs1T0TSKMshmSo
         1CuPM2vqlwGu+Vjwg0ol38fB17pluRseU4KIhOt/l6D7ejUv0fxtJeU/vDqHZ063dQhD
         ty8Q==
X-Gm-Message-State: AOAM532hlSdpy4fT5SjTXdrkamT5i40tjUrvmfGMC9Spr/Qji1IbLaVX
        8jZWlg0RvPt5cxvCbKYSqTE=
X-Google-Smtp-Source: ABdhPJymKKc+XVUpenxf+jd1ScMukrmFbuvTNcw31j1lCdP+8lRjoLEVTS2kUqbaqB1/SFt8FBqo8w==
X-Received: by 2002:aca:cf52:: with SMTP id f79mr3633917oig.73.1612902291411;
        Tue, 09 Feb 2021 12:24:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u126sm4659966oig.55.2021.02.09.12.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 12:24:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Feb 2021 12:24:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 1/8] mm: Cleanup faultaround and finish_fault()
 codepaths
Message-ID: <20210209202449.GA104837@roeck-us.net>
References: <20210114175934.13070-1-will@kernel.org>
 <20210114175934.13070-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114175934.13070-2-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 05:59:27PM +0000, Will Deacon wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> alloc_set_pte() has two users with different requirements: in the
> faultaround code, it called from an atomic context and PTE page table
> has to be preallocated. finish_fault() can sleep and allocate page table
> as needed.
> 
> PTL locking rules are also strange, hard to follow and overkill for
> finish_fault().
> 
> Let's untangle the mess. alloc_set_pte() has gone now. All locking is
> explicit.
> 
> The price is some code duplication to handle huge pages in faultaround
> path, but it should be fine, having overall improvement in readability.
> 
> Link: https://lore.kernel.org/r/20201229132819.najtavneutnf7ajp@box
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> [will: s/from from/from/ in comment; spotted by willy]
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  fs/xfs/xfs_file.c       |   6 +-
>  include/linux/mm.h      |  12 ++-
>  include/linux/pgtable.h |  11 +++
>  mm/filemap.c            | 177 ++++++++++++++++++++++++++---------
>  mm/memory.c             | 199 ++++++++++++----------------------------
>  5 files changed, 213 insertions(+), 192 deletions(-)
> 

When building microblaze:mmu_defconfig:

mm/filemap.c: In function 'filemap_map_pages':
mm/filemap.c:3153:3: error: implicit declaration of function 'update_mmu_cache'; did you mean 'update_mmu_tlb'?

Bisect log attached.

Guenter

---
# bad: [a4bfd8d46ac357c12529e4eebb6c89502b03ecc9] Add linux-next specific files for 20210209
# good: [92bf22614b21a2706f4993b278017e437f7785b3] Linux 5.11-rc7
git bisect start 'HEAD' 'v5.11-rc7'
# bad: [a8eb921ba7e8e77d994a1c6c69c8ef08456ecf53] Merge remote-tracking branch 'crypto/master'
git bisect bad a8eb921ba7e8e77d994a1c6c69c8ef08456ecf53
# bad: [b68df186dae8ae890df08059bb068b78252b053a] Merge remote-tracking branch 'hid/for-next'
git bisect bad b68df186dae8ae890df08059bb068b78252b053a
# bad: [323c9f6fb99b033883b404ecbc811e7b283a60b3] Merge remote-tracking branch 'sunxi/sunxi/for-next'
git bisect bad 323c9f6fb99b033883b404ecbc811e7b283a60b3
# bad: [4053c8a4d3b53205272aa16b65a5b7ed1a3a5b3e] Merge remote-tracking branch 'arm-soc/for-next'
git bisect bad 4053c8a4d3b53205272aa16b65a5b7ed1a3a5b3e
# good: [dfb8870aed6ad71fb7e378274521bf68a7d465cb] Merge branch 'arm/dt' into for-next
git bisect good dfb8870aed6ad71fb7e378274521bf68a7d465cb
# good: [9ad7e5a35f96b8bf8aebedfd8f397a64eecb21bd] Merge remote-tracking branch 'arm/for-next'
git bisect good 9ad7e5a35f96b8bf8aebedfd8f397a64eecb21bd
# good: [edc55d8409542cd05d5c17203615a162cddbcb4c] Merge branch 'arm/drivers' into for-next
git bisect good edc55d8409542cd05d5c17203615a162cddbcb4c
# good: [d1bbc35fcab28668c8992c4d5777234b794d7306] arm64: hibernate: add __force attribute to gfp_t casting
git bisect good d1bbc35fcab28668c8992c4d5777234b794d7306
# bad: [fb01b86f47a44f0c03278a7cc78ece8415898ed0] Merge branches 'for-next/cosmetic', 'for-next/crypto', 'for-next/faultaround', 'for-next/from-tip/irq/urgent', 'for-next/kexec', 'for-next/misc', 'for-next/mm', 'for-next/perf', 'for-next/random', 'for-next/rng', 'for-next/selftests', 'for-next/stacktrace', 'for-next/topology' and 'for-next/vdso' into for-next/core
git bisect bad fb01b86f47a44f0c03278a7cc78ece8415898ed0
# good: [750d43b4a79e5f3767ee1db933b42abdf967ce1e] dt-bindings: arm: add Cortex-A78 binding
git bisect good 750d43b4a79e5f3767ee1db933b42abdf967ce1e
# good: [0188a894c390e51475274ece76b4d601782d709e] arm64: vmlinux.ld.S: add assertion for tramp_pg_dir offset
git bisect good 0188a894c390e51475274ece76b4d601782d709e
# bad: [3f98a28cc37253269b4104cf95a51f7716a2eb97] mm/nommu: Fix return type of filemap_map_pages()
git bisect bad 3f98a28cc37253269b4104cf95a51f7716a2eb97
# bad: [742d33729a0df11c9d8d4625dbf21dd20cdefd44] mm: Move immutable fields of 'struct vm_fault' into anonymous struct
git bisect bad 742d33729a0df11c9d8d4625dbf21dd20cdefd44
# bad: [46bdb4277f98e70d0c91f4289897ade533fe9e80] mm: Allow architectures to request 'old' entries when prefaulting
git bisect bad 46bdb4277f98e70d0c91f4289897ade533fe9e80
# bad: [f9ce0be71d1fbb038ada15ced83474b0e63f264d] mm: Cleanup faultaround and finish_fault() codepaths
git bisect bad f9ce0be71d1fbb038ada15ced83474b0e63f264d
# first bad commit: [f9ce0be71d1fbb038ada15ced83474b0e63f264d] mm: Cleanup faultaround and finish_fault() codepaths

