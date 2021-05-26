Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D26391152
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhEZHV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:21:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:36980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhEZHVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:21:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622013622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hu6vbJEUfSy3xVjpGxE3b+lLzlhlYDxtyQ/EIyQiosc=;
        b=G5yhKDNp4+PYobmOwje4fpv7dLvBBCDMWYp+HvxTy6mZ7UVgUMcSSGO8vVm3DY9BZd2+8Z
        HEx0kEFGrGhize7XgHogHyS4f4PnNOK2AvnPrM0xPAebbh/H9zEElNCZjZ0NQHXmr/JhQa
        JSzjw6PtgeHkGxEtNZqqakhQprDWsVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622013622;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hu6vbJEUfSy3xVjpGxE3b+lLzlhlYDxtyQ/EIyQiosc=;
        b=9ad48l5y2ubiKXhnRbjbhg/s79jT9taB+Gy1te+fdt3OQQbBDEIgQdu3/e4u50XotLDFAo
        S//S+53jARk2H2Bg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47DAAAD54;
        Wed, 26 May 2021 07:20:22 +0000 (UTC)
Date:   Wed, 26 May 2021 09:20:19 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arm64 crash while online/offline memory sections
Message-ID: <20210526071948.GA30891@linux>
References: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
 <DM5PR0201MB35576CEF62C53EF393E3D9768E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK07NhNOnKNB02RY@localhost.localdomain>
 <8e0dc9de-6834-72aa-364c-50ce1c717437@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0dc9de-6834-72aa-364c-50ce1c717437@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 08:12:22PM +0200, David Hildenbrand wrote:
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index b31b3af5c490..6e661d106e96 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -218,14 +218,15 @@ static int memory_block_offline(struct memory_block *mem)
>         struct zone *zone;
>         int ret;
> -       zone = page_zone(pfn_to_page(start_pfn));
> -
>         /*
>          * Unaccount before offlining, such that unpopulated zone and kthreads
>          * can properly be torn down in offline_pages().
>          */
> -       if (nr_vmemmap_pages)
> +       if (nr_vmemmap_pages) {
> +               /* Hotplugged memory has no holes. */
> +               zone = page_zone(pfn_to_page(start_pfn));
>                 adjust_present_page_count(zone, -nr_vmemmap_pages);
> +       }
>         ret = offline_pages(start_pfn + nr_vmemmap_pages,
>                             nr_pages - nr_vmemmap_pages);
> 
> 
> We must not touch pfn_to_page(start_pfn) if it might be a memory hole.
> offline_pages() will make sure there are no holes, but that's too late.

Yeah, definitely. I somehow didn't think about holes when writing that.
Thanks for catching it David. Would you be so kind to send a patch?

Thanks!


-- 
Oscar Salvador
SUSE L3
