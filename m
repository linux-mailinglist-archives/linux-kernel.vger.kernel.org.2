Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442D833C695
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhCOTNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhCOTND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:13:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46371C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:13:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r3so50453854lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETITyohOMGTA5c4SIeM+KSc+vnY0j80+gbmDYG75nz8=;
        b=eUXS+eYjf+Yk/kl3W0OvWXfvjkkqHNRrjwdTH5TwORbKwcYVFwXMs9SmogjPXwISOy
         yvExM7tfpgvqw52fRnOOZ6TV1JmLafFLHrtyyX6WiqdPFAHBille72a5D4sWCa/Tx+yH
         tg9SxqVJrMSQftrhwh2aK0lNjc9j0s0vIvTU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETITyohOMGTA5c4SIeM+KSc+vnY0j80+gbmDYG75nz8=;
        b=RicZs/U26uQpjCGijYh7YF1P42l6psQyCVd6DeABnw2HSgbdgE19FY7fuz53qIDjOK
         pOM3V2IulZ7N27hoh3TmQwvMzjAfT0T/r1azvKZsvdA5VqfJK95GG0nEpBScfNekA1v0
         DPfcj1YeZ4IOfJ/eTAy5c7K1XBGLEYPGbr+refamgiL5DPQ1qZ/LnTduTUpb2QIIHZeg
         Gr3UeYcXofsmiV1g8RVJZW/9PmOCRf8z7hdSl+NADg9sVKS0TDEMW0BOzbsazsC1Qit/
         gcM0lVF81SFV3ZQyvwYo8TcPZyOScqH1LfvW+AP7OzyBaa+ytZxERdy3j/4QQnKwXPWr
         vJGA==
X-Gm-Message-State: AOAM533II1ALHUE+HoWNFB1rIz7aDdCivcxMnYtxHwiAm6EZZJcpiqLo
        few3LJLHH4uqTBROykvs7+nMzhl008J/1w==
X-Google-Smtp-Source: ABdhPJyMa4TKsho887Y1Ye2jNO5JQK1/cIGISBCzmGsYnGf1fYKqLaUp2xhce1UrHwqGjPbs47oJig==
X-Received: by 2002:a05:6512:ce:: with SMTP id c14mr9002595lfp.64.1615835579256;
        Mon, 15 Mar 2021 12:12:59 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 197sm2992299ljf.70.2021.03.15.12.12.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 12:12:58 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 18so58579063lff.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:12:57 -0700 (PDT)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr8614258lfy.377.1615835577584;
 Mon, 15 Mar 2021 12:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <202103120329.VU4uJ0yZ-lkp@intel.com> <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
 <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com> <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
 <09373c3d-73e8-933a-24ad-5c4ba4fdc615@intel.com>
In-Reply-To: <09373c3d-73e8-933a-24ad-5c4ba4fdc615@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Mar 2021 12:12:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0DY=cE-6Tjp_Dt32UC6XtMZBa0Rr2GqkK=Sh9HE=5kQ@mail.gmail.com>
Message-ID: <CAHk-=wg0DY=cE-6Tjp_Dt32UC6XtMZBa0Rr2GqkK=Sh9HE=5kQ@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH] gcov: fail build on gcov_info size mismatch
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 7:32 PM Rong Chen <rong.a.chen@intel.com> wrote:
>
> It can be reproduced with '-a' option in dash:

Oh, ok. That kind of explains it.

'dash' is trash. Please somebody make a bug report.

>      $ a="!"
>      $ [ "$a" = ".size" ]
>      $ [ "$a" = ".size" -a "$b" = ".LPBX0," ]
>      sh: 2: [: =: unexpected operator

This is 100% a dash bug. There is no question what-so-ever about it.
This is not some kind of "POSIX is ambiguous", or "the handling of
'-a' is complicated".

It's simply just that dash is buggy.

>  While dash supports most uses of the -a and -o options, they have
> very confusing semantics even in bash and are best avoided.

No, they have perfectly sane semantics in bash, and in POSIX.

See

     https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html

and there is absolutely zero question that bash does this correctly,
and dash does not.

But yes, it seems to be easy to work around, but still - could some
Ubuntu person please open a bug report on dash?

               Linus
