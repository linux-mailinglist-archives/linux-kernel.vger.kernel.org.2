Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE132D921
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhCDR7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhCDR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:59:00 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA49EC061760
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:58:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so51179845ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8otJ+QXVNuhO+CoL5UIOP2Zpn78jb+0u14xT9NO0oaI=;
        b=I7RLdKPz+0nbiE/tPyyi3RBbc1Ko7eWuyqgqwNPZWg3uWi+MybCjsLbqkfhES0iLjh
         lYipu0bJm0/360fjG8Q+Y/f50vMIeoOUfNTcWb5uSN+cAuTO5MW11/eF2tgC6Yctw43k
         vdlE+oPrTr4SV8E7Ubi4EyRYKl7JLiba82EXBs7Ex07SGVCbDZ81mPCBxmWOP0BkyvpM
         DENEwmLdV9CcdspmvRE8yDH30lss9YVNopUq9xhIKEdj3o9YbjnYASOxdIkKKKnpscSj
         /aC5WQcLzXYQSEiyf1pyWASemsmwoyyKeERTrF7hdsJ2YMG8ZbaRF6GaO8RjNP7K+vdh
         L1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8otJ+QXVNuhO+CoL5UIOP2Zpn78jb+0u14xT9NO0oaI=;
        b=LCA62LvkICDY5LIOedSLskz+/SAva9XjyLp0RI68kUnnvXERyZ+K/XXLx6mKjCbhp9
         Kuu6L+KHlqjBLGJULp2yVP8Cekjcq0rv6VtgAoD94VE2iEhhTEQD7rmOCDmQMjhdRbV2
         Ai14GZRrQAj63TtCtv2n91s3dfl0+hA7/4+w34iLxO+czPG+/Nzcz5XysSJAEg+VUVsH
         B94SbkOgxtxg/s+UstFniOJibSpIOgZ+Myv5D0lwwwQTYJxd5H5PpeWrUsHTSnwqusPQ
         wbQU9JMA+h1olf3TvdTmc6LkmJPjDNGYk0sEvbQZ1BpCNHfJtJTm7OU8sigpWZ2yrNDX
         D2Ow==
X-Gm-Message-State: AOAM531XQ3ioPGfiRml89R/G2ZG0untjCI80SHBxY5ASWrC0gfeGibiv
        Aolm/UL+xsLoejMjQMKubbnFXHN6zK2zojGrhPgfFw==
X-Google-Smtp-Source: ABdhPJwP32cWgTZhbgugyJHSgv+e/cuMqlUseyqjVdSzyz0wZa2hqLQIEzpOesuCH/cL407aI0R8O8N+dZ0/euh/NRU=
X-Received: by 2002:a17:906:d8ca:: with SMTP id re10mr5665674ejb.18.1614880698539;
 Thu, 04 Mar 2021 09:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20210302192719.741064351@linuxfoundation.org> <CA+G9fYvkW+84U9e0Cjft_pq9bGnBBqCXST7Hg+gx4pKNyuGPFQ@mail.gmail.com>
 <YEDDIzz32JqSvi1S@kroah.com> <20210304165247.GA131220@roeck-us.net> <YEESn1JboVRjfJGN@kroah.com>
In-Reply-To: <YEESn1JboVRjfJGN@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 4 Mar 2021 23:28:07 +0530
Message-ID: <CA+G9fYuDQ9Ph8-Y3dRzNi7odmcLX4shE5rbCvHekn+wTnzj4Dg@mail.gmail.com>
Subject: Re: [PATCH 5.11 000/773] 5.11.3-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 at 22:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 04, 2021 at 08:52:47AM -0800, Guenter Roeck wrote:
> > On Thu, Mar 04, 2021 at 12:23:15PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 03, 2021 at 02:02:20PM +0530, Naresh Kamboju wrote:
> > > > On Wed, 3 Mar 2021 at 00:59, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > This is the start of the stable review cycle for the 5.11.3 relea=
se.
> > > > > There are 773 patches in this series, all will be posted as a res=
ponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Thu, 04 Mar 2021 19:25:07 +0000.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-revie=
w/patch-5.11.3-rc3.gz
> > > > > or in the git tree and branch at:
> > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable-rc.git linux-5.11.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > >
> > > > Results from Linaro=E2=80=99s test farm.
> > > > All our builds are getting PASS now.
> > > > But,
> > > > Regressions detected on all devices (arm64, arm, x86_64 and i386).
> > > > LTP pty test case hangup01 failed on all devices
> > > >
> > > > hangup01    1  TFAIL  :  hangup01.c:133: unexpected message 3
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > This failure is specific to stable-rc v5.10.20-rc4 and v5.11.3-rc3
> > > > Test PASS on the v5.12-rc1 mainline and Linux next kernel.
> > > >
> > > > Following two commits caused this test failure,
> > > >
> > > >    Linus Torvalds <torvalds@linux-foundation.org>
> > > >        tty: implement read_iter
> > > >
> > > >    Linus Torvalds <torvalds@linux-foundation.org>
> > > >        tty: convert tty_ldisc_ops 'read()' function to take a kerne=
l pointer
> > > >
> > > > Test case failed link,
> > > > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.11.y/bui=
ld/v5.11.2-774-g6ca52dbc58df/testrun/4070143/suite/ltp-pty-tests/test/hangu=
p01/log
> > > >
> > >
> > > Thanks for testing them all, I'll try to debug this later today...
> > >
> >
> > Did you see my response to v5.10.y ? It looks like two related patches
> > may be missing from v5.10.y and v5.11.y.
>
> I did, thank you, I need to get through some other tasks first before
> trying the reproducer and see if the patches you list fix it or not...

I have applied those two patches and the reported problem did not solve
on v5.10.20.

- Naresh
