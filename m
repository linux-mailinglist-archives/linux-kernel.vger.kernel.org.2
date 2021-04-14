Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7166035FD11
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhDNVSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhDNVSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:18:36 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ABBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:18:14 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id k124so11098414vsk.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSRWSjJIyTOfOO8D771rBsEaBLI9bpiKOdKKIXVQ4CQ=;
        b=akCZ6cl2eKyt+LPsYu0lXcStEvNjyEYweD9QTez7knontom444UNX1fyj0tpxD2IRP
         gZzB+zzZ2FAkILUStIAqPiPT0vyr/SCDnavdE+73jzATEe/zFOL0Ol7XdP97K2aWdnW7
         ifT1Do9UcX1ufZ1wuYOwFfGLwGMFsLJFlPMmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSRWSjJIyTOfOO8D771rBsEaBLI9bpiKOdKKIXVQ4CQ=;
        b=U/XwFeoRAumtv4Rav9PllASAey0j/OkrswFV45hGeD3Agj6bDKCwOkRidVMobqtDrC
         0sLC05uXA6HZN2vObt0bnppM0JsJuPsawJSmL775QVmkKnZQZg9BE2p4PFUZTs/yQse9
         YC52OP+SkguHeZRMeY5M3RvwSJy08U0rl1N02XB4KImhO8/8vBPbMNAGrZnl0y9VGQnX
         uxvCmzb1zEhkhH0Tvudpng+Y1F5HFMRHYzNTf8xl/8Rd1NcnllF7ydAclPqOCzVOyalR
         /ahBUfMqR0msu6sIe5aPKs6Hg9msdUnS9i1pZI7SmlTP1LQAdt9k1jab1DOqiJStwgta
         8LWQ==
X-Gm-Message-State: AOAM533z58hx5TJxJXxJapsQHg43+z4MBP3fGN8C5rgX7aAV+IIIRWEx
        S5hEKDdUwRMmOOftJUzdyghtzC/FQCznirqjF+AV0w==
X-Google-Smtp-Source: ABdhPJy7qhYOC24xTuqNgMcJtiTn6UiIGa9unLUc0bB7eerUQ1Kg45G19YSdh6czre0FVvcpJgsGfjIBwM1bdqnAK04=
X-Received: by 2002:a67:c88f:: with SMTP id v15mr242466vsk.31.1618435092886;
 Wed, 14 Apr 2021 14:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210326035035.3057800-1-jwerner@chromium.org>
In-Reply-To: <20210326035035.3057800-1-jwerner@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 14 Apr 2021 14:18:01 -0700
Message-ID: <CAODwPW_rdHnkKuAhCxbF9Lb3bPvAKR54G1wowFGyoDQ_sp-3Cg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Detect suspicious indentation after conditional
To:     Julius Werner <jwerner@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Ivo Sieben <meltedpianoman@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*friendly ping*

Hi Andy, Joe,

Any comments on this patch series? Are you guys the right point of
contact for checkpatch changes?

On Thu, Mar 25, 2021 at 8:50 PM Julius Werner <jwerner@chromium.org> wrote:
>
> This patch series is adding functionality to checkpatch.pl to test for
> incorrect code indentation after a conditional statement, like this:
>
>  if (a)
>    b;
>    c;
>
> (Indentation implies that `c;` was guarded by the conditional, but it
> isn't.) The main part is re-sending a patch from Ivo Sieben that was
> already proposed in 2014 [1]. I don't know why it was never merged --
> it seems that there was no discussion on it. I hope that it was only
> overlooked, because it works great, and I think this is a very important
> class of common error to catch.
>
> I have tested it extensively on the kernel tree and in the course of
> that found a few more edge cases that get fixed by the other two
> patches. With all these applied, the vast majority of hits I get from
> this check on the kernel tree are actual indentation errors or other
> code style violations (e.g. case label and statement on the same line).
> The only significant remaining group of false positives I found are
> cases of macros being defined within a function, which are overall very
> rare. I think the benefit of adding this check would far outweigh the
> remaining amount of noise.
>
> [1]: https://lore.kernel.org/patchwork/patch/465116
>
> Ivo Sieben (1):
>   Suspicious indentation detection after conditional statement
>
> Julius Werner (2):
>   checkpatch: ctx_statement_block: Fix preprocessor guard tracking
>   checkpatch: Ignore labels when checking indentation
>
>  scripts/checkpatch.pl | 56 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 4 deletions(-)
>
> --
> 2.29.2
>
