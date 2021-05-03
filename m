Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF174371276
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhECIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECIb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:31:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC7C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 01:30:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g13so1838958qts.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLo/NoP158wv5OLfShasVC5JlpjEaHWC6HUB0+ZGjO0=;
        b=CIXrGbIRxeraVpRULYv+5spL+TSP8Krc2gF+U+gZIEbuBAbu5nvZXjKNwCbObTH/Jz
         IAbWElfvgYmpqv0wvQLO/9nwOa6mt0xhA82cN+fq0s4GlRd2Ve1BYIFyDCxRfaDowlOw
         xgjAIj2gU8IUl6QieprpxyN89fK3hecnnd28lLRZdMVCBDpW76cCl/JfcYyOZQeBB3+t
         hrmjnsRvZ5tqAGWHAAGfJckgAIZSISGib4W25RDFM/gkwo2lia3/wBGy9wMb1IWza+Jm
         mgt+GVmxSLtyaKFjP9DPBudAr7OEy3JcBjU8cgyxfvPyUe8QFoZ3x5YOCSYFBwBE3+ab
         iQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLo/NoP158wv5OLfShasVC5JlpjEaHWC6HUB0+ZGjO0=;
        b=p4hhWwbCZHfllumtgeWgeRxynCA8rwvP3g54K5pptKVdtgaNinimWUI2iKIHvn5xYF
         gYej8JHk62LeT1QJTSpvR0wnwlVOCe3Oz+dI31mE2j84uDeZXvNBfQW99S202qBnh89L
         eDmZAWsJxO/wboScQU8LzPDrcP5QGIrmrNlSF1nrFyhkOt/u/NUCSK8eXfRlQTTY4Ynh
         QQCu/9PUpzrhnWfuJXuF11viUJc+yomdYtvkLDQu/zwpGoRI1ytSw32DZL6jDGMcSRIe
         WzdSF22W/lnY/pRBRYYP9ZXAphZNgtXOLq++Zy7Pfj/RB6R5Q4b/SV8GRzN39vXTmCOp
         x06Q==
X-Gm-Message-State: AOAM532cIJ4j8K1aC6RdtDrOPBfUb4NTfZXoDAUt6LxTzAcK9Rphva5L
        lsZmXc7kTcvnHP0/YsTUEANjm978SqgBbuUjd3Mzsw==
X-Google-Smtp-Source: ABdhPJxVY5+QQybGN3KVm47/Sf02KlFhibdGtoizTL5gHG36o9icaRD2xforWUuf7jiEN0rIu7D6J7yV8ZgaSjPVYwQ=
X-Received: by 2002:ac8:7407:: with SMTP id p7mr16020099qtq.67.1620030632287;
 Mon, 03 May 2021 01:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008d396205b9e4adee@google.com> <CACT4Y+ZisDCO0w9O57tOp+7FL6VqJiFdxaRJ739rjW5z52PeXg@mail.gmail.com>
 <20210127174322.GH4387@sirena.org.uk> <CAAeHK+yW_GCbKAdLEdQpFsjfBKy8_nkFKpBydg3icpb5rbA69g@mail.gmail.com>
 <bf5e0465-2935-a3a0-f003-de2b837dadf6@arm.com> <CACT4Y+bwbHpp4H0UuEd41xfiPSBqrw7KUSKLAqR_fusP8hDHAw@mail.gmail.com>
 <aa1336d9-88d7-0d67-8eb4-8fb63ed181ee@arm.com>
In-Reply-To: <aa1336d9-88d7-0d67-8eb4-8fb63ed181ee@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 May 2021 10:30:21 +0200
Message-ID: <CACT4Y+b5xNFBgawGk1yudd_peAF1uAJXPPBRnZF7SQnVf+R-nw@mail.gmail.com>
Subject: Re: KASAN: invalid-access Read in kmem_cache_destroy
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzbot <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, mbenes@suse.cz,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 2:25 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 1/28/21 12:43 PM, Dmitry Vyukov wrote:
> > On Thu, Jan 28, 2021 at 1:30 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> On 1/27/21 7:50 PM, Andrey Konovalov wrote:
> >>> On Wed, Jan 27, 2021 at 6:44 PM Mark Brown <broonie@kernel.org> wrote:
> >>>>
> >>>> On Wed, Jan 27, 2021 at 06:14:13PM +0100, Dmitry Vyukov wrote:
> >>>>> On Wed, Jan 27, 2021 at 5:58 PM syzbot
> >>>>> <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com> wrote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> syzbot found the following issue on:
> >>>>>>
> >>>>>> HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> >>>>>> git tree:       upstream
> >>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12eb4ad8d00000
> >>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> >>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=2a52b6c31dbefb1e9d9f
> >>>>>> userspace arch: arm64
> >>>>>>
> >>>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>>
> >>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>>> Reported-by: syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com
> >>>>>
> >>>>> This happens on arm64 instance with MTE enabled.
> >>>>> I don't see any corresponding reports on x86_64. So I would assume
> >>>>> it's a generic latent bug, or probably more likely a bug in MTE
> >>>>> support.
> >>>>
> >>>> Copying in Vincenso who's done a bunch of MTE stuff recently.
> >>>
> >>> Could be the same issue as:
> >>>
> >>> https://lkml.org/lkml/2021/1/27/1109
> >>>
> >>
> >> I had a look at the trace and I agree with Andrey it seems the same issue.
> >
> >
> > #syz fix: Revert "mm/slub: fix a memory leak in sysfs_slab_add()"
> >
>
> Thanks for the confirmation.


This was also just detected by KFENCE:
https://lore.kernel.org/lkml/0000000000003f654905c168b09d@google.com/
I think it's a real bug in F2FS and MTE report was correct, but we mis-read it.
