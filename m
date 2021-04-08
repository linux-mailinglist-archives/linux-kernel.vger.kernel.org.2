Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C94358DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhDHT53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhDHT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:57:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1225C061763
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 12:57:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t22so1275681ply.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=SFjnCjujGEgtSC+ABQLNrqugqZ/9XaANTg42WzyEM+c=;
        b=Wgh/cbKnfaPzqZefmKDOLkn79wXmeeaUQXbhkscPI2a05rTC9L4oeuVVAGS8tXOPS4
         Rcl9YephQY6h/zRkFgEtL+sdoR35e/eQA0oabkjl/jrOSeLMjUra4EVzqL9fReZUB9mN
         9MkSfuFoUKIjiC9NPna5S6xg85iI+u9tNn3o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=SFjnCjujGEgtSC+ABQLNrqugqZ/9XaANTg42WzyEM+c=;
        b=jRdj9sMaKWnDquk2I7aJZxqoOERIeq8uOdHijPfcao1k/AHVX/e/8d+lo5Nr8m9KmQ
         ULES6gqI6e6gCQXB6Ixwims9oW/ZcnX386z07hBXwzI9j6l2P1szOFd6cdJTxax3Q7pe
         3HyToL4HzSFxU6MAgYdes07x170f60kd2qGsWUJmcTbFI+GeOv4wATsR3oEAj7EdZbr6
         mQtDbq5EK5bWOd266Mp24butwTcDlrgLaMPmlDmk+kJqC9EnUBYeLvvevFpdLqWM4s/n
         InR9Y+QmJHJctUvpqWOYmBY0JCq/RfJt+Sf4/BTmddFmEYy3rhl2x/wjKoZ4E8jp/6AO
         QFvg==
X-Gm-Message-State: AOAM533ZjgbOnj3HWU+h/IpprsdL4ROKn/0+26SdvIECs6e90FGy7tPP
        BQQgzoQWNxOYPKK4U4gFMYJQng==
X-Google-Smtp-Source: ABdhPJza2HPcGn1bIxKNzHBGVf3omGhgZFg1zXshKLaBZaSsZcgPE8LCZTfrGp300dJ+o9tqAAc2kg==
X-Received: by 2002:a17:902:d78a:b029:e6:e1f:f695 with SMTP id z10-20020a170902d78ab02900e60e1ff695mr9289653ply.82.1617911830394;
        Thu, 08 Apr 2021 12:57:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:44c3:3248:e7f5:1bbd])
        by smtp.gmail.com with ESMTPSA id c2sm246727pfb.121.2021.04.08.12.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:57:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YG8NwgD3y/ydzVXI@smile.fi.intel.com>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-5-swboyd@chromium.org> <YG8I2dQWkOIkypqO@gunter> <YG8NwgD3y/ydzVXI@smile.fi.intel.com>
Subject: Re: [PATCH v3 04/12] module: Add printk format to add module build ID to stacktraces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jessica Yu <jeyu@kernel.org>
Date:   Thu, 08 Apr 2021 12:57:08 -0700
Message-ID: <161791182832.3790633.9176764008911708133@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2021-04-08 07:05:54)
> On Thu, Apr 08, 2021 at 03:44:57PM +0200, Jessica Yu wrote:
> > +++ Stephen Boyd [30/03/21 20:05 -0700]:
>=20
> ...
>=20
> > > +static void init_build_id(struct module *mod, const struct load_info=
 *info)
> > > +{
> > > +   const Elf_Shdr *sechdr;
> > > +   unsigned int i;
> > > +
> > > +   for (i =3D 0; i < info->hdr->e_shnum; i++) {
> > > +           sechdr =3D &info->sechdrs[i];
> > > +           if (!sect_empty(sechdr) && sechdr->sh_type =3D=3D SHT_NOT=
E &&
> > > +               !build_id_parse_buf((void *)sechdr->sh_addr, mod->bui=
ld_id,
> > > +                                   sechdr->sh_size))
> > > +                   break;
> > > +   }
> > > +}
> >=20
> > Why not just look for the .note.gnu.build-id section instead of trying
> > to parse each note section? Doesn't it always contain the build id? At
> > least the ld man page seems to suggest this section name should be
> > consistent.

That's basically what this code is doing. We're looking through all the
section headers and finding the ones that are notes and then
build_id_parse_buf() is checking to see if that note is a GNU type note
(name =3D=3D "GNU") and is of the type NT_GNU_BUILD_ID (type =3D=3D 3). We =
don't
need to check for a section name of ".note.gnu.build-id", we can use the
existing code in build_id_parse_buf() that looks for the name and type.

>=20
> Interesting idea (in positive way!), I'm wondering what Clang does in such
> case.
>=20

Clang also inserts a GNU build ID and it works with these patches.
