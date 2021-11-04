Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB74445CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKDXk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKDXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:40:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 16:37:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d23so12119431ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3yQZQJXhgX/zkHFD6Mrk/GQBKYWCdh2u+VZfZzPF1EQ=;
        b=K4+xRIl2O3ZxTQ7b9FxffLrwYSFr7hDvs4g8BhAj5vjUGOHZeYX5vOhJaXrAA0/QJF
         3D7CXT0mkFrRgedEZ1KwsTkfsZJqTjFdexqZMnQg6Wzpq8vQFaMzynN7PeRDkwtRSKCp
         dUG+fB5ioYbqCyv/DJ4+YtlEOSpHvSP23UDK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3yQZQJXhgX/zkHFD6Mrk/GQBKYWCdh2u+VZfZzPF1EQ=;
        b=k/7ABId1w+SwePxMKe2ECJzfJeP7icSvUD+APyYpSxXJPL1f9VFpr5WjbKNqWLsKYA
         oV/v9ktydPdIX71rqR2O3/ROqJtQE3fPZIVjJndXpcGXJiDZjnBYux+a9VrtkxFSsyoW
         HP7qAxGf6GBVRAxttO0trOyGuqS7wtZw+hFKtNFWDulLyS0Gs18ebSXpB7X8UIz6JLDo
         KiUJ/w2nRDmC4H1rnhwJCDJMLbktB2TfWbKOxAr1rvsOSmqiwijWVdjA5Otqimf06k7Q
         VyKPqtXvJZwSMFPp+kkCUsg/UZkVcvtkoIxy5aBcQGJXUjFRKdRAb6p9zKtm8i+qSTUv
         ilrw==
X-Gm-Message-State: AOAM532XHvQIzStIh/K9UsPJjWL8Q9lVLXfIglInJlW+Fn6cqQQkBkx2
        vB+XyxSJSuW3hBRWRWlugmWIoIECjnD0z+ym
X-Google-Smtp-Source: ABdhPJxXPUFYLanD/qWcY8Q0YU0ayX9hOsG52nhnmVL8gDjO/CG92B6PS5kpN7vf06lnKsVMXMjFlw==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr19921470ljw.214.1636069062392;
        Thu, 04 Nov 2021 16:37:42 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k14sm328569lfu.161.2021.11.04.16.37.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 16:37:41 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g3so12125452ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 16:37:41 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr29514920ljp.68.1636069061422;
 Thu, 04 Nov 2021 16:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211104115001.GU20319@twin.jikos.cz> <CAHk-=whYQvExYESEOJoSj4Jy7t+tSZgbCWuNpdwXYh+3zq2itw@mail.gmail.com>
In-Reply-To: <CAHk-=whYQvExYESEOJoSj4Jy7t+tSZgbCWuNpdwXYh+3zq2itw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 16:37:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
Message-ID: <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
Subject: Re: Kmap-related crashes and memory leaks on 32bit arch (5.15+)
To:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 3:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm obviously not on my laptop right now, but I did look at the btrfs
> lzo code earlier today again, and didn't see anything that looked
> remotely suspicious.

Ok, back at the laptop, and once again looking at this.

I'm stumped.

So if I understand correctly,

 5.15 + 2cf3f8133bda ("btrfs: fix lzo_decompress_bio() kmap leakage")

is fine.

Also, 5.15 with the folio merge, plus the fix for that (commit
e66435936756: "mm: fix mismerge of folio page flag manipulators") is
fine too. I

The tested "tip of the day" that was bad was dcd68326d29b ("Merge tag
'devicetree-for-5.16' of git://...").

Since you already tested the folio merge, there really isn't a whole
lot of mm changes left in there. Andrew hasn't sent his patch-bombs
yet.

Doing a

   gitk 49f8275c7d9247cf..037c50bfbeb33b \
        mm/ include/linux/highmem* fs/btrfs/

really doesn't show anything that looks particularly suspicious.
There's some sync_bdev() changes, and some polling changes, but they
look trivial.

The only half-way relevant thing that remains is my merge, which very
much had conflicts around kmap/kunmap because of the revert problems.

So I continue to think that I must have screwed up, but I still don't
see which kmap/kunmap would be wrong.

I'll just repeat my suggestion here since the original email didn't go
to the lists.

>  (a) test your side before my merge with your alternate kmap fix
>      commit (the one you had in the other branch to make it allegedly
>      easier to resolve)?
>
>  (b) if that works, re-do the merge using that kmap pattern?

Your kmap() pattern is slightly different from mine. I tried to avoid
an unnecessary "kmap again" in copy_compressed_data_to_page(), so my
kmap lifetime is slightly longer over that loop.

Having looked at it once more, it still looks "ObviouslyCorrect(tm)"
to me, but I suspect I'm just being blind to some obvious bug.

> If (a) works, but (b) still fails, then it must be some odd
> interaction issue with something else. Which sounds unlikely, since I
> don't think we really had anything that should affect kmap or anything
> in this area, but who knows...

And bisection ends up perhaps somewhat painful, but sounds like the
way to go if there's no other path forward.

                 Linus
