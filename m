Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D6324082
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhBXPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235653AbhBXOVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:21:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C928564ED6;
        Wed, 24 Feb 2021 14:19:44 +0000 (UTC)
Date:   Wed, 24 Feb 2021 14:19:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, rppt@kernel.org,
        dyoung@redhat.com, bhe@redhat.com, will@kernel.org,
        nsaenzjulienne@suse.de, corbet@lwn.net, John.P.donnelly@oracle.com,
        bhsharma@redhat.com, prabhakar.pkin@gmail.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, james.morse@arm.com,
        xiexiuqi@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
Message-ID: <20210224141939.GA28965@arm.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130071025.65258-2-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
> Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
> alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
> function reserve_crashkernel() also used 1M alignment. So just
> replace hard-coded alignment 1M with macro CRASH_ALIGN.
[...]
> @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
>  	} else {
>  		unsigned long long start;
>  
> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>  						  crash_base + crash_size);
>  		if (start != crash_base) {
>  			pr_info("crashkernel reservation failed - memory is in use.\n");

There is a small functional change here for x86. Prior to this patch,
crash_base passed by the user on the command line is allowed to be 1MB
aligned. With this patch, such reservation will fail.

Is the current behaviour a bug in the current x86 code or it does allow
1MB-aligned reservations?

-- 
Catalin
