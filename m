Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B43334F17E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhC3TNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhC3TMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:12:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9B6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:12:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e14so6663727plj.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=pSBj0YaYaN0GbrJlNEC2b8pftXmc5dsioW7Jk9w3b0Q=;
        b=kNYY6xY3yQWZigWtv6pzY98fYe8q2MVfB/FUD6Qtz/kvwR9jrpi8sDZV07WXnzg7+Y
         JGpb+4U00fQhXmQZ33N0dRoEoJx6TkAJo2T1GtK3p7WOJkEkxHNJ1JCd6Wy4VWS+HIgL
         DPfQK0dmqnDvTmnXGIylTcFh5YaSA+fpw0KYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=pSBj0YaYaN0GbrJlNEC2b8pftXmc5dsioW7Jk9w3b0Q=;
        b=Tq8f1UConoYPtv/j+Jv22yMwp3w7TBMZFdVavg2l2wWPhFFLOANuxG0d/mFAw43lmJ
         M91jXycXTUARdXjAAYCp1fNsdZ7aiaA8sAquem23BpuIP58MbUVmJP5IIWt+rrNOwZfY
         ut1yX+76e1I/sQz5GR42sqyH8LZf7nCtpw9sZTj9evIX8hixQ+s8j8LTLun/IG/noKR5
         wGdBXnU9moW+mYvB/xmQmJyOolqcRschGET2pnkNeVEk/dScfq+5RkJuM+OZr28Y5Moh
         yAB0NtRCreffXtfdKNZthQkRRtbtbhcstF8BuRxUMp/p4qJdGEC061HqFozJe2MWKuP5
         KkAw==
X-Gm-Message-State: AOAM531XA+gxatxbG8RbPX7pcwp5j+K/J3AB7srVhpYdS5dEGoBV00H3
        4PZfMg/1Cz9ySNGf+UEJ9SPuKA==
X-Google-Smtp-Source: ABdhPJzPloxjPL7P2kxXfUtG7olsGtlZdZfNGi1MCSQcNkhfcNYyLOfJY+tmHcpRqGrO4heVY1nWdA==
X-Received: by 2002:a17:902:c104:b029:e7:3268:6eb9 with SMTP id 4-20020a170902c104b02900e732686eb9mr22685163pli.32.1617131552563;
        Tue, 30 Mar 2021 12:12:32 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id h14sm3341649pjc.37.2021.03.30.12.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 12:12:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YGL9hHFg9Pm4xaNM@alley>
References: <20210324020443.1815557-1-swboyd@chromium.org> <20210324020443.1815557-5-swboyd@chromium.org> <YGL9hHFg9Pm4xaNM@alley>
Subject: Re: [PATCH v2 04/12] module: Add printk format to add module build ID to stacktraces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Date:   Tue, 30 Mar 2021 12:12:29 -0700
Message-ID: <161713154989.2260335.1975274918938126463@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-03-30 03:29:24)
> On Tue 2021-03-23 19:04:35, Stephen Boyd wrote:
> > Let's make kernel stacktraces easier to identify by including the build
> > ID[1] of a module if the stacktrace is printing a symbol from a module.
> >=20
> > Example:
> >=20
> >  WARNING: CPU: 3 PID: 3373 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNIN=
G+0x28/0x30 [lkdtm]
> >  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cg=
roup uinput xt_MASQUERADE hci_uart <modules trimmed>
> >  CPU: 3 PID: 3373 Comm: bash Not tainted 5.11 #12 a8c0d47f7051f3e6670ce=
aea724af66a39c6cec8
>=20
> I tested it with "echo l >/proc/sysrq-trigger" and I got the following
> output:
>=20
> [   71.905593] CPU: 0 PID: 1762 Comm: bash Kdump: loaded Not tainted 5.12=
.0-rc5-default+ #167 00000080ffffffff0000000000000000
> 00000000
>=20
> It does not looks like an unique build-id.
> Any idea what was going wrong?

Hmm not sure. What does 'hexdump /sys/kernel/notes' show or 'file
vmlinux' parse out of the kernel image?

>=20
> > --- a/include/linux/kallsyms.h
> > +++ b/include/linux/kallsyms.h
> > @@ -91,6 +93,7 @@ const char *kallsyms_lookup(unsigned long addr,
> > =20
> >  /* Look up a kernel symbol and return it in a text buffer. */
> >  extern int sprint_symbol(char *buffer, unsigned long address);
> > +extern int sprint_symbol_stacktrace(char *buffer, unsigned long addres=
s);
> >  extern int sprint_symbol_no_offset(char *buffer, unsigned long address=
);
> >  extern int sprint_backtrace(char *buffer, unsigned long address);
>=20
> Could we use a more clear name? It is hard to guess what is
> the difference between sprint_*_stacktrace() and sprint_backtrace().
>=20
> What about sprint_symbol_build_id() ?

Sure.

>=20
>=20
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 30479355ab85..9e9cb502fb33 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2770,6 +2771,20 @@ static void add_kallsyms(struct module *mod, con=
st struct load_info *info)
> >       }
> >       mod->core_kallsyms.num_symtab =3D ndst;
> >  }
> > +
> > +static void init_build_id(struct module *mod, const struct load_info *=
info)
> > +{
> > +     const Elf_Shdr *sechdr;
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < info->hdr->e_shnum; i++) {
> > +             sechdr =3D &info->sechdrs[i];
> > +             if (!sect_empty(sechdr) && sechdr->sh_type =3D=3D SHT_NOT=
E &&
> > +                 !build_id_parse_buf((void *)sechdr->sh_addr, mod->bui=
ld_id,
> > +                                     sechdr->sh_size))
> > +                     break;
> > +     }
>=20
> Just to be sure. Is this really reliable way how to find the build ID,
> please?
>=20

The build ID is always part of a note section, so if we parse the notes
and find a build ID type of section (see nhdr->n_type =3D=3D BUILD_ID) with
a GNU name then we know we have the right section and will be able to
parse the ID out of the buffer.
