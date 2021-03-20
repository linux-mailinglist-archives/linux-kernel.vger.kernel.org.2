Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E971F342F54
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCTTme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 15:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:42:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960CAC061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 12:42:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a198so15148337lfd.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVgAWw1YOr1g8Gf6SRPp2z7AA76SRYSgDFeMcq5+XRk=;
        b=d27AXJ3F2hzODjs3FGKrs1zzMMkbDWhFucO4aywXQXJM0JMSqZeoBFygnG1+BpqIHq
         3vLfWpJioMsTbwmY5xpxA8uFyOrjCct/ugbX4GQNicAqkaWyXkokmv8FTJp7ENkZHY4n
         FcSbp4jqG9i9ST8BTWnF38aLT5LiaBIzqT5po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVgAWw1YOr1g8Gf6SRPp2z7AA76SRYSgDFeMcq5+XRk=;
        b=I50gHnnZP4FB0tI/rl8ealwr5/ofGhDF3B/3TlERIAwbZSwDftWs3VAEHOBsLg3t/G
         B4gY7NUodNFjeMX9AXRpN+0IPRy0ApB0SHd51MCL6+pLtB/nNc55RpTEg/sPCf2Gynbk
         SBkpE3wtcsEnCYwewe+1v/AewZLkifiFnxTsmYhCB0DFappCDA+Zol9Oa8/nD/mV2pBB
         QgCfkxvjQIuoQ8NW/2itwFtu4p7hfjagGTzr5O08BsXlQAWAMbPoJ33HeVZqNnjIf4jt
         0hA1XZUa98aJZPn8C9wkmWbz/gMLGxUVcqaQE84TXCFCTc+TsV3nJaorLmuzlKZSR7sB
         wQ8w==
X-Gm-Message-State: AOAM531JSXklXSMv1419+2z0lRjPE33eguimVimpc61ZXw7fZcV7JP/P
        NCTMqB14e1aURsXHLLc4HvyF8YM/y9sY/w==
X-Google-Smtp-Source: ABdhPJzmfpCp5VkemkWct6nlj+yDbd6xammWnuq/3jsfd9cX445av117nN+622n6axmdGa7g8TgoLw==
X-Received: by 2002:ac2:4857:: with SMTP id 23mr4405155lfy.136.1616269343678;
        Sat, 20 Mar 2021 12:42:23 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id g6sm1006683lfh.232.2021.03.20.12.42.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 12:42:22 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s17so16151620ljc.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 12:42:22 -0700 (PDT)
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr4521968ljj.465.1616269341975;
 Sat, 20 Mar 2021 12:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082939.77495e55@canb.auug.org.au> <YFTJdL1yDId+iae4@unreal>
 <65e47dcc-702b-98e0-2750-d5b11a7c0ae1@pengutronix.de>
In-Reply-To: <65e47dcc-702b-98e0-2750-d5b11a7c0ae1@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Mar 2021 12:42:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmL3qJhjnoG1z9kH-N0RokWOHATRjPyLWGx=U7Ar-1qA@mail.gmail.com>
Message-ID: <CAHk-=wgmL3qJhjnoG1z9kH-N0RokWOHATRjPyLWGx=U7Ar-1qA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net tree with Linus' tree
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephane Grosjean <s.grosjean@peak-system.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 12:28 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Good idea. I'll send a pull request to David and Jakub.

I don't think the revert is necessary. The conflict is so trivial that
it doesn't really matter.

Conflicts like this that are local and obvious aren't really
problematic. Any maintainer pulling git trees will have seen them and
is used to them (admittedly probably me and Stephen more than most,
but still).

The conflicts that can be pretty painful and might be worth worrying
about ahead of merge time - or at least let the maintainer/me know
about loudly when you ask them/me to pull - are the ones that might
not even show up as a file conflict. The conflict might be purely
semantic rather than some simple "changed lines next to each other"
kind of thing.

Often even those are trivial, but they might fly under the radar. Many
of them cause build issues (think "changed arguments to or renamed a
function" on one side, "added new use of function" on the other side),
but not all do, And even if they do, they might do so only under
certain configurations and architectures, of course.

And occasionally there are conflicts that are just so *big* that they
are painful to work through (things like renaming variables and moving
code on one side, and then non-trivial changes on the other side).
They can look particularly scary when you see the conflict diff, but
on the whole it's unusual that it's a real problem. I reasonably often
ask people to verify my merge "just in case", but it's seldom actually
a big issue. I don't remember the last time I actually went back to a
maintainer and said "ok, this looks too nasty, please actively help me
out".

In fact, the most common conflict problem is not that the conflict is
_hard_ - it's that some coding patterns are just _annoying_ when they
cause conflicts.

Things like big whitespace cleanups across whole subdirectories get
_really_ old as you're working on the fifth file that has a conflict
due to the same silly syntactic change.

But something like this that just removes the
MODULE_SUPPORTED_DEVICE() thing that basically never gets touched
anyway, and we happened to be unlucky in *one* file? Not a worry at
all.

                   Linus
