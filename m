Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8417A325878
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhBYVQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhBYVQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:16:11 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA47C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:15:30 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id e7so10745440lft.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jGFsjEI1gQ2OR3E02XGNTuUq+EFNUhZz/AXFp1fN+CM=;
        b=QUDef+8oQUsKGQT4TI2l9XVZteXXw1VhFhn66wtfEG8uEuN0kxAQbVKdcyc8STPRdT
         NXHOtDdoV/syJMcKLTumsInPyhtizLTsxUPJnAtTBDV4BmCQ1h/UpaxTcHPmXywZ2xKq
         cL8d+Hx5Sa3VCps7utdsANgeELZq9iQJxuoPh5occw2FeYot6NU3q9JNvGf+U4iCT44S
         +g4LMDNUu2Bpj+9LPLiYCUHVN3U8cdjzHymQec7uhNcsyoFxwRMdVJqGvgH8FP7EtatW
         +9qpTMU8VsEWkfyPZYCv/Un7xRgo7fmwQz3Px9jMvpHSdAXlSRhY4MDEjNYz3P7VBcpJ
         XPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jGFsjEI1gQ2OR3E02XGNTuUq+EFNUhZz/AXFp1fN+CM=;
        b=ChKBb7H4I+3/WzSKYtehD3WG8f9Dd/tzzDIa9K/Bn0hz4ukUS9GIqp4gPvzsTrvw+3
         R17tAYETDOMfB0fiFwXWzZHuRZ1tptL9KHwYMTuxeJH+aPtyTWhZxT98SOXIOgiMQn9h
         MNH87MiCZesfMnPiHKlg0b1v5o5u3PxFu8xQNMavG/8Wj+WQ1Cjj8R3Npdncvdg5QQhJ
         1cFrjRTgCbs/UQV3U4jz2G2Sh89wmYTsMltxPx4nHijeJZeWI9GGYca4XSV3fOet4+gV
         m7XewbqoIYPf8zcSLXaLK1sh01UR/N6goGabgwh3sX4qeeVO5IVKVrxyTizfyHgUMFQZ
         0cbg==
X-Gm-Message-State: AOAM5318J0Qw/Qt0Z+djjb1d+soWtOUzsd31hkvjWzbTQya6b6wvj4gb
        PXXFCQfACXDJ/jszBpYDhrhld9XJvl7KB/8sMK2vkg==
X-Google-Smtp-Source: ABdhPJydo50QZMsFLHFdcrMQccawsp0xycWnRC92VTYdUGqAk9yNquqaLfJDSCFQ77zzPTByIW3fPz7ApE1HLgLvYx4=
X-Received: by 2002:a19:f11d:: with SMTP id p29mr2961781lfh.547.1614287728943;
 Thu, 25 Feb 2021 13:15:28 -0800 (PST)
MIME-Version: 1.0
References: <202102242224.Cpiog92Y-lkp@intel.com> <83ab58cb-581f-135f-21fd-05c15860cafa@suse.com>
 <a7013b23-af0b-e1dd-324c-904a536d9f01@intel.com> <20210225183436.GA1349@MSI.localdomain>
In-Reply-To: <20210225183436.GA1349@MSI.localdomain>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 13:15:18 -0800
Message-ID: <CAKwvOd=UvZ8Gy0-E8c9EFooCAC4tOALQ4hZ2kZqQsFCPT1Ehfw@mail.gmail.com>
Subject: Re: [kbuild-all] Re: WARNING: modpost: vmlinux.o(.text+0x1a8edb8):
 Section mismatch in reference from the function stop_machine() to the
 function .init.text:intel_rng_hw_init()
To:     Nathan Chancellor <nathan@kernel.org>,
        Rong Chen <rong.a.chen@intel.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:34 AM Nathan Chancellor <nathan@kernel.org> wrot=
e:
>
> On Thu, Feb 25, 2021 at 04:17:21PM +0800, Rong Chen wrote:
> >
> >
> > On 2/24/21 10:26 PM, J=C3=BCrgen Gro=C3=9F wrote:
> > > On 24.02.21 15:20, kernel test robot wrote:
> > > > tree:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > master
> > > > head:   c03c21ba6f4e95e406a1a7b4c34ef334b977c194
> > > > commit: ab234a260b1f625b26cbefa93ca365b0ae66df33 x86/pv: Rework
> > > > arch_local_irq_restore() to not use popf
> > > > date:   2 weeks ago
> > > > config: x86_64-randconfig-a005-20210223 (attached as .config)
> > > > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-projec=
t
> > > > f14a14dd2564703db02f80c00db8ae492b594f77)
> > > > reproduce (this is a W=3D1 build):
> > > >          wget
> > > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.=
cross
> > > > -O ~/bin/make.cross
> > > >          chmod +x ~/bin/make.cross
> > > >          # install x86_64 cross compiling tool for clang build
> > > >          # apt-get install binutils-x86-64-linux-gnu
> > > >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/commit/?id=3Dab234a260b1f625b26cbefa93ca365b0ae66df33
> > > >          git remote add linus
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >          git fetch --no-tags linus master
> > > >          git checkout ab234a260b1f625b26cbefa93ca365b0ae66df33
> > > >          # save the attached .config to linux build tree
> > > >          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.c=
ross
> > > > ARCH=3Dx86_64
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > >
> > > > > > WARNING: modpost: vmlinux.o(.text+0x1a8edb8): Section
> > > > > > mismatch in reference from the function stop_machine() to
> > > > > > the function .init.text:intel_rng_hw_init()
> > > > The function stop_machine() references
> > > > the function __init intel_rng_hw_init().
> > > > This is often because stop_machine lacks a __init
> > > > annotation or the annotation of intel_rng_hw_init is wrong.
> > >
> > > I'd be very interested to know how the identified patch would be able=
 to
> > > have this effect.

Sorry, this looks like fallout from a recent LLVM change, see also:
https://lore.kernel.org/lkml/CAKwvOd=3DB=3DcHpp_XfPTtyVpQyrwQrFZX9SXKw=3DSJ=
C1VC-VbEwFA@mail.gmail.com/

> >
> > Hi Clang Team,
> >
> > The problem is found by the latest clang, and I can't reproduce it with
> > clang-11,
> > could you take a look?
> >
> > Best Regards,
> > Rong Chen
>
> Hi Rong,
>
> Known issue. LLVM 13 cut over to the new pass manager (NPM) which has
> changed some of the inlining heuristics. I would probably recommend
> cutting over to the "release/12.x" branch for now, which should be more

ehh...we still want coverage of ToT LLVM though, to spot potential
issues like this.  I'd take both (clang-12 and 13) if possible; both
are pre-release and still undergoing active development.

> up to date but also stable.
>
> Additionally, Arnd sent a fix for this particular warning here:
> https://lore.kernel.org/lkml/20210225130153.1956990-1-arnd@kernel.org/

Looks like it got picked up by akpm@ in -mm?

>
> Cheers,
> Nathan



--=20
Thanks,
~Nick Desaulniers
