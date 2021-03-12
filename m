Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF42339593
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCLRxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhCLRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:53:19 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0021DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:53:18 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y1so7836808ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvzU3ku1cX88BhdKq0kAksjEj4GXqJMRVkJC6RIvqcg=;
        b=C5z3zA+p0A+wStGFn4QI5vWidY+DJ1pOk42St+Ak28nJfNF4NzPDl10t+g4ECx+QT3
         9wxff1g2/+QfhHuK5gosVrq2DBq3oGCfy292LdbFHCVDjAFaJwoIt3GAyoR9ZfyPmKsQ
         McSNEPMaNEQ+7xYsUSNaRvpQ0/qbn6FZhYJS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvzU3ku1cX88BhdKq0kAksjEj4GXqJMRVkJC6RIvqcg=;
        b=fNPAOYSbZpNzn+uN6WiS3YrnrYShN4pAzw9dQb1Wa3zHshTMld4xxduMq7L3fI6aVv
         /a+/Gv58iosPeK8k6XbbDnPrF/j4GFFCiuz1Wd6gqcWR7h6u3/7j//6vA1EarwE53Bk8
         UnGGJBYpVPDjqMJ53KXigBJn/pmQYvwG0tJA26LYMkFIrQPrujCcqgvJmshCQOkDoL0y
         gohDmKSx0lMEsdhe5fGo5NMip3+r2B18A3p6dBAeJ52EbyXcpQpkzZuBjd/hpWF54OjX
         l1beaibHD3ZjZeQR49SvAKmDrHZZBBMKnxdZegpsMnJIactiAGEPDpzymibYDWW6ZEZg
         UT8A==
X-Gm-Message-State: AOAM533bRbRayBFTmLXXILUINNToGpJO6nDF01yUace8M+EPff2oYadn
        WAvjY2icYFGHBffjwTc1Ey8SZdBUgOEWig==
X-Google-Smtp-Source: ABdhPJz4HX9gioMtV6WA1XMOEOckxRPjqHhmGtAj5Kgc3w5H5LOOlyfIdDMBHVQVZdmIl0g0ZgEMhw==
X-Received: by 2002:a2e:924e:: with SMTP id v14mr3149058ljg.362.1615571596908;
        Fri, 12 Mar 2021 09:53:16 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p18sm2046082ljo.75.2021.03.12.09.53.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 09:53:16 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id u4so47136778lfs.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:53:15 -0800 (PST)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr207519lfo.201.1615571595634;
 Fri, 12 Mar 2021 09:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <202103120329.VU4uJ0yZ-lkp@intel.com> <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
 <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com>
In-Reply-To: <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Mar 2021 09:52:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
Message-ID: <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
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

On Thu, Mar 11, 2021 at 7:50 PM Rong Chen <rong.a.chen@intel.com> wrote:
>
>
> The issue is from a=!, and [ "$a $b" = ".size .LPBX0," ] can avoid the
> error.
>
> + [ ! = .size -a ABI = .LPBX0, ]
> ./kernel/gcov/geninfosize.sh: 13: [: =: unexpected operator

But that's not what the patch did.

The patch used quotes around $a, so "$a" should still be fine.

See:

   [torvalds@ryzen ~]$ a="!" [ "$a" = ".size" ]

is fine, but

   [torvalds@ryzen ~]$ a="!" [ $a = ".size" ]
   -bash: [: =: unary operator expected

and the patch I saw, and that the test robot replied to, had that
correct quoting, afaik.

So I still don't see what the test robot is complaining about. Was
there an earlier version of the patch without the quotes that I didn't
see?

Or is the shell on the test robot doing something really really odd,
and it's somehow nds32-specific?

                Linus
