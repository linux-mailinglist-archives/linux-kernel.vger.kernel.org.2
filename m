Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B43E8B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhHKHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhHKHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:38:30 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33A8C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 00:38:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w10so1353076qtj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KY+zRy9hKXyNf5Kmtc6yl/ru0cuaPUULXfigVpYJwxQ=;
        b=sGY/P6NtAnbm69Lm7vXOE9Jk/dGMYwJgcyYfv0WSY5iC0Q9bkFcLqQcYBDwR9v+C3Z
         ee+eEFLvK0ppuCf3J9hBRv1S3lsmUuxTVGCxmvb1EFA7yrX0Gby+gFFT7V0xHKfRlDSg
         JaiHjzgFMaY2k40bT5RLsOq6wdALAOyM5HICs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KY+zRy9hKXyNf5Kmtc6yl/ru0cuaPUULXfigVpYJwxQ=;
        b=UMZjSZFuLTapNtCCZBjYhyqmIf7zC4k6JJGOrCVk3/l5SvglMRam09D44XUgyVISdu
         58np5K1LBfM8gl08FI1nXAvlIo179Gq9Mt8Ll4J716XpK1SEbUo9QCr+gpMgfbhCEQGW
         ++WipYd0GSXREMt/4SHWlRUn45eq1hVCxzFaDdF5KyvB3qkbzn2SG2qrmqgoskkxprUz
         hLYUvdG/FJ1qwkOvpSSWcfZpenKxMRHb8w5tOc3CKvomdoqDJiD1UHsGyURf8n7A5d4A
         vYQqqJORIyloQXcVG4cfnLC/abiLv0+fmfaOTw6kjnEGRoSaw1vfLIovRD7Mdh1CM061
         ovtg==
X-Gm-Message-State: AOAM533/MW5RrQsQE9aMDShGSnnT5ZsXH6uKdjCSjHjij8KjvsyDYks4
        Jih3VNr+/hxc8XdejAMQJwfWA1WYC9+Um3GTLNN7/0ujiaY=
X-Google-Smtp-Source: ABdhPJwCp4Yz8cVkAjE0jO5SUaGG6LJ3u5iOqFeWzK7H8MEZL9sBdH3FnPiiqXuHFhES8IHwtDyVYn52RaJp6BZfV64=
X-Received: by 2002:a05:622a:387:: with SMTP id j7mr29561897qtx.132.1628667485754;
 Wed, 11 Aug 2021 00:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210617110842.2358461-1-daniel@0x0f.com> <20210806220242.4b83237d@xps13>
In-Reply-To: <20210806220242.4b83237d@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 11 Aug 2021 16:37:55 +0900
Message-ID: <CAFr9PXm4FTw5U9pFNoqptZ28M21czDHrbipCOVRcn7uABkEKSQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mtd: spinand: core: Properly fill the OOB area.
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Sat, 7 Aug 2021 at 05:02, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> This change looks fine, I'll use spinand->oobbuf instead of databuf +
> offset (will update when applying).

Thanks for looking at this for me. One thing I was worried about is
why the SPI NAND subsystem worked before this change with winbond etc
parts.

You probably don't remember now but I sent a patch to include support
for the longsys foresee parts that have the weird quirk of having no
ECC
data in the OOB so it's all usable by the user except for the bad
block marker and the ECC status bits being next to useless.
I found this issue while trying to validate ubi + my ECC status
decoding worked. [0]

The SPI NAND subsystem in u-boot worked fine as it could create the
ubi formatting on the flash and that would survive reboots but any
blocks written by Linux would be bad on reboot.
When Linux created the ubi format it would work until a reboot as the
correct data was cached in memory then u-boot would complain because
all of the blocks were marked bad.

But winbond parts mounted on the same board, same code etc worked just fine.
I guess the OOB is getting fixed somewhere else for other parts. Maybe
it only happens on the longsys parts because there is no ECC in OOB?

Anyhow I was worried my fix hid some other issue/broke other parts.

Cheers,

Daniel

0 - https://lore.kernel.org/lkml/20210408174922.55c1149f@xps13/
