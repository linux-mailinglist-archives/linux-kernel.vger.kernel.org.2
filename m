Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C283B5B48
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhF1Jca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhF1Jc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:32:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21BBC061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 02:30:02 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b2so692314qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 02:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E72ySZbZCZJUglG4bV3l9a6211R6RN9M28XMGqPmIic=;
        b=Og6yi3wkkqPF391Xj/IuoiwJsVRCZ7ibznjPyr58+t2frYgGOcragsAcbWEw9/Lm9g
         5J2lkz3uaWNxLLDGVAdFcVFoNOD0Pl8tuHH87b4eBkGTZgyGkyNGJ0lOW6lqlOUHR0gT
         z3PbhZhyYWufY/vvxuBAiweYDOLC4KefQuoto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E72ySZbZCZJUglG4bV3l9a6211R6RN9M28XMGqPmIic=;
        b=I/MzLh3zgJAHbIJfhBLR2d3lhRAt8x/JufxovT0N3PvBtPkYeXScegRmSKHgkyYZEV
         gli7RkpuhaH5SZnBqSRwGVqvlGK7USQXRnk+C68wTyc56uj+7cI/oBypLAgMGRMZVGat
         5TaJjjZHYR6qkY6uJG4Z70jXuUw8tLwVqeYPp6SK+JA9yN2P72kV6WzngbBBlfoSVdjn
         t2/x3+IAz6DfN57Y3GdyXKq9WmgVtCWGuegLPrhMc+DJ7DF0Fm+nCPLR3edRP3cJyOWA
         bd3SjfEM9Hof3Mv0E3GyMTZBkrc0t3Ilj2Ig7EQzddmfaCZryI4DqNnUk2NDxXHH2mA8
         pWcg==
X-Gm-Message-State: AOAM532fdv67znRrCNb3/TzoT5nhyJ8jpfvlSu2xqB9eywuubwNFXERZ
        zMRsRJyvTqh7WIMVo1VwlWoenMXUdDUqD/q5ombnaw==
X-Google-Smtp-Source: ABdhPJwxqWTFWg875LeELm0St37Pwr8hO8VE72D3ovSrwjzrF4LIZI8Xq0Wumaj6tg+ZVpzLbABfLc3yhLSnNpq5slE=
X-Received: by 2002:a05:620a:cc1:: with SMTP id b1mr24390353qkj.468.1624872602089;
 Mon, 28 Jun 2021 02:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de> <CAFr9PXk84aejj186UNizftwK_w5G1RXLMsSvAEVEYsXi8=yCoA@mail.gmail.com>
 <27c78c11-b230-a5b5-6648-6b93daf6afda@physik.fu-berlin.de> <CAMuHMdV+SmxUtvAptYfVgy04jCHeABmsEpn3mcUfFQ_RfTF7eA@mail.gmail.com>
In-Reply-To: <CAMuHMdV+SmxUtvAptYfVgy04jCHeABmsEpn3mcUfFQ_RfTF7eA@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 28 Jun 2021 18:29:51 +0900
Message-ID: <CAFr9PXnuFWFy-3mUAo63aiP5qXmD9ULycWVn=_YG96ReohJAjg@mail.gmail.com>
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, 28 Jun 2021 at 17:57, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > There is an unmerged patch set by Yoshinori Sato that adds device tree support for SH.
>
> But it does not include support for SH7724 yet, only for SH775[01]
> (note to myself: still have to try it on my landisk).

I have some landisks. Is there a sane u-boot for them? I think mine
still have the hacked up lilo thing.

> Fortunately most core devices on SH7724 and Ecovec should already
> have DT support in their drivers. The main missing pieces are
> interrupt and clock support.

This sounds like a fun project. I'm not sure if I could manage it
without the Hitachi/Renesas debugging dongle though.

Anyhow, it would be a shame to remove the ecovec just because it
doesn't have DT as it pretty much fully works with a few small patches
to fix some bit rot like ethernet and the LCD not working.
I sent a patch a few years ago for the ethernet and never got a response. :(

Cheers,

Daniel
