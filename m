Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395B43E1F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHEXJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhHEXJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:09:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE9CC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 16:09:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u3so12224996ejz.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZmonuIQTdAhHxcAtdvOowXsqN794Bg05ztX26jKcCI=;
        b=MKvCiDNEpYyA4lQihlVosLUnqVak2vs0tLKXVyxnBboi3U7GyHBcTHEb5bvLR2zNE+
         9teQVbu+Gpa58mDlhnrgRhg74OmHrgAb5Q7tmQGbAbCj7qSiTzJplS5QV43tQNpbYdzE
         F3RNSgwuUS1PkiYoLLUOm7xsXoOzjEm1FDq9+7MQaIknb55h0TVq5/mLGDp3ddtLV2s2
         +zxWBkh76E6cJkuwqM9FdcJ05M9DF0pV4esUi2lKQNMPS53ap/WY6zQ4p7NAURFBXwmp
         tnZkB/aYUOBdxoiv+0SI0Epbv5h8iJ9G+p8NRMDsUdzkpp63PWspG83ongRFiVhOKSmI
         7Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZmonuIQTdAhHxcAtdvOowXsqN794Bg05ztX26jKcCI=;
        b=iF0vQG2VYBwS+YJwL2rX19RsHuKO/4kMWXH8RCXuFzHi3+S1BZM/5N8gavZR5POI1C
         0dQ/HS1tBBeXiOiEMO/CXNKEJdNiXaOQnwFCfQzjJs83lY1VbW3FJnpDTYSrBP1UZFVm
         ZgrggYhKxYE30wX0hpFjwOF3dZavVxOoq8y8S3nHELz79BLW0GuiGZPn60tkV13vTOza
         HiSk6O5KyXkyAi5Z4G6DPMrveggE4/5AFxegXvaN1GfxTOhuLoauWGkgaRac2LlGr/TD
         2+hOacrOBrdzS8XNqY2W2yHAC6iH6sYq2tyvlc+FMl4iRyzyohZ2NIHvxfi6a2YAXoml
         LUeg==
X-Gm-Message-State: AOAM532d0E6ya6P6kHMyO7Y6tO9m7fusi1fscoS755S+guzw8dQsbHzX
        khZPqy7QZuWvUEd0n2uljf16mUALLcAY2jvbb1I=
X-Google-Smtp-Source: ABdhPJyjQztuhZDt0Xu6FsiLlbU88gNeqS21nu7PtVgMZznVyJDeW7AVSHD3uCsA20GU63KCUfpAKbQEiRsNhBt2bDg=
X-Received: by 2002:a17:906:c182:: with SMTP id g2mr6982687ejz.507.1628204948269;
 Thu, 05 Aug 2021 16:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
 <YPs6cQo7iG1JcOn8@casper.infradead.org> <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YQkwBdpWTPjv4xIx@casper.infradead.org> <704d597-443b-32f-84eb-524a58dd8ef@google.com>
In-Reply-To: <704d597-443b-32f-84eb-524a58dd8ef@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 5 Aug 2021 16:08:56 -0700
Message-ID: <CAHbLzkrShKORwU-Zrf5_5c6_o_iVwoXRTT+7ABZALLj7p0w-Ug@mail.gmail.com>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 10:34 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 3 Aug 2021, Matthew Wilcox wrote:
> > On Tue, Aug 03, 2021 at 04:14:38PM +0800, Huang, Ying wrote:
> > > Matthew Wilcox <willy@infradead.org> writes:
> > > > But I REALLY REALLY REALLY want a reproducer.  Right now, I have a hard
> > > > time believing this, or any of the other races can really happen.
> > >
> > > I think the race is only theoretical too.  Firstly, swapoff is a rare
> > > operations in practice; secondly, the race window is really small.
> >
> > So do something to provoke it.  Widen the window.  Put an msleep(1000)
> > between *pagep = NULL and the call to get_swap_device().  That's assuming
> > that the swapon/swapoff loop that I proposed doesn't work.  Did you
> > try it?
>
> I've been doing that swapon/swapoff loop for years, while running kernel
> builds on tmpfs going out to swap; for better or worse on baremetal not VM.
>
> You're right that few will ever need that level of reliability; but it
> has caught problems from time to time, and I do insist on fixing them.
>
> I'm not as insistent as you on wanting a reproducer; and we all take pride
> sometimes in fixing ever more inconceivable bugs.  I'm not against that,
> but it's easy to end up with a fix more dangerous than what it claims to
> fix, rather like with random newbie cleanups.
>
> I've never seen the swapoff race claimed by Miaohe, and don't expect to;
> but he's probably right, given the current code.  I just dislike adding
> unnecessary complexity, and siting it in the wrong place (mm/shmem.c).
>
> Yang, is it possible that 5.1 commit 8fd2e0b505d1 ("mm: swap: check if
> swap backing device is congested or not") was actually developed and
> measured on 4.1 or earlier, which still had blk_set_queue_congested()?

I forgot the exact version, but definitely not 4.1 or earlier. Maybe
4.19 or earlier. I'm not familiar with how block layer detect
congestion, if the logic was changed, hence the optimization doesn't
stand anymore nowadays, I'm totally fine to remove it.

>
> I cannot explain its usefulness nowadays, on congested HDD anyway:
> Matthew is right that NFS and a few others may still be setting
> congested flags, but they're not what that commit was proposed for.
>
> If it is still useful, then I contend (but Huang Ying will disagree)
> that the get_swap_device() and put_swap_device() should be around
> 8fd2e0b505d1's inode_read_congested() block in swap_cluster_readahead(),
> not encroaching into mm/shmem.c.
>
> But if that block is not useful, then it should simply be removed (later).
>
> Hugh
