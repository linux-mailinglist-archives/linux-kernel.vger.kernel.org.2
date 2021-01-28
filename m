Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1781C306B34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhA1Crg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229569AbhA1Cr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611801960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPo1STRYTKfqs7mFA7ySYVGYtwah0YVMMd6XdvG+LT4=;
        b=h9OVplUyC02+IhaxJHYw5hoCLbFMd/+bN/r6PtTo853nBcYoTGER2v5MVg5jNXFhp6bWQd
        X6qNLB5uivGxJCvf8PYUfq1u02e7PglC1e/G3oFNnkcei4SeAQLQW/zw4I7hsBBw80/Rp9
        fIi7DF0I8SdmOxv/0oVF8PMZ0qL5tsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-TqP09w0eMA-KLnRjWLG-nw-1; Wed, 27 Jan 2021 21:45:55 -0500
X-MC-Unique: TqP09w0eMA-KLnRjWLG-nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29AB356BE6;
        Thu, 28 Jan 2021 02:45:53 +0000 (UTC)
Received: from localhost (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D309818A2F;
        Thu, 28 Jan 2021 02:45:51 +0000 (UTC)
Date:   Thu, 28 Jan 2021 10:45:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     =?utf-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>,
        Guenter Roeck <groeck@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>
Subject: Re: PROBLEM: Crash after mm: fix initialization of struct page for
 holes in memory layout
Message-ID: <20210128024549.GA3693@MiWiFi-R3L-srv>
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
 <20210127100454.GK196782@linux.ibm.com>
 <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
 <20210127111858.GA273567@linux.ibm.com>
 <CAFJ_xbo8Zv9VdJibC106sFOqoYsVhifm0eh=VWtMzeoUE4KVWA@mail.gmail.com>
 <CAFJ_xbrwLwgDfCyHA=PmJ8j_3dJXqVNxmv7e+ATQAAa9n3de2w@mail.gmail.com>
 <20210127182651.GA281042@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127182651.GA281042@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/27/21 at 08:26pm, Mike Rapoport wrote:
> Hi Lukasz,
> 
> On Wed, Jan 27, 2021 at 02:15:53PM +0100, Łukasz Majczak wrote:
> > Hi Mike,
> > 
> > I have started bisecting your patch and I have figured out that there
> > might be something wrong with clamping - with comments out these lines
> > it started to work.
> > The full log (with logs from below patch) can be found here:
> > https://gist.github.com/semihalf-majczak-lukasz/3cecbab0ddc59a6c3ce11ddc29645725
> > it's fresh - I haven't analyze it yet, just sharing with hope it will help.
> 
> Thanks, that helps!
> 
> The first page is never considered by the kernel as memory and so
> arch_zone_lowest_possible_pfn[ZONE_DMA] is set to 0x1000. As the result,
> init_unavailable_mem() skips pfn 0 and then __SetPageReserved(page) in
> reserve_bootmem_region() panics because the struct page for pfn 0 remains
> poisoned.

It's a great finding and quick fix. Previously I tested my cleanup
patches based on Mike's commit 9ebeee59af4cdd4d ("mm: fix initialization
of struct page for holes in memory layout") on a hardware system,
didn't meet this crash. But this crash seems to be a always reproduced
issue, wondering why I didn't reproduce it.

> 
> Can you please try the below patch on top of v5.11-rc5?
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 783913e41f65..3ce9ef238dfc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7083,10 +7083,11 @@ void __init free_area_init_memoryless_node(int nid)
>  static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn,
>  					 int zone, int nid)
>  {
> -	unsigned long pfn, zone_spfn, zone_epfn;
> +	unsigned long pfn, zone_spfn = 0, zone_epfn;
>  	u64 pgcnt = 0;
>  
> -	zone_spfn = arch_zone_lowest_possible_pfn[zone];
> +	if (zone > 0)
> +		zone_spfn = arch_zone_highest_possible_pfn[zone - 1];
>  	zone_epfn = arch_zone_highest_possible_pfn[zone];
>  
>  	spfn = clamp(spfn, zone_spfn, zone_epfn);
> 
>  
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index eed54ce26ad1..9f4468c413a1 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7093,9 +7093,11 @@ static u64 __init
> > init_unavailable_range(unsigned long spfn, unsigned long epfn,
> >         zone_spfn = arch_zone_lowest_possible_pfn[zone];
> >         zone_epfn = arch_zone_highest_possible_pfn[zone];
> > 
> > -       spfn = clamp(spfn, zone_spfn, zone_epfn);
> > -       epfn = clamp(epfn, zone_spfn, zone_epfn);
> > -
> > +       //spfn = clamp(spfn, zone_spfn, zone_epfn);
> > +       //epfn = clamp(epfn, zone_spfn, zone_epfn);
> > +       pr_info("LMA DBG: zone_spfn: %llx, zone_epfn %llx\n",
> > zone_spfn, zone_epfn);
> > +       pr_info("LMA DBG: spfn: %llx, epfn %llx\n", spfn, epfn);
> > +       pr_info("LMA DBG: clamp_spfn: %llx, clamp_epfn %llx\n",
> > clamp(spfn, zone_spfn, zone_epfn), clamp(epfn, zone_spfn, zone_epfn));
> >         for (pfn = spfn; pfn < epfn; pfn++) {
> >                 if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> >                         pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> > 
> > Best regards,
> > Lukasz
> > 
> > 
> > śr., 27 sty 2021 o 13:15 Łukasz Majczak <lma@semihalf.com> napisał(a):
> > >
> > > Unfortunately nothing :( my current kernel command line contains:
> > > console=ttyS0,115200n8 debug earlyprintk=serial loglevel=7
> > >
> > > I was thinking about using earlycon, but it seems to be blocked.
> > > (I think the lack of earlycon might be related to Chromebook HW
> > > security design. There is an EC controller which is a part of AP ->
> > > serial chain as kernel messages are considered sensitive from a
> > > security standpoint.)
> > >
> > > Best regards,
> > > Lukasz
> > >
> > > śr., 27 sty 2021 o 12:19 Mike Rapoport <rppt@linux.ibm.com> napisał(a):
> > > >
> > > > On Wed, Jan 27, 2021 at 11:08:17AM +0100, Łukasz Majczak wrote:
> > > > > Hi Mike,
> > > > >
> > > > > Actually I have a serial console attached (via servo device), but
> > > > > there is no output :( and also the reboot/crash is very fast/immediate
> > > > > after power on.
> > > >
> > > > If you boot with earlyprintk=serial are there any messages?
> > > >
> > > > > Best regards
> > > > > Lukasz
> > > > >
> > > > > śr., 27 sty 2021 o 11:05 Mike Rapoport <rppt@linux.ibm.com> napisał(a):
> > > > > >
> > > > > > Hi Lukasz,
> > > > > >
> > > > > > On Wed, Jan 27, 2021 at 10:22:29AM +0100, Łukasz Majczak wrote:
> > > > > > > Crash after mm: fix initialization of struct page for holes in memory layout
> > > > > > >
> > > > > > > Hi,
> > > > > > > I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Caroline),
> > > > > > > but I've noticed it has crashed - unfortunately it seems to happen at
> > > > > > > a very early stage - No output to the console nor to the screen, so I
> > > > > > > have started a bisect (between 5.11-rc4 - which works just find - and
> > > > > > > 5.11-rc5),
> > > > > > > bisect results points to:
> > > > > > >
> > > > > > > d3921cb8be29 mm: fix initialization of struct page for holes in memory layout
> > > > > > >
> > > > > > > Reproduction is just to build and load the kernel.
> > > > > > >
> > > > > > > If it will help any how I am attaching:
> > > > > > > - /proc/cpuinfo (from healthy system):
> > > > > > > https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377c1a785b64a97066
> > > > > > > - my .config file (for a broken system):
> > > > > > > https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b53efe8e18b5da33c
> > > > > > >
> > > > > > > If there is anything I could add/do/test to help fix this please let me know.
> > > > > >
> > > > > > Chris Wilson also reported boot failures on several Chromebooks:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/161160687463.28991.354987542182281928@build.alporthouse.com
> > > > > >
> > > > > > I presume serial console is not an option, so if you could boot with
> > > > > > earlyprintk=vga and see if there is anything useful printed on the screen
> > > > > > it would be really helpful.
> > > > > >
> > > > > > > Best regards
> > > > > > > Lukasz
> > > > > >
> > > > > > --
> > > > > > Sincerely yours,
> > > > > > Mike.
> > > >
> > > > --
> > > > Sincerely yours,
> > > > Mike.
> 
> -- 
> Sincerely yours,
> Mike.
> 

