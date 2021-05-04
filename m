Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4143732A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhEDXG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 19:06:29 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:39530 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhEDXG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 19:06:29 -0400
Received: by mail-yb1-f169.google.com with SMTP id z1so230534ybf.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 16:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvfEJxx8T5Gfb4a+lHvIlRpfFqDd/U5kxfg9D9O09eY=;
        b=iQgdt7g+Lq7U6bEq7BsRpjV3hoIlERNFZrC9yLZfqsq9wVTlGzCBX6OQ7uT5LCBf/o
         T2kVHbp1IuD3oqTOQnTtX+ZoNeqP88eGkvqa4mrjtVitbnHSuYuySxwzr7XZfBp//4CM
         kzSSyU1x6K/GBBEorJp98eor9yvZfCQFkrr/7efTfAo0ZR5yNsQlHX6uacURPWP3eBfG
         bDns/cbkalcVbqvlvSCTuTzfJD57S+d2dVN1pkCIqsjewYJMOK0YGNT5FXBPhszkLIC8
         1QqxkgXbgMlgEGIOul+PrQJWgIZSCpHeuzXzv8wxDdRR7GRyb6akI/F1mdj4ZirmwNcw
         IR8A==
X-Gm-Message-State: AOAM533MKCZGojZ7zh39VRWaZyMO98Q/kgvfpFQS5dzstsTQ6E4LhfKL
        wKKEs642M1onpLDOyZJ58/tu1nzXC1AX6PPCiYw=
X-Google-Smtp-Source: ABdhPJyFVsMqrnR6x8IusJFQG/jF2WyzHDJgRmzBvPLGzHsLYzJQWw41sT7jkiUxcF/LHIbYy8fC+7DQvf0rZc7kRwA=
X-Received: by 2002:a25:bc08:: with SMTP id i8mr36987237ybh.146.1620169533255;
 Tue, 04 May 2021 16:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <alpine.DEB.2.21.2105020346520.2587@angie.orcam.me.uk> <YJAK1C1uLknYGYrH@mit.edu>
In-Reply-To: <YJAK1C1uLknYGYrH@mit.edu>
From:   Greg Stark <stark@mit.edu>
Date:   Tue, 4 May 2021 19:04:56 -0400
Message-ID: <CAM-w4HOJqDUyK9HXjtqD3K2ja1Wt=u2s5waQ1wqm7jHy0P5V-A@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 at 10:39, Theodore Ts'o <tytso@mit.edu> wrote:
>
> That was because memory was *incredibly* restrictive in those days.
> My first Linux server had one gig of memory, and so shared libraries
> provided a huge performance boost --- because otherwise systems would
> be swapping or paging their brains out.

(I assume you mean 1 megabyte?)
I have 16G and the way modern programs are written I'm still having
trouble avoiding swap thrashing...

This is always a foolish argument though. Regardless of the amount of
resources available we always want to use it as efficiently as
possible. The question is not whether we have more memory today than
before, but whether the time and power saved in reducing memory usage
(and memory bandwidth usage) is more or less than other resource costs
being traded off and whether that balance has changed.

> However, these days, many if not most developers aren't capable of the
> discpline needed to maintained the ABI stability needed for shared
> libraries to work well.

I would argue you have cause and effect reversed here. The reason
developers don't understand ABI (or even API) compatibility is
*because* they're used to people just static linking (or vendoring).
If people pushed back the world would be a better place.

-- 
greg
