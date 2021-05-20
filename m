Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2338AFB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbhETNLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbhETNJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:09:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E03C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:02:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id v8so19400913lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bfs5XG6Orq6hCirwXDv5eFA3LNXHAM5IFwkddiPAs8g=;
        b=azrOQ06XjZ71pGUijwdHkI0wPGcXQCx8uLOHPB0jJ5DQPHGwNnvIZmLywTL526K44i
         8LypOQWJQUb9bOTa4omd9etXsoHDTXJzKeYjYpAasxEg86sRunHOYGnVbSiZ9jOCoi8I
         vjsi7+TOsqS5+aMYLrQc3Gx5/lqQyPhj5rMLRqAiOje6AS0xvSLObTD2vi4EmrxY6i2l
         MIdmiBz0ve2nex6CjdjPuSIG77/Rhb5ajQ8apbKMoWwHQIBCA5VnRFhKmUw1hkAnLL6q
         D6+yUWnGfxbX2Cpg7wSAdm6vDv/ZR8js6nX53/Ht92//fEiU7y4jyqb+PglSJYOEXGhs
         z12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bfs5XG6Orq6hCirwXDv5eFA3LNXHAM5IFwkddiPAs8g=;
        b=muwqsR3v7PLqHlXddLEa93UqKck9IVApsd4MDW1ZPOuJKiPyZhd34Z1lNbG6wJJWtX
         1+T/bEO48LvUlk7NNVXCpIM/KM6+DSc+Pw9/rWMlbscNHgFF3y91CYTob0tREil2S5C5
         lplvhlZWzeYZd3eyoLqBuPXI3dllDq9ic4tSH1TFRGSXXVVitsmwXFSriY3P6AB0/cSJ
         r9QtUG6Ss8KQSZACmr9qBc/egQKAopj96r0Vr2V2Zp43ixI4jreJhkMyXVCK/rIRC8vl
         SRDDUrRreFxPuEhInBnV/RRplcB5WqWUdfIYGUEPRQGuN4cdq88rgwYMGwjCUYrMfc5y
         gn+w==
X-Gm-Message-State: AOAM5303NESUppAWqdHefP6c7ot9r8mDpmafdxRUhBM16xvRxz9VSpom
        Xvc54WoMT5/6gN9sbHHVek8CYfV5MQpU70X+Ag8yFFY/Z8FeD32G
X-Google-Smtp-Source: ABdhPJxYcONugoqkSV++75gu6rP+Zb2Ec71unBL7zsP5eB8e6sj7j/R7lBbGQq/9xmpiRQmXsR5u3p4S9Dz1ykKQqtg=
X-Received: by 2002:ac2:4ed9:: with SMTP id p25mr3240375lfr.576.1621515767913;
 Thu, 20 May 2021 06:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210520015704.489737-1-andrew@aj.id.au> <CAKXUXMxTnz6edBLpBgqOo6uUiSGm8rULH9P8G24xx2OhP_Yb6A@mail.gmail.com>
 <a0d1f44a-c8ff-4108-af34-6455b5683262@www.fastmail.com> <CABJPP5C7ZokRycaE0aAvUv3BfOJqOvPyqn-P0bbPdyCfnuuESw@mail.gmail.com>
 <72ed5aa8-bca5-451d-9458-48735fc17b84@www.fastmail.com> <CABJPP5AMPL22dJ2YKNqdTtHrTJRr=SKnxo05PKn9FoveNX7tow@mail.gmail.com>
 <CAKXUXMzTiYOe9T6w_mPny8S1gBGyktSzpZ+FFPLxVTUhkTTUcQ@mail.gmail.com>
In-Reply-To: <CAKXUXMzTiYOe9T6w_mPny8S1gBGyktSzpZ+FFPLxVTUhkTTUcQ@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 20 May 2021 18:32:36 +0530
Message-ID: <CABJPP5CF6Ts=c6b4k4FPsbV-D-Ao9rfppR=17zW4rqQ==4terw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Tweak BIT() macro include
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 5:36 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Thu, May 20, 2021 at 12:21 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> >
> > On Thu, May 20, 2021 at 3:15 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > >
> > >
> > > On Thu, 20 May 2021, at 18:47, Dwaipayan Ray wrote:
> > > > On Thu, May 20, 2021 at 12:55 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On Thu, 20 May 2021, at 16:28, Lukas Bulwahn wrote:
> > > > > > On Thu, May 20, 2021 at 3:57 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > > > >
> > > > > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > > > > include/linux/bits.h in [1]. Since [1] BIT() has moved again into
> > > > > > > include/vdso/bits.h via [2].
> > > > > > >
> > > > > > > I think the move to the vDSO header can be considered a implementation
> > > > > > > detail, so for now update the checkpatch documentation to recommend use
> > > > > > > of include/linux/bits.h.
> > > > > > >
> > > > > > > [1] commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
> > > > > > > [2] commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
> > > > > > >
> > > > > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > > > >
> > > > > > Looks sound to me.
> > > > > >
> > > > > > I would prefer a bit of word-smithing the commit message by just
> > > > > > removing the references:
> > > > > >
> > > > > > So:
> > > > > >
> > > > > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > > > > include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file"). Since that commit, BIT() has moved again into
> > > > > > > include/vdso/bits.h via commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
> > > > > > >
> > > > > > > I think the move to the vDSO header can be considered a implementation
> > > > > > > detail, so for now update the checkpatch documentation to recommend use
> > > > > > > of include/linux/bits.h.
> > > > > > >
> > > > > >
> > > > > > And then drop references [1] and [2].
> > > > > >
> > > > > > Andrew, what do you think?
> > > > >
> > > > > I mostly did this because initially I wrapped the commit message and
> > > > > checkpatch spat out errors when it failed to properly identify the
> > > > > commit description for [1]. But, leaving the description unwrapped
> > > > > inline in the text feels untidy as it's just a work-around to dodge a
> > > > > shortcoming of checkpatch.
> > > > >
> > > > > With the reference style the long line moves out of the way and
> > > > > checkpatch can identify the commit descriptions, at the expense of
> > > > > complaints about line length instead. But the line length issue was
> > > > > only a warning and so didn't seem quite so critical.
> > > > >
> > > > > While the referencing style is terse I felt it was a reasonable
> > > > > compromise that didn't involve fixing checkpatch to fix the checkpatch
> > > > > documentation :/
> > > > >
> > > >
> > > > Hey,
> > > > Can you share which wrap around caused the checkpatch errors
> > > > to be emitted? We can try to fix that.
> > > >
> > > > I was able to wrap it without checkpatch complaining. You might consider
> > > > replacing it with this if you wish?
> > > >
> > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
> > > > Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").
> > >
> > > This wording works because the commit description is only split across
> > > two lines. With the wording I had it was split across three, and this
> > > caused checkpatch to barf. If we do this:
> > >
> >
> > Yes it won't work for 3 lines. We are checking only for an additional line
> > for split commit descriptions. Might be a thing to improve in the future.
> >
>
> Dwaipayan, you certainly got my go to improve checkpatch for this
> issue. You might want to re-run our known checkpatch evaluation and
> see how often this issue for commit references with multiple lines
> appears.
>
> Looking forward to your patch,

Sure I will try something.

Last time I ran checkpatch over 50k commits from v5.4 there were
1032 instances of the error "GIT_COMMIT_ID: Please use git commit
description style 'commit <12+ chars of sha1>".
Ref: https://raydwaipayan.github.io/blogs/checkpatch_out_50k.txt (42MB dump)

But now it's hard to tell how many are due to warping into > 2 lines.
A majority of these seem to be actual errors. (Through random sampling :)).
But unless we extract the commit messages themselves it's hard to tell.
Might be a very insignificant number or might be considerable as well.

Does Joe have any suggestions for this?

Thanks,
Dwaipayan.
