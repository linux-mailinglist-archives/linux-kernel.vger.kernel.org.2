Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3232D9DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhCDS7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:59:31 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:41758 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhCDS7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:59:05 -0500
Received: by mail-oo1-f48.google.com with SMTP id h38so6844939ooi.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEZbPMlm6OKVSsymypk8thSJ+cPHhsgbRxpP5e0RVR0=;
        b=k09kGhA+9d+mwovvbc3apQXyLRZNbPlPOXd83ttEKlrPE05xtOfkEyiENAFug6jaSq
         K97hnaovcDWs0oklEOnajQ2wScFvTQQLh3twxTPStyyfYo+/GfcIguyDHwudYTKwkGu0
         eU5M1RIsL98SYYDuiLS08qitcF2V471So06uWpRviGAEdt3PX7OIAbaGIlntjw/skT05
         BoyzW/vUFMZf3pz9g0egZ04iUzfZZW8Mha/EjWxtj0LwdCwfBAzOLS+5r4zIc/QDcQFe
         nGYlWLN8joPMzmrY8E+u9NbtaoagBqZ4WTAdptG1s4qK3tTAxAesTm+a944G7nusqul7
         c2xw==
X-Gm-Message-State: AOAM533FzCGhnaALsExmfilei3WkMJuT+J2us8OPDAsyX5AVRYOZT9Az
        Rj9zXMxWsD1gZMfuFvyNEfBwvVJPBpyRmwXi6o67MCTs/tM=
X-Google-Smtp-Source: ABdhPJxEzd0UhcOSI5CJVmhnWROZnYW5D76yRU0JCJKOuAoR45zotq8Rzr8Jww28ep+cvToCU9by2nHK3F/5Q2xasqI=
X-Received: by 2002:a4a:d50d:: with SMTP id m13mr4452966oos.2.1614884304439;
 Thu, 04 Mar 2021 10:58:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
 <CAMuHMdWn7GPkLrRnTJRT=9W-PVwoWOVBTqdM-gR180c66vGfOQ@mail.gmail.com> <79c3603cb086435b87030227d3d39443@AcuMS.aculab.com>
In-Reply-To: <79c3603cb086435b87030227d3d39443@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Mar 2021 19:58:11 +0100
Message-ID: <CAMuHMdXv8P-wiNVRv6VLX2OFuy5AxgP3Gk49eLFBGGaQLf46bg@mail.gmail.com>
Subject: Re: A note on the 5.12-rc1 tag
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Mar 4, 2021 at 5:56 PM David Laight <David.Laight@aculab.com> wrote:
> > On Thu, Mar 4, 2021 at 1:59 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > And, as far as I know, all the normal distributions set things up with
> > > swap partitions, not files, because honestly, swapfiles tend to be
> > > slower and have various other complexity issues.
> >
> > Looks like this has changed in at least Ubuntu: my desktop machine,
> > which got Ubuntu 18.04LTS during initial installation, is using a (small)
> > swapfile instead of a swap partition.
>
> My older ubuntu (13.04) didn't have swap at all.

IIRC, the small swapfile was the default suggestion. I don't really
need swap (yummy, 53 GiB in buff/cache ;-)

> I had to add some when running multiple copies of the Altera
> fpga software started causing grief.
> That will be a file.

Or switch FPGA, and use yosys ;-)

> After all once you start swapping it is all horrid and slow.
> Swap to file may be slower, but apart from dumping out inactive
> pages you really don't want to be doing it - so it doesn't matter.
>
> Historically swap was a partition and larger than physical memory.
> This allows simple 'dump to swap' on panic (for many disk types).
> But I've not seen that support in linux.

I know.  We started with lots of small partitions, but nowadays the
distros wan't to install everything in a single[*] partition, even swap.

[*] Ignoring /boot/efi, which didn't exist in the good ol' days.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
