Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7023992E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhFBSyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhFBSyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:54:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C146C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 11:52:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v22so3584226lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xh7dUgz7mefwvCgLTFvf8qdD1zEY7RsCdSbdxugXBkY=;
        b=UqnWFzBL6uuNGo3zlt40ZcnADPYSPUCL2e+Q6eoKMaohuAvSLEugaRetUXvmyxIZlE
         CssZgi5bl4+782V7DdT9jI+knGyNQ2NFkQSL6U6QZXaLaNxk0crAN8Vu3DUG9lypN1Qk
         1YZSFbFkiIwG13mL5R/aVrQBwaMIdhGN8juEywI5IJevX7IAjlHUQMQnPkECwHTamPwv
         3RTxt3F32gRzHW9N4t9RcJlHoE5fRvaSPOf2ZW5wKyxAyn1duuiW0i/nrC/pQtxMdkp9
         fixFykYibY57kJMSh7+417zyzLltpW22CCFa6hjvQVvCkHIW27VwG0wenBQuDkjPAsE7
         Yo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xh7dUgz7mefwvCgLTFvf8qdD1zEY7RsCdSbdxugXBkY=;
        b=CXAsFzM5kTyQH+pjxDdW3POKlCL7mKbBFIkLTz8P3ck8A+G6xdyfFli3LAdJAJxZMG
         Vq2yFMNHmOZ96zXeREVcuBEgT2mnMvZDBA0BeVsNy0YNrMTs1U2Yrz0xQubEQ3kFP2x8
         XGsDYJ33Bm5JNLB+S/ebXuodG9hUz67g/jpsVTGyUj1V8JK/qhOiCbHDul+Qm1BNWL/1
         V/gsGw+U7dPt5GzFicWuVsP9VA2fdg2O0rZerFyGvj03GzyUtYacxlufPo+AaURlMR3M
         Wd0lpJ65qeN8mn74NVJYqxwoY8+Ok4/JoEiMWUVSYKdKksfGDFeSqFaPiy52HzSncJat
         Qurg==
X-Gm-Message-State: AOAM532r0TVka9x6hYpAxoPG4P62i9vKJdzsc28Db0wlsecJceyinGrY
        di/2dzUUKPGkiZTNBgTJ1HQ=
X-Google-Smtp-Source: ABdhPJzy8gYwG8d+OGAd7e3/tCNYRf7UgxCgRH6xBWDs128H+HLJJybjfiXWH7e1RU1hwugQP//pEg==
X-Received: by 2002:ac2:51c8:: with SMTP id u8mr12914617lfm.137.1622659971475;
        Wed, 02 Jun 2021 11:52:51 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4ycc2b7s--vdqzfy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:42b0:76ff:fe23:6d08])
        by smtp.gmail.com with ESMTPSA id p2sm69568lfo.141.2021.06.02.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:52:50 -0700 (PDT)
From:   jarmo.tiitto@gmail.com
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH 1/1] pgo: Fix allocate_node() handling of non-vmlinux nodes.
Date:   Wed, 02 Jun 2021 21:52:49 +0300
Message-ID: <2185399.41UrIWHXBM@hyperiorarchmachine>
In-Reply-To: <202106021037.09943A41@keescook>
References: <20210602005702.9650-1-jarmo.tiitto@gmail.com> <20210602005702.9650-2-jarmo.tiitto@gmail.com> <202106021037.09943A41@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote keskiviikkona 2. kes=C3=A4kuuta 2021 20.41.28 EEST:
> On Wed, Jun 02, 2021 at 03:57:04AM +0300, Jarmo Tiitto wrote:
> > Currently allocate_node() will reserve nodes even if *p
> > doesn't point into __llvm_prf_data_start - __llvm_prf_data_end
> > range.
> >=20
> > Fix it by checking if p points into vmlinux range
> > and otherwise return NULL.
> >=20
> > Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> > ---
> >  kernel/pgo/instrument.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> > index 0e07ee1b17d9..9bca535dfa91 100644
> > --- a/kernel/pgo/instrument.c
> > +++ b/kernel/pgo/instrument.c
> > @@ -55,6 +55,10 @@ void prf_unlock(unsigned long flags)
> >  static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data =
*p,
> >  						 u32 index, u64 value)
> >  {
> > +	/* check if p points into vmlinux. If not, don't allocate. */
> > +	if (p < __llvm_prf_data_start || p >=3D __llvm_prf_data_end)
> > +		return NULL;
>=20
> This should be a tighter check (struct llvm_prf_data has size, so just
> checking for p < __llvm_prf_data_end isn't sufficient. I recommend using
> the memory_contains() helper.
>=20
> And I think this should be louder as it's entirely unexpected right
> now. Perhaps:
>=20
> 	if (WARN_ON_ONCE(!memory_contains(__llvm_prf_data_start,
> 					  __llvm_prf_data_end,
> 					  p, sizeof(*p))))
> 		return NULL;
>=20
> > +
> >  	if (&__llvm_prf_vnds_start[current_node + 1] >=3D __llvm_prf_vnds_end)
> >  		return NULL; /* Out of nodes */
> > =20
> > --=20
> > 2.31.1
> >=20
>=20
> --=20
> Kees Cook
>=20


Well, if you do that the WARN_ON_ONCE() will always trigger, unless CONFIG_=
MODULES=3Dn =F0=9F=98=87

This is because 'struct llvm_prf_data *p' argument is expected
(at least I think so) to point into __llvm_prf_data section in vmlinux
and also into each module's own __llvm_prf_data section.

So in the end the compiler supplied pointer is likely correct,
but the current v9 PGO patch attempts to reserve all vnodes
from vmlinux __llvm_prf_vnds section, instead of respective module section.

I think it would be normal to ignore pointers here,
until my module PGO machinery is ready.

But I agree on using memory_contains() for checking if p is within bounds.
I will follow on with v2 of this patch. :-)

=2DJarmo



