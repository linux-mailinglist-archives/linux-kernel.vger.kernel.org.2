Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26A44BBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 08:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhKJHGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 02:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229713AbhKJHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 02:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636527795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0cadZK7XFbebH7WBSpOeCcH2GLCqGBVv5pJTjTqScgI=;
        b=MSb6zyufM34Dz/7le2ju8Z/eb/gd2fD9gJrZP5CfMs/HU5ggn5mjxss+POEtqZftBRagQ6
        SgsiioYqRuhiMeyeZKCBLXK909YE6L5BHV1D0jJrRfyv9lV6ufk33T2WNJv0JwjscPpF1R
        37vAXkdUci9mThxhEajvpXtW5WwOIQo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-purM7dspPJOb7tUb07asiQ-1; Wed, 10 Nov 2021 02:03:14 -0500
X-MC-Unique: purM7dspPJOb7tUb07asiQ-1
Received: by mail-pj1-f71.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so553471pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 23:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0cadZK7XFbebH7WBSpOeCcH2GLCqGBVv5pJTjTqScgI=;
        b=ujpIo8mjUbuAbk0+JJTIRCnp97KKPFuwCdskV/mRECPyqJjtvpm+YQVMrL0VYwETYO
         j45zSYL6eS1eRL06x8hreIZBTvOqiylDcUsFsov+Zk3lIJItfsLOO7acVvEb9nm8Vsf2
         6qdNTD0HbThHsE+6Mh+HqqH6/4bGbdrabdBU20C1/rO6vxRL0HPw7o40B0dja+dyafsi
         uOZ518sQ9Jgel2OUEtRFnE5CoakJBaiA5uuGxO4mueFCso1ovysYgEjvb8Z9ioBUpMS8
         VpWmk87/pYj1a1aZFP8fU2Aa+ZV1l0sFfNGFqgwLhclkuXk9XaqOis62m2zP8ZH541nQ
         Pn0Q==
X-Gm-Message-State: AOAM532biCJ552v1mnrOFOFWdVxjeeBTYpyJM/04lNyvRmxa8mkzNkgl
        8ESMyPDP+XGaxh2K+MV8HksvlTvslRUIvovyh/DkSk++xiewm2M8v2yBYDx1Wb/tX4Q4ezCCZzM
        LyTe62vr8hXMN42tiL/aK47+H
X-Received: by 2002:a17:902:d50d:b0:141:ea03:5193 with SMTP id b13-20020a170902d50d00b00141ea035193mr13204503plg.89.1636527793174;
        Tue, 09 Nov 2021 23:03:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwADuN2McaK3Hz7vOj8bQd5Tyj05xsqo8F8qbby7T4wFIAY2nEuPkvVgYieWrNTWlsrTqt6ig==
X-Received: by 2002:a17:902:d50d:b0:141:ea03:5193 with SMTP id b13-20020a170902d50d00b00141ea035193mr13204473plg.89.1636527792955;
        Tue, 09 Nov 2021 23:03:12 -0800 (PST)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e15sm1645364pfv.131.2021.11.09.23.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 23:03:12 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:03:06 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-ID: <YYtuqsnOSxA44AUX@t490s>
References: <20211107235754.1395488-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211107235754.1395488-1-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mina,

Sorry to comment late.

On Sun, Nov 07, 2021 at 03:57:54PM -0800, Mina Almasry wrote:
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index fdc19fbc10839..8a0f0064ff336 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -23,7 +23,8 @@ There are four components to pagemap:
>      * Bit  56    page exclusively mapped (since 4.2)
>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
> -    * Bits 57-60 zero
> +    * Bit  58    page is a huge (PMD size) THP mapping
> +    * Bits 59-60 zero
>      * Bit  61    page is file-page or shared-anon (since 3.5)
>      * Bit  62    page swapped
>      * Bit  63    page present
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ad667dbc96f5c..6f1403f83b310 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1302,6 +1302,7 @@ struct pagemapread {
>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>  #define PM_UFFD_WP		BIT_ULL(57)
> +#define PM_HUGE_THP_MAPPING	BIT_ULL(58)

The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
"PM_HUGE" (as THP also means HUGE already)?

IMHO the core problem is about permission controls, and it seems to me we're
actually trying to workaround it by duplicating some information we have.. so
it's kind of a pity.  Totally not against this patch, but imho it'll be nicer
if it's the permission part that to be enhanced, rather than a new but slightly
duplicated interface.

Thanks,

-- 
Peter Xu

