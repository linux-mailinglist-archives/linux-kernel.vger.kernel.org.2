Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF4344352B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhKBSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhKBSO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:14:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D338C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 11:11:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y8so7717584ljm.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UouM5URc7sS4x+3y3XOGOAo1iVE4ApmJUu+krC+yBpc=;
        b=HLsdjknpIhOMABwxYbLjXJcnZ/bMt4DoSa6O/3xXiAa0qKfsxqz2D77XsgjfLcogNP
         YMlxc1jF4TSWKIrhkbjvWu1q8x5sCrTaYAZ+uW19tDUPWj8JHI9zx9A7nANuNoVnGT4q
         qyh0hAYFDtr8spvo6DJvfU1qiKLwK1iNSoSQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UouM5URc7sS4x+3y3XOGOAo1iVE4ApmJUu+krC+yBpc=;
        b=WxK+5Yk1YVB+JH4dwRnSIXDJ9ntSOcGWdPH2waPeAW6dz+ey4t+v/dZSbbyZsVn1Va
         ZdKGHM0Y5+mRlONp1TT7JP/wI2AycZ0wkjr8wn+VewD5g085g1AHQ1hKehcbPM5/UrWR
         OdjC373Ysk3LCEYTd/l42KwPTgx422oPv3exKyAv6b6YDdJC8MK+d2CGfn4tIkrLUR6a
         Pt2lA887r90LI9bePakx3O432mY51oHJJkHsg2JRazkOjMwMX7L7GV/9FweowD5vChn2
         jLZD/FhvrgOin5mKs5KGDr3UNM6lzLbC7QpA04aEumpVKK9H7UptvMcXm1ncjakQINSJ
         N0oQ==
X-Gm-Message-State: AOAM531cL56bJHjg4rG5iHtKHcJHJgfxGNsNuZW8q13192SjxnEo1blm
        sZmSpLiIS46SUSrI9zqdmyOZZoTuYfBt2k0M
X-Google-Smtp-Source: ABdhPJzPW+faPF3ABTiQA1nbWyk1LLsYaqAfvmc5fVu0zyxvIf5r7CLnCHvaDvIH/PULOPxXDwcYOg==
X-Received: by 2002:a05:651c:1181:: with SMTP id w1mr3244638ljo.424.1635876709202;
        Tue, 02 Nov 2021 11:11:49 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c4sm958893lfs.56.2021.11.02.11.11.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 11:11:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id k24so16905359ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 11:11:46 -0700 (PDT)
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr41624398ljk.191.1635876705721;
 Tue, 02 Nov 2021 11:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
In-Reply-To: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Nov 2021 11:11:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wges7MttbFTQ9=YykWmn=B4F5pQsZNKNuxmyA1CUM7hNQ@mail.gmail.com>
Message-ID: <CAHk-=wges7MttbFTQ9=YykWmn=B4F5pQsZNKNuxmyA1CUM7hNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 5.16
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 6:13 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> There are two merges from the tip tree: one is because of Tianyu's
> patches went in via tip/x86/sev, the other is because a tree-wide
> cleanup in tip/x86/cc conflicted with Tianyu's patch.
>
> Instead of requiring you to fix up I thought I'd just do it myself.

Please don't do that.

Merging a pre-requisite and having a common branch that you merge - that's fine.

But don't hide merge conflicts from me by "pre-merging". It's not helpful.

And to make matters worse, both of those merges are BAD.

They have absolutely no explanation.

Christ.

For the millionth time:

   IF YOU CAN'T BE BOTHERED TO WRITE A PROPER COMMIT MESSAGE FOR A
MERGE, DON'T DO THE MERGE

I'm getting really tired of having to say this multiple times every
merge window (and often in between merge windows too).

Your merges are bad, and you should feel bad.

I've pulled this, but at some point I'm just going to have to decide
that "bad merges means I will not pull your garbage".

Merges need commit messages that explain what is going on, just as
much as any other commit does.

In fact, arguably they need *more* explanation, since they are subtler
and don't have the obvious patch associated with them that may clarify
what is going on.

So a merge message like

    Merge remote-tracking branch 'tip/x86/sev' into hyperv-next

is *NOT* an acceptable merge message. It needs an explanation of what
that SEV branch contained, and *WHY* those contents needed to be
merged into hyperv-next.

Again: if you can't explain the merge, or you can't be bothered, just
DON'T DO IT.

And no, the "hide conflicts from Linus" is _not_ an acceptable reason
to do merges.

I do so many merges that I can do most conflicts in my sleep, and
often do them as well or better than the submaintainers do. And I
write proper merge messages, and when a conflict happens it means I
*know* about it and am aware of how different trees ended up
interacting with each other - all of which is good.

Again - I've taken this pull request, but I'm not happy about those
merges. Even the merge that was perfectly fine to do wasn't done well.

               Linus
