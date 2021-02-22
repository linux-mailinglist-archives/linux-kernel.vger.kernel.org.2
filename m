Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C6322203
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBVWPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhBVWPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:15:02 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB4C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:14:20 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id f33so357447otf.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=cna4YEE1gjo9sVywPKLpSJKhz+4g3nS9XRzAOLzaiKA=;
        b=q/cJ6fkb6WBfIj3i7CHLjD+2hiIFD/MR/53gmRXhip4yQnQRib09V4lthrwxh0xcw8
         hwpTfXs8E0eVq+to/Y7HNU+DSggnPNx2QuIGf8l4o827rrDXG3eOLRBKPPTY2MfnC6Ls
         dSXogSjzGyWwUhSz5jMo/n0UMUWqItS0zvXG4UUq92HyFLh4x05IIMeK8YDcSksuNVxS
         gq+B07BqvUrIbLawLvietlP5G2mzjVEkJ1t5t1R3DO03fxRqAy7EosfZISty1Phk3ts8
         6UYBaO5EepHwZiBDcVshP0xA7ZX0BnYWxjqPAOjhYVgRyPVJc9mwxV0+Szgfmpwlg8rl
         Dl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=cna4YEE1gjo9sVywPKLpSJKhz+4g3nS9XRzAOLzaiKA=;
        b=AdyRGBumnlYOollNLCE+elJyRpdXrteoDMrcM10RFMhdPM7Wa5wkXx6i44/wU9wW4z
         hYDPeWJ/PaMWXcDpptD3YNbZuS8dFwUk2XpAZ1qAvtpfLGsk2VayjjP0ufBIZ5y7wVbV
         jGM3aM/uQnLpUwBDwdH50AJ7//eAJNCsv0mGK1CSpuJh2EOpdBO4jPXzJHE8LuJA3ZYL
         SFZMPq1kd0Wn7FegnvC+ICd//0ooqR60B9krGXW3CXYICcVJFwI2X2A1FiyCghUqfvg4
         t2LmdeVgPrPJQASrKTz+GVicAjDNPb201jIO1vnJf6F9wi6i6oSdF605EpUsQkMvpNdJ
         FNxw==
X-Gm-Message-State: AOAM532vItU9AJonmoF3vsESQsYYRDucfbUbaR/TDeU5rgo4K7P2sntx
        Cruqfg4cc7MBXxMSGf9mXz77dw==
X-Google-Smtp-Source: ABdhPJwPTsXUG6KEsxydd/rUi5Vct+HpBOrLvzLDA9cDvVaFppI5mFSlIakwJaJ2zrmAkg8cr7HjYA==
X-Received: by 2002:a9d:7403:: with SMTP id n3mr19409436otk.122.1614032059667;
        Mon, 22 Feb 2021 14:14:19 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z8sm3718117oon.10.2021.02.22.14.14.18
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 22 Feb 2021 14:14:19 -0800 (PST)
Date:   Mon, 22 Feb 2021 14:14:07 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jens Axboe <axboe@kernel.dk>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] percpu_counter: increase batch count
In-Reply-To: <5eea419a-e0b5-2652-3f35-5042d7925e23@kernel.dk>
Message-ID: <alpine.LSU.2.11.2102221405130.4959@eggly.anvils>
References: <0bf90e07-8758-b238-b3f3-a330725a1134@kernel.dk> <20210218151644.df430e4f77f763b7db2a004f@linux-foundation.org> <919b3aa5-7332-0817-3b70-4f20ae6410a8@kernel.dk> <alpine.LSU.2.11.2102221309570.4728@eggly.anvils>
 <5eea419a-e0b5-2652-3f35-5042d7925e23@kernel.dk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021, Jens Axboe wrote:
> On 2/22/21 2:31 PM, Hugh Dickins wrote:
> > On Thu, 18 Feb 2021, Jens Axboe wrote:
> >> On 2/18/21 4:16 PM, Andrew Morton wrote:
> >>> On Thu, 18 Feb 2021 14:36:31 -0700 Jens Axboe <axboe@kernel.dk> wrote:
> >>>
> >>>> Currently we cap the batch count at max(32, 2*nr_online_cpus), which these
> >>>> days is kind of silly as systems have gotten much bigger than in 2009 when
> >>>> this heuristic was introduced.
> >>>>
> >>>> Bump it to capping it at 256 instead. This has a noticeable improvement
> >>>> for certain io_uring workloads, as io_uring tracks per-task inflight count
> >>>> using percpu counters.
> > 
> > I want to quibble with the word "capping" here, it's misleading -
> > but I'm sorry I cannot think of the right word.
> 
> Agree, it's not the best wording. And if you can't think of a better
> one, then I'm at a loss too :-)
> 
> > The macro is max() not min(): you're making an improvement for
> > certain io_uring workloads on machines with 1 to 15 cpus, right?
> > Does "bigger than in 2009" apply to those?
> 
> Right, that actually had me confused. The box in question has 64 threads,
> so my effective count was 128, or 256 with the patch.

Ah, yes, so there I *was* confused in saying "1 to 15",
the improvement was for "1 to 127" of course - thanks.

> 
> > Though, io_uring could as well use percpu_counter_add_batch() instead?
> 
> That might be a simpler/better choice!
> 
> > (Yeah, this has nothing to do with me really, but I was looking at
> > percpu_counter_compare() just now, for tmpfs reasons, so took more
> > interest.  Not objecting to a change, but the wording leaves me
> > wondering if the patch does what you think - or, not for the
> > first time, I'm confused.)
> 
> I don't think you're confused, and honestly I think using the batch
> version instead would likely improve our situation without potentially
> changing behavior for everyone else. So it's likely the right way to go.

You're too polite! But yes, if percpu_counter_add_batch() suits, great.

> 
> Thanks Hugh!
> 
> -- 
> Jens Axboe
