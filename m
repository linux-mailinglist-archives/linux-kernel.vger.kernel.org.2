Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1D3243AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhBXSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBXSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:21:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA08C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:21:10 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id v17so3483121ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrtuukhPXQ5trgm/Ohmf8LNWrlvZuO1xjRlOBOh5s3c=;
        b=cspPLorMXiQn/Fspzpq/DJvDPSIdIJgSiGP10/8G7BWm7l2+o3a91GW/zctpbzWp9C
         N2lfaBA+DeH1qJV6qnDXWmjKmPGtupKYZbnaAocy05NHnewNBbMOuOuGwoe7aY6utFNu
         EOmutkqR62yCwBndo1dyTgPtH+OcOjdewQcbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrtuukhPXQ5trgm/Ohmf8LNWrlvZuO1xjRlOBOh5s3c=;
        b=dJT634ip84ZuXreM3aFhibk8+MM1qoINI2chasOuOAXFPNW/imkYtlWC+0eCGVbCBj
         +rwwjh3hdR6t0YuaBybjyzTI9+LVZXnOjIwlfqsWU5Dfqn41BkVohWwkBDZ13NP6HlFw
         sGLOW45xTigC2L21wNRAMB7d9nAwCFuN0guvvKj0t2XpdlSz+v2K2+CGqQ+JUURslL12
         V046KRWxel1nIrIFIEQ5WQLPDLox+vvGowQ8rtcjRPrBgnG0/L8Rfo7CF0dN8FXO0Yth
         b2RPuI4tnTaapA7PJeD7a9IqSkwjJ8PZYelEV3c0y5EAiYaailTES+aJrhqzCKtjNrnE
         /OlA==
X-Gm-Message-State: AOAM531FPhLcRlq0NUp+C0lX6xyQbYoZlh4rtF0RsXWb6rrtNH4a56EO
        HuddYeBa9d6DLNdFS0jzwNuKzFHGASK5cA==
X-Google-Smtp-Source: ABdhPJw4NLSuJ7/RI93wMJWbGvMNLosDQ94nj7xKYUAkhwidvb1TwkvpTqDhT+zYVtYYPId8TevzUQ==
X-Received: by 2002:a2e:9007:: with SMTP id h7mr15613276ljg.447.1614190861795;
        Wed, 24 Feb 2021 10:21:01 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id p10sm624469lfo.293.2021.02.24.10.21.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 10:21:01 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id z11so4459288lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:21:00 -0800 (PST)
X-Received: by 2002:a19:8186:: with SMTP id c128mr19882702lfd.377.1614190860554;
 Wed, 24 Feb 2021 10:21:00 -0800 (PST)
MIME-Version: 1.0
References: <YDZiQoP8h/QDSNkJ@kroah.com>
In-Reply-To: <YDZiQoP8h/QDSNkJ@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Feb 2021 10:20:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2kJRPWx8B09AAtzj+_g+T6UBX11TP0ebs1WJdTtv=WQ@mail.gmail.com>
Message-ID: <CAHk-=wj2kJRPWx8B09AAtzj+_g+T6UBX11TP0ebs1WJdTtv=WQ@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core / debugfs changes for 5.12-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 6:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>  [..] I've reverted that change at
> the very end so we don't have to worry about regressions in 5.12.

Side note: it would have been really nice to see links to the actual
problem reports in the revert commit.

Yes, there's a "Link:" line there, but that points to the
less-than-useful patch submission for the revert, not to the actual
_reasons_ for the revert.

Now I'm looking at that revert, and I have absolutely no idea why it
happened. Only a very vague "there are still reported regressions
happening".

I've pulled it, but wanted to just point out that when there's some
fairly fundamental revert like this, it really would be good to link
to the problems, so that when people try to re-enable it, they have
the history for why it didn't work the first time.

Now all that history is basically lost (well, hopefully Saravana and
you actually remember, but you get my point).

               Linus
