Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BD541514F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhIVUXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbhIVUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:23:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83940C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:21:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m3so16992814lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+xhlLd4huTRJupVTgnduPJLYoAg28pRoAPZdUIDHYE=;
        b=KB4oJUW1zrMvaDw9J/F7wkiDHhTBjRs3+VPOv8q74he+/KK7vTzgQp9ym5f7epRhXJ
         e7fCj6TrmlzX40U5DT3gk4252HT9vjMH/PiV6TwTsi3sbJJ+mC5g1IxME1+AVhlAwyPO
         rDEF0KjrxrDuYv++ZlVCIwd6iolgz093Tk1vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+xhlLd4huTRJupVTgnduPJLYoAg28pRoAPZdUIDHYE=;
        b=7ULu3Q+rCsWmLjWukui10HxqWzxvEouCTxGU9Au3Dldo9dkfJ2I/g+ZFKWAZ3kCTRW
         lkZ7QJQvrukC3u7m7f9tNZFXfa4FMPb/pOJSB8P3A67O81qyCv4PSSGBOXsD5unKNNuS
         6C9GKZVZHBad65JhPyMHYXxAFiDGAT3KSApXIlTUxn2s7ZBFnvZskK8/y+AMme9mgy8k
         WJRlNfaP2KrxHFujxH+Lowgl0hgMctdsCJalV1YSji5RiRMUIQs3gV/ExvxdtfYMR/Qx
         ekOUmEwMsZ+zfUxNUSYH4HiEiJfg3a2A4GMPKSgrnnliiZXOPGpLvpLyp/Ur/cj36U5m
         qJIg==
X-Gm-Message-State: AOAM533zZTW5wfqeJPo0BZZERy+pzY6nRRqtTChYlwTlYPZeB0GEqGPN
        OtuhHD7mU5qGEVqbLxeMqGIIcl7GG0koavbKxs8=
X-Google-Smtp-Source: ABdhPJw7eX4THfW3GXyncrl9J2lUYPV40BlUF3sJ5evRLTGzKttRSLZobw0bQ/vtUJFYqovr1K8D7Q==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr1235374ljk.278.1632342099570;
        Wed, 22 Sep 2021 13:21:39 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r3sm257760lfc.114.2021.09.22.13.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 13:21:38 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y28so16768301lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:21:37 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr1340109ljh.68.1632342097278;
 Wed, 22 Sep 2021 13:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <YTu9HIu+wWWvZLxp@moria.home.lan> <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org> <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan> <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org> <YUtPvGm2RztJdSf1@moria.home.lan>
 <YUtZL0e2eBIQpLPE@casper.infradead.org> <A8B68BA5-E90E-4AFF-A14A-211BBC4CDECE@fb.com>
 <YUuJ4xHxG9dQadda@casper.infradead.org>
In-Reply-To: <YUuJ4xHxG9dQadda@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 13:21:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=vOmaE-BTHNjTTkw+vjx=P3Pa-TFPZngEOR-39fZhPg@mail.gmail.com>
Message-ID: <CAHk-=wh=vOmaE-BTHNjTTkw+vjx=P3Pa-TFPZngEOR-39fZhPg@mail.gmail.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:56 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> The continued silence from Linus is really driving me to despair.

No need to despair. The silence isn't some "deep" thing.

What  happened is literally that I wasn't 100% happy with the naming,
but didn't hate the patches, and still don't.

But when there is still active discussion about them during the merge
window, I'm just not going to merge them.

The silence literally is just due to that - not participating in the
discussion for the simple reason that I had no hugely strong opinions
on my side - but also simply because there is no way I'd merge this
for 5.15 simply exactly _because_ of this discussion.

Normally I get to clean up my inbox the week after the merge window,
but the -Werror things kept my attention for one extra week, and so my
mailbox has been a disaster area as a result. So only today does my
inbox start to look reasonable again after the merge window (not
because of the extra email during the merge window, but simply because
the merge window causes me to ignore non-pull emails, and then I need
to go back and check the other stuff afterwards).

So I'm not particularly unhappy with the patchset. I understand where
it is coming from, I have no huge technical disagreement with it
personally.

That said, I'm not hugely _enthused_ about the mm side of it either,
which is why I also wouldn't just override the discussion and say
"that's it, I'm merging it". I basically wanted to see if it led
somewhere.

I'm not convinced it led anywhere, but that didn't really change
things for me, except for the "yeah, I'm not merging something core
like this while it's under active discussion" part.

           Linus
