Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562C4377343
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhEHQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEHQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 12:48:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7332CC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 09:47:02 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c15so978824ljr.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpBgi0AKlff8147OOEepLQzMBGFd2Jt9bavNArPpQME=;
        b=bypPdqFJPA5UGrC7VjMqIpDRd67/c4G9oxLzYlL8bqj5WHAW1G0t+zlQDg0DLILqA8
         K4pattodnxkJL9u3sPT5fbfMSAiz0Z1Bc3f1KBYDfpdNL36j/INuMqu9tRPTnyIKMJaK
         wTzy/qU2N01zcOpGy1Hz/2WG6ax9Mzy9on2bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpBgi0AKlff8147OOEepLQzMBGFd2Jt9bavNArPpQME=;
        b=j/22LS1JRpdc3MM63a1WD+Eeo08rUw9svhl2XiWcXCUvuyKLgxIXpEx4R0pKysrhaq
         Ux0KNHZHdRe3+VzgmtBokLg/MhcZJNDoIul5DQ3zqkbqmfvpnpMDvlhlyY/iEXma/PRg
         6G/vgeC57/FrPoVxXeqInc0qHBGjUZ8sMW9I99+HQtmge3VnDM0wn4zEDFlScVDXdW0G
         3OUQpXaCptHOzWS7NqxEIW9HUWPhXPFpkRfXoxQzRwFHcBXi+K5A7UXpEsqj6vfNVork
         aikUrWei6WncI/0tE9GZjgb4ueXKRnqblpBz9N8NIKkTk4QTZX8b101wGEuNs5t67L2m
         b6NQ==
X-Gm-Message-State: AOAM530irShpy9DEB0bNieOQAWEzRs2pGA4D6sz021j+fNdQVWiM8YVf
        KgWQZ7TEg2eYsB/23Jo5LZFAkD+DmZYr4kijdaY=
X-Google-Smtp-Source: ABdhPJyOsTESGbq9WfAz06lBYhMlzfd03MW7GmKULvmF0ALXC+pmHzsbcZHYZadw6Bdy+wQ4ru+HVg==
X-Received: by 2002:a2e:9e53:: with SMTP id g19mr13176045ljk.58.1620492420750;
        Sat, 08 May 2021 09:47:00 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id j7sm101388lfu.114.2021.05.08.09.46.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 09:46:57 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id i9so10605933lfe.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 09:46:57 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr10031878lfe.41.1620492417345;
 Sat, 08 May 2021 09:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <YJBHiRiCGzojk25U@phenom.ffwll.local> <CAHk-=wiwgOPQ+4Eaf0GD5P_GveE6vUHsKxAT=pMsjk1v_kh4ig@mail.gmail.com>
 <YJVijmznt1xnsCxc@phenom.ffwll.local>
In-Reply-To: <YJVijmznt1xnsCxc@phenom.ffwll.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 09:46:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjO8-f1bUwQB=5HGzkvSS+aGACR9+H5CkkDhRgud+3MA@mail.gmail.com>
Message-ID: <CAHk-=wgjO8-f1bUwQB=5HGzkvSS+aGACR9+H5CkkDhRgud+3MA@mail.gmail.com>
Subject: Re: [PULL] topic/iomem-mmap-vs-gup
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Daniel, please fix your broken email setup. You have this insane
"Reply-to" list that just duplicates all the participants. Very
broken, very annoying ]

On Fri, May 7, 2021 at 8:53 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> So personally I think the entire thing should just be thrown out, it's all
> levels of scary and we have zero-copy buffer sharing done properly with
> dma-buf since years in v4l.

So I've been looking at this more, and the more I look at it, the less
I like this series.

I think the proper fix is to just fix things.

For example, I'm looking at the v4l users of follow_pfn(), and I find
get_vaddr_frames(), which is just broken.

Fine, we know users are broken, but look at what appears to be the
main user of get_vaddr_frames(): vb2_dc_get_userptr().

What does that function do? Immediately after doing
get_vaddr_frames(), it tries to turn those pfn's into page pointers,
and then do sg_alloc_table_from_pages() on the end result.

Yes, yes, it also has that "ok, that failed, let's try to see if it's
some physically contiguous mapping" and do DMA directly to those
physical pages, but the point there is that that only happens when
they weren't normal pages to begin with.

So thew *fix* for at least that path is to

 (a) just use the regular pin_user_pages() for normal pages

 (b) perhaps keep the follow_pfn() case, but then limit it to that "no
page backing" and that physical pages case.

And honestly, the "struct frame_vector" thing already *has* support
for this, and the problem is simply that the v4l code has decided to
have the callers ask for pfn's rather than have the callers just ask
for a frame-vector that is either "pfn's with no paeg backing" _or_
"page list with proper page reference counting".

So this series of yours that just disables follow_pfn() actually seems
very wrong.

I think follow_pfn() is ok for the actual "this is not a 'struct page'
backed area", and disabling that case is wrong even going forward.

End result, I think the proper model is:

 - keep follow_pfn(), but limit it to the "not vm_normal_page()" case,
and return error for some real page mapping

 - make the get_vaddr_frames() first try "pin_user_pages()" (and
create a page array) and fall back to "follow_pfn()" if that fails (or
the other way around). Set the

IOW, get_vaddr_frames() would just do

        vec->got_ref = is_pages;
        vec->is_pfns = !is_pages;

and everything would just work out - the v4l code seems to already
have all the support for "it's a ofn array" vs "it's properly
refcounted pages".

So the only case we should disallow is the mixed case, that the v4l
code already seems to not be able to handle anyway (and honestly, it
looks like "got_ref/is_pfns" should be just one flag - they always
have to have the opposite values).

So I think this "unsafe_follow_pfn()" halfway step is actively wrong.
It doesn't move us forward. Quite the reverse. It just makes the
proper fix harder.

End result: not pulling it, unless somebody can explain to me in small
words why I'm wrong and have the mental capacity of a damaged rodent.

                Linus
