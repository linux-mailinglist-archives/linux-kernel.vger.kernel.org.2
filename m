Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33B43F512D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhHWTW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhHWTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:22:54 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B520BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:22:11 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c14so10325567qvs.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6iKivFntL9jO7A0bCG8XT9/kFuKhYKYNxAQLHLMCA8=;
        b=BSRfZn3mjcrNmw8pFTD0zSn1xAXWxcKMU9J2TF+jD2LkWw9I7AhfhljTQwfgv51OLf
         mE/H3lpQQMB55BLYil6FkPi+0QlqRcAbP2GaIJFgcDsEvfHQE0nlkGDRpvRvr3qSYXp9
         i0NnD/y0GbccrRSpP11Icq9wQ2gr/o0otdPKnjS8aYOI681yCT0GilYqs4683pADtHDn
         jM0Ir2gvmWRo7/awhQZYFYC69CaNV02Evw6mk74Tiik+azOAb1lI5u4Chuycy89p0RWO
         +rG2TqaSvk6TOtF9TPpgsCHa+YPl2YT29z3zUFDSNayYtOk3VdaquRQcmR37SY8L1Agp
         6q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6iKivFntL9jO7A0bCG8XT9/kFuKhYKYNxAQLHLMCA8=;
        b=JiefDSDKvE4uVMsh0uRLRPZw5KP1Y+Kio2t4U+fVVmR3s72Rqam+LXl3dH9U1cSvFN
         9MClmwNWdm2cBFh0WbJE62/z2C0tc2AoVHDgOc6OTN+jg0Gq07iWPvWB8MzhznAZ9Hgx
         5P78yETGXalbVBNji86rxlerYzTcisOPtMFbFYvoi/ndZoT0z155cowQHmvd6pz965E9
         tpCDvgu4OncFxcy2Ma9L5ADiUCg9Ckx1z9Kyqyan8gzSKRM0tlxIRKSnkEFvWaZ3sLo9
         PaMzfwEU9xc7TZy8CtQ9hCvNunCSyCfug0os5B5KB9usMmSVxmGCGZswZ+XVt2n8iBa4
         0Ugw==
X-Gm-Message-State: AOAM533SXr99jx/Hy33S+YQjr5iVTiSm2m5PBeLIC9IdSdFlfCT0J86Q
        5mKZaaiPtCAFlRC1oXgmdff/yFZQL+Lfb1yIvab1Bg==
X-Google-Smtp-Source: ABdhPJzSmsDDXrKpnjlCjqU/iSM5pI5Vk9qNwlyj24hp3zzEDN+2wjy9BTW6K99y21o6o3AvyFjVbWNT+e3EGt3wGKw=
X-Received: by 2002:a05:6214:240b:: with SMTP id fv11mr33382976qvb.28.1629746530676;
 Mon, 23 Aug 2021 12:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
 <20210809190157.279332-4-dovmurik@linux.ibm.com> <YRZuIIVIzMfgjtEl@google.com>
 <CAMj1kXFC-cizTw2Tv40uZHdLArKtdMNxdQXWoPWSL-8qexdkLQ@mail.gmail.com>
 <CADcWuH0mP+e6GxkUGN3ni_Yu0z8YTn-mo677obH+p-OFCL+wOQ@mail.gmail.com> <b3c65f9d-5fd3-22c5-cd23-481774d92222@linux.ibm.com>
In-Reply-To: <b3c65f9d-5fd3-22c5-cd23-481774d92222@linux.ibm.com>
From:   Andrew Scull <ascull@google.com>
Date:   Mon, 23 Aug 2021 20:21:59 +0100
Message-ID: <CADcWuH05vbFtJ1WYSs3d+_=TGzh-MitvAXp1__d1kGJJkvkWpQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] virt: Add sev_secret module to expose confidential
 computing secrets
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 at 19:36, Dov Murik <dovmurik@linux.ibm.com> wrote:
>
>
>
> On 19/08/2021 16:02, Andrew Scull wrote:
> > On Mon, 16 Aug 2021 at 10:57, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Fri, 13 Aug 2021 at 15:05, Andrew Scull <ascull@google.com> wrote:
> >>>
> >>> On Mon, Aug 09, 2021 at 07:01:57PM +0000, Dov Murik wrote:
>
> [...]
>
> >>>
> >>>> +static int sev_secret_unlink(struct inode *dir, struct dentry *dentry)
> >>>> +{
> >>>> +     struct sev_secret *s = sev_secret_get();
> >>>> +     struct inode *inode = d_inode(dentry);
> >>>> +     struct secret_entry *e = (struct secret_entry *)inode->i_private;
> >>>> +     int i;
> >>>> +
> >>>> +     if (e) {
> >>>> +             /* Zero out the secret data */
> >>>> +             memzero_explicit(e->data, secret_entry_data_len(e));
> >>>
> >>> Would there be a benefit in flushing these zeros?
> >>>
> >>
> >> Do you mean cache clean+invalidate? Better to be precise here.
> >
> > At least a clean, to have the zeros written back to memory from the
> > cache, in order to overwrite the secret.
> >
>
> I agree, but not sure how to implement this:
>
> I see there's an arch_wb_cache_pmem exported function which internally
> (in arch/x86/lib/usercopy_64.c) calls clean_cache_range which seems to
> do what we want (assume the secret can be longer than the cache line).
>
> But arch_wb_cache_pmem is declared in include/linux/libnvdimm.h and
> guarded with #ifdef CONFIG_ARCH_HAS_PMEM_API -- both seem not related to
> what I'm trying to do.
>
> I see there's an exported clflush_cache_range for x86 -- but that's a
> clean+flush if I understand correctly.

This would be perfectly correct, the invalidation is just unnecessary.

> Suggestions on how to approach? I can copy the clean_cache_range
> implementation into the sev_secret module but hopefully there's a better
> way to reuse.  Maybe export clean_cache_range in x86?

Exporting sounds much better than duplicating.

It looks like the clean-only instruction was added to x86 more
recently and with persistent memory as the intended application.

d9dc64f30 "x86/asm: Add support for the CLWB instruction" says:

"This should be used in favor of clflushopt or clflush in cases where
you require the cache line to be written to memory but plan to access
the data cache line to be written to memory but plan to access the
data"

I don't expect the secret table would be accessed with such frequency
that it would actually make a difference, but if it's just a quirk of
history that the clean-only version isn't exported, now seems as good
a time as any to change that!

> Since this is for SEV the solution can be x86-specific, but if there's a
> generic way I guess it's better (I think all of sev_secret module
> doesn't have x86-specific stuff).

arch_wb_cache_pmem is the closest to arch agnostic I've seen, but that
has it own problems :/
