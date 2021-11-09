Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D7A44B2CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbhKISpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhKISpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:45:09 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6042AC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:42:22 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id s24so275199lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InQJGFKmQYllVp7IiaAZn+LAmA7OCtH0DBxbniPKpR0=;
        b=RtmT1bhWauZj9jI+RdomKFJes0ucsgQhFZWz3On7EK78Gg5p1mXKWZMa+pU09O9QzI
         i+/g33wS7+C89uC4MHhX5Qi4qnrod6GLyFsWJc355cGkzhhEN5Quwe5VJJk9BPSnv+Wa
         qVnhA9Yf5ByNArMXFVsHusV0Q9r8No1+hC01fSmnXN/iXSaAniHK2S+VdhapXQ8zXSJV
         wZWrszGWl9x3NRa0Ll9Fnkdyl1ofinN6ano1IBnKWVHLTjZmqD90cw7w5kdGx6C/824r
         rGdh+Y3iWoVF7MEJ0w79Q/CTpqulco2q4mGnXPcIYyr8wtv2++wJqSg2p1wA2P7i7RDk
         xJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InQJGFKmQYllVp7IiaAZn+LAmA7OCtH0DBxbniPKpR0=;
        b=skUjgKij/WXEo4tThKdG+smQmj0aN3FrF9DpZ+hfxhZnuUsxZicLZXG+IhVsEZ6fLC
         z+3xoC7ZGsoDalMyPSH6fiA7z4XUxXABB4l+C1kAHv5x2BbKwu9/8WKqy3yjGW9nb/UX
         8w0pxMZwHusxOUpqUHpZrTob32v+3mGCe7nNaiRdIFnLFGBumup1c9V0sidRKcHNb14n
         g+Y0QPvwKyQGZP1lqG6ksjq37hPzWsxPRxE8A9fZq2eWV4NtTX4DnFNNcr3kjw7Z7Kq4
         IKX21LkstRXCV5hmpATwzFJIYHJzNo2fCJrjC2dqyJv1RhYjLAT3yTp6fOkuKnfLwvHe
         aVig==
X-Gm-Message-State: AOAM531K4If6Hrc1zBVOBEjD58jOmBYooFSeo36bTfJiqvvbRgzwZWR7
        q19WohEE8qYMyjDtmryak3ju6gcw4b+zNrqeE6Z+fw==
X-Google-Smtp-Source: ABdhPJwAZPyc1/1ykNzKwifTludqmxvARMnVfNLCjFtpgzyLA65k6mCir8ivv3rsSe7AYhGJcUeB5FaZBkDDDAisdxY=
X-Received: by 2002:a05:651c:1035:: with SMTP id w21mr9520966ljm.278.1636483340373;
 Tue, 09 Nov 2021 10:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com> <20211102142331.3753798-3-pgonda@google.com>
 <YYqicq5YnNuwTS+B@google.com> <CAMkAt6q37BmPcA2Le98NOFQoz9nAwiDQqrALLD-Ogf5RytSS4g@mail.gmail.com>
 <YYqwT1fGxBQQmFvY@google.com>
In-Reply-To: <YYqwT1fGxBQQmFvY@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 9 Nov 2021 11:42:08 -0700
Message-ID: <CAMkAt6pF9cLQa5i4rqGVsrkwZSKsXbWBjY4sgGHVs+HT+4NtXA@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] crypto: ccp - Move SEV_INIT retry for corrupted data
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas.Lendacky@amd.com, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 10:31 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Nov 09, 2021, Peter Gonda wrote:
> > On Tue, Nov 9, 2021 at 9:31 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Tue, Nov 02, 2021, Peter Gonda wrote:
> > > > This change moves the data corrupted retry of SEV_INIT into the
> > >
> > > Use imperative mood.
> >
> > Will do for next revision
> >
> > >
> > > > __sev_platform_init_locked() function. This is for upcoming INIT_EX
> > > > support as well as helping direct callers of
> > > > __sev_platform_init_locked() which currently do not support the
> > > > retry.
> > > >
> > > > Signed-off-by: Peter Gonda <pgonda@google.com>
> > > > Reviewed-by: Marc Orr <marcorr@google.com>
> > > > Acked-by: David Rientjes <rientjes@google.com>
> > > > Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> > > > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > > > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > > > Cc: Marc Orr <marcorr@google.com>
> > > > Cc: Joerg Roedel <jroedel@suse.de>
> > > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > > Cc: David Rientjes <rientjes@google.com>
> > > > Cc: John Allen <john.allen@amd.com>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: linux-crypto@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > ---
> > > >  drivers/crypto/ccp/sev-dev.c | 24 ++++++++++++------------
> > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > > > index ec89a82ba267..e4bc833949a0 100644
> > > > --- a/drivers/crypto/ccp/sev-dev.c
> > > > +++ b/drivers/crypto/ccp/sev-dev.c
> > > > @@ -267,6 +267,18 @@ static int __sev_platform_init_locked(int *error)
> > > >       }
> > > >
> > > >       rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > > > +     if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {
> > >
> > > There are no guarantees that @error is non-NULL as this is reachable via an
> > > exported function, sev_platform_init().  Which ties in with my complaints in the
> > > previous patch that the API is a bit of a mess.
> >
> > That seems like a bug from the caller right? Is it typical that we
> > sanity-check the caller in these instances?
>
> sev-dev.c needs to make up its mind.  __sev_do_cmd_locked() very clearly allows
> a NULL @error, ergo all of the wrappers for sev_do_cmd() support a NULL @error.
>
> > For example the same comment could be made here:
> > https://elixir.bootlin.com/linux/latest/source/drivers/crypto/ccp/sev-dev.c#L336
> >
> > ```
> > static int sev_get_platform_state(int *state, int *error)
> > {
> > struct sev_user_data_status data;
> > int rc;
> >
> > rc = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS, &data, error);
> > if (rc)
> > return rc;
> >
> > *state = data.state;  <--- State could be null.
>
> No, because this is an internal helper and all call sites can be easily audited.
>
> > return rc;
> > }
> > ```
> >
> > Example outside of this driver:
> > https://elixir.bootlin.com/linux/v5.15.1/source/arch/x86/kvm/x86.c#L468
> >
> > ```
> > int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > {
> > enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
> > enum lapic_mode new_mode = kvm_apic_mode(msr_info->data);  <---
> > msr_info could be null here
> > u64 reserved_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu) | 0x2ff |
> > (guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) ? 0 : X2APIC_ENABLE);
> >
> > if ((msr_info->data & reserved_bits) != 0 || new_mode == LAPIC_MODE_INVALID)
> > return 1;
> > if (!msr_info->host_initiated) {
> > if (old_mode == LAPIC_MODE_X2APIC && new_mode == LAPIC_MODE_XAPIC)
> > return 1;
> > if (old_mode == LAPIC_MODE_DISABLED && new_mode == LAPIC_MODE_X2APIC)
> > return 1;
> > }
> >
> > kvm_lapic_set_base(vcpu, msr_info->data);
> > kvm_recalculate_apic_map(vcpu->kvm);
> > return 0;
> > }
> > EXPORT_SYMBOL_GPL(kvm_set_apic_base);
> > ```
>
> The difference is that KVM has consistent expecations for a set of functions,
> whereas sev-dev.c does not.   Yes, KVM will explode if @msr_info is NULL, and
> there are undoubtedly a bajillion flows in the kernel that would do the same,
> but unlike the functions declared in include/linux/psp-sev.h() the requirements
> on the caller are fairly obvious.  E.g. why should this be illegal from a caller's
> perspective?
>
>         sev_platform_init(NULL);
>         sev_platform_status(&status, NULL);

Ack. I'll store a intermediate error in __sev_platform_init_locked and
export to @error if its not null.
