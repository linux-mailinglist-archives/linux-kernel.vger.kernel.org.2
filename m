Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3305133864F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCLHA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhCLHAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:00:52 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C967C061574;
        Thu, 11 Mar 2021 23:00:52 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id c10so1664300ilo.8;
        Thu, 11 Mar 2021 23:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8E99Zfd2Mf/hwCot5q1fILbMB3CtDrbC/Ip5gYh/Z/0=;
        b=TGKYTHizKqsGrQpO/TU9IX/03j7/ZLBzRS1n5Lh2M0F0Yb0Pu8IrWr28jlPSnFzqNb
         BitZowvws3i6Vcq7GaLHVAKv8FiKEsDrmdQkQrL+8kbxqz4QKmhfPbfinF5TOb1ns3bH
         imvDx+8nqOyvLou9YSPCGFm+gyjUXNNB7udxWwNYhNDmxXMWLE/pxvsrPZQBz8g9SZg/
         csMH09562v+RRpvrj9PCYHddVzl2nZzscQbYTz7lRAA7WeB5xbFmMIiLJ0wlxVQLdyxS
         p1KB+c7XfAq/HvWm3nj6R4hdCUgQGCHlM+u5N8BCYe0FHsui56fbPaivnio/dQI/L0M9
         +xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8E99Zfd2Mf/hwCot5q1fILbMB3CtDrbC/Ip5gYh/Z/0=;
        b=eIliDvpd8oLzAACbS5D+sybqZVs9n73O30civzuvwOGdBIJ7XjVE3TjJJg2ZtkWLBZ
         Hh/mtpuXvfgGsrcQm06NK8Plucz8hS/zVWx59Z6Q8PvuTWARTaLZy/NUF5SsXuNEcjKN
         wQG/g5TMvRG8z2MXzLfRy40Ot+iXmQY21NqhFKR2bzZISGGZIsrWgKzzhbx0Ag4x2Baj
         xcYSJGBeqJmmJYoX5c0wNkoVD7dC80lbXyU+ztgCPGRj56g/ZHWATESXI26IEPfP4S1V
         UBBYBhUQT5ek1fQu3ywl8T3bDfleSe9MEyKqI0RunHEIizi5M7SEnAlVMHs26dF36YmU
         nxBg==
X-Gm-Message-State: AOAM532CgnzI8XACRawk2xAkfykdDbe3OpJ+FDOF881OTg0lprHyYFHZ
        OpKQ/51uA8yulVj1Qrt8e8/hrXPpKhMKtG6hZxUVcq3CZHE=
X-Google-Smtp-Source: ABdhPJwLExrMo8wDJt1HPXiyvI5heC6Dp8wP9tSCOIe+64pzlnT1e3vU7Ga8S/OE3Y+PxWhoWtJ1dTkJAa1XZnR+wH0=
X-Received: by 2002:a05:6e02:1049:: with SMTP id p9mr1772509ilj.125.1615532451415;
 Thu, 11 Mar 2021 23:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20210309125324.4456-1-yashsri421@gmail.com> <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com> <CAKXUXMwg7Vs5hm_X3ZHJj9309w5VYbnNeqXaajHBHS1oAKQydw@mail.gmail.com>
 <838a823b-f3fd-ed1b-70d1-82611f9f4ada@gmail.com>
In-Reply-To: <838a823b-f3fd-ed1b-70d1-82611f9f4ada@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 12 Mar 2021 08:00:40 +0100
Message-ID: <CAKXUXMyJKU2ayx6KPFU50JA+t+X6-hhQwo0woNC18T6FTK60rw@mail.gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Aditya <yashsri421@gmail.com>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:04 PM Aditya <yashsri421@gmail.com> wrote:
>
> On 10/3/21 11:49 am, Lukas Bulwahn wrote:
> > On Tue, Mar 9, 2021 at 10:24 PM Aditya <yashsri421@gmail.com> wrote:
> >>
> >> On 9/3/21 7:00 pm, Markus Heiser wrote:
> >>>
> >>> Am 09.03.21 um 13:53 schrieb Aditya Srivastava:
> >>>> Starting commented lines in a file mostly contains comments describing
> >>>> license, copyright or general information about the file.
> >>>>
> >>>> E.g., in sound/pci/ctxfi/ctresource.c, initial comment lines describe
> >>>> its copyright and other related file informations.
> >>>
> >>> The opening comment mark /** is used for kernel-doc comments [1]
> >>>
> >>> [1]
> >>> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments
> >>>
> >>
> >> Hi Markus!
> >> That's true. But the content inside the comment does not follow
> >> kernel-doc format.
> >> For e.g., try running kernel-doc -none/man/rst on the above file in
> >> the example("sound/pci/ctxfi/ctresource.c").
> >> The starting 2-3 lines in files generally do not contain any
> >> struct/enum/function, etc. declaration.
> >>
> >
> > Aditya, can you provide a diff of the warnings over the whole kernel tree?
> >
> > At the moment, your patch just implements ignoring the initial
> > comment, which probably is good for experimentation.
> >
> > Alternatively, we could simply have a dedicated warning and then
> > ignore it or even warn and then parse it as-if.
> >
> > In the "long run", we would probably want to fix all current files in
> > the repository by just replacing '/**' by '/*' and have kernel-doc
> > warn about this suspicious pattern, when new files appear (maybe even
> > configurable, but that is another feature to enable or disable certain
> > kernel-doc checks and warnings). I would certainly assist and
> > contribute to such a clean-up task.
> >
> > I think the first step is to look at the diff, and see how many cases
> > really appear in the tree... then check how many patches throughout
> > the whole tree are required and if they are generally accepted.
> >
>
> Hi Lukas!
> This is the diff of the warnings over kernel tree before and after
> applying these changes.
> There are 2 sections in this report:
> 1) for the warnings present before, but not after, and;
> 2) after but not before
>
> The part (2) contains, for some cases, where the warning for "warning:
> Incorrect use of kernel-doc format:" type has changed to "warning:
> wrong kernel-doc identifier on line:" type.
>
> The diff file can be found at:
> https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/kernel-doc/avoid_init_line_diff.txt
>

Thanks, let us check if we can use this diff to create a patch set
that cleans up those header comments for those files.

Lukas
