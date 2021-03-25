Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E071D3495C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhCYPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:36:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhCYPgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:36:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616686558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hpz5bZISM1LPyawPkc+NNNxx8vN1clwZYSZEi0x1MIs=;
        b=nMpO1UOk1RdHTKFtgRVc34rgrYVPuo2Xk4zaR2ml/ODzH2v0YITYLapp/S3OdEb9hwiHrw
        c0UQPmQFqRgBr80ox2K/hNZhHrab3Rs/UgPVxX5/GOyY0Q3dEtn4ReFQcunBDyar1FHtp/
        l/NdTOawXeAo0AYkdCk53AJSNt57f+k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98323AA55;
        Thu, 25 Mar 2021 15:35:58 +0000 (UTC)
Date:   Thu, 25 Mar 2021 16:35:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
References: <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
 <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
 <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
 <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
 <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 16:19:36, David Hildenbrand wrote:
> On 25.03.21 16:12, Michal Hocko wrote:
> > On Thu 25-03-21 15:46:22, David Hildenbrand wrote:
> > > On 25.03.21 15:34, Michal Hocko wrote:
> > > > On Thu 25-03-21 15:09:35, David Hildenbrand wrote:
> > > > > On 25.03.21 15:08, Michal Hocko wrote:
> > > > > > On Thu 25-03-21 13:40:45, David Hildenbrand wrote:
> > > > > > > On 25.03.21 13:35, Michal Hocko wrote:
> > > > > > > > On Thu 25-03-21 12:08:43, David Hildenbrand wrote:
> > > > > > > > > On 25.03.21 11:55, Oscar Salvador wrote:
> > > > > > [...]
> > > > > > > > > > - When moving the initialization/accounting to hot-add/hot-remove,
> > > > > > > > > >        the section containing the vmemmap pages will remain offline.
> > > > > > > > > >        It might get onlined once the pages get online in online_pages(),
> > > > > > > > > >        or not if vmemmap pages span a whole section.
> > > > > > > > > >        I remember (but maybe David rmemeber better) that that was a problem
> > > > > > > > > >        wrt. pfn_to_online_page() and hybernation/kdump.
> > > > > > > > > >        So, if that is really a problem, we would have to care of ot setting
> > > > > > > > > >        the section to the right state.
> > > > > > > > > 
> > > > > > > > > Good memory. Indeed, hibernation/kdump won't save the state of the vmemmap,
> > > > > > > > > because the memory is marked as offline and, thus, logically without any
> > > > > > > > > valuable content.
> > > > 
> > > > ^^^^ THIS
> > > > 
> > > > > > > > 
> > > > > > > > Could you point me to the respective hibernation code please? I always
> > > > > > > > get lost in that area. Anyway, we do have the same problem even if the
> > > > > > > > whole accounting is handled during {on,off}lining, no?
> > > > > > > 
> > > > > > > kernel/power/snapshot.c:saveable_page().
> > > > > > 
> > > > > > Thanks! So this is as I've suspected. The very same problem is present
> > > > > > if the memory block is marked offline. So we need a solution here
> > > > > > anyway. One way to go would be to consider these vmemmap pages always
> > > > > > online. pfn_to_online_page would have to special case them but we would
> > > > > > need to identify them first. I used to have PageVmemmap or something
> > > > > > like that in my early attempt to do this.
> > > > > > 
> > > > > > That being said this is not an argument for one or the other aproach.
> > > > > > Both need fixing.
> > > > > 
> > > > > Can you elaborate? What is the issue there? What needs fixing?
> > > > 
> > > > offline section containing vmemmap will be lost during hibernation cycle
> > > > IIU the above correctly.
> > > > 
> > > 
> > > Can tell me how that is a problem with Oscars current patch? I only see this
> > > being a problem with what you propose - most probably I am missing something
> > > important here.
> > > 
> > > Offline memory sections don't have a valid memmap (assumption: garbage). On
> > > hibernation, the whole offline memory block won't be saved, including the
> > > vmemmap content that resides on the block. This includes the vmemmap of the
> > > vmemmap pages, which is itself.
> > > 
> > > When restoring, the whole memory block will contain garbage, including the
> > > whole vmemmap - which is marked to be offline and to contain garbage.
> > 
> > Hmm, so I might be misunderstanding the restoring part. But doesn't that
> > mean that the whole section/memory block won't get restored because it
> > is offline and therefore the vmemmap would be pointing to nowhere?
> 
> AFAIU, only the content of the memory block won't be restored - whatever
> memory content existed before the restore operation is kept.
> 
> The structures that define how the vmemmap should look like - the memory
> sections and the page tables used for describing the vmemmap should properly
> get saved+restored, as these are located on online memory.
> 
> So the vmemmap layout should look after restoring just like before saving.

OK, makes sense. Thanks for the clarification. 

So there is indeed a difference. One way around that would be to mark
vmemmap pages (e.g. PageReserved && magic value stored somewhere in the
struct page - resembling bootmem vmemmaps) or mark section fully backing
vmemmaps as online (ugly).
-- 
Michal Hocko
SUSE Labs
