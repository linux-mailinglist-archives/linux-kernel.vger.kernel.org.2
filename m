Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78833C810
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhCOU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhCOU6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:58:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:58:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 15so17929131ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Gws+gEAPzAxYfrRQwqDKewKbX80S4jZnS6vikGwglJk=;
        b=IeoRTuXOWpLBFpGSSswcLrO3VzlTKlqDhlP+sriejTxdrukWDsBOx/iuc9Tsv7KTX7
         KYxFOTAPwdkCZ4HxXWtTnSOhFWIxryjTcFVUQmSv3D5h40x5CEemQWcwR4eyxHN0ryHF
         YS4BehP9Dvd5MWtrnPHd9hnHOzwtR4cChpoVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Gws+gEAPzAxYfrRQwqDKewKbX80S4jZnS6vikGwglJk=;
        b=qbGs9jlea2WfitaBPijCQ1T7PoEipLyWiBIp75RiUVZJhzXf0MOhMFfXkId4cUAkBh
         vzJnpr0CLH30LTfbX6+LfyVSmuWEcwFV+Iy2I/zw1QA5C+sToA4YqIQv6QVUeHkIIPlc
         qI+Q3A8DpE2ffgmEWmLi6iKXsaSdi4dNWebF3Q7LBmfRYpMGPdRFS1Zb/8BKBZ065hDo
         ej3ASeA5Ci/1AUFhR7/Ksoh8rU3AqJBQWwXCiXJJHRDMgYK7kPhtLVMxklnZqgaNI4ND
         lf2XtEKu8+g3RSBHPNQi3SAROSGUmoCa81yOY+wUxptqu663hT40ACyh39q5ivK6ifdr
         DLuw==
X-Gm-Message-State: AOAM532VVeIIZH5xXL5oFoLWVsGUr6W+5Oo6aTldsoeoZ/PjwpTrMNcP
        3/MQ9l5+IF45SXnvEr8z72PvNJCuVS4rTA==
X-Google-Smtp-Source: ABdhPJxafmFsCpxHkDYrSnr4rhsDOin6mTDxzfCQ1K9fDFwxciJxd9s6yEa2Uh+jcvZU8BP3CukiEQ==
X-Received: by 2002:a2e:8959:: with SMTP id b25mr528669ljk.245.1615841896085;
        Mon, 15 Mar 2021 13:58:16 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id m7sm2742670lfg.285.2021.03.15.13.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 13:58:15 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x4so52347540lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:58:14 -0700 (PDT)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr8634354lfu.41.1615841894494;
 Mon, 15 Mar 2021 13:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <202103120329.VU4uJ0yZ-lkp@intel.com> <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
 <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com> <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
 <09373c3d-73e8-933a-24ad-5c4ba4fdc615@intel.com> <CAHk-=wg0DY=cE-6Tjp_Dt32UC6XtMZBa0Rr2GqkK=Sh9HE=5kQ@mail.gmail.com>
 <YE/ERLHBdjJ19TYT@audible.transient.net>
In-Reply-To: <YE/ERLHBdjJ19TYT@audible.transient.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Mar 2021 13:57:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6OiV_sSZbqz-ZPnL7=NboN-3VQYM6brVCfq2px0EAqg@mail.gmail.com>
Message-ID: <CAHk-=wj6OiV_sSZbqz-ZPnL7=NboN-3VQYM6brVCfq2px0EAqg@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH] gcov: fail build on gcov_info size mismatch
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 1:32 PM Jamie Heilman
<jamie@audible.transient.net> wrote:
>
> fwiw, https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=850202

Yup, that seems to be the exact same thing from 4 years ago.

But it looks like nothing ever came out of it. It probably stayed
within the Debian bugzilla, and didn't go to upstream dash
maintainers.

It does look like dash is actually actively maintained, and it's even
a kernel maintainer that does it: Herbert Xu seems to maintain the
dash tree and I see commits from January.

So maybe we can get it fixed by just cc'ing Herbert.

Herbert, easy test-case:

    $ [ "!" = ".size" ]

works, but

    $ [ "!"  = ".size" -a "b" = ".LPBX0," ]

causes

    dash: 6: [: =: unexpected operator

because for some reason that "-a" ends up (wild handwaving here about
what is going on) re-parsing the first expression, and ignoring the
quoting around "!" when it does so.

I verified that the bug still exists in that current dash source tree,
but I didn't dig any deeper than that "wild handwaving guess" as to
what is actually going on.

                Linus
