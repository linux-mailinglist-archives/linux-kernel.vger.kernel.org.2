Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34B8348136
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhCXTGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhCXTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:06:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108EC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so3107359pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=jgwTIxb3kQfmGqGhW9clIE4XoyPxtgRgM44bNnHIRJA=;
        b=jtx6m+XsWwynK5IrbYLlN/i1szBH5bcX8ipkJybFqKLbyXmDevTO3+5KsJuoCoCI6j
         TnBWZsNV8EaPOnS5yqKSZpyhdjMxuwp2OYsCyfWnPpSRkU/93S0J/HV4Hh1w++AWSWoL
         joN8SFKfNFy84lEyN1PVBsZNbBhQP9VRf25qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=jgwTIxb3kQfmGqGhW9clIE4XoyPxtgRgM44bNnHIRJA=;
        b=RpCxApAXTV2TnKxkxiocEDITRhifIVyYtoVocTBXTp8L18RoQwPyzmnHZg7iiqJiiW
         GweOhB0HkeXzADjNUL5QOGaKDQj65CtoaJ2N4kxlwmrP5mtk3mGVAmTZqHBFYYT2PXUZ
         aFsKiT1RXdVcmxoIh7wL8yVlynpNaCVsJ8ebXmpClEKRpqCZhUi//IV6IyxPIlm24FJd
         YLAgTBPe+ylWxvph1HaYOzMEjr8rnhcXWhZgJiMFmK34YB8Dv1c/+pvgMhewK7dSXyRy
         b0BZyXXmjGK1zOraJk1017cHQlTCNEqoHofx1v1BzSuN2mm4Hw2g3/X8EA2877EFnrkm
         XsVg==
X-Gm-Message-State: AOAM532FO/goCqCn6ArKvPkYFX/MDBOLtu8yrQITnfgD7uBi8BzNG4yu
        SNGdojobcW5MuxZTsszhGh5jg4LNpntmGw==
X-Google-Smtp-Source: ABdhPJx7ADilZ/U3c/pueKY9lgNEyG4MWQ3dh5d2nSFUDXA0PHmJ5XhEbCHiOjSZczWe1ktjsEvCGw==
X-Received: by 2002:a17:90a:c797:: with SMTP id gn23mr4946489pjb.180.1616612781852;
        Wed, 24 Mar 2021 12:06:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id e65sm3215857pfe.9.2021.03.24.12.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:06:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7ef21ff8-8056-3b07-31ac-bc2de89fa7a0@rasmusvillemoes.dk>
References: <20210324020443.1815557-1-swboyd@chromium.org> <20210324020443.1815557-3-swboyd@chromium.org> <7ef21ff8-8056-3b07-31ac-bc2de89fa7a0@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 02/12] buildid: Add method to get running kernel's build ID
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 12:06:17 -0700
Message-ID: <161661277766.3012082.5402015164122526850@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rasmus Villemoes (2021-03-24 02:24:27)
> On 24/03/2021 03.04, Stephen Boyd wrote:
> > Add vmlinux_build_id() so that callers can print a hex format string
> > representation of the running kernel's build ID. This will be used in
> > the kdump and dump_stack code so that developers can easily locate the
> > vmlinux debug symbols for a crash/stacktrace.
> >=20
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: <kexec@lists.infradead.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  include/linux/buildid.h |  2 ++
> >  lib/buildid.c           | 19 +++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >=20
> > diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> > index ebce93f26d06..2ff6b1b7cc9b 100644
> > --- a/include/linux/buildid.h
> > +++ b/include/linux/buildid.h
> > @@ -10,4 +10,6 @@ int build_id_parse(struct vm_area_struct *vma, unsign=
ed char *build_id,
> >                  __u32 *size);
> >  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 b=
uf_size);
> > =20
> > +const unsigned char *vmlinux_build_id(void);
> > +
> >  #endif
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index 010ab0674cb9..fa1b6466b4b8 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/elf.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/string.h>
> > =20
> >  #define BUILD_ID 3
> > =20
> > @@ -171,3 +172,21 @@ int build_id_parse_buf(const void *buf, unsigned c=
har *build_id, u32 buf_size)
> >  {
> >       return parse_build_id_buf(build_id, NULL, buf, buf_size);
> >  }
> > +
> > +/**
> > + * vmlinux_build_id - Get the running kernel's build ID
> > + *
> > + * Return: Running kernel's build ID
> > + */
> > +const unsigned char *vmlinux_build_id(void)
> > +{
> > +     extern const void __start_notes __weak;
> > +     extern const void __stop_notes __weak;
> > +     unsigned int size =3D &__stop_notes - &__start_notes;
> > +     static unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
> > +
> > +     if (!memchr_inv(vmlinux_build_id, 0, BUILD_ID_SIZE_MAX))
> > +             build_id_parse_buf(&__start_notes, vmlinux_build_id, size=
);
> > +
> > +     return vmlinux_build_id;
> > +}
> >=20
>=20
> Hm, is there any reason to do that initialization lazily and thus need
> an accessor? If the system is coming down hard, there's a (very very
> small) risk that one thread starts finding the build id, is in the
> middle of the memcpy, another thread also ends up wanting the vmlinux
> build id, sees some non-nul byte, and proceeds to using the partially
> written vmlinux_build_id.
>=20
> Perhaps consider just exposing the vmlinux_build_id[] array itself,
> adding a init_vmlinux_build_id() call somewhere early in start_kernel().
>=20
> It could then also be made __ro_after_init.
>=20
> In any case, if you decide to keep the current way, please rename the
> local variable (just "build_id" is fine) so that it doesn't shadow the
> very function it resides in, that's very confusing.
>=20

No particular reason to do it this way. I'll take that approach to
initialize it early in start_kernel() and then expose the array instead.
Thanks!
