Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32A244B3ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbhKIU25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbhKIU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:28:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF666C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 12:26:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p18so607549plf.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bn5wQOpHWThLth/4ojxebks2dgNLK2oZehBEm+f68LY=;
        b=AaWnDDC2c8PPJf9B+ZG7OlVIudEoP5fxke8WB0Y26NEEkGKHJjgvRca0NWEQReekpC
         8gvUxvAAlWbMBbik/nb1iaVc9z3Wbrp4OhJJNHyW8PnIUH9soPuloHn9oLZn+TV8zHjH
         EK9DmpIt2OxasDljBuJZ924mDKBS0Caw+9lgcaVtZGC/tvU4AZ5a0bYHtCaDMIoyRTIm
         Axrd55aYkppREPS8GzPGVMpQce5RQdU8MbEVxANDqB2k1+30QTl79zkbSzAZ4qIv7Je+
         fZo+riiH0n9i+dKF8qSPfmCjsp0nDcQ/ld9Q2X1QYaNikCajyPwNsHs/CNU8/+XpTiS9
         F/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bn5wQOpHWThLth/4ojxebks2dgNLK2oZehBEm+f68LY=;
        b=A2rGKRiQlM8BHUaCfMS0CuwEKuM7crLCW7NMgpSNLW2KC3pugIkRGDTsY3f3weYyYh
         eH1VQBtbQr+3xfiMT8acJMNb+qX3h4z2tR2pZmzfmdeDQD57pNGcPgv1OQGDbBJ/r5uu
         AdWx06fZvPczPop4/rXmEIcur4scL0IH85THXZ+2pjI5YPwDQgckasOmikMKGajOxjqA
         fVQu1qWsVg+h1Fer0tfcRZh5AMzVOJ0ZClRmlBMZcsQHf//0b5Sy4ruinOFi1tAAsNZa
         NPN2EBneaxo9jhJ6+BJi3jKupNZuTeZk1+X+IA8i6fRCqp8h0tVBSWZ9yX2RG+Xi6EVb
         S9xQ==
X-Gm-Message-State: AOAM533B2IXfjXyxf0E+xJ0lK1XiCH9FvH5oj5JZWcV4QJEtcc+O3pM7
        lza7q90GbPMHgr0ky4kHsZjHvD0+MIuG3Q==
X-Google-Smtp-Source: ABdhPJzk88EAgEPY1yaGU+w3vWgwrKw28XWTOVFhooiMLe+Qfj6joifGN6+R/Rp2WrI/3qscN2pHRg==
X-Received: by 2002:a17:90b:4a83:: with SMTP id lp3mr10496013pjb.242.1636489568944;
        Tue, 09 Nov 2021 12:26:08 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x18sm7004299pfh.210.2021.11.09.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:26:08 -0800 (PST)
Date:   Tue, 9 Nov 2021 20:26:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     Thomas.Lendacky@amd.com, David Rientjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/4] crypto: ccp - Add SEV_INIT_EX support
Message-ID: <YYrZXRTukz3RccPN@google.com>
References: <20211102142331.3753798-1-pgonda@google.com>
 <20211102142331.3753798-5-pgonda@google.com>
 <YYquDWbkIwCkixxD@google.com>
 <CAMkAt6rHdsdD-L4PbZL7qaOY7GRHmApVJam0V0yY2BnYdhmPjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkAt6rHdsdD-L4PbZL7qaOY7GRHmApVJam0V0yY2BnYdhmPjA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021, Peter Gonda wrote:
> On Tue, Nov 9, 2021 at 10:21 AM Sean Christopherson <seanjc@google.com> wrote:
> > There's no need for this to be a function pointer, and the duplicate code can be
> > consolidated.
> >
> > static int sev_do_init_locked(int cmd, void *data, int *error)
> > {
> >         if (sev_es_tmr) {
> >                 /*
> >                  * Do not include the encryption mask on the physical
> >                  * address of the TMR (firmware should clear it anyway).
> >                  */
> >                 data.flags |= SEV_INIT_FLAGS_SEV_ES;
> >                 data.tmr_address = __pa(sev_es_tmr);
> >                 data.tmr_len = SEV_ES_TMR_SIZE;
> >         }
> >         return __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > }
> >
> > static int __sev_init_locked(int *error)
> > {
> >         struct sev_data_init data;
> >
> >         memset(&data, 0, sizeof(data));
> >         return sev_do_init_locked(cmd, &data, error);
> > }
> >
> > static int __sev_init_ex_locked(int *error)
> > {
> >         struct sev_data_init_ex data;
> >
> >         memset(&data, 0, sizeof(data));
> >         data.length = sizeof(data);
> >         data.nv_address = __psp_pa(sev_init_ex_nv_address);
> >         data.nv_len = NV_LENGTH;
> >         return sev_do_init_locked(SEV_CMD_INIT_EX, &data, error);
> > }
> 
> I am missing how this removes the duplication of the retry code,
> parameter checking, and other error checking code.. With what you have
> typed out I would assume I still need to function pointer between
> __sev_init_ex_locked and __sev_init_locked. Can you please elaborate
> here?

Hmm.  Ah, I got distracted between the original thought, the realization that
the two commands used different structs, and typing up the above.

> Also is there some reason the function pointer is not acceptable?

It's not unacceptable, it would just be nice to avoid, assuming the alternative
is cleaner.  But I don't think any alternative is cleaner, since as you pointed
out the above is a half-baked thought.

> > > +     rc = init_function(error);
> > >       if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {
> > >               /*
> > >                * INIT command returned an integrity check failure
> > > @@ -286,8 +423,8 @@ static int __sev_platform_init_locked(int *error)
> > >                * failed and persistent state has been erased.
> > >                * Retrying INIT command here should succeed.
> > >                */
> > > -             dev_dbg(sev->dev, "SEV: retrying INIT command");
> > > -             rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > > +             dev_notice(sev->dev, "SEV: retrying INIT command");
> > > +             rc = init_function(error);
> >
> > The above comment says "persistent state has been erased", but __sev_do_cmd_locked()
> > only writes back to the file if a relevant command was successful, which means
> > that rereading the userspace file in __sev_init_ex_locked() will retry INIT_EX
> > with the same garbage data.
> 
> Ack my mistake, that comment is stale. I will update it so its correct
> for the INIT and INIT_EX flows.
> >
> > IMO, the behavior should be to read the file on load and then use the kernel buffer
> > without ever reloading (unless this is built as a module and is unloaded and reloaded).
> > The writeback then becomes opportunistic in the sense that if it fails for some reason,
> > the kernel's internal state isn't blasted away.
> 
> One issue here is that the file read can fail on load so we use the
> late retry to guarantee we can read the file.

But why continue loading if reading the file fails on load?

> The other point seems like preference. Users may wish to shutdown the PSP FW,
> load a new file, and INIT_EX again with that new data. Why should we preclude
> them from that functionality?

I don't think we should preclude that functionality, but it needs to be explicitly
tied to a userspace action, e.g. either on module load or on writing the param to
change the path.  If the latter is allowed, then it needs to be denied if the PSP
is initialized, otherwise the kernel will be in a non-coherent state and AFAICT
userspace will have a heck of a time even understanding what state has been used
to initialize the PSP.
