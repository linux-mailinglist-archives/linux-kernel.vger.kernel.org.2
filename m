Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06230764D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhA1Moi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhA1Moc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:44:32 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09832C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:43:52 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c1so3927629qtc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFanYpLk8EQSvMHX5xoViEs7dc+YjAc8O4DTZLkTaek=;
        b=RioM2wMaTHIJFLJB6xJ1fRP7Zh8QMt0XWq0cK+8OWW7RYWtMqQWIqmi+ThMhw2DTBz
         LcdGsUn42D+Ct0gU6vFmLYMOKN3r/jIzVGLeHjX0fQ0SMgdmAPQBse4iPsrQggdcjKuo
         y2jRCzMOaKsLxMXP0fPaVnJx/uzS/QZQvg/16VL/pwVgcrrJ5VcGnzB1xAeI8Mxowl0F
         +HhlTgAQ1NHruB60HilgyzNYRnvBdPhCeRG8PeaZUd+2VYZQ5Vd92Tvn0hhowXPLZDKF
         sLW1TvgcGrK9rUoquiIN5LYilmYit7XdQj47cboqLzZFYbLzhRCoRkqaP9Hrwjx7IO0x
         KZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFanYpLk8EQSvMHX5xoViEs7dc+YjAc8O4DTZLkTaek=;
        b=MKo948qOW7R7OWzehkFqyLmlwbs5eWJSOJlsP/u/TtBa4zw50mcMEvtXT1rRIeGfKe
         k2bZDirutSgMTnOq/FQufj89REToA7PVX5V9t9ARZbSGa+/vD4CvpuF+QOcEDCBtja7N
         pfBLPVcAbRY6LkZSZxsj9bRr20Wsi6i+xW0xRg/NDmbu8ru9d3XAspX55gy/4jcCq2D9
         1I9F49W03kg1HS6AwMEncyRyYvcu0Ywsnl+mWttOU1ZlfBHKvEeZOfTe5halv29owga9
         NIU/2DgavWTDvBbFCwYTbwIdER/N6nKmmxeKA7OTkwVJEkjUMIrDDHMzPSE4mXDY5qn5
         q2ZQ==
X-Gm-Message-State: AOAM5322AiVuBPxWxAHrA+FNcX+V0kIHE/wvxbEqGwHkNHe15SY8NaFU
        4YjBdlunF93DlhC8TiH2a5S7W+V3lffY5QRAqgRMug==
X-Google-Smtp-Source: ABdhPJz/F2ClHwtafa6xLEuPg9l+/kXpeoJsV5JsTUrGY4O9joyvBUwgfwdlADXdJ6e+4/Pu4gIfoDvt93N7qEgxWcw=
X-Received: by 2002:ac8:480b:: with SMTP id g11mr3751732qtq.290.1611837830913;
 Thu, 28 Jan 2021 04:43:50 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008d396205b9e4adee@google.com> <CACT4Y+ZisDCO0w9O57tOp+7FL6VqJiFdxaRJ739rjW5z52PeXg@mail.gmail.com>
 <20210127174322.GH4387@sirena.org.uk> <CAAeHK+yW_GCbKAdLEdQpFsjfBKy8_nkFKpBydg3icpb5rbA69g@mail.gmail.com>
 <bf5e0465-2935-a3a0-f003-de2b837dadf6@arm.com>
In-Reply-To: <bf5e0465-2935-a3a0-f003-de2b837dadf6@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Jan 2021 13:43:39 +0100
Message-ID: <CACT4Y+bwbHpp4H0UuEd41xfiPSBqrw7KUSKLAqR_fusP8hDHAw@mail.gmail.com>
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

On Thu, Jan 28, 2021 at 1:30 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 1/27/21 7:50 PM, Andrey Konovalov wrote:
> > On Wed, Jan 27, 2021 at 6:44 PM Mark Brown <broonie@kernel.org> wrote:
> >>
> >> On Wed, Jan 27, 2021 at 06:14:13PM +0100, Dmitry Vyukov wrote:
> >>> On Wed, Jan 27, 2021 at 5:58 PM syzbot
> >>> <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> syzbot found the following issue on:
> >>>>
> >>>> HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> >>>> git tree:       upstream
> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12eb4ad8d00000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=2a52b6c31dbefb1e9d9f
> >>>> userspace arch: arm64
> >>>>
> >>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>
> >>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>> Reported-by: syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com
> >>>
> >>> This happens on arm64 instance with MTE enabled.
> >>> I don't see any corresponding reports on x86_64. So I would assume
> >>> it's a generic latent bug, or probably more likely a bug in MTE
> >>> support.
> >>
> >> Copying in Vincenso who's done a bunch of MTE stuff recently.
> >
> > Could be the same issue as:
> >
> > https://lkml.org/lkml/2021/1/27/1109
> >
>
> I had a look at the trace and I agree with Andrey it seems the same issue.


#syz fix: Revert "mm/slub: fix a memory leak in sysfs_slab_add()"
