Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22F53CF7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbhGTJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbhGTJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:49:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D2C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:30:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so1190022wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yyHhpf3IFAZa8+1SI9IG6peKhoOSRw9FB1qV/j0MUk8=;
        b=PhXJaFKOpcy2R87A3f53vk2DTtTJTWwcjsKW3ZIokani62gKo5jR0aptPSmRJ/1fTA
         6DTZ6pKoaLfDrl4bXXLSOUBjVLCt7f5wxvv4LQMWoTuqMv0cxIUiPLbommSaffKuRjrP
         gOmxbCxfzZ7GDSNvdtbSL2rHvQELDImGwvWMlagzTJLTsFQ/sqVZYBhcLuUrRLjO5xop
         0BAAZHK1brhUGSN7QZ6Rc5KkPqMNq2A9quWdZax1xJCcYYfyGp0q8AOgjjkeOo8R2jk8
         LznC5t+fgx50pyAxYWv1XtdF/r48ir3eBkYYr7JNEU1eMnPFNXlYweVxAtymaGdW9yV1
         SiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yyHhpf3IFAZa8+1SI9IG6peKhoOSRw9FB1qV/j0MUk8=;
        b=tG4P+rwgKQUHtIm8It+OPE+ARlxEbhafZwmfKoXbKFNouznVjlDiv7IpvrGpwOxfQK
         Vpw4pspN33xaUPtzRScvoy+StiSuPkxVKh1H2D5Jyt7Jj0rTyHpTKMQ19q2NS6hbjnBe
         J5btQ9YMx43Dlit2wwkBSb7gyvjlDtMr1qnRIwZf2/LQ8O5sS0OTRVvzf8ItQYfyvMS1
         qASD5eQXQjgnUIfgbAo+Tj6K5RHQaR3tFYFDtStrVVzYbPtR7u/zpjsFPPS1Qt3kCK7j
         /xrqB2FYhS4TP8Rox2xjntQa3HGzP3FIRDqNBoIKjZ7U08K4fGQkc52BOS7R8n7LGeMn
         lN/Q==
X-Gm-Message-State: AOAM532vbTs+QCRLn6Y/5QdrCQKREpOrzwNaj5lcQ8nQlQkb9IZRZYbu
        2pw50yv2qYgsCd0U/j2AUiWkDA==
X-Google-Smtp-Source: ABdhPJzn7ppEiI6BziSUJrI9AZI83z3s8BqsMlMXuRgHmlK8PB4VVXduDhaZmxWobhXPrKosB7ng7A==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr30864834wmm.90.1626777010977;
        Tue, 20 Jul 2021 03:30:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id w15sm2558095wmi.3.2021.07.20.03.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:30:10 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:30:07 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH 06/14] KVM: arm64: Tolerate re-creating hyp mappings to
 set ignored bits
Message-ID: <YPalr09gA6tGYVtl@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-7-qperret@google.com>
 <CA+EHjTzjT2iv=9jsTNquSAD-_AWqpyCKVPiuCBWGzpxcAkWf9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzjT2iv=9jsTNquSAD-_AWqpyCKVPiuCBWGzpxcAkWf9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fuad,

On Tuesday 20 Jul 2021 at 11:17:03 (+0100), Fuad Tabba wrote:
> Hi Quentin,
> 
> 
> On Mon, Jul 19, 2021 at 11:47 AM Quentin Perret <qperret@google.com> wrote:
> >
> > The current hypervisor stage-1 mapping code doesn't allow changing an
> > existing valid mapping. Relax this condition by allowing changes that
> > only target ignored bits, as that will soon be needed to annotate shared
> > pages.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index a0ac8c2bc174..34cf67997a82 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -362,6 +362,17 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
> >         return 0;
> >  }
> >
> > +static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
> > +{
> > +       if (old == new)
> > +               return false;
> > +
> > +       if (!kvm_pte_valid(old))
> > +               return true;
> > +
> > +       return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_IGNORED);
> 
> Wouldn't this return false if both ignored and non-ignored bits were
> different, or is that not possible (judging by the WARN_ON)?

Correct, but that is intentional, see below ;)

> If it is, then it would need an update, wouldn't it?

Maybe, but if you look at what the existing code does, we do skip the
update if the old mapping is valid and not equal to new. So I kept the
behaviour as close as possible to this -- if you change any bits outside
of SW bits you get a WARN and we skip the update, as we already do
today. But if you touch only SW bits and nothing else, then I let the
update go through.

That said, I don't think warning and then proceeding to update would be
terribly wrong, it's just that a change of behaviour felt a bit
unnecessary for this particular patch.

Thanks,
Quentin
