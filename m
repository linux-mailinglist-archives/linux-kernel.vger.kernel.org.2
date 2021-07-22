Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF53C3D3038
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 01:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhGVWuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 18:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGVWuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 18:50:23 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0F5C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 16:30:57 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id o4so2699653uae.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPY6X6Rtw90AF5qvM0t4dkoLpJt3vYNK9WYhKNctEG8=;
        b=Z+/cUWopycJ/hLUaIbpaykOlK1CidWr4Ry5yl2uN8wfUATjJzR4e+vZ+FGKoqg8VUH
         ZWk4+lVCRoJb55ZFkRhwzyTQt9MfWBxunFNr2oYRS+hXmoDgFiqIsltQAhGLzi+TAkvr
         yd0VtOHHYiOReYQW9FAOYlXvTt/CtIFAuy13VrI1T0Pco3gGiOuLd27JGbJQfHUAfHnn
         8T3t4rZpqUEqYu6E+PECBBuZj22G0XdJOB/DEfCsGMZiiVTWCbk1BTxNRadJbf5A5FJ8
         lDKCXwDVyCYcDpB7UNUnnxLsfkoJbymP7hXeUpN0TyQM0PwwAKBEttR7TcNjgZIN2VRh
         M9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPY6X6Rtw90AF5qvM0t4dkoLpJt3vYNK9WYhKNctEG8=;
        b=E4H8qV1efFRNUi3BXjqm1A5ptJZ3jbtLwfAoKvt4GuCBb5RDTXeArrEbYedGRsU4y8
         LGBtyt2D9KFM4KpruV2ACsQdDFd/NMqYsRlTsmzIgrKCGl/GlF8jMeofg++5qM4Xfac/
         C7zgb8ivM16Jw97bwtz0X/F6w9zSWFOx05Zh5yQey9/XzjdfybXawqqzIuvLh9uhOVQ0
         5AvezrEEZ1BJwoO0ZMYR8hrgrEt3V+2KI2vt9dZ6+bJcyBig14TVNZvSRB48qT8YxR2g
         5MDzLoqRHj+PKlYbGhfy8TznpoIV71LuR4kho5I9hl2tiMsIMLkNuMNLYW30w5Buic5F
         SNlQ==
X-Gm-Message-State: AOAM531HpBeCzL83BS+iAKrRZh9TewtpbBC/babK96UWWZVVv0rveB3z
        MrMo8azDnn6+lJy6xcb7QC8BKDl5xvO2AYYZ3avx+w==
X-Google-Smtp-Source: ABdhPJzV1u7Nmx1s6U90suVoJm1WVLVMV8qE4Q4yO//QLsjdAGGbgcokX4grSdZuofesC94eqPdTCf3JR9oUyaaS3jY=
X-Received: by 2002:ab0:5b59:: with SMTP id v25mr2722821uae.112.1626996655977;
 Thu, 22 Jul 2021 16:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
From:   Jue Wang <juew@google.com>
Date:   Thu, 22 Jul 2021 16:30:44 -0700
Message-ID: <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the challenge being the uncorrectable errors are essentially
random. It's
just a matter of time for >1 UC errors to show up in sequential kernel accesses.

It's easy to create such cases with artificial error injections.

I suspect we want to design this part of the kernel to be able to handle generic
cases?

Thanks,
-Jue

On Thu, Jul 22, 2021 at 8:19 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Thu, Jul 22, 2021 at 06:54:37AM -0700, Jue Wang wrote:
> > This patch assumes the UC error consumed in kernel is always the same UC.
> >
> > Yet it's possible two UCs on different pages are consumed in a row.
> > The patch below will panic on the 2nd MCE. How can we make the code works
> > on multiple UC errors?
> >
> >
> > > + int count = ++current->mce_count;
> > > +
> > > + /* First call, save all the details */
> > > + if (count == 1) {
> > > + current->mce_addr = m->addr;
> > > + current->mce_kflags = m->kflags;
> > > + current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> > > + current->mce_whole_page = whole_page(m);
> > > + current->mce_kill_me.func = func;
> > > + }
> > > ......
> > > + /* Second or later call, make sure page address matches the one from first call */
> > > + if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
> > > + mce_panic("Machine checks to different user pages", m, msg);
>
> The issue is getting the information about the location
> of the error from the machine check handler to the "task_work"
> function that processes it. Currently there is a single place
> to store the address of the error in the task structure:
>
>         current->mce_addr = m->addr;
>
> Plausibly that could be made into an array, indexed by
> current->mce_count to save mutiple addresses (perhaps
> also need mce_kflags, mce_ripv, etc. to also be arrays).
>
> But I don't want to pre-emptively make such a change without
> some data to show that situations arise with multiple errors
> to different addresses:
> 1) Actually occur
> 2) Would be recovered if we made the change.
>
> The first would be indicated by seeing the:
>
>         "Machine checks to different user pages"
>
> panic. You'd have to code up the change to have arrays
> to confirm that would fix the problem.
>
> -Tony
