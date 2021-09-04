Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5908400C79
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhIDSKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhIDSKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:10:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E7C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 11:09:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y6so3972634lje.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9cCKBvhWQzJ1D49VIyTebPGrZpxmsDI6MMA6+ICjqw=;
        b=HJK+uwndSZDYMHUzAH2y1VYzz3qQkff8CaYRr5jvVhT2+rmi0k+i0J+wr5bTW0pCiz
         sPI+5NNf1wFJW96mj0g6PLOostmhaZo4meoyhQw7fIIveBocpxXBQU4fJ1dr69eLoWac
         XydqvnVnJB2yWg7x8Gy8VphD1A+JJ5CU0SoZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9cCKBvhWQzJ1D49VIyTebPGrZpxmsDI6MMA6+ICjqw=;
        b=Daqv95XzblIgbGSmoZxcxOzvWFZ4a/3G08lQD+cBKK9fVp1m2NuyVx+cme04ww6HDn
         mdw6VzFBMh1uXcTqCmVrgKaCdhuiF1dZLK4QI51fvDQb0knTEw/2cniUQGqGiF4XJGKz
         5rxLepgzhlUmHMO6HV4oBZo5B0PJmt5dBrFDb4TZOhEJ8C5w2w2k4X9dDANg0mFCSNow
         zYFxe/Hr6um4UitDI4DsrCfP74xwLrPswj60eaKx9qTgQzozJDPVQNrEUUhVdHxUwtYq
         JOHz29gTnwjo+edTa7rgydtQdl3MNDHD/etrnV92gf2pza+ywP5W/NAWV9ps1rIXQl1C
         rKsA==
X-Gm-Message-State: AOAM533eTPeZ/fb9dVmYpeaNqS6BkDf3Eu0YbiTvCPXmCvX8N/3vUvjI
        LGzfVfG2hOxg1ZrLeETaxzlHjbMHgvh2tGfJ
X-Google-Smtp-Source: ABdhPJyj+4MEB/N3Inmm4bSM5CxvUFISRJ7s253OYPV7aRdYISPqxwf+Xd/JoOzrWYUS/upR/EAHPA==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr3544452lji.296.1630778956478;
        Sat, 04 Sep 2021 11:09:16 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d18sm313855ljq.110.2021.09.04.11.09.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 11:09:14 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id p38so5020735lfa.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:09:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr3726453lfu.280.1630778954535;
 Sat, 04 Sep 2021 11:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com> <CAHk-=whFAkqwGSNXqeN4KfNwXeCzp9-uoy69_mLExEydTajvGw@mail.gmail.com>
In-Reply-To: <CAHk-=whFAkqwGSNXqeN4KfNwXeCzp9-uoy69_mLExEydTajvGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Sep 2021 11:08:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbtip559HcMG9VQLGPmkurh5Kc50y5BceL8Q8=aL0H3Q@mail.gmail.com>
Message-ID: <CAHk-=wjbtip559HcMG9VQLGPmkurh5Kc50y5BceL8Q8=aL0H3Q@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: new NTFS driver for 5.15
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 10:34 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> For github accounts (or really, anything but kernel.org where I can
> just trust the account management), I really want the pull request to
> be a signed tag, not just a plain branch.

Ok, to expedite this all and not cause any further pointless churn and
jumping through hoops, I'll let it slide this time, but I'll ask that
you sort out your pgp key for the future and use signed tags.

Also, I notice that you have a github merge commit in there.

That's another of those things that I *really* don't want to see -
github creates absolutely useless garbage merges, and you should never
ever use the github interfaces to merge anything.

This is the complete commit message of that merge:

    Merge branch 'torvalds:master' into master

Yeah, that's not an acceptable message. Not to mention that it has a
bogus "github.com" committer etc.

github is a perfectly fine hosting site, and it does a number of other
things well too, but merges is not one of those things.

Linux kernel merges need to be done *properly*. That means proper
commit messages with information about what is being merged and *why*
you merge something. But it also means proper authorship and committer
information etc. All of which github entirely screws up.

We had this same issue with the ksmbd pull request, and my response is
the same: the initial pull often has a few oddities and I'll accept
them now, but for continued development you need to do things
properly. That means doing merges from the command line, not using the
entirely broken github web interface.

(Sadly, it looks like that ksmbd discussion was not on any mailing
lists, so I can't link to it).

                    Linus
