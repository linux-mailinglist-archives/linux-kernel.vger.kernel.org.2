Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1123262D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhBZMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhBZMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:43:06 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60086C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:42:26 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q14so10454290ljp.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3fME1d4VIB5ZDW+Zg5+fz2IFPz3UwmBc0l8F1kXAFM=;
        b=xZ3dKPHZO5QvdJGOlSxgGavwkjcKeYv3pwIwSaw/A/JtyRnbbXXjgLbbMbKzFa8gcD
         ekFYJqEahA7tihnQ7Cz/4aOok1S0P+R6fYYUvRPhWEdolLCOwNpasYURdVtK2Rp05oMB
         iWChaLwejieKSxxdssyHe2iPXcgWQwCWIwKmDCqZX46Kk7gx7vP+5xI9R1qNMpKhsWk+
         UwcI5wvXEY4WD6A3FevR3Q3N4cUtwVTgwrtR9q5WexjS8Y7vfyqLhu7Qnh5GfK+cdbtK
         Sk5jKMsFJetDgpM0oZrsyjCaXSmP7qDvSuV9xgwN2UzpBItCgUiIVI5ObH1mYK6vMkCU
         MCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3fME1d4VIB5ZDW+Zg5+fz2IFPz3UwmBc0l8F1kXAFM=;
        b=Jqo396dz4kZSK0gbCJBt+FQvHocbUJ2/M1geuYE9syQnpqb+Qyfp0AZfAwoBLWDHlD
         9uJ87mY7oFSD1tKE1wB6lFnhy3m7H21eX2o+Jo1DCN+iRjDNAVqNjX+Hp+MNsT6Nc45T
         lO+kyyPeps+9BHGtxGlTLHXex0cwY6XiP0y/jccmOUBQQuCAlZcODLfX9As6VSmsQFtV
         V/U4ZEDGOsanu85wDlu4KfsKIvgZlpNW3cNFJ2VFV0qqHJ3Ji5JU+SFjK/GaHzUO/p4+
         gLiLTobdoYyQhAuBUqqt0buaTvP9r6trZffplZHE0tBsrDVQEoGgWZshcYgVf5iOlZoY
         DPfQ==
X-Gm-Message-State: AOAM530jB9ZoNkTivXSk9fOPzje/3nICNkwiRsbUX52iS/7aqDUGgNLX
        6DVbP+MIFFDC/t/Jt1SNSiRPygP8q7HjXKtkerXyShXDs2jlRg==
X-Google-Smtp-Source: ABdhPJw7oH109Dg4gqkMhZt7HREBU+yHbE5JwvdS0fD3Fs7vdC2qy1/240GAXNFq01wAJq4JZttc7aq+oIYlbDN1DnM=
X-Received: by 2002:a2e:5c47:: with SMTP id q68mr1681266ljb.314.1614343344870;
 Fri, 26 Feb 2021 04:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20210226095306.1236539-1-sumit.garg@linaro.org> <20210226105934.gmppt6kubfadv4uf@maple.lan>
In-Reply-To: <20210226105934.gmppt6kubfadv4uf@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 26 Feb 2021 18:12:13 +0530
Message-ID: <CAFA6WYPXCKSYBH8Tapf_yg-jS7G0sH0Dmi27s6hutUMtSE39-Q@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Get rid of custom debug heap allocator
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 at 16:29, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Feb 26, 2021 at 03:23:06PM +0530, Sumit Garg wrote:
> > Currently the only user for debug heap is kdbnearsym() which can be
> > modified to rather ask the caller to supply a buffer for symbol name.
> > So do that and modify kdbnearsym() callers to pass a symbol name buffer
> > allocated statically and hence remove custom debug heap allocator.
>
> Why make the callers do this?
>
> The LRU buffers were managed inside kdbnearsym() why does switching to
> an approach with a single buffer require us to push that buffer out to
> the callers?
>

Earlier the LRU buffers managed namebuf uniqueness per caller (upto
100 callers) but if we switch to single entry in kdbnearsym() then all
callers need to share common buffer which will lead to incorrect
results from following simple sequence:

kdbnearsym(word, &symtab1);
kdbnearsym(word, &symtab2);
kdb_symbol_print(word, &symtab1, 0);
kdb_symbol_print(word, &symtab2, 0);

But if we change to a unique static namebuf per caller then the
following sequence will work:

kdbnearsym(word, &symtab1, namebuf1);
kdbnearsym(word, &symtab2, namebuf2);
kdb_symbol_print(word, &symtab1, 0);
kdb_symbol_print(word, &symtab2, 0);

>
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 9d69169582c6..6efe9ec53906 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
>
> The documentation comment for this function has not been updated to
> describe the new contract on callers of this function (e.g. if they
> consume the symbol name they must do so before calling kdbgetaddrarg()
> (and maybe kdbnearsym() again).
>

I am not sure if I follow you here. If we have a unique static buffer
per caller then why do we need this new contract?

>
> >       char symbol = '\0';
> >       char *cp;
> >       kdb_symtab_t symtab;
> > +     static char namebuf[KSYM_NAME_LEN];
> >
> >       /*
> >        * If the enable flags prohibit both arbitrary memory access
> > diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> > index b59aad1f0b55..9b907a84f2db 100644
> > --- a/kernel/debug/kdb/kdb_support.c
> > +++ b/kernel/debug/kdb/kdb_support.c
> > @@ -57,8 +57,6 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
> >  }
> >  EXPORT_SYMBOL(kdbgetsymval);
> >
> > -static char *kdb_name_table[100];    /* arbitrary size */
> > -
> >  /*
> >   * kdbnearsym -      Return the name of the symbol with the nearest address
> >   *   less than 'addr'.
>
> Again the documentation comment has not been updated and, in this case,
> is now misleading.

Okay, I will fix it.

>
> If we move the static buffer here then the remarks section on this
> function is a really good place to describe what the callers must do to
> manage the static buffer safely as well as a convenient place to mention
> that we tolerate the reuse of the static buffer if kdb is re-entered
> becase a) kdb is broken if that happens and b) we are crash resilient
> if if does.
>
>
> > @@ -79,13 +77,11 @@ static char *kdb_name_table[100]; /* arbitrary size */
> >   *   hold active strings, no kdb caller of kdbnearsym makes more
> >   *   than ~20 later calls before using a saved value.
> >   */
> > -int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > +int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab, char *namebuf)
>
> As above, I don't understand why we need to add namebuf here. I think
> the prototype can remain the same.
>
> Think of it simple that we have reduce the cache from having 100 entries
> to having just 1 ;-) .

Please see my response above.

-Sumit

>
>
> Daniel.
