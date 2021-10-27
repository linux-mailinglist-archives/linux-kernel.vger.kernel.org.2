Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012D943D0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbhJ0SaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbhJ0SaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:30:05 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A7DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:27:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id i26so4319316ljg.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTPGGY5lRCDLBi6dC5IO32LUKxcN06wIGk1r7lIVLSo=;
        b=d3wjkgrfbqcygeWm6K/TtNmo32Mpi/IvWJLl5UmypGRAf01wECJBMI5oO6ZlCl7qfg
         kXxZKIMk1Hd3etghlMO0DF8OBeeQDZqxG+A97FEd+MR+G92uCtX7rGbLKD1qhsQW00VE
         hKRgadi2AztZburwCJd4Z1+tzPZJDoqhKJCrDO2EiSdQgweRWRn4fVv5+GX4swPMf7FH
         8iQF+zzjdnwFD2o7TqZRU///noJZNQruC4Z4+YkOpzMF287IW/ePgpl8ewJBYjODSmR0
         pluAlAFLYSCqFcxQsw935K3sqFD7E4hV/QSA5u0DJaCDiLZRcgpwlDdd2ADfdA231iih
         jsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTPGGY5lRCDLBi6dC5IO32LUKxcN06wIGk1r7lIVLSo=;
        b=P+W8lOdLu/tBHrfbY4o+1ady2XHCAWMkq5jb/EcC3Omz21m4nL5eaoF8gEIBdo1bqZ
         OeFr+0YCccknHx+kLqDsgJA/WT4WO02lKBlBuS6alziPPBqlQ4PuVIyI4+XB9e/0+rdl
         NM48htALZqzsx8Ggyc1OdGYOuCWpwwrrPW6hqMesn73kBmexGGpmMeTvh6gQDwRLra1J
         yfR/B5X325NqIbA2SdR8fEueuH+mnppi3Q8ZIkKLm2w564b5eTdV5AAf0ceWdhb+RFlj
         sJSkNpsjxtmtoza5sKHlpJwUhm/qU6Kwv+d3pN/HhD96xRWeRIv59I+MC/T1p/emS8HT
         t/uQ==
X-Gm-Message-State: AOAM531MNIhcTeZWg/95/Y1QW1MstiE1RcVCrbNxNCiVu0meuiY/Jafl
        8QKkLUMmCNt4xYxJ3Nf4qxcNO7dNujRNw651etC96g==
X-Google-Smtp-Source: ABdhPJzVrqJVm8ugC/NpTWWt0IMrYAXeu8WHnFF1TrXtg37Te+R3tSJ+rO1eSFGnjAMpx1n4+0JJslJTRNvu3vH6O7E=
X-Received: by 2002:a2e:810c:: with SMTP id d12mr34769148ljg.177.1635359258205;
 Wed, 27 Oct 2021 11:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com> <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
 <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com> <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com>
In-Reply-To: <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Oct 2021 14:27:01 -0400
Message-ID: <CA+CK2bBiomTe-vOuxM_R+0CMAippyrfZ6AgpXQGqps3ZFQCtRA@mail.gmail.com>
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in set_page_recounted()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 1:12 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 10/26/21 11:21, Pasha Tatashin wrote:
> > It must return the same thing, if it does not we have a bug in our
> > kernel which may lead to memory corruptions and security holes.
> >
> > So today we have this:
> >     VM_BUG_ON_PAGE(page_ref_count(page), page); -> check ref_count is 0
> >     < What if something modified here? Hmm..>
> >     set_page_count(page, 1); -> Yet we reset it to 1.
> >
> > With my proposed change:
> >     VM_BUG_ON_PAGE(page_ref_count(page), page); -> check ref_count is 0
> >     refcnt = page_ref_inc_return(page);  -> ref_count better be 1.
> >     VM_BUG_ON_PAGE(refcnt != 1, page); -> Verify that it is 1.
> >
>
> Yes, you are just repeating what the diffs say.
>
> But it's still not good to have this function name doing something completely
> different than its name indicates.

I see, I can rename it to: 'set_page_recounted/get_page_recounted' ?

>
> >>
> >> I understand where this patchset is going, but this intermediate step is
> >> not a good move.
> >>
> >> Also, for the overall series, if you want to change from
> >> "set_page_count()" to "inc_and_verify_val_equals_one()", then the way to
> >> do that is *not* to depend solely on VM_BUG*() to verify. Instead,
> >> return something like -EBUSY if incrementing the value results in a
> >> surprise, and let the caller decide how to handle it.
> >
> > Actually, -EBUSY would be OK if the problems were because we failed to
> > modify refcount for some reason, but if we modified refcount and got
> > an unexpected value (i.e underflow/overflow) we better report it right
> > away instead of waiting for memory corruption to happen.
> >
>
> Having the caller do the BUG() or VM_BUG*() is not a significant delay.

We cannot guarantee that new callers in the future will check return
values, the idea behind this work is to ensure that we are always
protected from refcount underflow/overflow and invalid refcount
modifications by set_refcount.

Pasha
