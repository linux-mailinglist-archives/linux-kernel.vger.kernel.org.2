Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5878744214C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhKAUG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhKAUGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:06:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA0C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 13:03:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu18so21326858lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FR2K5/kGEObb0f9w9HtvEq5L7B0uQm0JuIDp97X/b0s=;
        b=RA3rD8ACX3CuP3TdohPvJvbGOIt80mDkhfWxL6bkh9VQE0rxtINxPHYaql5mavpVG4
         0jgWUU2V+0aZ+9Td9YK1PYi3H6GxiuZGb+WxaFdVCBXxlhsDc51HOst7HDT1XrMpLJL5
         8N4gfMr/EPXNxhJgjbb4LLMUT1mPZpY4w2Tt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FR2K5/kGEObb0f9w9HtvEq5L7B0uQm0JuIDp97X/b0s=;
        b=c2GVXOntzjKmIZGqVwfMZHq27QmGaHpb++73JOXAg81U2IbtoqxNmwsXqLte8R83cG
         eMGJtvtFoGM0br5FUBMH9Qedw6qkRyQAsmwNCkpnN3x34lRyh7sFM5qZj9uFuXM9KJ6N
         anN2iBReh8B6BCSNIh9fFGIgCRi/7uDLd7y/fePu+z5GLavyA29Zvc7p5hLVoakbsIBK
         FET4JchaI+0bDX9EfjmLGGVkcxujRsaz4bjS8rAC1gM5XPAYot0IDcdgQ1sfgdhm4BXQ
         rRgOjRLNB5b11BGORJxQtTSmJdK+NSZvw05KKzKyv1+ha0hIi4yZ2TiJJP4Ei2u9do4z
         iLWA==
X-Gm-Message-State: AOAM531W/PyGawvYivp/lx5fQOIEPfs8mk9caILtGtuH9p//SAp52/zj
        BOyvqLTh3fhrYrwQhvGpI0DmC/hK5lQ/H5Bw
X-Google-Smtp-Source: ABdhPJygIZgohGs9G931l3/AN1vYzQWOSNxThjh6jKGBv2tmu0aoAeMlnFCD8Ydh6t1dRVqYX6DPiw==
X-Received: by 2002:a05:6512:3d14:: with SMTP id d20mr31734457lfv.542.1635797022038;
        Mon, 01 Nov 2021 13:03:42 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q6sm1489088lfg.188.2021.11.01.13.03.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:03:41 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id d23so29854717ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 13:03:41 -0700 (PDT)
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr34338022ljk.191.1635797021035;
 Mon, 01 Nov 2021 13:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635773880.git.dsterba@suse.com>
In-Reply-To: <cover.1635773880.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 13:03:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
Message-ID: <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.16
To:     David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 9:46 AM David Sterba <dsterba@suse.com> wrote:
>
> There's a merge conflict due to the last minute 5.15 changes (kmap
> reverts) and the conflict is not trivial.

You don't say.

I ended up just re-doing that resolution entirely, and as I did so, I
think I found a bug in the original revert that caused the conflict in
the first place.

And since that revert made it into 5.15, I felt like I had to fix that
bug first - and separately - so that the fix can be backported to
stable.

I then re-did my merge on top of that hopefully fixed state, and maybe
it's correct.

Or maybe I messed up entirely.

I did end up comparing it to your other branch too, but that was
equally as messy, apart from the "ok, I can mindlessly just take your
side".

And it was fairly different from what I had done in my merge
resolution, so who knows.

ANYWAY. What I'm trying to say is that you should look very very
carefully at commits

  2cf3f8133bda ("btrfs: fix lzo_decompress_bio() kmap leakage")
  037c50bfbeb3 ("Merge tag 'for-5.16-tag' of git://git.../linux")

because I marked that first one for stable, and the second is
obviously my entirely untested merge.

It makes sense to me, but apart from "it builds", I've not actually
tested any of it. This is all purely from looking at the code and
trying to figure out what the RightThing(tm) is.

Obviously the kmap thing tends to only be noticeable on 32-bit
platforms, and that lzo_decompress_bio() bug also needs just the
proper filesystem settings to trigger in the first place.

Again - please take a careful look. Both at my merge and at that
alleged kmap fix.

                          Linus
