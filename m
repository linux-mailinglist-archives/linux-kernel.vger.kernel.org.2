Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24373E4AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhHIRZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhHIRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:25:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:25:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c16so35537650lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=le5LL61SCcfAtGwVATr90Mk3ZUjYL0wYggEt0ZTf/MI=;
        b=N8fEFXpDUGjJ8NO2mWK1epYiyaTos+/DV8TihHMXwyrgK3dn+R2sbEPeMqYf55yRvL
         wLPSb8gxrO4KhfXXWh0CPXTKayOZNM97h+Wk5erPYOsApsY0wuo61bM2GL0tC6BxKepg
         UGMlKdWUy9fZBY+xR5Nncker8vxk6OHVAKZP9M1/siZlmFe/bXBjaugVHHkyX/5nlllU
         0hGk0MYYF5HUSuRJwQABQTS3EDQ578FbCLh4gG5xvPIhA0AYDSsGglKUWmBRL/c9qNFv
         VCbZhdY9j+2r5ljfaiq9cW+jgawZdaHWUYR4JcJkzBOtHDyVOJwJQW/gwmsko5i2X0nk
         Gfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=le5LL61SCcfAtGwVATr90Mk3ZUjYL0wYggEt0ZTf/MI=;
        b=ZnJ71RzhpO2S5bXNwg9VBHoUhx9igvTLpO5FqmZARM3WyuAjJWUK13tiuhTwnYmf/X
         E+77GHD4s8wotmGahxuMB3FK86qzJAXCZQT3p4ebp4OSWUdM7AqPwFPjE+5wZi+lbUOK
         aOTMF9YzEMSlE+ZnEKnzs8hX7CbOgH3KG8HhyUpA+HKDspywp+g8Tmbtc3esp4UZMOcP
         qMzjAn7ZqA2qK87Z9CSqmjS6+w+1MVWBMkk70EcpsD65G9kuGD02M0yYFHPf/bz+uFoX
         vhL+ayx3P2N/0CVVtG0AsVYswJRj1WsSigduqSQRgOUuzzHGq99Zq87yU61jgR+RlVyu
         8sBA==
X-Gm-Message-State: AOAM531waE/Mtv5j0L99ZU4bXUwiKSyVxTLI01RNZVpHLpVImHuLuCVV
        nuqnGWGUZ9HTDMyRbC257ush7hwcBMcwGOR7gVnjvQ==
X-Google-Smtp-Source: ABdhPJyRnnE+GH1msxqmGez7iEx4Ik5TOSsIctlCTCgTdDM/STfQOF+uqDNSBBN1sUzMy+eg1WbVxDfuaN4dmdzpv/I=
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr18762068lfu.547.1628529908386;
 Mon, 09 Aug 2021 10:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <202108041936.52T4sUU6-lkp@intel.com> <CAKwvOdmOTNTGvGeaRKSp4f6M1PC-HQLjMoaeQU6WM9ygxuU5_w@mail.gmail.com>
 <20210806102246.GB1330186@pl-dbox> <CAKwvOdmP1Bb0wkyUJAs-n5wT-obH56jw2zcBpT7jpV84id4tfw@mail.gmail.com>
 <89b3f65d-b2c8-bd39-24a6-fd6b7f146a98@mozilla.com>
In-Reply-To: <89b3f65d-b2c8-bd39-24a6-fd6b7f146a98@mozilla.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Aug 2021 10:24:56 -0700
Message-ID: <CAKwvOdkqdJpHDK3OX4H99XmcQDRgsq2B46Nf631x0witdBvgWQ@mail.gmail.com>
Subject: Re: ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko]
 undefined!
To:     Sylvestre Ledru <sylvestre@mozilla.com>
Cc:     Philip Li <philip.li@intel.com>, Chen Rong <rong.a.chen@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Brian Cain <bcain@codeaurora.org>,
        Sid Manning <sidneym@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 8, 2021 at 2:13 AM Sylvestre Ledru <sylvestre@mozilla.com> wrot=
e:
>
> Hello,
>
> Le 06/08/2021 =C3=A0 18:57, Nick Desaulniers a =C3=A9crit :
> > On Fri, Aug 6, 2021 at 3:28 AM Philip Li <philip.li@intel.com> wrote:
> >> On Wed, Aug 04, 2021 at 10:18:10AM -0700, Nick Desaulniers wrote:
> >>> On Wed, Aug 4, 2021 at 4:39 AM kernel test robot <lkp@intel.com> wrot=
e:
> >>>> Hi Nathan,
> >>>>
> >>>> First bad commit (maybe !=3D root cause):
> >>>>
> >>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git master
> >>>> head:   d5ad8ec3cfb56a017de6a784835666475b4be349
> >>>> commit: 6fef087d0d37ba7dba8f3d75566eb4c256cd6742 hexagon: handle {,S=
OFT}IRQENTRY_TEXT in linker script
> >>>> date:   4 weeks ago
> >>>> config: hexagon-randconfig-r023-20210804 (attached as .config)
> >>> cool, one of the first reports from 0day bot of hexagon :)
> >> :-) yeah, we just enabled it. BTW: we use one specific version of clan=
g,
> >> does such hexagon support work in latest clang 14.0.0?
> > Yes, it ought to; we're using ToT llvm to build it in our CI.  I'm not
> > precisely sure about clang-13 yet until the apt.llvm.org binaries
> > exist for that branch.
>
> The branch already exists. The webpage wasn't just live yet but it
> should be a few hours (CDN):
>
> https://apt.llvm.org/

Thanks Sylvestre! Nathan has the list of next steps for upgrading our
CI to add coverage of the newly cut branch at:
https://github.com/ClangBuiltLinux/continuous-integration2/issues/176
--=20
Thanks,
~Nick Desaulniers
