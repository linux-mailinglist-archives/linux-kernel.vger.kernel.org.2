Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB18A3C280A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhGIRMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIRML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:12:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09731C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:09:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c28so24075111lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBhcYMUl2xlWqh1FOBf7oxdHmtzU8noyHn56sS3VewQ=;
        b=HiGFi2E15x32PX3njJDWrVvTsLBOSaGOKg60iPGD69rXNs3jRSWIcD68BeSV/F9zVG
         95W1G2I+8fkAiGUajAUSmuF1lboZBUyWzG61Qbu5Q4dg24vCbxRVzEuGHLP/42Lo8gm0
         PqnJmXGQvoVg6B/nG2f2X5sNgX3X+1BgM8M1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBhcYMUl2xlWqh1FOBf7oxdHmtzU8noyHn56sS3VewQ=;
        b=JifchpWD590ll9QZB65hPrSz6JGgRPEFo2a61G58wVWjqpbfe9ZjSOevEpQ4AUfubw
         0QIW6lOGATpe3jfJxxzH2DBQFsdA77Ck1JklznpEzn+qPQSzVYwcqVAhJAGmYbqoOVcM
         tSIum3Sr3mxGdZlMIR2Vpcm8QuDofJ+GIUHRlUhRzalTNPpUD+rJl9YdTrOM7avJFqSv
         LmXG/teJeTkac2U7Q8OOSi5lcs7u9JWPIxBLn+eoCIhby6RMtg9H1gJKr9aUxBmoefub
         FNvZNrsUh9cImppYj3xHBKtbC8/UwUG+goYB7dldOoud2sod8pk+969z+qxF9ZOcvxdS
         diqw==
X-Gm-Message-State: AOAM532pjV2CK4jeyu/PPJTnFulq9mySYUkazlfjpHyv4BnfR1z+QHRs
        17jFQXQCPEde3d+Sjh2qt1fj2an/SLFw1dWoi9Y=
X-Google-Smtp-Source: ABdhPJwmxWLrJDeTbIg3i7Q1ItEIgy0vvzzNQpGvpINw34BggrGvjgTyhxhfUAhi+EDWsqTAUTPHjA==
X-Received: by 2002:a19:7716:: with SMTP id s22mr4581596lfc.272.1625850565197;
        Fri, 09 Jul 2021 10:09:25 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f8sm506757lfu.188.2021.07.09.10.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 10:09:25 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id x25so11820228lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:09:24 -0700 (PDT)
X-Received: by 2002:ac2:4475:: with SMTP id y21mr1343435lfl.487.1625850564418;
 Fri, 09 Jul 2021 10:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <6809750d3e746fb0732995bb9a0c1fa846bbd486.camel@hammerspace.com>
 <CAHk-=wjvNb9GVdbWz+xxY274kuw=xkYBoBYHHHO7tscr1V0YAQ@mail.gmail.com> <448e0f2b96b7fa85f1dd520b39a24747ea9487ed.camel@hammerspace.com>
In-Reply-To: <448e0f2b96b7fa85f1dd520b39a24747ea9487ed.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Jul 2021 10:09:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLAQPisWbcoc+YcUdtLp87TMc29bETJrS4f6pjoAAy5Q@mail.gmail.com>
Message-ID: <CAHk-=wjLAQPisWbcoc+YcUdtLp87TMc29bETJrS4f6pjoAAy5Q@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 5.14
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 9:55 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Thanks! It didn't result in any overall code changes or even changes to
> the result of the merges. However if you're OK with the occasional
> duplicate patch then I'll make sure to avoid this in the future.

The occasional duplicate patch is actually completely normal.

Particularly when it is something like an important fix that gets
pushed to mainline late in the -rc series: people often want them in
their development trees as well for testing, and so you end up with
the same fix both in mainline and in the "for next merge window"
branch.

In fact, that "important fix that goes to both branches" can be a very
good thing, exactly because you want to test that -next branch, and
you want to do it without having to worry about old bugs that might
trigger or hide new issues.

And then I very much want to pull that _tested_ development branch,
not some "ok, I removed that fix from the branch before asking Linus
to pull, because it's already in his tree".

See?

And yes, sometimes they happen by mistake, and the duplication is not
intentional, and it's not some "good thing". It happens just because
the same patch was sent two different ways.

That's fine too.

It's a problem if they happen a _lot_ - partly because they do make it
much more likely to cause pointless merge conflicts (and mistakes can
happen during that stage), but even more because it shows that
something is going wrong in the patch management, and people are
stepping on each other's feet.

So then the duplicate patches is not necessarily a _technical_
problem, but it's indicative that something is wrong with patch flow.

But even then removing the duplicate patches is generally less
important than trying to fix the maintenance issue.

So on the whole, a couple of duplicate patches isn't a big deal, and
not worth rebasing.

Aim to keep rebasing mainly for "oh, keeping that will cause actual
problems" (and sometimes the "actual problems" can be about things
like truly horribly mangled commit messages and wrong attribution
etc).

So rebasing isn't necessarily always "wrong", but it just needs to
have a fairly compelling reason.

              Linus
