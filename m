Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314D441C9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345886AbhI2QMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345674AbhI2QMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:12:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD60C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:09:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y35so10721461ede.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uaWtDAo3kQSYCQrNbQm2HCi7HuCaEOju1rd0rKAU9dQ=;
        b=WfDFN+AjqSMPvMlMCOsJcFYl1uex3whdvbM9klc0hcheDieIqdAFIQJhsnsXfizDQt
         h5uqgLQsafVDIkFEkSDmfSXEcyaIudmJrpA7xh5gbPs+cRKygnx5eW22JA1UjDLiw4fZ
         H1dMOEu0rF/3q4tBVa29T+wyCKLINjeOFZU020y4uxgIaUrDdYOhWtvH3D8xDG6dvboM
         GCfdOFaIr+0eK94U/rRJ0pcjpDnKF666XnxzBgMuxgl/YvtDi+IACNfnr0p9frdCw6Dr
         9RsSqc346jaQJxeGCddmUzKqZnBtmL4rbk5SDvCf3XRCG1okZvYHQNc2zmG4v0fqRSmQ
         MHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uaWtDAo3kQSYCQrNbQm2HCi7HuCaEOju1rd0rKAU9dQ=;
        b=kDKgxH41do/cDV6RL6WxJedvdzEtxUhD3TUK0nba+s2diwtJL3bYuAEGtDTFZkDqjM
         LymiELc75dykNQ5TTnMREjwE8I50JQkLhb3pG6tK7YShzOQkPS/EMdCyuxzBeW8FvAn3
         J2E1/SE/rbc74sVZ59DVCIF64VSEMrufYYVj9BDmDKvRsn9cxJJrMhpxTXCvmZyP5l7y
         JNC/uYgc+1zpAQLMtTzyDmF0zfB/BESTW4AE3qdeYpghBckxxoVp26iAk4qsPkH8o2qT
         8MJ8H2blNYIjjj2XK0GJ9hSdvQywBiOz9F2DvRbLc1Qfq0LGPqchwRPp9xRqP/svU9dy
         1zqA==
X-Gm-Message-State: AOAM530aNulPVTCxBMpaV71O5iqPJkDQwNRc3e31S6We507y5DLK5RSW
        NbAMreeXwNZBxouR8fXLYbaYd/c3cuUJk7QTKIk=
X-Google-Smtp-Source: ABdhPJyrMM22bNMGflNyc+y8rA206GxgP0Bp7Ld+WDu3Hp9kybxMvtdUCZ9+WUrD0DIV6jTyeV3C1mpV667nLwdSIsc=
X-Received: by 2002:aa7:c4d0:: with SMTP id p16mr787607edr.71.1632931717974;
 Wed, 29 Sep 2021 09:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210908132727.16165-1-david@redhat.com> <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com> <20210916193403.GA1940@pc638.lan>
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com> <20210921221337.GA60191@pc638.lan>
 <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com> <20210922104141.GA27011@pc638.lan>
 <e378e60a-319b-e9aa-7e30-3e280c4431da@redhat.com> <CA+KHdyWZ9T2GEuUENXD_OYHX1JxKfZuW5YzmDtqXUYSgkQd8fQ@mail.gmail.com>
 <953ea84a-aabb-f64b-b417-ba60928430e0@redhat.com> <CA+KHdyWFjtoVqGd=7-yp33G-5WcZCtf80BaAk+3jx2bW5FCfWA@mail.gmail.com>
 <689b7c24-623d-c01e-6c0f-ad430f1fa3ae@redhat.com>
In-Reply-To: <689b7c24-623d-c01e-6c0f-ad430f1fa3ae@redhat.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 29 Sep 2021 18:08:26 +0200
Message-ID: <CA+KHdyVC1KCP2r2st_TmfmXaPZ49ym0gyN31CwLZfE=ipLGjmA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment > 1
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Could you please to be more specific? I mean how is it connected with huge
> > pages mappings? Huge-pages are which have order > 0. Or you mean that
> > a special alignments are needed for mapping huge pages?
>
> Let me try to clarify:
>
>
> KASAN does an exact allocation when onlining a memory block,
> __vmalloc_node_range() will try placing huge pages first, increasing the
> alignment to e.g., "1 << PMD_SHIFT".
>
> If we increase the search length in find_vmap_lowest_match(), that
> search will fail if the exact allocation is surrounded by other
> allocations. In that case, we won't place a huge page although we could
> -- because find_vmap_lowest_match() would be imprecise for alignments >
> PAGE_SIZE.
>
>
> Memory blocks we online/offline on x86 are at least 128MB. The KASAN
> "overhead" we have to allocate is 1/8 of that -- 16 MB, so essentially 8
> huge pages.
>
> __vmalloc_node_range() will increase the alignment to 2MB to try placing
> huge pages first. find_vmap_lowest_match() will search within the given
> exact 16MB are a 18MB area (size + align), which won't work. So
> __vmalloc_node_range() will fallback to the original PAGE_SIZE alignment
> and shift=PAGE_SHIFT.
>
> __vmalloc_area_node() will set the set_vm_area_page_order effectively to
> 0 --  small pages.
>
> Does that make sense or am I missing something?
>
Thank you for clarification. OK, we come back anyway to the "problem" with fixed
range and an exact allocation plus a special alignment > PAGE_SIZE. Thus the
KASAN will not make use of huge pages mappings and go with regular instead
as a fallback path. But we would like to utilize huge-mappings for KASAN.

I will send the patch you tested and add your "tested-by" tag. Does it
sound good?

--
Uladzislau Rezki
