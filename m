Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411AB44B19B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhKIQ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbhKIQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:59:17 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41FC061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 08:56:30 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e11so18315350ljo.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 08:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/boREeiOnUsS7l12hdWo7Yz/43cU9hRgiBg0G45VUI=;
        b=U644LgmH5os0YhjyX2lXGVcMnJy/jzLf+nmKZWo4uzo4LdV1H8Cv0tRTOTTy7/M6Aq
         ZrFTYuHQ3V5e40aKm+hxm5JZ08l1WUXxk64GmITWcPwbOWVJbsp1fmyA9DZftQSsHuPR
         weHY4BIvmTZtEyip2t8+bf6UVbzSFsL/zUI+tS9yGAYBLWSikonnZM7GeKILQesWnuLT
         woivcyqg6fgqO8+otNCwxgPTTZpGD3uN9/wgeDTmUS6oXMJvaPJrE2qskAb89Vw0/d1k
         Dx4SDGwPDT8KwiqjSf9kxaa7t45b+eS+I2hVNMgo0QhQvh2N9MALqreUVFN3MxboqNEE
         d2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/boREeiOnUsS7l12hdWo7Yz/43cU9hRgiBg0G45VUI=;
        b=GtTrLIl4VHjbab+fgnEycBHiMrVT6F86AiT5z+7f5UjE32TLc6FP4GbQPJuJWQ3f3d
         9zbXGqwBrl0XSYxrVpi7i4IUBwrYkGW/XReL8osdXFxRdUo17FPVLVnc3NgdHq/tfjR0
         WmKCD7SQ6PfZ6dJMj4luFibUAb2O5xihyyBqmrjJNkK9Osux07iTibqk1dAtPSjI0+ci
         LjUbiZoSLQuSAZ9QcvIbRyMbUnpfHAMvz514oIS5Fj6h8sdsJgigSoqL5qFRJOU3Ox5Y
         dgIv1WeOpFlnEvdmbx3PLPAdn8m8I/Kg2aAaciHw7HX1smBZ2btMEaKt7zz9zATdstx0
         mIgQ==
X-Gm-Message-State: AOAM533WiE1Qb3GqqioVjMTzWZRsuvgkX9ciTQs5BBtWYCPKHHf/BiI3
        8jFZ/PE3mUD992rdqev5y9aMMyoIfLP8xM5hIIKaPQ==
X-Google-Smtp-Source: ABdhPJzDj9Vv1wNyWnEEvLmld2YkGi0DQTUPwiqlGO23z4KMUMdDxmu6xiSKFYw+E4RgCf2MhFP+zpUg6U2e12w0JDE=
X-Received: by 2002:a2e:b8cd:: with SMTP id s13mr9222842ljp.527.1636476988886;
 Tue, 09 Nov 2021 08:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com> <20211102142331.3753798-3-pgonda@google.com>
 <YYqicq5YnNuwTS+B@google.com>
In-Reply-To: <YYqicq5YnNuwTS+B@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 9 Nov 2021 09:56:17 -0700
Message-ID: <CAMkAt6q37BmPcA2Le98NOFQoz9nAwiDQqrALLD-Ogf5RytSS4g@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 9:31 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Nov 02, 2021, Peter Gonda wrote:
> > This change moves the data corrupted retry of SEV_INIT into the
>
> Use imperative mood.

Will do for next revision

>
> > __sev_platform_init_locked() function. This is for upcoming INIT_EX
> > support as well as helping direct callers of
> > __sev_platform_init_locked() which currently do not support the
> > retry.
> >
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Reviewed-by: Marc Orr <marcorr@google.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Marc Orr <marcorr@google.com>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: John Allen <john.allen@amd.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/crypto/ccp/sev-dev.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index ec89a82ba267..e4bc833949a0 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -267,6 +267,18 @@ static int __sev_platform_init_locked(int *error)
> >       }
> >
> >       rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > +     if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {
>
> There are no guarantees that @error is non-NULL as this is reachable via an
> exported function, sev_platform_init().  Which ties in with my complaints in the
> previous patch that the API is a bit of a mess.

That seems like a bug from the caller right? Is it typical that we
sanity-check the caller in these instances? For example the same
comment could be made here:
https://elixir.bootlin.com/linux/latest/source/drivers/crypto/ccp/sev-dev.c#L336

```
static int sev_get_platform_state(int *state, int *error)
{
struct sev_user_data_status data;
int rc;

rc = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS, &data, error);
if (rc)
return rc;

*state = data.state;  <--- State could be null.
return rc;
}
```

Example outside of this driver:
https://elixir.bootlin.com/linux/v5.15.1/source/arch/x86/kvm/x86.c#L468

```
int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
{
enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
enum lapic_mode new_mode = kvm_apic_mode(msr_info->data);  <---
msr_info could be null here
u64 reserved_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu) | 0x2ff |
(guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) ? 0 : X2APIC_ENABLE);

if ((msr_info->data & reserved_bits) != 0 || new_mode == LAPIC_MODE_INVALID)
return 1;
if (!msr_info->host_initiated) {
if (old_mode == LAPIC_MODE_X2APIC && new_mode == LAPIC_MODE_XAPIC)
return 1;
if (old_mode == LAPIC_MODE_DISABLED && new_mode == LAPIC_MODE_X2APIC)
return 1;
}

kvm_lapic_set_base(vcpu, msr_info->data);
kvm_recalculate_apic_map(vcpu->kvm);
return 0;
}
EXPORT_SYMBOL_GPL(kvm_set_apic_base);
```

About the API being a mess that seems a little out of scope for this
change. I am not changing the API surface at all here. Again happy to
discuss improvements with you and Tom for follow up series.

>
> > +             /*
> > +              * INIT command returned an integrity check failure
> > +              * status code, meaning that firmware load and
> > +              * validation of SEV related persistent data has
> > +              * failed and persistent state has been erased.
> > +              * Retrying INIT command here should succeed.
> > +              */
> > +             dev_dbg(sev->dev, "SEV: retrying INIT command");
> > +             rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > +     }
> > +
> >       if (rc)
> >               return rc;
> >
> > @@ -1091,18 +1103,6 @@ void sev_pci_init(void)
> >
> >       /* Initialize the platform */
> >       rc = sev_platform_init(&error);
> > -     if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
> > -             /*
> > -              * INIT command returned an integrity check failure
> > -              * status code, meaning that firmware load and
> > -              * validation of SEV related persistent data has
> > -              * failed and persistent state has been erased.
> > -              * Retrying INIT command here should succeed.
> > -              */
> > -             dev_dbg(sev->dev, "SEV: retrying INIT command");
> > -             rc = sev_platform_init(&error);
> > -     }
> > -
> >       if (rc) {
> >               dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
> >                       error, rc);
> > --
> > 2.33.1.1089.g2158813163f-goog
> >
