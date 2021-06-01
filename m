Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD91D397B5B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhFAUsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhFAUsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:48:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB34DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 13:46:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w33so23889781lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiWwAMz7iLrYejxtz+2HF1gEQcQDx+tl72Dyj7rhLz8=;
        b=WPSXIeGWAZ/pyLH1/FB8Nyq+rWQsY+c6rTjQR372TslZRPpiL7ctujqUDUFcAg/7cu
         LOsK4vJL1tPxR9cO/ZQ9Njx0CU121FyJpncS5iaFFkYv1nhwgcSejT9uXlRscy21kdMc
         AzUqEbCyL72/JYa98VI5We3dZ6wSkCKtdiyJ39DCFbPy2CNiHCWTyA7hEwjlDggU4RA6
         tJNlykxgmFtBYua5bFLV4Tjn/6W05U3rprRkxzNchgp/2GQcvSwsnsdXtfr3/FhjZmT6
         ish7rmG2HigXuTvCW/wuBVGg2CCzDjDG0GP2JoqHeachplpbqTAAjFcbOTvhyrOA6C6t
         i5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiWwAMz7iLrYejxtz+2HF1gEQcQDx+tl72Dyj7rhLz8=;
        b=N35HiOHmrS0scvDG96xAOZLW/4tGtEpevIShKP4wJsC6m1C7ICRkxBuwtEEN2Od7Zb
         V58qsNpySgaThAnsNvQW15xnBxYWxque4D9TmKt7dNMCWb4moQq1HyaKmXZZdDrN/yQa
         ejj09uobGCQ30Cd5OCwlSqCD5FQK8BLpSqOI3ej3jysa8bB18s8+lrRoLn9QnVbQi+aw
         +je9NjgR0ZtXsM9IeuyO4WjvMxyQAy6KQcBeygDyTM40Kousq7v5XoEHL8mxpAWd9gZA
         Z1zTI+ryU08Mz0E6OTXXtwO50QCAmPe624OK2wMggAFrfv1fIYv1l1Z4l7Sp8BVl1Lkz
         whIg==
X-Gm-Message-State: AOAM530hiQGG65B6J62O0+Nm5K1qgnU/OcqWyHPIN41j8mdhLODULBzF
        2z+T5ZwVYxL47q9Wks7845U=
X-Google-Smtp-Source: ABdhPJzYi2v5Pz+R4dh0r/ZGJh+62e1/m0a9b3Yl9uLsBUl6fxV2vr6ZukFZakomaNX9+htjtlwdQA==
X-Received: by 2002:a19:e05d:: with SMTP id g29mr1274724lfj.524.1622580385211;
        Tue, 01 Jun 2021 13:46:25 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4yb9bh06yk5jm2qt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:3d09:bda0:2327:559b])
        by smtp.gmail.com with ESMTPSA id 14sm1952086lfq.130.2021.06.01.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:46:24 -0700 (PDT)
From:   jarmo.tiitto@gmail.com
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>, samitolvanen@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 3/6] pgo: modules Add module profile data export machinery.
Date:   Tue, 01 Jun 2021 23:46:23 +0300
Message-ID: <3233714.pFP5IgcPq9@hyperiorarchmachine>
In-Reply-To: <CAKwvOdmk34yQQow_kMLeF32OpfcP4O0SrPx3gMO3KQvgE8uZ9Q@mail.gmail.com>
References: <20210528200821.459214-1-jarmo.tiitto@gmail.com> <2450763.S1xdTQMYLV@hyperiorarchmachine> <CAKwvOdmk34yQQow_kMLeF32OpfcP4O0SrPx3gMO3KQvgE8uZ9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirjoitit tiistaina 1. kes=C3=A4kuuta 2021 20.27.01 EEST:
> On Tue, Jun 1, 2021 at 6:26 AM <jarmo.tiitto@gmail.com> wrote:
> > Kirjoitit tiistaina 1. kes=C3=A4kuuta 2021 11.33.48 EEST:
> > > On Mon, May 31, 2021 at 12:09 PM Nathan Chancellor <nathan@kernel.org>
> >=20
> > wrote:
> > > > On Fri, May 28, 2021 at 11:08:21PM +0300, Jarmo Tiitto wrote:
> > > > > PGO profile data is exported from the kernel by
> > > > > creating debugfs files: pgo/<module>.profraw for each module.
> > > >=20
> > > > Again, I do not really have many comments on the actual code as I am
> >=20
> > not
> >=20
> > > > super familiar with it.
> > > >=20
> > > > However, fs_mod.c duplicates a lot of the functions in fs.c, which
> >=20
> > makes
> >=20
> > > > maintaining this code even more difficult, especially against LLVM =
PGO
> > > > profile data format changes. I just want to make sure I understand
> >=20
> > this:
> > > > does PGO currently not work with modules? Or does this patch series
> >=20
> > just
> >=20
> > > > make it so that each module has its own .profraw file so individual
> > > > modules can be optimized?
> > > >=20
> > > > If it is the latter, what is the point? Why would you want to optim=
ize
> > > > just a module and not the entire kernel, if you already have to go
> > > > through the profiling steps?
> > > >=20
> > > > If it is the former, there has to be a better way to share more of =
the
> > > > machinery between fs.c and fs_mod.c than basically duplicating
> > > > everything because there are some parameters and logic that have to
> > > > change. I do not have a ton of time to outline exactly what that mi=
ght
> > > > look like but for example, prf_fill_header and prf_module_fill_head=
er
> > > > are basically the same thing aside from the mod parameter and the
> > > > prf_..._count() calls. It seems like if mod was NULL, you would call
> >=20
> > the
> >=20
> > > > vmlinux versions of the functions.
> > >=20
> > > Functions definitely shouldn't be duplicated with only minor changes.
> > > We should determine a way to combine them.
> > >=20
> > > As for whether the original PGO patch supports profiling in modules,
> > > the answer is "it depends". :-) I believe that clang inserts profiling
> > > hooks into all code that's compiled with the "-fprofile..." flags.
> > > This would include the modules of course. In GCOV, it's possible to
> > > retrieve profiling information for a single file. Jarmo, is that the
> > > intention of your patches?
> > >=20
> > > -bw
> >=20
> > Thanks for replying Nathan and Bill!
> >=20
> > My original motivation for writing this patch was the realization that =
no
> > profile data could be obtained from modules using the original patch on=
ly.
> >=20
> > My insight when testing the original patch was that the compiler indeed
> > does
> > instrument+profile all code, including any loaded modules. But this is
> > where
> > the current instrument.c falls short:
> > The allocate_node() function may consume nodes from __llvm_prf_vnds_sta=
rt
> > that are actually in a module and not in vmlinux.
> > So llvm_prf_data *p argument may point into an module section, and not
> > into
> > __llvm_prf_data_start range.
> >=20
> > This can result in early exhaustion of of nodes for vmlinux and less
> > accurate
> > profile data. I think this is actually a bug in the original patch.
> >=20
> > So no, the PGO does not currently work with modules. And it somewhat wo=
rks
> > for vmlinux.
>=20
> Hi Jarmo,
> Thanks for the series! Would you mind including the above in a cover lett=
er
> in a v2? (You can use --cover-letter command line arg to `git format-patc=
h`
> to generate a stub).  The please explicitly cc
> Sami Tolvanen <samitolvanen@google.com>
> Bill Wendling <morbo@google.com>
> on the series? Finally, please specify the cover letter and all patch fil=
es
> to git send-email in one command, so that the individual patch files are
> linked on lore.kernel.org. This makes it significantly easier to review a=
nd
> test.
>=20

Hello,
=20
Yeah, I realized afterwards that I screwed up at the git send-mail/message=
=20
threading task. Sorry about that. I will correct all of it in my next v2=20
patch. Make mistakes, and learn new things. =F0=9F=98=83

I will post new v2 patch once I'm done writing and testing it. Based on the=
=20
feed back here I will try keep it simple and unify the vmlinux + modules co=
de=20
such that there is no fs_mod.c source any more nor necessary code duplicati=
on.

Basically it will be an rewrite on my part but I'm just excited to do it.
I feel this first attempt was more like of RFC/prototype such that I could =
get=20
in contact with you guys.

Just one question about copyrights: do I need to add my statement to the=20
sources, if yes, then how should I proceed ?

Regards,
Jarmo Tiitto.

> > My code confines the llvm_prf_value_node reservation to vmlinux or modu=
le
> > in
> > instrument.c based on where the llvm_prf_data *p argument points into.
> >=20
> > My next intention with the patch is that vmlinux and each loadable modu=
le
> > exports their own, separate profile data file in debugfs/pgo/ like the
> > vmlinux
> > already does.
> > So no file level information like in gcov. Only per whole "module.ko" a=
nd
> > the
> > vmlinux binary.
> > This way you can inspect what each module is doing individually using
> > "llvm-
> > profdata show mod.profraw"
> >=20
> > For PGO final build I intended combining the profile data from vmlinux =
and
> > all
> > modules with "llvm-profdata merge" into single profile for optimized
> > build.
> >=20
> > I agree fully that the current code duplication is bad.
> > Maybe I should pass in the mod->prf_xxx sections in a struct to the
> > serializing functions?
> > In that way, the struct can be initialized from either module or the
> > vmlinux
> > sections and all serializing code can share the same code.
> >=20
> > Either way, thanks to your questions and info I can try an write better
> > version.=F0=9F=98=83
> >=20
> > I have learned a lot, thanks.
> > -Jarmo Tiitto
> >=20



