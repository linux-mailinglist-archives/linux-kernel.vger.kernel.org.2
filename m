Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5443945D7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354363AbhKYKOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354532AbhKYKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637834969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JJz0qEyNzReubdlE4bgJTpQjKIHhlioIGoaUH7sJe0=;
        b=aVQWDbzKAv8jt3jaSkLdYhreFu/Bjh0Hx7Bq+fmV7CAREh08ZdRNzcV+kijiLRC6zLu5/M
        2KoFxXNEsfOuQv3kpmMiq8wSlJBIz9/IAw1EzVFY6c83yK9sx75XMedTwfj5WLL2yJMTv1
        CKcIaeLVcWPPhAR4LEHJo4VwCoIBO+w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-6knBrdMSNVS4f-5k01Jmrw-1; Thu, 25 Nov 2021 05:09:27 -0500
X-MC-Unique: 6knBrdMSNVS4f-5k01Jmrw-1
Received: by mail-pl1-f200.google.com with SMTP id e9-20020a170902ed8900b00143a3f40299so1869352plj.20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/JJz0qEyNzReubdlE4bgJTpQjKIHhlioIGoaUH7sJe0=;
        b=BSAwJ4vjba66ViNi58L1AwZ01artgguk1Rd0alzuesh57Umxct1LNINO0LV3ZnESSH
         KfQDbvXzRYQ/WzTt8ynDNr7farNWKjItNiQ2xrUdaM4zsEyY5hH23Ea8Fho/saUagCFE
         StVx6vmnmi432tHfymyhhlQ7PTQx4pqSWTXBC6b67f1wtwf3lxv4wiAXCFCmwFCSvKks
         +WehWAfkeAHjnpORdCvyc7rnc+JyP8B6WEPvivSi7RX3SExywMKOLHvXDeVfsbQg2IPr
         3hpDFKJrBA8aDmiJC1nmgxGx7bQhOcaa+sy59fcNtKl0dGK+edWh1fXUntnbTDu4LPS9
         +xVw==
X-Gm-Message-State: AOAM533MoxAtV7Oy93O2DIy9Nv8wga0NdNzkJ193QXj6Y/RQ1Z21Jz1h
        bmQV3SP8mEk+RsCE+d97wmspMQEEyhpgAjd9Zb+Vxp57Kxx8SYfVnddTz17ynWoDSktSnN16EmW
        nFAKhBO83ElTM83YgRE4AiLg1
X-Received: by 2002:a17:90b:4c02:: with SMTP id na2mr5628666pjb.94.1637834966691;
        Thu, 25 Nov 2021 02:09:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze6OQsdVwHY+zRy+pZmJn5TkhSeCuJ4mD0b9601Z+uulZVYsL5U3/Z5lkS3fu+G93IwYTp7A==
X-Received: by 2002:a17:90b:4c02:: with SMTP id na2mr5628628pjb.94.1637834966388;
        Thu, 25 Nov 2021 02:09:26 -0800 (PST)
Received: from xz-m1.local ([94.177.118.150])
        by smtp.gmail.com with ESMTPSA id p8sm3002445pfo.141.2021.11.25.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:09:25 -0800 (PST)
Date:   Thu, 25 Nov 2021 18:09:19 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <YZ9gz8WGic8QOTxE@xz-m1.local>
References: <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com>
 <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
 <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com>
 <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
 <c61a6f30-ed62-7773-3371-981102f6804f@redhat.com>
 <CALvZod7xTfg5aeQC7-EaOZJ47Twb8CkoS6u4C=8+y+AX-NREVw@mail.gmail.com>
 <1b400921-8bef-8073-10f9-a7cbb09cfefe@redhat.com>
 <CALvZod6wyF7v1v888StoXSSWtb7ujaeBUnUB8Vs2RfMzUsj+Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod6wyF7v1v888StoXSSWtb7ujaeBUnUB8Vs2RfMzUsj+Gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:28:34AM -0800, Shakeel Butt wrote:
> On Tue, Nov 23, 2021 at 9:26 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 23.11.21 18:24, Shakeel Butt wrote:
> > > On Tue, Nov 23, 2021 at 9:20 AM David Hildenbrand <david@redhat.com> wrote:
> > >>
> > >> On 23.11.21 18:17, Shakeel Butt wrote:
> > >>> On Tue, Nov 23, 2021 at 8:57 AM David Hildenbrand <david@redhat.com> wrote:
> > >>>>
> > >>> [...]
> > >>>>>>
> > >>>>>> I do wonder which these locking contexts are exactly, and if we could
> > >>>>>> also do the same thing on ordinary munmap -- because I assume it can be
> > >>>>>> similarly problematic for some applications.
> > >>>>>
> > >>>>> This is a good question regarding munmap. One main difference is
> > >>>>> munmap takes mmap_lock in write mode and usually performance critical
> > >>>>> applications avoid such operations.
> > >>>>
> > >>>> Maybe we can extend it too most page zapping, if that makes things simpler.
> > >>>>
> > >>>
> > >>> Do you mean doing sync THP split for most of page zapping functions
> > >>> (but only if that makes things simpler)?
> > >>>
> > >>
> > >> Yes -- if there are no downsides.
> > >>
> > >
> > > I will try. At the moment the assumption of "Not null zap_details
> > > implies leave swap entries" is giving me a headache.
> >
> > Not only you, did you stumble over
> >
> > https://lkml.kernel.org/r/20211115134951.85286-1-peterx@redhat.com

(thanks for raising this, David)

> >
> > already?
> >
> 
> Oh thanks for the pointer. I missed that. I will take a look. Thanks again.

Hi, Shakeel, 

I saw your v2 has started to pass in zap_details, then we need know the side
effect on that skip-swap-entry thing because with your v2 code munmap() will
start to skip swap entry too (while it was not before).

I saw that you didn't mention this in v2 patch either in commit message or
code, not sure whether you digged that up.  I think it needs some double check
(or feel free to start this digging by reviewing my small patch above :).

Thanks,

-- 
Peter Xu

