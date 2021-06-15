Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0599A3A7BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFOKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhFOKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:33:19 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C7FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:31:15 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id p5-20020a9d45450000b029043ee61dce6bso6697719oti.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QY2/939t5WrgTBjBlWlTUN2kXiGUMSX5srdzV+Tkpzg=;
        b=YHM+AxYLU1vo0wyn+Xcdbnd4wDcDCXRBgefB95WMmxeVpB3BvW4yvfwfwVluV1Uzct
         6K0x9n3XOqRv8uQH8AEMEuII+L+xTyvkNwtmz4LEduSbH1p++oLjK3B5ahJY0azvywOM
         T31KEOBH92t02N1PEbDaLty+7/fh5xSj5xUDRQatrCmFDyNj2RrjeuLyF00I3rcEzBT5
         y4copCCRCT3PrDQibV1nipJBlHCII3CNu463NSgQeBzirVTKyhueU8FaItBT3K9Jt5Tu
         gXYPLJbUVtIOL6dEEh/yYa6kKqJpNoQ4et+caeyUly9uTAL32yzZbThnjCQGUCk32+3P
         6DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QY2/939t5WrgTBjBlWlTUN2kXiGUMSX5srdzV+Tkpzg=;
        b=NNf6+deqLjnTLcS8IM1YHSm/L7HHFBo35yK1WYDiHAOem4NsWGc//J9ekGUCoSSeCK
         GKZUYblZ1PSht1mQYlVnKAHDd8Nt3sz+gi9OEbfJQTV2Mf+A2v3pRoD59/5zZrMVE5GQ
         NoWtbIG/aFS+j/rNKrGOrKClQCop2ZYRuAuu9l42z8QSUTt0ySsBXHzpN7L6XylcOz6O
         Iubd4hqxOmv4Ff1njme7kbRflYAR8P0UE0Xbam6yXgRnX0L9oH29W6dP8zk3Swf1z5ip
         xSBi69arxbfakl/BtZt2ckgZXXtpPQmpjFIPvsMzbe4Gpo3gt0Yd9nwTBZXmyt/gtnKc
         tr8A==
X-Gm-Message-State: AOAM531MQJuVISCPZprY4MXEvZNnxbq4obQ+12DnQI9ThiOOH5xPnpEB
        ko0QfPsWHMWDTk/aA8Zirsqx4SkYw+/Ei5IFU3EhqQ==
X-Google-Smtp-Source: ABdhPJy0fOalbu0NNzzqQsmoqmUKuJjfDqFf3ggFxXrfL2cRyMZXd7VINleb2XaFbl/rrryoGYhGPaIVwz4Mi8joh90=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr17226203oto.17.1623753073778;
 Tue, 15 Jun 2021 03:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210615014705.2234866-1-dja@axtens.net>
In-Reply-To: <20210615014705.2234866-1-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 15 Jun 2021 12:31:02 +0200
Message-ID: <CANpmjNO9EdwPEiNPu630a2kgsxMXYiNU_phKH2=7Z5YFRCSR1A@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] KASAN core changes for ppc64 radix KASAN
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Andrey]

On Tue, 15 Jun 2021 at 03:47, Daniel Axtens <dja@axtens.net> wrote:
>
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to 64-bit Book3S kernels running on the Radix MMU.
>
> I've been trying this for a while, but we keep having collisions
> between the kasan code in the mm tree and the code I want to put in to
> the ppc tree. So my aim here is for patches 1 through 4 or 1 through 5
> to go in via the mm tree.

I think this is reasonable. I'd suggest just sending non-ppc patches
separately (i.e. split the series explicitly) to KASAN maintainers,
and ensure to Cc Andrew, too. Just point at this series to illustrate
how it'll be used.

I think the patches are fine, but I'm not entirely sure about the
current placements of kasan_arch_is_ready(), so hopefully Andrey can
also have a look.


> I will then propose the powerpc changes for
> a later cycle. (I have attached them to this series as an RFC, and
> there are still outstanding review comments I need to attend to.)
>
> v12 applies to next-20210611. There should be no noticable changes to
> other platforms.
>
> Kind regards,
> Daniel
>
> Daniel Axtens (6):
>   kasan: allow an architecture to disable inline instrumentation
>   kasan: allow architectures to provide an outline readiness check
>   kasan: define and use MAX_PTRS_PER_* for early shadow tables

^^ Up to here could be a separate series to go through -mm.

>   kasan: Document support on 32-bit powerpc

^^ The Documentation changes are minimal and not just confined to
kasan.rst it seems. In fact your "powerpc: Book3S .." patch changes
Documentation more. So you could just take "kasan: Document support on
32-bit powerpc" through ppc tree as well.

>   powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
>   [RFC] powerpc: Book3S 64-bit outline-only KASAN support
