Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA073DC708
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhGaQ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhGaQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 12:56:12 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950FC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:56:04 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u25so18079606oiv.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EGVOaVtjMq5XNSC5HlGQYOQPa1eoJCtX+l2Bxd44EkE=;
        b=IXw4JxmRSJzZhZ0FKi7pak4HydBuQq8t+Plwb1wNOQgWbdHNV6byOKqQmJPHWKlCrS
         i9UN89jR3d/Imv+U+OXR3HSPZjdH52Sr3i+T3ixxzRa/C7GW7fMlub1xDDgWPyj/9qwu
         ZESuVvW73kLasTQwwu/NUgMUCrcA8eh+p8GFHJfMn7XJwroKRwIwmD/tdi7fEhHwZBN8
         3sy8BABBIdZ27CcDUDqcp2tjkqCql0QZAx5gMOZigCFry9MQ4kxl43oV1DuVFvOib6qD
         ZZQBK6Zr65Ww/o3eeZQzVxkH2cBclxpbJL47juFCjIYE79QnWVmsEeicLoNy5REHMuUi
         3CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EGVOaVtjMq5XNSC5HlGQYOQPa1eoJCtX+l2Bxd44EkE=;
        b=a4xQwpDwLkD85Gjq6Cjtn7leBavucSKePop/ldLSAHvWk+rnUOs2UlcZcv6C6H8KQO
         OkMCHwHA8vTZrNWP0z7npDv8KqPcyvKYHS9zwgyYbr3H8LCCus0uAgPl5p7U3T8moHxM
         PgyTbkL96Tmf8K/kn884AfNTRqicWd1ZilgWhhkvCu6N1r0vxY0SHyBNIzNgcEUbPBvg
         0Dzb2P+E8ZKMQ2skMIPWyl+3g/B4SkBft0+f2Phl9eSbNK8V0CJzqjsdqpxvzx7zSPyO
         dNF1ObzudiU1Uaglk8+XK0U3BCwRm3V4GNh77vnxxpJVYtFyUk8iZz5IiB1Fva06Xi5t
         VqAA==
X-Gm-Message-State: AOAM53241geD00nOanxCPLX8uS/oAxyTQIp5OA3wY7yojfwrZ1rlu8cy
        66e/bW46emvO/p9VN5r+cVg=
X-Google-Smtp-Source: ABdhPJxwCvTkqEL4wIKWqOZ9mVLAobF7kDSqaQBWYtGj5OXQyue8bo31EWau92yY9t1cqMCHPWugUw==
X-Received: by 2002:a05:6808:d4d:: with SMTP id w13mr5884374oik.98.1627750564188;
        Sat, 31 Jul 2021 09:56:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id be15sm880127oib.18.2021.07.31.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 09:56:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Jul 2021 09:56:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/page_alloc: always initialize memory map for the
 holes
Message-ID: <20210731165601.GA1900220@roeck-us.net>
References: <20210714123739.16493-1-rppt@kernel.org>
 <20210714123739.16493-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714123739.16493-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 14, 2021 at 03:37:36PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Currently memory map for the holes is initialized only when SPARSEMEM
> memory model is used. Yet, even with FLATMEM there could be holes in the
> physical memory layout that have memory map entries.
> 
> For instance, the memory reserved using e820 API on i386 or
> "reserved-memory" nodes in device tree would not appear in memblock.memory
> and hence the struct pages for such holes will be skipped during memory map
> initialization.
> 
> These struct pages will be zeroed because the memory map for FLATMEM
> systems is allocated with memblock_alloc_node() that clears the allocated
> memory. While zeroed struct pages do not cause immediate problems, the
> correct behaviour is to initialize every page using __init_single_page().
> Besides, enabling page poison for FLATMEM case will trigger
> PF_POISONED_CHECK() unless the memory map is properly initialized.
> 
> Make sure init_unavailable_range() is called for both SPARSEMEM and FLATMEM
> so that struct pages representing memory holes would appear as PG_Reserved
> with any memory layout.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

This patch causes microblaze petalogix-ml605 qemu emulations to fail
silently (no console output). Reverting it fixes the problem.

Guenter

---
Bisect log:

# bad: [8d4b477da1a807199ca60e0829357ce7aa6758d5] Add linux-next specific files for 20210730
# good: [ff1176468d368232b684f75e82563369208bc371] Linux 5.14-rc3
git bisect start 'HEAD' 'v5.14-rc3'
# good: [8f3eb1f5c702ef868d89799b03c21d122f2fe197] Merge remote-tracking branch 'bpf-next/for-next'
git bisect good 8f3eb1f5c702ef868d89799b03c21d122f2fe197
# good: [32286c7080c56c835f25302c38eebccf41b7b576] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 32286c7080c56c835f25302c38eebccf41b7b576
# good: [70c40604c7d393f95171f49717a27bf8e05b5439] Merge remote-tracking branch 'dmaengine/next'
git bisect good 70c40604c7d393f95171f49717a27bf8e05b5439
# good: [b038834891b35ec410693028a500f769db132a81] Merge remote-tracking branch 'rust/rust-next'
git bisect good b038834891b35ec410693028a500f769db132a81
# bad: [d8f4e506a9ba375110945d75573b3304491e6350] memory-hotplug.rst: complete admin-guide overhaul
git bisect bad d8f4e506a9ba375110945d75573b3304491e6350
# good: [bef692dcfb7cdb5c960abfc31e2386a0ff41af54] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
git bisect good bef692dcfb7cdb5c960abfc31e2386a0ff41af54
# bad: [5fcd957e2f0dc4cb25a6ee60ebfb1200de09c9d1] mm-migrate-demote-pages-during-reclaim-v11
git bisect bad 5fcd957e2f0dc4cb25a6ee60ebfb1200de09c9d1
# good: [8c2a82ab20eb09d217446989ae209f5ff19a64ac] mm/vmalloc: use batched page requests in bulk-allocator
git bisect good 8c2a82ab20eb09d217446989ae209f5ff19a64ac
# bad: [c36a5446e29f1461780b06785769b9402522f847] mm/page_alloc.c: fix 'zone_id' may be used uninitialized in this function warning
git bisect bad c36a5446e29f1461780b06785769b9402522f847
# good: [05e358c552628e26be3985933bea88e7512414c0] mm/kasan: move kasan.fault to mm/kasan/report.c
git bisect good 05e358c552628e26be3985933bea88e7512414c0
# bad: [b467ff7f560908e60ca181658b7ee48e5da94da1] microblaze: simplify pte_alloc_one_kernel()
git bisect bad b467ff7f560908e60ca181658b7ee48e5da94da1
# bad: [d2a572bf593a57246827bd79c91fe2ee6b7af1f0] mm/page_alloc: always initialize memory map for the holes
git bisect bad d2a572bf593a57246827bd79c91fe2ee6b7af1f0
# first bad commit: [d2a572bf593a57246827bd79c91fe2ee6b7af1f0] mm/page_alloc: always initialize memory map for the holes
