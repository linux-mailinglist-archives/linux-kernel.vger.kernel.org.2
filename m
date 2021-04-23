Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36B368A47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbhDWBN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:13:56 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AF2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:13:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id u20so16128908qku.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cyx9PZhhSqw92stXaMId3qxBJwezQqU3jTPjAxVlHlk=;
        b=mgdTLS5W8PQoNS/dXi6oYepC4uoCembez+MudJ0h+KNNWTwpFw1pwUm8ZDNjGtBYk4
         I9qHtwvaD3FG2VGm3M6GovfzgKhq27EOw2f8sGVqyD6N3dMQVxLVDLOxPMgZs7Z/mEUW
         tsKee86jzEscppvMZ1Yx3HeM214Tq9mKQTkSMUA+sEGB3UM7DVXTUCxK33YAEv+16OKf
         0GdsESez/v+Ln92dv1DTXMw1iAgsw6335n5PgG42tBlLOqRwxTrnJ5Z8nitCCNOvMLru
         pYKf5YR73dtORqGwHzHR/bPFqGWGhzzeZmb8LCVb5TiVp0Z5uM37LrsJoLx7PZOi8z7F
         UIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cyx9PZhhSqw92stXaMId3qxBJwezQqU3jTPjAxVlHlk=;
        b=E5tehk28l3jctcETp2RCCFNqXs0X6prbyhCBH4VBZEYF5SgCUf2PyoImCtuewkpQrE
         qzDs00vSTPt0xHHTkApUPyqOewZvI9eNt6Zj9RdHm50Xega8NMXMjePx51FbE3B5eXri
         xJtf//oXLskX5RRkR8QZIb1vAPsHsdwjQw65K01kNOSzvxcV1yGZa47g8XZ7NXhswRy2
         bk8H0BQYc2fQvswL3Ay7y35iVgSfdHNJ/tiH6Zn8LXbBjC8OQ5MyLUmoajtUq6jLDju+
         +BYdYvsS/xPQIIBEksh6yQ2FSDRSd7R9Jykm9eKUhNAn9dd81fWn/+MyQd+Qt9XZ1wAh
         K+0Q==
X-Gm-Message-State: AOAM5328tvYqBB9thzbBxZDj8bSNBIN3l5c3n/b8BPtxwH07XudkGsK7
        uyS5Sz15afKwWnLwodPqc5En9qO5RwkSp1bj2/c=
X-Google-Smtp-Source: ABdhPJwJH1UEhJGG3Lec9f5cL3X8GJPl5O+T7Hkxm277gfreNh5f9baH0Kl+KtZN9Nlb/WaapdjLW510gb5y7s+bRCM=
X-Received: by 2002:a37:de14:: with SMTP id h20mr1613385qkj.34.1619140398678;
 Thu, 22 Apr 2021 18:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210422195405.4053917-1-ndesaulniers@google.com> <87lf99zzl3.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87lf99zzl3.fsf@dja-thinkpad.axtens.net>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 23 Apr 2021 11:13:07 +1000
Message-ID: <CAOSf1CGoN5R0LUrU=Y=UWho1Z_9SLgCX8s3SbFJXwJXc5BYz4A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv/pci: remove dead code from !CONFIG_EEH
To:     Daniel Axtens <dja@axtens.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
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

On Fri, Apr 23, 2021 at 9:09 AM Daniel Axtens <dja@axtens.net> wrote:
>
> Hi Nick,
>
> > While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
> > possible candidate to convert to #ifdef CONFIG_EEH, but it seems that
> > based on Kconfig dependencies it's not possible to build this file
> > without CONFIG_EEH enabled.
>
> This seemed odd to me, but I think you're right:
>
> arch/powerpc/platforms/Kconfig contains:
>
> config EEH
>         bool
>         depends on (PPC_POWERNV || PPC_PSERIES) && PCI
>         default y
>
> It's not configurable from e.g. make menuconfig because there's no prompt.
> You can attempt to explicitly disable it with e.g. `scripts/config -d EEH`
> but then something like `make oldconfig` will silently re-enable it for
> you.
>
> It's been forced on since commit e49f7a9997c6 ("powerpc/pseries: Rivet
> CONFIG_EEH for pSeries platform") in 2012 which fixed it for
> pseries. That moved out from pseries to pseries + powernv later on.
>
> There are other cleanups in the same vein that could be made, from the
> Makefile (which has files only built with CONFIG_EEH) through to other
> source files. It looks like there's one `#ifdef CONFIG_EEH` in
> arch/powerpc/platforms/powernv/pci-ioda.c that could be pulled out, for
> example.
>
> I think it's probably worth trying to rip out all of those in one patch?

The change in commit e49f7a9997c6 ("powerpc/pseries: Rivet CONFIG_EEH
for pSeries platform") never should have been made.

There's no inherent reason why EEH needs to be enabled and forcing it
on is (IMO) a large part of why EEH support is the byzantine
clusterfuck that it is. One of the things I was working towards was
allowing pseries and powernv to be built with !CONFIG_EEH since that
would help define a clearer boundary between what is "eeh support" and
what is required to support PCI on the platform. Pseries is
particularly bad for this since PAPR says the RTAS calls needed to do
a PCI bus reset are part of the EEH extension, but there's non-EEH
reasons why you might want to use those RTAS calls. The PHB reset that
we do when entering a kdump kernel is a good example since that uses
the same RTAS calls, but it has nothing to do with the EEH recovery
machinery enabled by CONFIG_EEH.

I was looking into that largely because people were considering using
OPAL for microwatt platforms. Breaking the assumption that
powernv==EEH support is one of the few bits of work required to enable
that, but even if you don't go down that road I think everyone would
be better off if you kept a degree of separation between the two.
