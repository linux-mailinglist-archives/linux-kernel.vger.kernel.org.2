Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB60839B093
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFDCsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:48:24 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:40711 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDCsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:48:23 -0400
Received: by mail-oi1-f181.google.com with SMTP id f30so7082813oij.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 19:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=855vlSEYhsLOGNdJcugYbdlOBheupCBIdY8o4dmTr/0=;
        b=aymqnrJmRWg5jXI6iKWsmz4jrob/orNsUCAC8p8/H1z8/H1qH0Ap4GOSkiuU0OhZwC
         NSysJZDc8NqFnY1EWohSavsL1H6CP9VB/d4GZ9X3syjDiyGFBbrcOgXTlR6ZY5V+6xrp
         1qtT5Drf272NI5zkkGK6CMFyaDN689nWJ/WDOqUpKRdPS6tsLzghBhm/D08LtGsgOAha
         JAL6/4VEZWRXeumpuGv1+k6y2/btUDHnVZrRfc/NFo7fe834/BpS8hLik41C+d+23Rj5
         TI6MHqhzMW84NjjH+h+HCnceTHSZaDq5vNQiL6oF20cgEMqDFZz6p+K+QSbUZJauHD2l
         bGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=855vlSEYhsLOGNdJcugYbdlOBheupCBIdY8o4dmTr/0=;
        b=BcaU2YuTcAeWYXtnPEce1D2r4c1XmPv1PRtg3RNtkOz8uqvWhXysUUsVTOtUwFvG/D
         dtvV5BX9sOv/7aR5sv0sy7cQ632NtvLd7JN3e+qPqKnL6Qt2uq9j0xcGpYyaoBuIf9Xa
         OL/zKtg9a0XXAxpGS398eZepfTu7+jzU8uXqd3M0pZOEO6TuG+QLh6iiX4QQvIgV/Tni
         ykzj59OfEtKXMHBPbXPjQZ1xjFOGzUh2O4VLMkznHLIKLzhhTUhpVk5NGsBHG95guqek
         GBFe32WfzE5DEsfTlJrcjIE1FvKmDLGTRsSTa69LhS1pDaPksdIDCg/JnaOgyK8BUWJz
         AePg==
X-Gm-Message-State: AOAM531C+nDzky0QK6VeoZfPSriB0TqV8Q4Mv7kjufw3IEfbVUTuFx/9
        kDdAAhDLguzv2deeVnFygtbppg==
X-Google-Smtp-Source: ABdhPJzRyhZp5CykGMFTeTYXTpk0uIoK9A9IkhdVQ1PT2z8ehR0eKm4KQe1UC3BvFixUimvRrO9kKQ==
X-Received: by 2002:a05:6808:8a:: with SMTP id s10mr6703449oic.33.1622774724484;
        Thu, 03 Jun 2021 19:45:24 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b81sm198114oia.19.2021.06.03.19.45.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 19:45:24 -0700 (PDT)
Date:   Thu, 3 Jun 2021 19:45:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM
 splitting
In-Reply-To: <CAHbLzkrUcNhGDmPstSNHhwbdoo3z2B=v-zb7__M3RqHL-Ct-EA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2106031923410.12760@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011405510.2148@eggly.anvils> <CAHbLzkrUcNhGDmPstSNHhwbdoo3z2B=v-zb7__M3RqHL-Ct-EA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021, Yang Shi wrote:
> On Tue, Jun 1, 2021 at 2:07 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Instead of abandoning the unsafe VM_BUG_ON_PAGE(), and the ones that
> > follow, use PVMW_SYNC in try_to_unmap_one() in this case: adding TTU_SYNC
> > to the options, and passing that from unmap_page() when CONFIG_DEBUG_VM=y.
> > It could be passed in the non-debug case too, but that would sometimes add
> > a little overhead, whereas it's rare for this race to result in failure.
> 
> The above statement makes me feel this patch is just to relieve the
> VM_BUG_ON, but my patch already changed it to VM_WARN, the race sounds
> acceptable (at least not fatal) and the splitting code can handle the
> failure case as well. So I'm wondering if we still need this patch or
> not if it is just used to close the race when CONFIG_DEBUG_VM=y.

I do agree that your 1/2 (what I'm calling 6.1/7) BUG->WARN patch
is the most important of them; but it didn't get marked for stable,
and has got placed behind conflicting mods never intended for stable.

And a lot of the descriptions had been written in terms of the prior
situation, with VM BUG there: it was easier to keep describing that way.

Whether your fix makes mine redundant is arguable (Wang Yugui thinks
not).  It's easier to argue that it makes the racy ones (like this)
redundant, than the persistent ones (like vma_address or pvm_walk).

Since I know of at least one customer who wants all these fixes in 5.10
longterm, I'm fighting to get them that far at least.  But the further
back they go, the less effort I'll make to backport them - will fall
back to porting your BUG->WARN only.

Hugh
