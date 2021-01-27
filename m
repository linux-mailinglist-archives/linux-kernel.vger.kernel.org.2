Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E908D306478
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhA0Tvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhA0TvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:51:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D33C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:50:22 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q131so1890642pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9U/E4NAOZN1zGDJN6ajr3v7PnsrIwJRfTojEiXgDFE=;
        b=SQcnEZz3e5KTzenB+u2Yw7jys4kDRMmrkJkmIajdVCFcMDZKtQ994n+cLvV77fnkXa
         7f7j4qD2ZLp/L5GB7HbBg6SSfbT6botBfxUjzikDsHTxc9fS8G35rTfFbIRFBoohtlhn
         NXA2WpS7tLdCP/wtitm+LzVd1McGKUwDvYtwhd8GQ3tKA6ZvtAymK710GYAMJcsRHlJh
         2rRfRMyuT0ia5m1N3I4gFXC1qHPR1jdVgMnE6sgCocWMUmVU0lZaGB/ud9XPOzlIKRp+
         Qiu4qNxMvL8E0aZCbQ3yv5EEHow1s7RIuVb6oBxcMMfJ47pWMz5Y5xVh2yQ4YOcnk4AY
         gLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9U/E4NAOZN1zGDJN6ajr3v7PnsrIwJRfTojEiXgDFE=;
        b=qCxGS/eBU0cBFrWzZgbIv4Z/+kxfAbSEIImEh0QTfZoWXjR0vRxrT4kaRKy5RmF+hr
         kRqohWFDn4w1/zNZn+SPbo/hxs5deewOtnPETGiEKKNdK41DNaWqsGl6NWTQd0TYmQi2
         szouHouqr877bIgWyIHWhGx4WEwzZXzlaOaipAtzB87XNFP157vtU6iugPvIHz+jKeoo
         hcoq8e+yREPqeLsETiDwMCZXg8AnG1BplxAiSN39dLCLMHckZr/t6z4eqCEm8P9k/FLY
         HOEdR3lb8RQY9ea1S1GbU6QtR82qmQSbgSVSJkN2C7b+hJ6BLpbUekmtI9nptOpC96vc
         jhaw==
X-Gm-Message-State: AOAM532K2zMOqd3O7NxL/ydxOekPAdUhDiAcfV4tYR+MmtZA5iPzGny/
        tIFhsMV9c/Q5Ag5cEnpqDL3AnixB1OX8hHMpuoKvhw==
X-Google-Smtp-Source: ABdhPJxoE+wlvrWbJYlFeq+4g3omfEZVNtzrO3gbHcVhRi7GB60xkbsLiTAU6alGBMHRu5EOpVEpHdaSE8VSYx81i7s=
X-Received: by 2002:a65:430b:: with SMTP id j11mr12450545pgq.130.1611777021720;
 Wed, 27 Jan 2021 11:50:21 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008d396205b9e4adee@google.com> <CACT4Y+ZisDCO0w9O57tOp+7FL6VqJiFdxaRJ739rjW5z52PeXg@mail.gmail.com>
 <20210127174322.GH4387@sirena.org.uk>
In-Reply-To: <20210127174322.GH4387@sirena.org.uk>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 27 Jan 2021 20:50:10 +0100
Message-ID: <CAAeHK+yW_GCbKAdLEdQpFsjfBKy8_nkFKpBydg3icpb5rbA69g@mail.gmail.com>
Subject: Re: KASAN: invalid-access Read in kmem_cache_destroy
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, mbenes@suse.cz,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 6:44 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jan 27, 2021 at 06:14:13PM +0100, Dmitry Vyukov wrote:
> > On Wed, Jan 27, 2021 at 5:58 PM syzbot
> > <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12eb4ad8d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2a52b6c31dbefb1e9d9f
> > > userspace arch: arm64
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com
> >
> > This happens on arm64 instance with MTE enabled.
> > I don't see any corresponding reports on x86_64. So I would assume
> > it's a generic latent bug, or probably more likely a bug in MTE
> > support.
>
> Copying in Vincenso who's done a bunch of MTE stuff recently.

Could be the same issue as:

https://lkml.org/lkml/2021/1/27/1109
