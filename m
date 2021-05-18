Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588F6386E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbhERAS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbhERAS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:18:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 17:17:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m11so11387827lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 17:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CEolhPmqveQdMHrQLZCdsiXhuzpxEikCHjkALj6N6s=;
        b=TbTUPK4keNe56luPmgX6uCwhrSdQZ+sh3+tKsNtLQZ5Ccvjic26ktns90GazmBY0Au
         lfjMKbGtNPTJCGovKTpXPhfF5vXDQRHiSN3jugeadftQxnhyO4CsHP1PZXqT6ppic5ZX
         FMw1MZHH/2FiqBHm+7HR7wap2ExLuwRljdy89af3sxtrP0/8AoD7h8+3GLGgZgrPkXIh
         ZLUVkkBFM4qNFqEDZRgavkH+wqy6Ex+/mEmSPqcDpRFiqVVSU5k4GviJMe0XgO84cJ8x
         9AitHiYtJaCiFkZblooua5Oa3R1GMBPQ6UQywcEQ+bAVQH6QHdTTRddpHQh0re2qVWAY
         Nz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CEolhPmqveQdMHrQLZCdsiXhuzpxEikCHjkALj6N6s=;
        b=XNYYn0jjTAoBA2pL8mEsvROTn71qTXC5z9kTiK+6+2Aurd9g2DGVclNxWBSBMtlmp8
         O+F8OD4MGb2y0lrAe+IaGrVZLCoqOZZ1cd0DvmxMC1iZYhDaC63wnQz1E/VOVq7zN0Tz
         6ZyeZddnOlU3zTP5QqIVc7JGY+GkbtTbU121Axm15eF9WfFaJNTWpL67NbKkiAMSlNbo
         4CSD+OlfqmJhDWmrYrYnf35rQAyBfpxTJ3czFAw0nFuPmcA+WZ+ZWV3HPDp7l2a9Xa9H
         /CKVWi7KVB95PH+YbZ7MPudy1UVROAtoOK0fzDcwrwYbTinyRqobY/2GYIp/dZOKimUo
         nT9w==
X-Gm-Message-State: AOAM5330kRa/vEjGazp4r4TgwPzv0tLxLAl3Tu+NzG4egbd3wSlIPahc
        80tAVGoxENZ7xMmg0Km0FOXbJFb/JEK6NZTHx1I+qg==
X-Google-Smtp-Source: ABdhPJyoWr87UCAbWx72DAglWwjbyV1piF0F7vlhsJEOX3Y/PT9jj+qa3mIycS6Kldf5epigLhL7eAP1BbERn+gbD5Y=
X-Received: by 2002:a05:6512:220c:: with SMTP id h12mr1945348lfu.374.1621297027203;
 Mon, 17 May 2021 17:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210422195405.4053917-1-ndesaulniers@google.com>
 <87lf99zzl3.fsf@dja-thinkpad.axtens.net> <CAOSf1CGoN5R0LUrU=Y=UWho1Z_9SLgCX8s3SbFJXwJXc5BYz4A@mail.gmail.com>
In-Reply-To: <CAOSf1CGoN5R0LUrU=Y=UWho1Z_9SLgCX8s3SbFJXwJXc5BYz4A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 May 2021 17:16:55 -0700
Message-ID: <CAKwvOdmMugQkTRwC3HOEt2-em2zSfAoi7gpvJRkqfdzSDRMeEg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv/pci: remove dead code from !CONFIG_EEH
To:     "Oliver O'Halloran" <oohall@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 6:13 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Fri, Apr 23, 2021 at 9:09 AM Daniel Axtens <dja@axtens.net> wrote:
> >
> > Hi Nick,
> >
> > > While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
> > > possible candidate to convert to #ifdef CONFIG_EEH, but it seems that
> > > based on Kconfig dependencies it's not possible to build this file
> > > without CONFIG_EEH enabled.
> >
> > This seemed odd to me, but I think you're right:
> >
> > arch/powerpc/platforms/Kconfig contains:
> >
> > config EEH
> >         bool
> >         depends on (PPC_POWERNV || PPC_PSERIES) && PCI
> >         default y
> >
> > It's not configurable from e.g. make menuconfig because there's no prompt.
> > You can attempt to explicitly disable it with e.g. `scripts/config -d EEH`
> > but then something like `make oldconfig` will silently re-enable it for
> > you.
> >
> > It's been forced on since commit e49f7a9997c6 ("powerpc/pseries: Rivet
> > CONFIG_EEH for pSeries platform") in 2012 which fixed it for
> > pseries. That moved out from pseries to pseries + powernv later on.
> >
> > There are other cleanups in the same vein that could be made, from the
> > Makefile (which has files only built with CONFIG_EEH) through to other
> > source files. It looks like there's one `#ifdef CONFIG_EEH` in
> > arch/powerpc/platforms/powernv/pci-ioda.c that could be pulled out, for
> > example.
> >
> > I think it's probably worth trying to rip out all of those in one patch?
>
> The change in commit e49f7a9997c6 ("powerpc/pseries: Rivet CONFIG_EEH
> for pSeries platform") never should have been made.

I'll change my patch to keep the conditionals, but use #ifdef instead
of #if then?

>
> There's no inherent reason why EEH needs to be enabled and forcing it
> on is (IMO) a large part of why EEH support is the byzantine
> clusterfuck that it is. One of the things I was working towards was
> allowing pseries and powernv to be built with !CONFIG_EEH since that
> would help define a clearer boundary between what is "eeh support" and
> what is required to support PCI on the platform. Pseries is
> particularly bad for this since PAPR says the RTAS calls needed to do
> a PCI bus reset are part of the EEH extension, but there's non-EEH
> reasons why you might want to use those RTAS calls. The PHB reset that
> we do when entering a kdump kernel is a good example since that uses
> the same RTAS calls, but it has nothing to do with the EEH recovery
> machinery enabled by CONFIG_EEH.
>
> I was looking into that largely because people were considering using
> OPAL for microwatt platforms. Breaking the assumption that
> powernv==EEH support is one of the few bits of work required to enable
> that, but even if you don't go down that road I think everyone would
> be better off if you kept a degree of separation between the two.



-- 
Thanks,
~Nick Desaulniers
