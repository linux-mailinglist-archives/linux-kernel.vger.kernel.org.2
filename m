Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBE3CF897
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 13:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhGTKZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbhGTKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:19:26 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257AFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:00:05 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s23so8357629oiw.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVn1SYmkQB3M7v69VF2he/NUlW4fKKcfsWY+DKqff6A=;
        b=Wy82mBov5LjHgcaRRiO3uSMxaLw2FeoKQvcia10TJnBdtBGL9IZSGjxDGX5omGEgDT
         nJh+G6Jfrn8+kvbeqa0NNd4uBsEq6fmqDFBP3pSD0fKZVNjsIB+SGAEEDPxzzPltefb4
         TbrGVgW+jrLjVChYoTUTA01fM0N3fPz6u2SHtPCZaKkDO9XgnJAZlGRfrhShxAb3WRcA
         KoGRFzcIC1HYR8G0Pv8fyy5KMFGFTqWbp33gLJ1HMxfFP3D1OVrjOReZ0PoE23EjMw/P
         BnIsWaeoQZSOTrN7575vP0mrGMcF3D62Z1G684aC+T1NcM5IS6FFk1MvgttlPpmbWWec
         edlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVn1SYmkQB3M7v69VF2he/NUlW4fKKcfsWY+DKqff6A=;
        b=KfDm3XsBs8LcGRKb43xnfhg0SjkKKZPQMb++qILkQ+OSSMslZqxYsG7ap6m6hthMPZ
         /oAQexB7mLWDn4TJnB+Bw0CPRioqbrBJz8swzNNeY3UqQCZivMvnS1oCJy3PbsC7TG6J
         CKNH0rPlrDk0RrbW4xelzngifJVm2BWK0OlnglJheRNzvEOew1LbMtz9fecWPrmFQ3ph
         3OniarWMmb+OXjz92AnC/qx7prp2ar2KZp850wm1c1TirZn94Osqbu4pDmLdlV7l3IgT
         bJdDCo4cR7N+ehvICl9dty76ZkcZP/U5+3NMgTDRtoqVexGsJrIal5SvbVqQHZjQGPhZ
         4gpw==
X-Gm-Message-State: AOAM5339ltD04IedTDeLiJXH2u2LinJIEi8vzlAcmYNITY953BV15xnR
        RxqBbyIyDdZ9PXJgknsaq2NgiRk5rVQ0pB1x1N0UAw==
X-Google-Smtp-Source: ABdhPJwifz6pu5NBhio7NwidX7Z1fxHFB/vsZ48ZpYgUwL+dzCzouBKLdEAxyuGStD1hj4hu7q+1YBk4sq1EMVSS+wg=
X-Received: by 2002:a05:6808:5a:: with SMTP id v26mr11589545oic.90.1626778803869;
 Tue, 20 Jul 2021 04:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com> <20210719104735.3681732-7-qperret@google.com>
 <CA+EHjTzjT2iv=9jsTNquSAD-_AWqpyCKVPiuCBWGzpxcAkWf9w@mail.gmail.com> <YPalr09gA6tGYVtl@google.com>
In-Reply-To: <YPalr09gA6tGYVtl@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 20 Jul 2021 11:59:27 +0100
Message-ID: <CA+EHjTz__zjYY2D8+nEPq2F8__saxC0kApnn7_rs0r2VCR2Nzg@mail.gmail.com>
Subject: Re: [PATCH 06/14] KVM: arm64: Tolerate re-creating hyp mappings to
 set ignored bits
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, Jul 20, 2021 at 11:30 AM 'Quentin Perret' via kernel-team
<kernel-team@android.com> wrote:
>
> Hi Fuad,
>
> On Tuesday 20 Jul 2021 at 11:17:03 (+0100), Fuad Tabba wrote:
> > Hi Quentin,
> >
> >
> > On Mon, Jul 19, 2021 at 11:47 AM Quentin Perret <qperret@google.com> wrote:
> > >
> > > The current hypervisor stage-1 mapping code doesn't allow changing an
> > > existing valid mapping. Relax this condition by allowing changes that
> > > only target ignored bits, as that will soon be needed to annotate shared
> > > pages.
> > >
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > > index a0ac8c2bc174..34cf67997a82 100644
> > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > @@ -362,6 +362,17 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
> > >         return 0;
> > >  }
> > >
> > > +static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
> > > +{
> > > +       if (old == new)
> > > +               return false;
> > > +
> > > +       if (!kvm_pte_valid(old))
> > > +               return true;
> > > +
> > > +       return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_IGNORED);
> >
> > Wouldn't this return false if both ignored and non-ignored bits were
> > different, or is that not possible (judging by the WARN_ON)?
>
> Correct, but that is intentional, see below ;)
>
> > If it is, then it would need an update, wouldn't it?
>
> Maybe, but if you look at what the existing code does, we do skip the
> update if the old mapping is valid and not equal to new. So I kept the
> behaviour as close as possible to this -- if you change any bits outside
> of SW bits you get a WARN and we skip the update, as we already do
> today. But if you touch only SW bits and nothing else, then I let the
> update go through.
>
> That said, I don't think warning and then proceeding to update would be
> terribly wrong, it's just that a change of behaviour felt a bit
> unnecessary for this particular patch.

Thanks for the clarification. It makes sense to preserve the existing
behavior, but I was wondering if a comment would be good, describing
what merits a "needs update"?

Cheers,
/fuad

> Thanks,
> Quentin
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
