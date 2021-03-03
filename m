Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29032C2D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353881AbhCDAGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhCCUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:54:19 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E42C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:53:37 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id q14so30519851ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=29R9t7f01tsBoXDV+Koehd/EHDMqlTrum3hJEMk0HMU=;
        b=ePpiHxfrV4Ugkr9JtT5tWU3hfIlefc3u49q1i8xVYKdzU0YCE+DSt3QpsED8tv28cO
         fcT4VbBwwG1AzdpXyiVmVpESrLcE4fL5COWoBl4eNj98iWvHywV2ou5lGMbIfuvLzxAh
         orGA569jwG0jCj/lgurHCBwqRij6sbDuWCGKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=29R9t7f01tsBoXDV+Koehd/EHDMqlTrum3hJEMk0HMU=;
        b=h7nMep90OLLF0jghwziDLnKoEyHvFyGeu88naIR+Lxt8TeZAyLOUnikJdYgwN0E9e/
         4W9jy2GaDQ8IZypZT9ntQ1xrFWX73TGNlWbXpNT/kyXXLn5KO7KPkyft8Sa444MMBagI
         XfkfiZ154xQVf5kYOM/9sTCww5VZK0PzWf1VQU684v/AA4twsK7mzTEHJVmzXWsN9qGs
         X3e++SmjXkQ+MIFLG1Nclzou/RRXRD2bj3OJjPgZG88PWWstzmxIv5eBG+FY304Nx9lI
         yhOQAjT8rntWhd13vxNsZExmy7ki9bw4xXDBNo1FGj3XULc4cvlKo4npAd4kBkJ4jcFM
         s18w==
X-Gm-Message-State: AOAM532eiJ5Yqqxmy1Rh4uI77KEMXxzGQm4yLLoQY/eZnK7g0ZiL25nA
        4MimbIK9UeaQ4/lkmWj/F2Qg7wiEMOSxZw==
X-Google-Smtp-Source: ABdhPJxuOusQcahXJjYfVIcz5EQ6Zr0JkXaDXJJ2TgdQhBppggQVdt7Ukdv+rjVSKhcho9lWOKkK0g==
X-Received: by 2002:a2e:96c7:: with SMTP id d7mr438722ljj.268.1614804815866;
        Wed, 03 Mar 2021 12:53:35 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id e2sm1620749ljp.135.2021.03.03.12.53.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 12:53:35 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id m22so39400846lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:53:34 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr320341lfu.253.1614804814383;
 Wed, 03 Mar 2021 12:53:34 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Mar 2021 12:53:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
Message-ID: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
Subject: A note on the 5.12-rc1 tag
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey peeps - some of you may have already noticed that in my public git
tree, the "v5.12-rc1" tag has magically been renamed to
"v5.12-rc1-dontuse". It's still the same object, it still says
"v5.12-rc1" internally, and it is still is signed by me, but the
user-visible name of the tag has changed.

The reason is fairly straightforward: this merge window, we had a very
innocuous code cleanup and simplification that raised no red flags at
all, but had a subtle and very nasty bug in it: swap files stopped
working right.  And they stopped working in a particularly bad way:
the offset of the start of the swap file was lost.

Swapping still happened, but it happened to the wrong part of the
filesystem, with the obvious catastrophic end results.

Now, the good news is even if you do use swap (and hey, that's nowhere
near as common as it used to be), most people don't use a swap *file*,
but a separate swap *partition*. And the bug in question really only
happens for when you have a regular filesystem, and put a file on it
as a swap.

And, as far as I know, all the normal distributions set things up with
swap partitions, not files, because honestly, swapfiles tend to be
slower and have various other complexity issues.

The bad news is that the reason we support swapfiles in the first
place is that they do end up having some flexibility advantages, and
so some people do use them for that reason. If so, do not use rc1.
Thus the renaming of the tag.

Yes, this is very unfortunate, but it really wasn't a very obvious
bug, and it didn't even show up in normal testing, exactly because
swapfiles just aren't normal. So I'm not blaming the developers in
question, and it also wasn't due to the odd timing of the merge
window, it was just simply an unusually nasty bug that did get caught
and is fixed in the current tree.

But I want everybody to be aware of because _if_ it bites you, it
bites you hard, and you can end up with a filesystem that is
essentially overwritten by random swap data. This is what we in the
industry call "double ungood".

Now, there's a couple of additional reasons for me writing this note
other than just "don't run 5.12-rc1 if you use a swapfile". Because
it's more than just "ok, we all know the merge window is when all the
new scary code gets merged, and rc1 can be a bit scary and not work
for everybody". Yes, rc1 tends to be buggier than later rc's, we are
all used to that, but honestly, most of the time the bugs are much
smaller annoyances than this time.

And in fact, most of our rc1 releases have been so solid over the
years that people may have forgotten that "yeah, this is all the new
code that can have nasty bugs in it".

One additional reason for this note is that I want to not just warn
people to not run this if you have a swapfile - even if you are
personally not impacted (like I am, and probably most people are -
swap partitions all around) - I want to make sure that nobody starts
new topic branches using that 5.12-rc1 tag. I know a few developers
tend to go "Ok, rc1 is out, I got all my development work into this
merge window, I will now fast-forward to rc1 and use that as a base
for the next release". Don't do it this time. It may work perfectly
well for you because you have the common partition setup, but it can
end up being a horrible base for anybody else that might end up
bisecting into that area.

And the *final* reason I want to just note this is a purely git
process one: if you already pulled my git tree, you will have that
"v5.12-rc1" tag, and the fact that it no longer exists in my public
tree under that name changes nothing at all for you. Git is
distributed, and me removing that tag and replacing it with another
name doesn't magically remove it from other copies unless you have
special mirroring code.

So if you have a kernel git tree (and I'm here assuming "origin"
points to my trees), and you do

     git fetch --tags origin

you _will_ now see the new "v5.12-rc1-dontuse" tag. But git won't
remove the old v5.12-rc1 tag, because while git will see that it is
not upstream, git will just assume that that simply means that it's
your own local tag. Tags, unlike branch names, are a global namespace
in git.

So you should additionally do a "git tag -d v5.12-rc1" to actually get
rid of the original tag name.

Of course, having the old tag doesn't really do anything bad, so this
git process thing is entirely up to you. As long as you don't _use_
v5.12-rc1 for anything, having the tag around won't really matter, and
having both 'v5.12-rc1' _and_ 'v5.12-rc1-dontuse' doesn't hurt
anything either, and seeing both is hopefully already sufficient
warning of "let's not use that then".

Sorry for this mess,
             Linus
