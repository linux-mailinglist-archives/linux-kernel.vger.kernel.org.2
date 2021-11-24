Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB945CE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhKXUk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhKXUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:40:54 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43755C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:37:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id e11so7910678ljo.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiWa89xq2Q9IF+ljEdo4/Z/asgRFC2P5rcNU6pbebKs=;
        b=dn2NWxi0lUYot/N0eTDsmPLuuonR6nIKnTH8qT9MOSFlqysj+TS5FqWODd36P9xB81
         C5sqvp5cwoBGiwtfg02AfI3aL/C6tMWaiBkcCVNRtYLptq6PLdC4IBHhyyHNwxpQDN7c
         yiAZ/dBbxuyXwzG9WjgN+gxoR92GjZUAldIXVtQRbsTgJH8+7pyf1lHzLhaV8DxnxHBC
         cUXt3orBS++uEkXIzWz3eq+Gy7Ut6kPcOpGdq5M13kR5wJCdToWwLO3RkYcgPxxU/smf
         Ykx/jXgdkYmFCDRMZ4oP1LTQnPurN3RmFXuwi5mg84Ho/1XGc9GggM2Q4kuCWTu11oO0
         6TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiWa89xq2Q9IF+ljEdo4/Z/asgRFC2P5rcNU6pbebKs=;
        b=lYyyUA2r7sPUS+05O7gnq3ovrAR2CFs8R9ANR3k44PD1Z5XJ2TgGq35V9Foifr9HL0
         EuigVvUCtNxFTLi5KsmMZnPZUBnTmGMvuuEkA1nsnwkYxTZDOmcFrFNfS/VmLjt+XKv5
         5PQ+RQGol5cRCSni+4GhSolhbXeyHNGsxmkgKPMJRlvucG8vnOlGRlYwH/ZMb3YuSupa
         OATfBapZrBZutRt147ObUgVl1hqpiSlvZAPkisyQdWVWV+fBInYZSEGqkwiGfJMBqhZK
         8y4EwJikQukVAtwFI5wEn9FntAIXF8yVdEZoIJFXtrn8u+ckHIO4SyRrDYnqcoTsQm6X
         pqzQ==
X-Gm-Message-State: AOAM530zMak7KIaavbfWGIeVB6zJ61tOVVnlLNeQnB6tIDqVJ87GBnZO
        xalAEyLPU2ZfhFiV8AvW8v5/vQoVZFqlY7wOzXG/LQ==
X-Google-Smtp-Source: ABdhPJyL75Mlj8xal8gIYuPHynOG80rShCrg0nTZF+lWp+P7xYgFGmnc53IBlOitVrzGGupuCheHT4r1L5ghKeafJZ4=
X-Received: by 2002:a2e:b751:: with SMTP id k17mr18583891ljo.467.1637786262375;
 Wed, 24 Nov 2021 12:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20211123191737.1296541-1-tkjos@google.com> <20211123191737.1296541-4-tkjos@google.com>
 <20211124124313.GH6514@kadam>
In-Reply-To: <20211124124313.GH6514@kadam>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 24 Nov 2021 12:37:30 -0800
Message-ID: <CAHRSSExk8iO5S+OP+GDGpysoMep8=bKW5tjEBJzOm+yAMeUqsQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] binder: defer copies of pre-patched txn data
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 4:44 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Nov 23, 2021 at 11:17:37AM -0800, Todd Kjos wrote:
> > +static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
> > +                                      struct binder_buffer *buffer,
> > +                                      struct list_head *sgc_head,
> > +                                      struct list_head *pf_head)
> > +{
> > +     int ret = 0;
> > +     struct list_head *entry, *tmp;
> > +     struct binder_ptr_fixup *pf =
> > +             list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
> > +                                      node);
> > +
> > +     list_for_each_safe(entry, tmp, sgc_head) {
>         ^^^^^^^^^^^^^^^^^^^
> All the list_for_each() loops can be changed to list_for_each_entry().
>
>
>         list_for_each_entry_safe(sgc, tmp, sgc_head, node) {

Will change. Thanks for the suggestion.

>
> regards,
> dan carpenter
>
>
>
> > +             size_t bytes_copied = 0;
> > +             struct binder_sg_copy *sgc =
> > +                     container_of(entry, struct binder_sg_copy, node);
> > +
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
