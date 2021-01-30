Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6831D309767
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhA3Ryd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 12:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhA3Ry3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 12:54:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3C4C061573;
        Sat, 30 Jan 2021 09:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=r968U5unr3V3GLWy0PdpbYarRwMGU/lEp6681LekGd8=; b=Laiab9D0nWGgpVEOZaJ07BdBOB
        P0zzHUwe1Fzmr26PFV46BlktFmhy07H6v+4qQFuXu2hM+n//TzHqX85I5SWTFKfxh/6o/UbZMQ1OA
        ST33rSISF7qCkgHZURNjZh4f7WT3reO/F7o6wQejhmEPf4g27nPqj6K3E+gw89TPotrZ43NmBO6/M
        Ix+qlJbUc/PWBUxG3ajoPp5CTbyULRgEaoCnZcFLvUGmwMV0k/t5sgSeeGrY0mb/IDRp0cY16HtJk
        0pj6lxnNV9Le/eZptOpHJsjh4zlfL3jzlB6ypv4r/JUlUFhNRWzyYQYxACmx393XyKIA/8BWRNxDA
        rpt3EBiQ==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5uRJ-0007Wc-Sy; Sat, 30 Jan 2021 17:53:42 +0000
Subject: Re: [PATCH v14 11/11] kdump: update Documentation about crashkernel
To:     Chen Zhou <chenzhou10@huawei.com>, mingo@redhat.com,
        tglx@linutronix.de, rppt@kernel.org, dyoung@redhat.com,
        bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        nsaenzjulienne@suse.de, corbet@lwn.net, John.P.donnelly@oracle.com,
        bhsharma@redhat.com, prabhakar.pkin@gmail.com
Cc:     horms@verge.net.au, robh+dt@kernel.org, arnd@arndb.de,
        james.morse@arm.com, xiexiuqi@huawei.com, guohanjun@huawei.com,
        huawei.libin@huawei.com, wangkefeng.wang@huawei.com,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-12-chenzhou10@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <686c331c-8009-1203-e8fe-b1ae67ae9652@infradead.org>
Date:   Sat, 30 Jan 2021 09:53:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210130071025.65258-12-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/29/21 11:10 PM, Chen Zhou wrote:
> ---
>  Documentation/admin-guide/kdump/kdump.rst     | 22 ++++++++++++++++---
>  .../admin-guide/kernel-parameters.txt         | 11 ++++++++--
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a10b545c2070..908e5c8b61ba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt

All of the "arm64" instances in [square brackets] should be "ARM64".

> @@ -738,6 +738,9 @@
>  			[KNL, X86-64] Select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
> +			[KNL, arm64] Try low allocation in DMA zone and fall back

			      here

> +			to high allocation if it fails when '@offset' hasn't been
> +			specified.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
> @@ -754,6 +757,8 @@
>  			Otherwise memory region will be allocated below 4G, if
>  			available.
>  			It will be ignored if crashkernel=X is specified.
> +			[KNL, arm64] range in high memory.

			      here

> +			Allow kernel to allocate physical memory region from top.
>  	crashkernel=size[KMG],low
>  			[KNL, X86-64] range under 4G. When crashkernel=X,high
>  			is passed, kernel could allocate physical memory region
> @@ -762,13 +767,15 @@
>  			requires at least 64M+32K low memory, also enough extra
>  			low memory is needed to make sure DMA buffers for 32-bit
>  			devices won't run out. Kernel would try to allocate at
> -			at least 256M below 4G automatically.
> +			least 256M below 4G automatically.
>  			This one let user to specify own low range under 4G
>  			for second kernel instead.
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
> -
> +			[KNL, arm64] range in low memory.

			      here

> +			This one let user to specify a low range in DMA zone for
> +			crash dump kernel.


Thanks.

-- 
~Randy

