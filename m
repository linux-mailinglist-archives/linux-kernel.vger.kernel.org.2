Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E91405FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347368AbhIIW5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345555AbhIIW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:57:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60068C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 15:56:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k13so89008lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ll2Nb/Rh/ET0+TwBLh//OAz8IKVSbYfnVralJR9y3lM=;
        b=MpZ1iF5kar3l4a5y2mq2lqPtsdQPViAY3yWrwP/QzgdtY6s/WnqVnIzYHuSwD66wNC
         kHs7IY4W9QQOe/FksrYH3pb4iovsSXAtL/+f/em1Cp4ckLWKJIePPXYTTlr0EXBht6j3
         YypuFDhDstbDWBUlmtVXCeyptUBLnP5YqTNAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ll2Nb/Rh/ET0+TwBLh//OAz8IKVSbYfnVralJR9y3lM=;
        b=ODHqozQycI40tViTG1OuzHWRSt+99T+IN6WDE0maMMJ9wA5BpPPgPV60hKpe0YR3Bd
         e8lijcqhsI+pXZ7K0zXe/2GncTTa1SjKGu3KLky5gzJUQjpXIZJGvvWbkli1VrMeXDpM
         l8JcPapRno4YaTzsbRceCQUs12K2yBWHi5NaiixiiPNu4XBisTKyBgAag6+vTKLv6IGr
         nTY0OgZeW35E5VWADrGTOtWWpfYKrdGqYqqrZZXAUjYEofyB+68F5dlBAAOu0zcf6q5a
         vW8lcznqxEfcAgl0V1K/9J1cQKh/QI8iQTMgYrd1MTw7FwgDKEJpPcBtH1Z9tHA5ib0f
         ELHQ==
X-Gm-Message-State: AOAM5317SHAIEjXvTA3zreQGIkbMalR1TKBWmErK+BCLCz8ceISiP0pm
        cu6BN8W4/kMpbAvViDqQuxoi5H9SOOEMx14bRlg=
X-Google-Smtp-Source: ABdhPJyR3518o97nBDFLFsWeHHEqDJSaMPNPrKUl8YApeMiiMDkUTNXKN6URRwKGwk6Ogq2Gi+U3zg==
X-Received: by 2002:a05:6512:239f:: with SMTP id c31mr1612705lfv.55.1631228186243;
        Thu, 09 Sep 2021 15:56:26 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 16sm336692lfr.303.2021.09.09.15.56.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:56:25 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id bq5so42463lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 15:56:25 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr1591482lfg.402.1631228185421;
 Thu, 09 Sep 2021 15:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk> <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk> <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com> <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
In-Reply-To: <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 15:56:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
Message-ID: <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 3:21 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/9/21 3:56 PM, Linus Torvalds wrote:
> >
> > IOW, can't we have  that
> >
> >         ret = io_iter_do_read(req, iter);
> >
> > return partial success - and if XFS does that "update iovec on
> > failure", I could easily see that same code - or something else -
> > having done the exact same thing.
> >
> > Put another way: if the iovec isn't guaranteed to be coherent when an
> > actual error occurs, then why would it be guaranteed to be coherent
> > with a partial success value?
> >
> > Because in most cases - I'd argue pretty much all - those "partial
> > success" cases are *exactly* the same as the error cases, it's just
> > that we had a loop and one or more iterations succeeded before it hit
> > the error case.
>
> Right, which is why the reset would be nice, but reexpand + revert at
> least works and accomplishes the same even if it doesn't look as pretty.

You miss my point.

The partial success case seems to do the wrong thing.

Or am I misreading things? Lookie here, in io_read():

        ret = io_iter_do_read(req, iter);

let's say that something succeeds partially, does X bytes, and returns
a positive X.

The if-statements following it then do not trigger:

        if (ret == -EAGAIN || (req->flags & REQ_F_REISSUE)) {
  .. not this case ..
        } else if (ret == -EIOCBQUEUED) {
  .. nor this ..
        } else if (ret <= 0 || ret == io_size || !force_nonblock ||
                   (req->flags & REQ_F_NOWAIT) || !(req->flags & REQ_F_ISREG)) {
  .. nor this ..
        }

so nothing has been done to the iovec at all.

Then it does

        ret2 = io_setup_async_rw(req, iovec, inline_vecs, iter, true);

using that iovec that has *not* been reset, even though it really
should have been reset to "X bytes read".

See what I'm trying to say?

                Linus
