Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8D7405D66
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245645AbhIITjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbhIITjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:39:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3725BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 12:38:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p15so4773763ljn.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCQSRehR2ZOFo/zjKqjv0LY16gqxQWCKetw3T+VgWXE=;
        b=AliT6R74tIzwlYSKpVb0jpl+QAkq5TlMBBdZh/VSrASCQJ5jZSDBd+2VKAtFoAun9o
         INXNuZN30cPsf7inYtabYnvsYnM+4N+LDuUwHBxHM3jEk1kzU0ACPdcHWBnoQ8KgEx2y
         DAJ3UQGzsVpIbYzABfU4I7iyeRkKdC3yHuQzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCQSRehR2ZOFo/zjKqjv0LY16gqxQWCKetw3T+VgWXE=;
        b=qX08kk+Zsb+CcUtoe78GaDW9YboI0sDfYkIDN+o4K6fM0T/mBjlabh3h/SXQLpPUcq
         QJtJxNv3KkfmpH2MEbQM86JGM+Xn5u/DUTy7xCxloYBN5CD2smnuu0kEfBpenjrre8RL
         TUptQsYjpVRzg918vF8+3gNYYA3B0j0mXToEQ/1X6ka/YOmfPtvasP3AAvU3tC5Jwy8a
         q+HbNxdEonaF6UjhfQPBvyW+68f2U5dx8nThUtBrFhUAHas2Rg62Z2/ikaVuDbBaSNXX
         XKKthlbdJycRCQxA2DhlvJXyuerzVkGR423lvczwFME231oIScLIQNGMDursOOHQxWDE
         gPrA==
X-Gm-Message-State: AOAM530dTRLpJ5BQnElMoGrDpOvXGMAvbdLxaPsGxlbOG2FpWpkiEsAK
        TneB+wMZn6M3U6nxpoUhPYXbuC1GTKgqrO/RJb0=
X-Google-Smtp-Source: ABdhPJxLVYjijHIICdLXgSUlEQkgS+7d2TyGMsNnVRc5CfpliF8CcIXv+albmoIYd/s1a/6VrFBtew==
X-Received: by 2002:a2e:351a:: with SMTP id z26mr1145078ljz.59.1631216290993;
        Thu, 09 Sep 2021 12:38:10 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c17sm289321lfb.257.2021.09.09.12.38.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 12:38:10 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id a4so5843310lfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:38:10 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr1059425lfr.173.1631216289838;
 Thu, 09 Sep 2021 12:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
In-Reply-To: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 12:37:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
Message-ID: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 9:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Fixes for io-uring handling of iov_iter reexpands

Ugh.

I have pulled this, because I understand what it does and I agree it
fixes a bug, but it really feels very very hacky and wrong to me.

It really smells like io-uring is doing a "iov_iter_revert()" using a
number that it pulls incorrectly out of its arse.

So when io-uring does that

                iov_iter_revert(iter, io_size - iov_iter_count(iter));

what it *really* wants to do is just basically "iov_iter_reset(iter)".

And that's basically what that addition of that "iov_iter_reexpand()"
tries to effectively do.

Wouldn't it be better to have a function that does exactly that?

Alternatively (and I'm cc'ing Jens) is is not possible for the
io-uring code to know how many bytes it *actually* used, rather than
saying that "ok, the iter originally had X bytes, now it has Y bytes,
so it must have used X-Y bytes" which was actively wrong for the case
where something ended up truncating the IO for some reason.

Because I note that io-uring does that

        /* may have left rw->iter inconsistent on -EIOCBQUEUED */
        iov_iter_revert(&rw->iter, req->result - iov_iter_count(&rw->iter));

in io_resubmit_prep() too, and that you guys missed that it's the
exact same issue, and needs that exact same iov_iter_reexpand().

That "req->result" is once again the *original* length, and the above
code once again mis-handles the case of "oh, the iov got truncated
because of some IO limit".

So I've pulled this, but I think it is

 (a) ugly nasty

 (b) incomplete and misses a case

and needs more thought. At the VERY least it needs that
iov_iter_reexpand() in io_resubmit_prep() too, I think.

I'd like the comments expanded too. In particular that

                /* some cases will consume bytes even on error returns */

really should expand on the "some cases" thing, and why such an error
isn't fatal buye should be retried asynchronously blindly like this?

Because I think _that_ is part of the fundamental issue here - the
io_uring code tries to just blindly re-submit the whole thing, and it
does it very badly and actually incorrectly.

Or am I missing something?

           Linus
