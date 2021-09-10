Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2A406FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhIJQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhIJQqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:46:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170CFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:45:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l10so5278044lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbDem+vz4vsFCSw7QFewQOYLmpPGceE2lX9++EL1i90=;
        b=cMoTMio4moJQpik9wWZWR2NxvpgiGXWe+ZMgp+cO9faXBY6cl3zqdZMOlk6kovQvMS
         JK7NBi4ZMmYzR4zvSFwSPag1UnPpVOdaFCqwVoaqknabSfwAd3/bZYuZp/LGhHJdyqPq
         ebouPDJ1usgUAH0Wij5KeTTwzsTz8iLyGlXD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbDem+vz4vsFCSw7QFewQOYLmpPGceE2lX9++EL1i90=;
        b=hPbBl1hby9NV1aqgfWmCPTo7P7AAI3niVwO0oVMTu49Kl7JrshU4T9rB2TYbAlt7fQ
         wARRTRsTWzm8GO3SmhdtUMWKoFRG6RKYvV4gydfYgoRxDL6oeT4gCHjWjIpD4F0akbdY
         sMHOvS2vBLo4tYGcE/SUKD9y9CKgaO5zbfK29kQTJzQ8mdqy1tYauyhyygFmRxSRA3Xm
         iIuCLjzaaa/u0wIlw/ojD9oS+xmgUEvT6Y1Da1udUUaYBiF/cDEErvtipgPElk6felq5
         6fBMzhMaBkb4BfelLt3lqrdxm7xOKWCzoIvKEEtVVTua8MiyiiwaC7G2Y+0GFHgn9LWd
         Ecrg==
X-Gm-Message-State: AOAM533lM+yjNIz7t4VhuJsPH/GU488IkqaTPeA9BiaGhh04n01MZL2/
        118dfBaCblcUPQ2hWY6/edWNPsed3TXEtjy2f9o=
X-Google-Smtp-Source: ABdhPJyaFrLb3ZoYVLt61eHdmJRtbW7Vmu9k8Qnufn8epQ+HBWx+HwLnnqqIWxoG/Q7rM1B8PMxpLA==
X-Received: by 2002:ac2:5f99:: with SMTP id r25mr4666672lfe.119.1631292299782;
        Fri, 10 Sep 2021 09:44:59 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id g2sm598854lfu.139.2021.09.10.09.44.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:44:58 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h16so5246857lfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:44:58 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr4638854lfv.655.1631292298401;
 Fri, 10 Sep 2021 09:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk> <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk> <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk> <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk> <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk> <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk> <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
 <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
In-Reply-To: <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Sep 2021 09:44:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9Oknen3Wd2_C+9PogvbsjTD1-knK7FVjPK7gyBRmo_Q@mail.gmail.com>
Message-ID: <CAHk-=wi9Oknen3Wd2_C+9PogvbsjTD1-knK7FVjPK7gyBRmo_Q@mail.gmail.com>
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

On Fri, Sep 10, 2021 at 9:06 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> +static void io_iter_restore(struct iov_iter *iter, struct iov_iter_state *state,
> +                           ssize_t did_bytes)
> +{
> +       iov_iter_restore_state(iter, state);
> +       if (did_bytes > 0)
> +               iov_iter_advance(iter, did_bytes);
> +}

This approach looks conceptually good to me.

Just name it "iov_iter_restore()", and (together with the actual
iov_iter_restore_state() - I don't think it makes much sense to inline
something like this that is by definition for the slow path when
something failed) move it to lib/iov_iter.c

If this allows us to remove the 'truncated' field from the iov_iter, I
think it's a win overall.

That said, I think your actual implementation of
iov_iter_restore_state() is buggy. It's not just those state bits you
need to restore, you do need to do all the "back out the i->iov/bvec
pointers" games too. All the stuff that iov_iter_revert() does.

Which means that I think your tricks to try to share the 'struct
iov_iter_state' with the 'struct iov_iter' using unions are just ugly
and pointless and make for more complex code. Because you can't just
save/restore the 'state part' of it all, you do have to do more than
that.

So instead of the union, just have the state in some sane (different)
form, and do the revert/advance thing taking different types of
iterators into account. This is not supposed to be
performance-critical code.

Alternatively, you'd need to make the state part be *both* the unions,
and restore the pointers that don't need restoring too. You end up
with pretty much all of iov_iter.

Al, what do you think?

               Linus
