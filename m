Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED71043FF34
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhJ2PQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ2PQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:16:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1EC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:13:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id d23so16065658ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qii+ptLF2i7+SBSvvUusnkbqd6rgIzG2RDHpMl1N+B4=;
        b=h54gEsdylR2vq6nHL+siTQXNFLt8HFCuK+/DSk/JuLE08Uig08MkvvcKcXosuQdmbj
         OqGRezQf8OATz2mbRTsYLII13C0LVXjjjSPY8MkkPTYFS5k8l/rovFyJGstwtOI5rCNU
         7LNOLYgt4YK2jSSk4xwOsDbArGaBSkRjX3O47KWt3QksRkO4YbZwL24MPn1taShCxUJ2
         JmjaRCRxK7PpNwC9Ypk97iugAIYa0PqDovTqSlcurVIHxoZny+KcRw2yoMuINeGP5sq4
         P5G6GFFtwRslP2a5808+I3lTUyB6OAOnJ/38SA7uhPEypV5bXja0L4lcdVhW4t+3Yrxz
         DA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qii+ptLF2i7+SBSvvUusnkbqd6rgIzG2RDHpMl1N+B4=;
        b=0aPZw32+vktSLOVVQIT9zV4eXyO3xx4tMfi17rYT0J7m9FOoQjEvI35pS9NCBTreTT
         mYF/zVHQqU4P1fXRndjqdXo29CUKITK0zHhxRcho76AT7X4koxzUgvNI3v3bRn1aDfTl
         N0XnMSbb1i0Y5IDKAsA81DWiMwQ6A+cjbFnavcca9XLg9zT4llpdCgixV0CM7ADQ/nmF
         0bfFPbdNkY2jc7WIewuyhQTre5Z2qUL8iN0WK8aq5PW3HovpxEAhA+0TScD/P57rdtk5
         8XRZM/MxN3pF9lut5arVhojcSxo2iUCFHTXCJq/Om7j4kSdmDxXHj3+kgW2REE8LtgAe
         e8og==
X-Gm-Message-State: AOAM530kcq982iqcr0ivtrzILGRsVbYms73OVD/bjUGAcBAEL9Y6vs21
        7cCQmmaA0eNBg6ARfXSPgsE6gDyCLRZxuy8PBDZU3g==
X-Google-Smtp-Source: ABdhPJz88OghnzzXUFPsG5FK3Vs4IQw/hl9DSdjasDqTvAbWXQ+f1eB3bxaULJIhND4FZLu7vw/JqPKmfrgZQpfUr8E=
X-Received: by 2002:a2e:a90b:: with SMTP id j11mr12135141ljq.282.1635520433458;
 Fri, 29 Oct 2021 08:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211028175749.1219188-1-pgonda@google.com> <20211028175749.1219188-4-pgonda@google.com>
 <d3235e92-e29a-3b52-540d-4a49ce53389b@amd.com>
In-Reply-To: <d3235e92-e29a-3b52-540d-4a49ce53389b@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 29 Oct 2021 09:13:41 -0600
Message-ID: <CAMkAt6r=KJ3fMGc4mrUeKVzyWjah5KYRU6u7bqTVsHtwfWkcZw@mail.gmail.com>
Subject: Re: [PATCH 3/4] crypto: ccp - Refactor out sev_fw_alloc()
To:     Tom Lendacky <Thomas.Lendacky@amd.com>
Cc:     David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 7:48 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 10/28/21 12:57 PM, Peter Gonda wrote:
> > Creates a helper function sev_fw_alloc() which can be used to allocate
> > aligned memory regions for use by the PSP firmware. Currently only used
> > for the SEV-ES TMR region but will be used for the SEV_INIT_EX NV memory
> > region.
> >
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Marc Orr <marcorr@google.com>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: John Allen <john.allen@amd.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Paolo Bonzini <pbonzini@redhat.com> (
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   drivers/crypto/ccp/sev-dev.c | 24 +++++++++++++++++-------
> >   1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index e4bc833949a0..b568ae734857 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -141,6 +141,21 @@ static int sev_cmd_buffer_len(int cmd)
> >       return 0;
> >   }
> >
> > +static void *sev_fw_alloc(unsigned long len)
> > +{
> > +     const int order = get_order(len);
>
> This should be an unsigned int to match the function definition, but is
> probably not needed given the comment below.
>
> > +     struct page *page;
> > +
> > +     if (order > MAX_ORDER-1)
> > +             return NULL;
>
> I believe alloc_pages() already does this check (and provides a warning
> unless requested not to), so this check isn't needed.

Oh I missed that. Removed.

>
> > +
> > +     page = alloc_pages(GFP_KERNEL, order);
>
> Without the above check, you can just replace the 'order' variable with
> 'get_order(len)'.

Moved the get_order() inline here as suggested.

>
> Thanks,
> Tom
>
> > +     if (!page)
> > +             return NULL;
> > +
> > +     return page_address(page);
> > +}
> > +
> >   static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
> >   {
> >       struct psp_device *psp = psp_master;
> > @@ -1076,7 +1091,6 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
> >   void sev_pci_init(void)
> >   {
> >       struct sev_device *sev = psp_master->sev_data;
> > -     struct page *tmr_page;
> >       int error = 0, rc;
> >
> >       if (!sev)
> > @@ -1092,14 +1106,10 @@ void sev_pci_init(void)
> >               sev_get_api_version();
> >
> >       /* Obtain the TMR memory area for SEV-ES use */
> > -     tmr_page = alloc_pages(GFP_KERNEL, get_order(SEV_ES_TMR_SIZE));
> > -     if (tmr_page) {
> > -             sev_es_tmr = page_address(tmr_page);
> > -     } else {
> > -             sev_es_tmr = NULL;
> > +     sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
> > +     if (!sev_es_tmr)
> >               dev_warn(sev->dev,
> >                        "SEV: TMR allocation failed, SEV-ES support unavailable\n");
> > -     }
> >
> >       /* Initialize the platform */
> >       rc = sev_platform_init(&error);
> >
