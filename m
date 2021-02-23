Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AC93225AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhBWGKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:10:42 -0500
Received: from foss.arm.com ([217.140.110.172]:59710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhBWGKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:10:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 409E7ED1;
        Mon, 22 Feb 2021 22:09:52 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 368173F73D;
        Mon, 22 Feb 2021 22:09:47 -0800 (PST)
Subject: Re: [PATCH] Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH
 doesn't apply to ARM64
To:     Barry Song <song.bao.hua@hisilicon.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org, Mel Gorman <mgorman@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20210223003230.11976-1-song.bao.hua@hisilicon.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <09dd1026-9e3f-b9be-b5a5-82771642348d@arm.com>
Date:   Tue, 23 Feb 2021 11:40:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223003230.11976-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/21 6:02 AM, Barry Song wrote:
> BATCHED_UNMAP_TLB_FLUSH is used on x86 to do batched tlb shootdown by
> sending one IPI to TLB flush all entries after unmapping pages rather
> than sending an IPI to flush each individual entry.
> On arm64, tlb shootdown is done by hardware. Flush instructions are
> innershareable. The local flushes are limited to the boot (1 per CPU)
> and when a task is getting a new ASID.

Is there any previous discussion around this ?

> So marking this feature as "TODO" is not proper. ".." isn't good as
> well. So this patch adds a "N/A" for this kind of features which are
> not needed on some architectures.
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/features/arch-support.txt        | 1 +
>  Documentation/features/vm/TLB/arch-support.txt | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
> index d22a1095e661..118ae031840b 100644
> --- a/Documentation/features/arch-support.txt
> +++ b/Documentation/features/arch-support.txt
> @@ -8,4 +8,5 @@ The meaning of entries in the tables is:
>      | ok |  # feature supported by the architecture
>      |TODO|  # feature not yet supported by the architecture
>      | .. |  # feature cannot be supported by the hardware
> +    | N/A|  # feature doesn't apply to the architecture

NA might be better here. s/doesn't apply/not applicable/ in order to match NA.
Still wondering if NA is really needed when there is already ".." ? Regardless
either way should be fine.

>  
> diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
> index 30f75a79ce01..0d070f9f98d8 100644
> --- a/Documentation/features/vm/TLB/arch-support.txt
> +++ b/Documentation/features/vm/TLB/arch-support.txt
> @@ -9,7 +9,7 @@
>      |       alpha: | TODO |
>      |         arc: | TODO |
>      |         arm: | TODO |
> -    |       arm64: | TODO |
> +    |       arm64: | N/A  |
>      |         c6x: |  ..  |
>      |        csky: | TODO |
>      |       h8300: |  ..  |
> 
