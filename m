Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED839EA37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFGXiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhFGXiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:38:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C367C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 16:36:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z22so8528068ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bj+3pmdBLjat38YzGIwe/LbSm4GNIavhFcUTV5mhCVk=;
        b=Sbo5NkDjodBKpzQgpBDWnnVyo+sOZY4L/bffARKmA/haCwh+jHPisbJEH8wkyItgYD
         q20QmGC4mQZeg0O7HcHaRDzioKDHpaLLl/EA2ocn26ly6NkvA5Xtd+KpbnCRwrd+1ydU
         E0OLAkEREa+xQUjv3yGnFZMGWR69WZVuXaWBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bj+3pmdBLjat38YzGIwe/LbSm4GNIavhFcUTV5mhCVk=;
        b=hOCK4iAifdZLajugxXyGFo2Ue6Nvs5ypC0Vs+wLq0a59J6u7kpXxEixrF4vWEuKAE2
         iBkgVcIf7b950QOo0cc/cidfpcfOpYVWivB01ZarwdD8vvRGILMwRRxWWCmz3c7F3/l6
         HYvv0B7aemIIwkugnqwzzj7TpGXP80+S3HzS0B5Wzx8yuo6tgdoClk419tgTq1bdpys2
         NysyxGowENjSlUWsU2klGjf5kn/xvSmLmr4OZncwXrHxfZnJr645JFHH3ZN2mNJj4ZkV
         CPjnNVlZ6I3Jx8J3c0DREhHPu4LLRH46UrLd8TyQPgNP3aAsBdmwbOwGEANKxBXyII5J
         rd7g==
X-Gm-Message-State: AOAM532p971V7qCq2eC+D+2+xhM43FmDvGGbNkRenu8F3BAuyhlpK3NX
        IorxjuG48MiuuVrLFTq++V1gu7IbrylPzNU+HJA=
X-Google-Smtp-Source: ABdhPJwA7IF48Ogu2XaRNYB3R9sHuofhHO9ciGGL5cgGeB3ZXWMxTn5UJqN9iLUwZiV7Kc4LPMalmQ==
X-Received: by 2002:a05:651c:1132:: with SMTP id e18mr15818968ljo.386.1623108963576;
        Mon, 07 Jun 2021 16:36:03 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id e20sm1203041ljk.67.2021.06.07.16.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 16:36:02 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w33so29113044lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 16:36:02 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr13531788lfl.253.1623108962242;
 Mon, 07 Jun 2021 16:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk> <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
 <YL3mxdEc7uw4rhjn@infradead.org> <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
 <YL5CTiR94f5DYPFK@infradead.org> <YL6KdoHzYiBOsu5t@zeniv-ca.linux.org.uk> <CAHk-=wgr3o6cKTNpU9wg7fj_+OUh5kFwrD29Lg0n2=-1nhvoZA@mail.gmail.com>
In-Reply-To: <CAHk-=wgr3o6cKTNpU9wg7fj_+OUh5kFwrD29Lg0n2=-1nhvoZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jun 2021 16:35:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxkH79DcqVrZbETWERxLFU4xoPSzXkJOxfkxYKbjUaiw@mail.gmail.com>
Message-ID: <CAHk-=wjxkH79DcqVrZbETWERxLFU4xoPSzXkJOxfkxYKbjUaiw@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 3:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (b) on all the common non-SET_FS architectures, kernel threads using
> iov_iter_init() wouldn't work anyway, because on those architectures
> it would always fill the thing in with an iov, not a kvec.

Thinking more about this thing, I think it means that what we *should*
do is simply just

  void iov_iter_init(struct iov_iter *i, unsigned int direction,
                        const struct iovec *iov, unsigned long nr_segs,
                        size_t count)
  {
        WARN_ON_ONCE(direction & ~(READ | WRITE));
        iWARN_ON_ONCE(uaccess_kernel());
        *i = (struct iov_iter) {
                .iter_type = ITER_IOVEC,
                .data_source = direction,
                .iov = iov,
                .nr_segs = nr_segs,
                .iov_offset = 0,
                .count = count
        };
  }

because filling it with a kvec is simply wrong. It's wrong exactly due
to the fact that *if* we have a kernel thread, all the modern
non-SET_FS architectures will just ignore that entirely, and always
use the iov meaning.

So just do that WARN_ON_ONCE() to show that something is wrong (the
exact same way that the direction thing needs to be proper), and then
just fill it in as an ITER_IOVEC.

Because handling that legacy KERNEL_DS case as a KVEC is actively not
right anyway and doesn't match what a kernel thread would do on x86 or
arm64, so don't even try.

                 Linus
