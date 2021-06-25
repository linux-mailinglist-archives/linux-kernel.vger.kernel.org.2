Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ADA3B4A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFYVZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:25:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:23:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b3so5374029plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4TQ23cTuZIs4A0SaruHtk3JijVaWX+yFgeWkG756PMY=;
        b=1uUld2yigI2hael1Mc9O8lBvA0enTvB5RmJ8p1a47LpwUo7A5iaReMSPHE+O1OzMH7
         TczYWlkSpaCN3NqRnMQBKwSBZdiOfA7s2cfeh+L6ZzFq5WvRUkPpF48bH/oWRif0rn3H
         JDTa2OWjcqJ4hUiC0gHEuCqhllbWhdhfuUWGwdkawbNks+X0YBW3AgW6KrLMPGcpsqqt
         s7VxP8p5ZPe8Q0Q8Rk5O8RfvywDyucYoywiffyZGPikfDJq1kc5Adtrk5qXrcXuDx0wn
         id06OB4EWCY09bai5FsQHY21Wn/TS84rdzl7Qbj6uBj5tiCm+IHACaecH8AQWFaC0cLo
         nb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4TQ23cTuZIs4A0SaruHtk3JijVaWX+yFgeWkG756PMY=;
        b=O7F+RZoAKW6l2baBey0czP+IUcaFZJ7BKpYOKquCCfX9Inv4v0rMp5msZSDo/Wdwcd
         I7MuO0bkGVMXRlChRZ9WK93XfpjWFix/fn0heqb+M+6WMItJ4282jD8D+UN8j3/1c+bb
         S4l+okoUW4yQ0YkZy4fpiGIMVC5KNgs6FSA5txyq8qX8sc2rTNczsLHwHaXqpX8q48wm
         l6p/fdqx8NMXkS1nw3GpV3r9tp0ooRMZ0ST4epj3Gue2vRh92bJe5OrUNx6SX8DTAsKe
         zF1gukPF0+gXGR2qrqd+A8kK1P35qIp3dFk9Woz/My+8vw2iXQOrUhj9Fr5V0LZolhR7
         km5A==
X-Gm-Message-State: AOAM531MdrKDV/iZolgI09bHLlvh4YktpX3mlioULU+XmdGc0nk5rfyN
        guqY9DSkZ0hr2ALyDoswlwMLHxUZ76i0AwrzS10w4w==
X-Google-Smtp-Source: ABdhPJwFNOgoPe90uDMmfd1g/GFbhjQoCstJvRVqJogay7DoZ3cIH+osgvptoCwioyEurt6jBY/PNdJzeVYS0w2Quxk=
X-Received: by 2002:a17:902:446:b029:120:1fd:adbf with SMTP id
 64-20020a1709020446b029012001fdadbfmr11098119ple.52.1624656195859; Fri, 25
 Jun 2021 14:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210427083019.110184-1-wangwensheng4@huawei.com>
 <e838d8b5-84f1-5532-6f22-e4b729124e1c@redhat.com> <20210623230939.GA2963480@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210623230939.GA2963480@hori.linux.bs1.fc.nec.co.jp>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Jun 2021 14:23:05 -0700
Message-ID: <CAPcyv4h5a5AYscsyC40_5bc6j1kmjMFWJ_0MFAGEx1EPS9Tmrw@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse: Fix flags overlap in section_mem_map
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Wang Wensheng <wangwensheng4@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.xiang@huawei.com" <rui.xiang@huawei.com>,
        =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= 
        <k-hagio-ab@nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 4:10 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Tue, Apr 27, 2021 at 11:05:17AM +0200, David Hildenbrand wrote:
> > On 27.04.21 10:30, Wang Wensheng wrote:
> > > The section_mem_map member of struct mem_section stores some flags an=
d
> > > the address of struct page array of the mem_section.
> > >
> > > Additionally the node id of the mem_section is stored during early bo=
ot,
> > > where the struct page array has not been allocated. In other words, t=
he
> > > higher bits of section_mem_map are used for two purpose, and the node=
 id
> > > should be clear properly after the early boot.
> > >
> > > Currently the node id field is overlapped with the flag field and can=
not
> > > be clear properly. That overlapped bits would then be treated as
> > > mem_section flags and may lead to unexpected side effects.
> > >
> > > Define SECTION_NID_SHIFT using order_base_2 to ensure that the node i=
d
> > > field always locates after flags field. That's why the overlap occurs=
 -
> > > forgetting to increase SECTION_NID_SHIFT when adding new mem_section
> > > flag.
> > >
> > > Fixes: 326e1b8f83a4 ("mm/sparsemem: introduce a SECTION_IS_EARLY flag=
")
> > > Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> > > ---
> > >   include/linux/mmzone.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index 47946ce..b01694d 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -1325,7 +1325,7 @@ extern size_t mem_section_usage_size(void);
> > >   #define SECTION_TAINT_ZONE_DEVICE (1UL<<4)
> > >   #define SECTION_MAP_LAST_BIT              (1UL<<5)
> > >   #define SECTION_MAP_MASK          (~(SECTION_MAP_LAST_BIT-1))
> > > -#define SECTION_NID_SHIFT          3
> > > +#define SECTION_NID_SHIFT          order_base_2(SECTION_MAP_LAST_BIT=
)
> > >   static inline struct page *__section_mem_map_addr(struct mem_sectio=
n *section)
> > >   {
> > >
> >
> > Well, all sections around during boot that have an early NID are early =
...
> > so it's not an issue with SECTION_IS_EARLY, no? I mean, it's ugly, but =
not
> > broken.
> >
> > But it's an issue with SECTION_TAINT_ZONE_DEVICE, AFAIKT.
> > sparse_init_one_section() would leave the bit set if the nid happens to=
 have
> > that bit set (e.g., node 2,3). It's semi-broken then, because we force =
all
> > pfn_to_online_page() through the slow path.
> >
> >
> > That whole section flag setting code is fragile.
>
> Hi Wensheng, David,
>
> This patch seems not accepted or updated yet, so what's going on?
>
> We recently saw the exact issue on testing crash utilities with latest
> kernels on 4 NUMA node system.  SECTION_TAINT_ZONE_DEVICE seems to be
> set wrongly, and makedumpfile could fail due to this. So we need a fix.
>
> I thought of another approach like below before finding this thread,
> so if you are fine, I'd like to submit a patch with this. And if you
> like going with order_base_2() approach, I'm glad to ack this patch.
>
>   --- a/include/linux/mmzone.h
>   +++ b/include/linux/mmzone.h
>   @@ -1358,14 +1358,15 @@ extern size_t mem_section_usage_size(void);
>     *      which results in PFN_SECTION_SHIFT equal 6.
>     * To sum it up, at least 6 bits are available.
>     */
>   +#define SECTION_MAP_LAST_SHIFT         5
>    #define SECTION_MARKED_PRESENT         (1UL<<0)
>    #define SECTION_HAS_MEM_MAP            (1UL<<1)
>    #define SECTION_IS_ONLINE              (1UL<<2)
>    #define SECTION_IS_EARLY               (1UL<<3)
>    #define SECTION_TAINT_ZONE_DEVICE      (1UL<<4)
>   -#define SECTION_MAP_LAST_BIT           (1UL<<5)
>   +#define SECTION_MAP_LAST_BIT           (1UL<<SECTION_MAP_LAST_SHIFT)
>    #define SECTION_MAP_MASK               (~(SECTION_MAP_LAST_BIT-1))
>   -#define SECTION_NID_SHIFT              3
>   +#define SECTION_NID_SHIFT              SECTION_MAP_LAST_SHIFT

Rather than make it dynamic, why not just make it 6 directly since
that matches the comment about the maximum number of flags available.
