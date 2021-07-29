Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E303D9A20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhG2AgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhG2AgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:36:05 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADF5C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 17:36:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l4so5247159ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 17:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e0UcSO3vN6NdPfXAW5Z2clYrWNWotEljfw6HtHpSH6U=;
        b=MhQvcj0tYToLcs058dln2lZoH+D307t+udfweA1FrP1x3zbDt7EAK13wSkIBQu/Tsq
         sdPj9hEkoU3qAYW6nZf5MwUp+uPi0j8kgEsGYSrQFEVQiIqhRrcmmVO/iLzMX5AyRCXc
         rWILmh7lcgtg2/5nctE2h6ZtsUoXc7Wu6Ubiivc1m6meFWdWer2PspuzmNJuEdUazXZu
         GfFqH3uVn1dKWdBVLO/NA6Wj35yxrej8oedP5BHroCL4E4qBgnQvc+5F6vDbmZrLWyXU
         f0yDw/8dU6g4wnu+dbh8M2lWQfGX7NaRXMemn1rArYgSK1ja9hOLVla73+9z7HCvYNte
         SBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e0UcSO3vN6NdPfXAW5Z2clYrWNWotEljfw6HtHpSH6U=;
        b=lsUfKjeWhPcyBbt4fQJ+aHMMJv2nw8f/R1OS4xvzmJghyHKNoketUgnHsL2BWdsuw3
         Z92dhZIfneHXM9u5XTsoXZe7AII+5fW6oJ9Oo5nhE7jBLQmkKQADNtZ9BVI/87s3N1AQ
         J9sCtT5sVYesAaQKxAYOF4h+4tERhtNE5CbGuQiMpgPLRO+tRSp3x4IPwU8Ft6TwcZpZ
         1e8eV4FoPnFNa9Fz2sSnkdB1AUqQk/SEdvKOoXdTQMtzQ6mjs2tkzWLsaIYXv3C74ETs
         31EMqhOfj4MJmFzbnaAguBGo8u/9iE5fcmCIIJVKylBxPCvIBwBgIijTON5HPK7fx0FI
         faxA==
X-Gm-Message-State: AOAM530gl9R0A5irVBMnciZAMcPPhvSpBeMy6c5B60T12ZhiJc2Xg8kS
        rDHMkxdEBYhFecpSrEHh7oCP1eMD/Y+mQJPsYqY=
X-Google-Smtp-Source: ABdhPJwE19Rr1oAyYK0g3PoM4H1rRstcPgIqc7RhE9AM1KAFko1tX+Lslj8n1g7uovPhtKq+LuSTgaYgXhBpEOm27aE=
X-Received: by 2002:a2e:a22c:: with SMTP id i12mr1359703ljm.267.1627518961185;
 Wed, 28 Jul 2021 17:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210708183427.22842-1-bvanassche@acm.org> <9afbc59c-f745-03c1-c74d-264a7180ec87@acm.org>
In-Reply-To: <9afbc59c-f745-03c1-c74d-264a7180ec87@acm.org>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 29 Jul 2021 09:35:50 +0900
Message-ID: <CAC5umygRc0hRDrpO_fU=bo9sAJRsm9vxB3tAtTFpPYguEWB+Lw@mail.gmail.com>
Subject: Re: [PATCH] fault-inject: Declare the second argument of
 setup_fault_attr() const
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=9C=A8) 8:05 Bart Van Assche <bvanass=
che@acm.org>:
>
> On 7/8/21 11:34 AM, Bart Van Assche wrote:
> > This patch makes it possible to pass a const char * argument to
> > setup_fault_attr() without having to cast away constness.
> >
> > Cc: Akinobu Mita <akinobu.mita@gmail.com>
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >   include/linux/fault-inject.h | 2 +-
> >   lib/fault-inject.c           | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.=
h
> > index e525f6957c49..afc649f0102b 100644
> > --- a/include/linux/fault-inject.h
> > +++ b/include/linux/fault-inject.h
> > @@ -42,7 +42,7 @@ struct fault_attr {
> >       }
> >
> >   #define DECLARE_FAULT_ATTR(name) struct fault_attr name =3D FAULT_ATT=
R_INITIALIZER
> > -int setup_fault_attr(struct fault_attr *attr, char *str);
> > +int setup_fault_attr(struct fault_attr *attr, const char *str);
> >   bool should_fail(struct fault_attr *attr, ssize_t size);
> >
> >   #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> > diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> > index ce12621b4275..45520151b32d 100644
> > --- a/lib/fault-inject.c
> > +++ b/lib/fault-inject.c
> > @@ -15,7 +15,7 @@
> >    * setup_fault_attr() is a helper function for various __setup handle=
rs, so it
> >    * returns 0 on error, because that is what __setup handlers do.
> >    */
> > -int setup_fault_attr(struct fault_attr *attr, char *str)
> > +int setup_fault_attr(struct fault_attr *attr, const char *str)
> >   {
> >       unsigned long probability;
> >       unsigned long interval;
>
> Hi Akinobu,
>
> Did I send this patch to the right person?

The fault injection patches are usually merged through the -mm tree.
Could you send this with CCing Andrew?

This patch looks good to me.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
