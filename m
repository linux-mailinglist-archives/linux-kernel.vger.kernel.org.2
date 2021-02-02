Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0630CBF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbhBBTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbhBBTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:40:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9192C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NYshmekz59/ebL0OxMq6zkLH6bwNBE7fSIJ02hCxO5E=; b=zc0ecUaFXW8Aa8RR1aNJNkGVDs
        zAe61YUDA7DTro7PMIgOhMdWGPhl9OgEgdJolVxEBATKtuodxw20gBsZnzw7KhK1NsiyIPqOM9GW4
        hMSDL2g5DsXX3ibmYra7FTmVqwQ/ZBhb/IDR44gDZtXJV+u+v3YWNLT+Bp41Scrv5vrBXS2aHvNBO
        K1n7ysLQ3Os9p226E8BdF0Oht1bK/t41j/92a5/l3G3VGfsb/SN7/yWy8kYRe6cBDNIUsnaKh5HRV
        bWQkqqOxyfnRKtyp3pRoVSu0vQcM2F7bvvFiRSLwx0WpWFrIaESy22l2d73hOgTaPyPNg/Mm5pwXT
        qQzs/31g==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l71Wg-0004IN-Ma; Tue, 02 Feb 2021 19:39:51 +0000
Subject: Re: [PATCH] arm64/ptdump:display the Linear Mapping start marker
To:     Hailong Liu <liuhailongg6@163.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hailong Liu <liu.hailong6@zte.com.cn>
References: <20210202150749.10104-1-liuhailongg6@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c032e6aa-7101-fb3c-09be-425d77877efe@infradead.org>
Date:   Tue, 2 Feb 2021 11:39:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210202150749.10104-1-liuhailongg6@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 7:07 AM, Hailong Liu wrote:
> From: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> The current /sys/kernel/debug/kernel_page_tables does not display the
> *Linear Mapping start* marker on arm64, which I think should be paired
> with the *Linear Mapping start* marker.

paired with itself?  just asking...

> 
> Since *Linear Mapping start* is the first marker, use level=-1 to display it.
> 
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> ---
>  arch/arm64/mm/ptdump.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 04137a8f3d2d..0e050d76b83a 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -324,6 +324,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>  	st = (struct pg_state){
>  		.seq = s,
>  		.marker = info->markers,
> +		.level = -1,
>  		.ptdump = {
>  			.note_page = note_page,
>  			.range = (struct ptdump_range[]){
> 


-- 
~Randy

