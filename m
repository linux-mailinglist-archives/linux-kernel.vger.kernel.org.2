Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD4439E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJYSKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhJYSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:09:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AFEC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:07:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id o11so18247737ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jznhQY9YDN9Bo/+eZUeL8mH4xnaJXsN5ZUXlcBDztJg=;
        b=W+3CaI/+xfMKHHZbtPTIA70pf3Oa5gyMV5/CeqjIVzuThNfi0uWdgR+yeAKOXW2u05
         BurZSwquYdSoeH8ItJYd7vesmHFvXhKHtHEmi4zU9e+hBb/Uy+/W3dYnAwDHvvAfRsRl
         RQ7Ei3wYUUIHXW6KudfWAFYcMWUK2zCbt/bTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jznhQY9YDN9Bo/+eZUeL8mH4xnaJXsN5ZUXlcBDztJg=;
        b=NDSSneEnq4gtBP0+5DUYsnKhrZxLkYm2ejc2GTL1nsj3gtUBGz7ORh6hNtmJsT4EwI
         ZkS5iEOYJQILUGoZyWR73c0qr3y0vwqJzWV3tFqc4E/436dre4t6aw8jbcZ1UKfsQGfR
         EJe4XIHED3UFjddhPMwXbDYFpLWfj2CSabzxkO2BTGDJ3rRkf42rTnf8okiiKJ0US+7N
         OMS/sLrFlrchWeeloJ2Xf7NGz/kM+duSpJr77FuMebYLLWpd3nyaJt6DXy9f8+9MZrvh
         Z4T4G3r6P8iV/80byp/Ojxnj2iaE5x6L++A/R5CDfJ+I7HGo/slK4GJ5jAxHpDFA7cd7
         GSSA==
X-Gm-Message-State: AOAM532ZEWjrvnbSHFJMqPkilElJWYJxk0UqQKDFdGCASKTmUjk0xXZF
        LSNweTuFtopTaBazpewj60cZL2IRwVd/Oixt
X-Google-Smtp-Source: ABdhPJxRtLdN4EzAeyCwLNHxkcjZXsndv2qZx/f0Pi3dkYKGsSce2CKLvg7w5z3y4nidntss9V+B7w==
X-Received: by 2002:a05:651c:b27:: with SMTP id b39mr20861634ljr.431.1635185253628;
        Mon, 25 Oct 2021 11:07:33 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id u8sm856929lff.53.2021.10.25.11.07.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 11:07:33 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id l13so15142906lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:07:32 -0700 (PDT)
X-Received: by 2002:a05:6512:3983:: with SMTP id j3mr10730262lfu.402.1635185252505;
 Mon, 25 Oct 2021 11:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjbXW13Eh6YnB4C5ghLrhJCq0u2bpSNA0JbK8eDb6o_XA@mail.gmail.com>
 <20211019203320.GA748645@roeck-us.net>
In-Reply-To: <20211019203320.GA748645@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 11:07:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPA5ZgXAG08vqtvZw3DK5H7Tkd9r+ZHSxxNaKYWzjw9g@mail.gmail.com>
Message-ID: <CAHk-=whPA5ZgXAG08vqtvZw3DK5H7Tkd9r+ZHSxxNaKYWzjw9g@mail.gmail.com>
Subject: Re: Linux 5.15-rc6
To:     Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 1:33 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Building alpha:allmodconfig ... failed
>
> drivers/spi/spi-tegra20-slink.c:1197:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
>  1197 | static int tegra_slink_runtime_resume(struct device *dev)

Ok, I've fixed this up _again_ now in my tree, since I'm about to make
another rc and didn't get the fix any other way.

And honestly, I'm a bit upset.

I'm upset because Mark not only screwed up a merge commit, he did so
despite the fact that HE SHOULD NOT HAVE DONE A MERGE AT ALL.

Mark, please stop doing these mindless AND INCORRECT back-merges of my
tree. There is absolutely no excuse for garbage like this:

  commit 59c4e190b10cd2d6edccb5c238a3d2bda071a018
  Merge: 6840615f85f6 5816b3e6577e
  Author: Mark Brown <broonie@kernel.org>
  Date:   Mon Sep 27 18:38

      Merge tag 'v5.15-rc3' into spi-5.15

      Linux 5.15-rc3

  commit ffb1e76f4f32d2b8ea4189df0484980370476395
  Merge: 2bab94090b01 e4e737bb5c17
  Author: Mark Brown <broonie@kernel.org>
  Date:   Mon Sep 20 15:56

      Merge tag 'v5.15-rc2' into spi-5.15

      Linux 5.15-rc2

where one of those merges was actively incorrect, and BOTH of the
merges were pure crap in that they don't have any explanation for what
the reason for the merge was.

I've said this a hundred times before, and I bet I'll have to say it a
hundred times again, but let me repeat one more time:

   IF YOU CANNOT EXPLAIN WHY YOU ARE DOING A MERGE, THEN DON'T DO THE MERGE.

Dammit, it's really that simple. This is not a complicated rule.

If your merge doesn't have an explanation for what you're doing and
*WHY* you are doing it, then your merge is bad, bad, bad.

Don't do it. Just stop it. Just keep developing your own tree, and
don't do bad back-merges of the upstream tree. You have absolutely no
business merging my random changes like this, and that is doubly true
when you do it badly and the end result is just broken and wrong to
the point of not even building.

If you really need to do a back-merge, explain WHY. And it had better
be some important reason.

In particular, the reson should not be "fix conflict", because you're
clearly not particularly good at it.

Yes, I can screw up merges too. It happens. But I do a _lot_ of
merges, and as a result I'm pretty good at them. Trying to fix a
conflict so that I don't see it is likely to just make things worse.

It makes things worse not only because you're more likely to get it
wrong, it makes it worse because it's literally hiding the kinds of
development process issues that I want to see so that I am aware of
them.

              Linus
