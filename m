Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75A3F532B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhHWWHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhHWWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:07:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD7C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:06:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so41081351lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNzxccHrLNvgtuARmJVk/6D6HUeCLBrBp9BAleU49Ss=;
        b=dwy8paMHkqyjLg1te3lCxkkLE6jDyUtbeifszfiKDvo9BBrM7XLb+10zYHDlIQZ6Gp
         s56jjZ/xv3KJAQ4Nz4+dvXUgTAQZmD21ubLfgu/r5vkDTVl0L1aNZ20sdEQO/9nYBeOg
         2kehgthnitJpNSRy4IWcnjmoAiUzkkD/n4/q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNzxccHrLNvgtuARmJVk/6D6HUeCLBrBp9BAleU49Ss=;
        b=UNXSnwHdTLJE8k8C5Xae4uafsG+EtdWdDcFLS434AdO5pF+IReT8enrPzAzJcsd1C8
         WYoAxEcfSJx943zFj794RakkGNCNxttXtEyOXVCmHDlo7OLXYf+ADNL4V30SV9OMyb7Q
         ktDTxFXFT3cKbJ+VUzyc8DxVaZLRTp9CNJoGfw7eVW08d4TjUGtBdcuYgb3Bd+FzdEkz
         l4B0uyINimS9yy8WiJy9xi3OnKJ9IfU+VSqsEJrlNPwq5KLXo9wGtjlrHLMBu7Z3uPXD
         CzpD5+LEjJ3HjYCfz7EN/4Xvi6swsYXW4/Q+zcVnzGjt2IC5fi4qmGKpWOYicmWPCpRx
         zyZg==
X-Gm-Message-State: AOAM530/6UonasHjRDm7OfHfLPdDVrNOqX9fbF5jVFic3l5QBmLMwrxw
        0c64tME4n95qxHl86lw9XU1BNVY8qu0siCuZ
X-Google-Smtp-Source: ABdhPJzu9Uucu+9bGNpZTd9YuLb/QNnsrjlBCkLCdSeLR3BOysRDRpL5hQCGqrRJ9br/MFym7Bcppg==
X-Received: by 2002:a05:6512:3905:: with SMTP id a5mr1369958lfu.354.1629756385156;
        Mon, 23 Aug 2021 15:06:25 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id l28sm539215lfj.202.2021.08.23.15.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 15:06:25 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q21so34036367ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:06:24 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr29180236ljc.251.1629756384152;
 Mon, 23 Aug 2021 15:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
In-Reply-To: <YSQSkSOWtJCE4g8p@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Aug 2021 15:06:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
Message-ID: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 2:25 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> One one hand, the ambition appears to substitute folio for everything
> that could be a base page or a compound page even inside core MM
> code. Since there are very few places in the MM code that expressly
> deal with tail pages in the first place, this amounts to a conversion
> of most MM code - including the LRU management, reclaim, rmap,
> migrate, swap, page fault code etc. - away from "the page".

Yeah, honestly, I would have preferred to see this done the exact
reverse way: make the rule be that "struct page" is always a head
page, and anything that isn't a head page would be called something
else.

Because, as you say, head pages are the norm. And "folio" may be a
clever term, but it's not very natural. Certainly not at all as
intuitive or common as "page" as a name in the industry.

That said, I see why Willy did it the way he did - it was easier to do
it incrementally the way he did. But I do think it ends up with an end
result that is kind of topsy turvy where the common "this is the core
allocation" being called that odd "folio" thing, and then the simpler
"page" name is for things that almost nobody should even care about.

I'd have personally preferred to call the head page just a "page", and
other pages "subpage" or something like that. I think that would be
much more intuitive than "folio/page".

                  Linus
