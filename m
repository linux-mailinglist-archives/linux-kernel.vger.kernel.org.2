Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FDC33B2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCOM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhCOM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:26:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36281C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:26:17 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f124so31355728qkj.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsGt/dwOV8D6F+fCE9EMCron0uUReKVhhqz5+NJRPXc=;
        b=OjqnRoV5lREN6AkRYyL3wtxE/OICaE0LY7v9GG+Jnhf23pxUciNPwTle5NOeU68II8
         /aeYla+smovrpH6q5NVVAWomfDjgrHQtvg3divL70X7qzGdLGvSXSw64hMNifBq6DObn
         J6Ph0Jv3KxPEMBbUG1drx4h+3EvGdod4RI/xaPGFz4jeEQOtnyEMRMmyD2is3h7/bpYB
         ngX2JXWeRP/j55yow1F2cflKD/YzI9BWTNmIIgW3dRFs5h3pS0nT4R2inpuBHgVmZRAJ
         TfUOy1Zg8o1LvXtqDROR8ZtKMS4Y69SOHlmIUntraau2wcWx4Dh2hsEhZOW1S2Pij/1N
         TuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsGt/dwOV8D6F+fCE9EMCron0uUReKVhhqz5+NJRPXc=;
        b=bmhqqRHE6xzaw385x4EKa1UVbM8b82mRgqDbhj9ICqPACpodjiwH7sxZz7YHvdrKcP
         qY5yAGbk7F5KZ9+FfIpE2lh3mdEQpM9X0ca91z7XFNIYJfSFis9qtEAylJTe4fp9+gjk
         vNePwwD9x0E3IGNWuSfZHtwAIpqVTiuJ6gBOD1J1sKc9KBL5w+QVoJ9z7LaT8wotXFoR
         1m4vqpg9yYe5w0bIrcYerBwSJSkINbXixWP6Z9ehZUZlkO+XGFHjdvmO51j9FR7Rwx8R
         OcTyepxVx0JMNKMBRjVBYF2Nk0Xu4GtYlWW+SQJKMaW/r47yeCR6ncUZA+wiFPT/Eowm
         zN/A==
X-Gm-Message-State: AOAM531h5qWtK0qSeCi9AbtFOfNyeUuoLQJNZ6BKPW9d48P9yBf1RZtp
        jEphwt7v1c5+LGr/y+Db4PW0p9btUK79OUYfd/eQlw==
X-Google-Smtp-Source: ABdhPJy8B+Q8m1FZs/7BgCVwNNRGjJlQrRHFP8Hq/jCV9z5Qtg/YSzefsAVyuVDnydxSiixQKKLRHBE+V4zZoBYFGQc=
X-Received: by 2002:a37:46cf:: with SMTP id t198mr24843358qka.265.1615811176122;
 Mon, 15 Mar 2021 05:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009c21de05ba6849e7@google.com> <CACT4Y+ZjVc+_fg+Ggx8zRWSGqzf4gmZcngBXLf_R4F-GKU4a9A@mail.gmail.com>
 <20210315120943.GB22897@arm.com>
In-Reply-To: <20210315120943.GB22897@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 13:26:04 +0100
Message-ID: <CACT4Y+Z0gir1LFtf_Xa2XHnu-ws8nk6Na9CtXFs71k+YLtw0xw@mail.gmail.com>
Subject: Re: kernel BUG in memory_bm_free
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     syzbot <syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 1:09 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Mar 15, 2021 at 08:08:06AM +0100, Dmitry Vyukov wrote:
> > On Wed, Feb 3, 2021 at 6:59 AM syzbot
> > <syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com> wrote:
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    3aaf0a27 Merge tag 'clang-format-for-linux-v5.11-rc7' of g..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17ef6108d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=10152c2ea16351e7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5ecbe63baca437585bd4
> > > userspace arch: arm64
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com
> >
> > The BUG is:
> > BUG_ON(!virt_addr_valid(addr));
> >
> > #syz fix: arm64: Do not pass tagged addresses to __is_lm_address()
>
> Does this mean that commit 91cb2c8b072e ("arm64: Do not pass tagged
> addresses to __is_lm_address()") fixes the regression? The patch was
> merged in -5.11-rc7 I think.

I hope so.
