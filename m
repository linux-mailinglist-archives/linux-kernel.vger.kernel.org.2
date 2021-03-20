Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805DF342D10
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 14:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhCTNWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 09:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCTNWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 09:22:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD07C061762;
        Sat, 20 Mar 2021 06:21:51 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id v17so9081445iot.6;
        Sat, 20 Mar 2021 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCOjc0tcqOTnDsStbeZc6I4mtJqZyPE6ypRSG5G1MfU=;
        b=lTm+JHYVhc6j2CCXKqCWkv2eHWJ6IJsP4sIIp871trHteNWSDDuFg2T08gTq5bdthf
         lR2M/CWir8bvR7r4KLYoRMo6wshYnqSGgxtpESzcPozkMjE6EUwIgZYBfx6hWluLr7fp
         GqFrZa3oyJ8C1boZC4pSx6hGJoL/sxVzG8/396X1uyWsZgtMRGkvzm3y5Q8GM5RNbjxI
         jpvd7TSABaC1sW8eRtUFIJGsL5VlZxGRN66J0nW/JTnXu6AEIm25rDKreQfUWfR+XmOL
         /D1S74ZQ/O9nQliZPF2Xvhvh6ffatdKe1Y4cKA+5n9IqJGD9S9L29DSpJSzxefymIQz1
         vZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCOjc0tcqOTnDsStbeZc6I4mtJqZyPE6ypRSG5G1MfU=;
        b=sXQYOnmdoHoChh4ddBccy9AA6vnK14u1PUv5EoTWg7fjllxMosPtSiKFGCBnswds72
         H3FHguufRSaJY5QurQUJDXs1aD+nfYENp70LRXKLL0OdeQ1zjBcRG036J3aL4XbtHWyq
         NG7vGW11Db3r1XCZivZ7HwBqK7Cpx++SByWEctCqMxtf5zDcAwrpOL2jlonH01i7LTrJ
         HzyWZ085I3fWBr6gunCCEzLWCN9whIt3+vVQG2JHd6pl4FejXQ2itNq6EOF8tlJZqW6H
         j/csPgJ5ndYNqHvRW6ZV86edanMxe4c/0VpJnsshWdHMvLls8TruEF6kmszzTGLJdrnL
         FMqA==
X-Gm-Message-State: AOAM532oQjSOiy8lLsL3sEG/Em5NboUfQD5h8CpebhPBDm4TR16jVTKK
        nLvmrDWoYjI4d2qsRqc4sF7Ts8GmIdggnjztwCIinX5eE2I=
X-Google-Smtp-Source: ABdhPJzUtJgxvFkyPVHwFPLYLYWuKCv8cgnqpNG+Q7bRPRwPW9SsoGxHRxMfHlZoCSVXTxZFFYrnnthdSTKjJxXn2Gg=
X-Received: by 2002:a02:6a14:: with SMTP id l20mr5212666jac.12.1616246510459;
 Sat, 20 Mar 2021 06:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210309125324.4456-1-yashsri421@gmail.com> <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com> <871rcg2p8g.fsf@meer.lwn.net>
 <CAKXUXMzwTp1H_vokVEAJSnmm7jNHfWzhhmLfpcrrBD9b8ak+dA@mail.gmail.com>
 <878s6kto3g.fsf@meer.lwn.net> <CAKXUXMxWOvM5HRwmAAWEsqQc2k6_ReqRw0uD=VANLO5D7OpFtg@mail.gmail.com>
 <87o8fgpbpx.fsf@meer.lwn.net> <99a21e10-266e-b997-7048-c29a570afe0b@gmail.com>
 <30051ed8-33e4-a303-199c-f4bdcb0e448a@gmail.com>
In-Reply-To: <30051ed8-33e4-a303-199c-f4bdcb0e448a@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 20 Mar 2021 14:21:39 +0100
Message-ID: <CAKXUXMyQRY9GC7sUG+_W5hQe3EFdvxKrYTEO7JL3E5LD3cCPKQ@mail.gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Markus Heiser <markus.heiser@darmarit.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 1:45 PM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> On 20/3/21 12:23 pm, Aditya wrote:
> > On 18/3/21 11:48 pm, Jonathan Corbet wrote:
> >> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
> >>
> >>> Yeah, and as this line-counting is really just a poor man's
> >>> heuristics, we might just be better to really turn this heuristics
> >>> into a dedicated cleanup warning script, then we can check for more
> >>> indicators, such as "does it contain the word Copyright" somewhere in
> >>> the kernel-doc comment, which tells us even more that this is not a
> >>> kernel-doc as we would expect it.
> >>
> >> I really don't think we need that kind of heuristic.  The format of
> >> kerneldoc comments is fairly rigid; it shouldn't be too hard to pick out
> >> the /** comments that don't fit that format, right?  Am I missing
> >> something there?
> >>
> >> Thanks,
> >>
> >> jon
> >>
>
> Hi Lukas and Jon!
> I have a question, should I clean up the files with '/**' like
> comments in only header lines? Or as we are planning for making it
> generic, for other lines as well?
>

Aditya, of course, if you can detect and come across some unintended
'/**' comments in some files, clean them in the same go (as you did
with ecryptfs).

I am just worried that if you extend it to the fully generic case,
that the list of cases simply explodes: showing many 1,000 cases
across various 1,000 files that need to be cleaned up, and such
clean-up work is just too much to get done by yourself.

The current list limited to comments in header lines seems to be a set
of patches that you can probably get done.

Lukas
