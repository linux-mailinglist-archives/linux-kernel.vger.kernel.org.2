Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB2348149
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhCXTL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbhCXTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:11:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74981C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:11:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so1672971pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=WISkCV+v/5OaNh2ppwj/aWSky3u9U+aak3r8UbJPxHQ=;
        b=IFfNxr8QrR36/C4OK1YVRL532hsTPL5VqVdA/a80N9o1Huk54iEkDmAe4pds3/QSYj
         bZGbyd8R0cvzu50QUeY8QWh0Q9u/dHuJZbkBI0pbpnQ+eGR5KhOT3G1zWsSontsun3VP
         oMF1LzqMB1XFRvqyv1Nrfmh0EjHEX6KPiYb2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=WISkCV+v/5OaNh2ppwj/aWSky3u9U+aak3r8UbJPxHQ=;
        b=MFnJ+YQ1VwXFQLhiLL9N0C7iAcmrJQtFKMVUhhUahRX271h+pOTRHGGV2PqeCHn7PQ
         YoS16sOpBNqwygnn0JlcOIRWKSvvbznqnTpamcQNskJjWIVDBMNHsBHnhG8Rj8CLVlPv
         mvf2e6E6/DKqvuYgHp3UY4VAituCcvpba/hlPz5DXoVj+WXMQV460AvhVeMhGUdod4FZ
         1ordOpoEetcSNTxBN1VPrAIHBmm1SKMyk6EtB0BJx3WRsdxIambMGtmUSL6TPody0el6
         kv7+WPmMtjHV1A7jooYV/wx/x2a0yIA86k9LKsVQryABjtX5+XbBYJj0GjFV2VclWeVU
         z6fg==
X-Gm-Message-State: AOAM532goJqOQq+CFWGkrLVDJdeZKzEJFtFXPV0F/HFaU1jit02cjPcX
        4D/5XvtVxSDL7PHn2ECAcybgXyudEnKOVw==
X-Google-Smtp-Source: ABdhPJzwiEU9bml7Oswo/1QUvqdzh67FXB1Qloacamo6Ro1DYj6onsT8ZQ8RuCMBtH5aa2BQHayv1w==
X-Received: by 2002:a17:90a:ea91:: with SMTP id h17mr4947872pjz.66.1616613090691;
        Wed, 24 Mar 2021 12:11:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id y193sm3413813pfc.72.2021.03.24.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:11:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6dfb8ca2-20f3-e58a-ad6b-db6a6472afe0@rasmusvillemoes.dk>
References: <20210324020443.1815557-1-swboyd@chromium.org> <20210324020443.1815557-5-swboyd@chromium.org> <6dfb8ca2-20f3-e58a-ad6b-db6a6472afe0@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 04/12] module: Add printk format to add module build ID to stacktraces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 12:11:28 -0700
Message-ID: <161661308874.3012082.15483899786731677633@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rasmus Villemoes (2021-03-24 02:57:13)
> On 24/03/2021 03.04, Stephen Boyd wrote:
>=20
> > @@ -2778,6 +2793,10 @@ static inline void layout_symtab(struct module *=
mod, struct load_info *info)
> >  static void add_kallsyms(struct module *mod, const struct load_info *i=
nfo)
> >  {
> >  }
> > +
> > +static void init_build_id(struct module *mod, const struct load_info *=
info)
> > +{
> > +}
> >  #endif /* CONFIG_KALLSYMS */
> > =20
> >  static void dynamic_debug_setup(struct module *mod, struct _ddebug *de=
bug, unsigned int num)
> > @@ -4004,6 +4023,7 @@ static int load_module(struct load_info *info, co=
nst char __user *uargs,
> >               goto free_arch_cleanup;
> >       }
> > =20
> > +     init_build_id(mod, info);
> >       dynamic_debug_setup(mod, info->debug, info->num_debug);
> > =20
> >       /* Ftrace init must be called in the MODULE_STATE_UNFORMED state =
*/
> > @@ -4235,7 +4255,7 @@ void * __weak dereference_module_function_descrip=
tor(struct module *mod,
> >  const char *module_address_lookup(unsigned long addr,
> >                           unsigned long *size,
> >                           unsigned long *offset,
> > -                         char **modname,
> > +                         char **modname, unsigned char **modbuildid,
>=20
> It's an existing defect with modname, but surely this should take a
> "const unsigned char **modbuildid", no?

Sure.

>=20
> >                           char *namebuf)
> >  {
> >       const char *ret =3D NULL;
> > @@ -4246,6 +4266,8 @@ const char *module_address_lookup(unsigned long a=
ddr,
> >       if (mod) {
> >               if (modname)
> >                       *modname =3D mod->name;
> > +             if (modbuildid)
> > +                     *modbuildid =3D mod->build_id;
> > =20
> >               ret =3D find_kallsyms_symbol(mod, addr, size, offset);
> >       }
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 41ddc353ebb8..9cd62e84e4aa 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -961,13 +961,15 @@ char *symbol_string(char *buf, char *end, void *p=
tr,
> >       char sym[KSYM_SYMBOL_LEN];
> >  #endif
> > =20
> > -     if (fmt[1] =3D=3D 'R')
> > +     if (fmt[1] =3D=3D 'R' || fmt[1] =3D=3D 'r')
> >               ptr =3D __builtin_extract_return_addr(ptr);
> >       value =3D (unsigned long)ptr;
> > =20
> >  #ifdef CONFIG_KALLSYMS
> >       if (*fmt =3D=3D 'B')
> >               sprint_backtrace(sym, value);
> > +     else if (*fmt =3D=3D 'S' && (fmt[1] =3D=3D 'b' || fmt[1] =3D=3D '=
r'))
> > +             sprint_symbol_stacktrace(sym, value);
> >       else if (*fmt !=3D 's')
> >               sprint_symbol(sym, value);
> >       else
> > @@ -2129,6 +2131,8 @@ early_param("no_hash_pointers", no_hash_pointers_=
enable);
> >   * - 'S' For symbolic direct pointers (or function descriptors) with o=
ffset
> >   * - 's' For symbolic direct pointers (or function descriptors) withou=
t offset
> >   * - '[Ss]R' as above with __builtin_extract_return_addr() translation
> > + * - '[Ss]r' as above with __builtin_extract_return_addr() translation=
 and module build ID
> > + * - '[Ss]b' as above with module build ID (for use in backtraces)
>=20
> The code doesn't quite match the comment. The lowercase s is not handled
> (i.e., there's no way to say "without offset, with build ID"). You don't
> have to fix the code to support that right now, the whole kallsyms
> vsprintf code needs to be reworked inside-out anyway (having vsnprint
> call sprint_symbol* which builds the output using snprintf() calls makes
> me cringe), so please just replace [Ss] by S to make the comment match
> the code - I notice that you did only document the S variant in
> printk-formats.rst.

No problem. Will fix this comment.

>=20
> Is there any reason you didn't just make b an optional flag that could
> be specified with or without R? I suppose the parsing is more difficult
> with several orthogonal flags (see escaped_string()), but it's a little
> easier to understand. Dunno, it's not like we're gonna think of 10 other
> things that could be printed for a symbol, so perhaps it's fine.
>=20

I think I follow. So %pSb or %pSRb? If it's easier to understand then
sure. I was trying to avoid checking another character beyond fmt[1] but
it should be fine if fmt[1] is already 'R'.
