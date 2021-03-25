Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF23493B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhCYOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:09:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhCYOIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:08:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616681310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ESAA6ThVbjxDwvrgI7oZbg7SXTWiqqrNoNLZkKKalh4=;
        b=tzDk5ICtnXG7UJmZ8DpY6U1BkuC8D1+8dPNDnnlOOpvOAWVIxnmuVjMZzsJBnI4o23vNa3
        ZfwNLnTDS1jWHUwwFpu2yhiWEI+8YhdGvMEGSKjVyqKi5ykvubchfi/vGyBcQ5scNA72Bp
        sWuqWpNUXdNN8ormZOk2m/JxOTpwPAw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08DEEADAA;
        Thu, 25 Mar 2021 14:08:30 +0000 (UTC)
Date:   Thu, 25 Mar 2021 15:08:23 +0100
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
Message-ID: <YFyZV6QSffsHkP2d@dhcp22.suse.cz>
References: <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain>
 <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
 <YFyDhKPqS15HdO0Y@dhcp22.suse.cz>
 <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31110e58-c99a-8dee-6f6e-98f456b77759@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 13:40:45, David Hildenbrand wrote:
> On 25.03.21 13:35, Michal Hocko wrote:
> > On Thu 25-03-21 12:08:43, David Hildenbrand wrote:
> > > On 25.03.21 11:55, Oscar Salvador wrote:
[...]
> > > > - When moving the initialization/accounting to hot-add/hot-remove,
> > > >     the section containing the vmemmap pages will remain offline.
> > > >     It might get onlined once the pages get online in online_pages(),
> > > >     or not if vmemmap pages span a whole section.
> > > >     I remember (but maybe David rmemeber better) that that was a problem
> > > >     wrt. pfn_to_online_page() and hybernation/kdump.
> > > >     So, if that is really a problem, we would have to care of ot setting
> > > >     the section to the right state.
> > > 
> > > Good memory. Indeed, hibernation/kdump won't save the state of the vmemmap,
> > > because the memory is marked as offline and, thus, logically without any
> > > valuable content.
> > 
> > Could you point me to the respective hibernation code please? I always
> > get lost in that area. Anyway, we do have the same problem even if the
> > whole accounting is handled during {on,off}lining, no?
> 
> kernel/power/snapshot.c:saveable_page().

Thanks! So this is as I've suspected. The very same problem is present
if the memory block is marked offline. So we need a solution here
anyway. One way to go would be to consider these vmemmap pages always
online. pfn_to_online_page would have to special case them but we would
need to identify them first. I used to have PageVmemmap or something
like that in my early attempt to do this.

That being said this is not an argument for one or the other aproach.
Both need fixing.
-- 
Michal Hocko
SUSE Labs
