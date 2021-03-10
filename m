Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E2334706
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhCJSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhCJSny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:43:54 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC22EC061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:43:53 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h4so26952220ljl.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vM8NHkCKbLRErp+CLsLgIaN6Ah0sE04uwPW1iIQb3RQ=;
        b=LhHMVyE9AxYhSGJEFd4XxwBbmy35wlBI/mM/atTza9Ur7/XCAkFEXBMvb1Z4xsjyGg
         9B7d31RNquKNpI6EorukgOrKK0VGqJQCD2JeMCiLB33vJjzAYFb0bVCNwPuckqStWaoY
         RUUOQEWgTeszGaFAV0VmO9cpXrj/rJOCagzfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vM8NHkCKbLRErp+CLsLgIaN6Ah0sE04uwPW1iIQb3RQ=;
        b=C0ZokAniCZbb/OA9ySLVeTo0uqYXF9HjrSMEMbADBxWmx6tE79/qeJnm2jroje/C0g
         ph4Bl8egXqJG+ZTDtpcLucREhDdH+Bt82ZzrOaqBSXo9DeGzFiq+gmSoHK5YgS3cKbxV
         +nd+Sf1tJCUuio2rBSyeaC18NjBCE194k9Ydlcy6Yx+q+SBfKNM7/6XbYXkBVXncQs07
         pnm48myIu16NPqrYB2OrHZ0wtvY+ClkAtmnSn78kUtQ36gWb9mRh3R2VEjoCIq1Wyr8O
         ERE7Y6Q2Nmc3nW+TxvSi+L6F008GpzrhVBE/msHGb8zauc3HM2JRU/69ZzhEdJns/6qK
         CjXw==
X-Gm-Message-State: AOAM533fl7sl3FKhvzh/EhwJEFqqosqvPKFp6zCK7/pZl6lsw7D7srxf
        o89HNFI22uzxPURX4aufUrWCl6ZSmfyTCQ==
X-Google-Smtp-Source: ABdhPJzoMZPRovMWDNilTFSBSTET5xA0ttyqFvty0I1vbJ+YeR8xxulXtVBJmDfkTRIcUGsZ3tmBtw==
X-Received: by 2002:a2e:300d:: with SMTP id w13mr2661005ljw.199.1615401831537;
        Wed, 10 Mar 2021 10:43:51 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id z10sm35742lfe.114.2021.03.10.10.43.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 10:43:50 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id t9so26913757ljt.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:43:49 -0800 (PST)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr2546489ljp.507.1615401829544;
 Wed, 10 Mar 2021 10:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20210122135735.176469491@linuxfoundation.org> <20210122135736.291270624@linuxfoundation.org>
In-Reply-To: <20210122135736.291270624@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Mar 2021 10:43:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiAafgm4fu-+NNfd5MA_0v7o5Spma-KH82eyJzY_q8-9A@mail.gmail.com>
Message-ID: <CAHk-=wiAafgm4fu-+NNfd5MA_0v7o5Spma-KH82eyJzY_q8-9A@mail.gmail.com>
Subject: Re: [PATCH 4.14 27/50] mm, slub: consider rest of partial list if
 acquire_slab() fails
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a note to the stable tree: this commit has been reverted
upstream, because it causes a huge performance drop (admittedly on a
load and setup that may not be all that relevant to most people).

It was applied to 4.4, 4.9 and 4.12, because the commit it was marked
as "fixing" is from 2012, but it turns out that the early exit from
the loop in that commit was very much intentional, and very much shows
up on scalability benchmarks.

I don't think this is likely to be a big deal for the stable kernels -
we're basically talking tuning for special cases, and while it is
reverted in my tree now, the "correct" thing to do is likely to be a
bit more flexible than either "exit loop immediately" or "loop for as
long as we have contention".

In practice, most machines probably won't see either case - or it will
at least be rare enough that you can't tell.

The machine that reports a huge performance drop was a multi-socket
machine under fairly extreme conditions, and these contention issues
are often close to exponential - a smaller machine (or a slighly less
extreme load) would never see the issue at all either way.

See

    https://lore.kernel.org/lkml/20210301080404.GF12822@xsang-OptiPlex-9020/

for details if you care. I don't think this has to necessarily be
undone in the stable trees, this email is more of an incidental note
just as a heads-up.

                Linus

On Fri, Jan 22, 2021 at 6:14 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Jann Horn <jannh@google.com>
>
> commit 8ff60eb052eeba95cfb3efe16b08c9199f8121cf upstream.
>
> acquire_slab() fails if there is contention on the freelist of the page [..]
