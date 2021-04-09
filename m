Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14313596A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhDIHnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:43:50 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:60402 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhDIHnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:43:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 142353F7A0;
        Fri,  9 Apr 2021 09:43:35 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=PlWrzoCP;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TYUFMyAhnJsP; Fri,  9 Apr 2021 09:43:34 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id C6AA13F377;
        Fri,  9 Apr 2021 09:43:33 +0200 (CEST)
Received: from [192.168.0.209] (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 1EE23361DE7;
        Fri,  9 Apr 2021 09:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1617954213; bh=nLyzMwqZi1pS8dIp+5a5AY91s3S25Zv80Z6WNiXvzRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PlWrzoCPHQSTnemMvEoT5uU667LeDa8BjQkJQCqZLvG+gGbOa1WgskCkKGGL9EJTJ
         NHBqExDebeLhuE/WmwJfPvpe5RVHjf8k++rbsQug/wW6ZBd7nb1DUKd1dN5zIb3XYB
         AGilG8zhTb8whaGwgil5IVsQoKVppq2xkKyKpdgM=
Subject: Re: [PATCH] mm/mapping_dirty_helpers: Guard hugepage pud's usage
To:     Zack Rusin <zackr@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20210408191529.677958-1-zackr@vmware.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <0a742aa1-572f-a62f-677f-af430d47a19c@shipmail.org>
Date:   Fri, 9 Apr 2021 09:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408191529.677958-1-zackr@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/21 9:15 PM, Zack Rusin wrote:
> Lets make sure we don't use pud hugepage helpers on architectures
> which do not support it. This fixes the code on arm64.
nits:

Perhaps be a little more specific about what it fixes? I figure it's a 
compilation failure?
Also please use imperative form: "Fix the code arm64" rather than "This 
fixes the code on arm64"

Other than that LGTM.

Reviewed-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>


>
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Hellström (Intel) <thomas_os@shipmail.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   mm/mapping_dirty_helpers.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
> index b59054ef2e10..b890854ec761 100644
> --- a/mm/mapping_dirty_helpers.c
> +++ b/mm/mapping_dirty_helpers.c
> @@ -165,10 +165,12 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
>   		return 0;
>   	}
>   
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>   	/* Huge pud */
>   	walk->action = ACTION_CONTINUE;
>   	if (pud_trans_huge(pudval) || pud_devmap(pudval))
>   		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
> +#endif
>   
>   	return 0;
>   }
