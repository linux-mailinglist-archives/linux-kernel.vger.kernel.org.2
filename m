Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96232204A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhBVTik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231397AbhBVTib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:38:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDDD564E12;
        Mon, 22 Feb 2021 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022670;
        bh=QxlYfneRY2HBN6KTXEA8fk9V3REnEK8ST+NRSecETSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTAtP66vodXx5Id4YRl0vwCatSI5W9JhzJWWumCv6O/pb+0D0n51Pd0K/IKDH7/Sf
         2cbmdDdLkas6QN0oSkiETzVXAbySDkV1DZ9Fj516V3TfG2rmf5+DYQqKj+pcZnsAym
         f/UECmj+OolANVgK0/aoTDKdaMeA8+HS0JWllCbHTvcz46qQg4SgIqxJ8xpC0Br2OO
         0b8+UzLKd4RDTONrRiBeqX1R2guRlhoTH10Geq70ZDGyM080Ro3DDrxhxS3dSFHIum
         bBBbYPodP5neobHfWt/gMut9yQfddpYE+HKyrSebIMxHezN73JO73m8W1hbDaUN2hm
         gUO40DbQKrgxg==
Date:   Mon, 22 Feb 2021 12:37:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: clang-12: tun: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err -2)
Message-ID: <20210222193749.GA2954@24bbad8f3778>
References: <CA+G9fYuE4ELVDju=LESHnphL4Z2DT5YQjdh9rNgr5D1x5gZxgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuE4ELVDju=LESHnphL4Z2DT5YQjdh9rNgr5D1x5gZxgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 01:01:16AM +0530, Naresh Kamboju wrote:
> Following test regressions reported after upgrade to clang-12 from clang-10.
> Regression detected on Linux mainline and stable-rc 5.4, 5.10 and 5.11.
> 
> qemu-x86_64-clang-12 failed test cases,
>   ltp-containers-tests:
>     * netns_breakns_ip_ipv4_ioctl
>     * netns_breakns_ip_ipv4_netlink
>     * netns_breakns_ip_ipv6_ioctl
>     * netns_breakns_ip_ipv6_netlink
>     * netns_breakns_ns_exec_ipv4_ioctl
>     * netns_breakns_ns_exec_ipv4_netlink
>     * netns_breakns_ns_exec_ipv6_ioctl
>     * netns_breakns_ns_exec_ipv6_netlink
>     * netns_comm_ip_ipv4_ioctl
>     * netns_comm_ip_ipv4_netlink
>     * netns_comm_ip_ipv6_ioctl
>     * netns_comm_ip_ipv6_netlink
>     * netns_comm_ns_exec_ipv4_ioctl
>     * netns_comm_ns_exec_ipv4_netlink
>     * netns_comm_ns_exec_ipv6_ioctl
>     * netns_comm_ns_exec_ipv6_netlink
>     * netns_netlink
> 
> Test error log:
> --------------
> [   19.017163] tun: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err -2)
> open: No such device
> netns_netlink    1  TBROK  :  netns_netlink.c:143: system() failed
> netns_netlink    2  TBROK  :  netns_netlink.c:143: Remaining cases broken
> netns_breakns 1 TINFO: timeout per run is 0h 15m 0s
> [   19.070922] veth: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err -2)
> [   19.095171] veth: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err -2)
> Error: Unknown device type.[   19.101364] ip (751) used greatest stack
> depth: 12088 bytes left
> 
> netns_breakns 1 TBROK: unable to create veth pair devices
> Cannot find device \"veth0\"
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> Full test error log link,
> -------------------------
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.11.y/build/v5.11-13-g6380656c9227/testrun/4002283/suite/ltp-containers-tests/test/netns_breakns_ip_ipv4_ioctl/log
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.11-2899-g2c405d1ab8b3/testrun/3994442/suite/ltp-containers-tests/test/netns_breakns_ip_ipv4_ioctl/log
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org

Thanks for the report. This has been fixed in -next and has a CC for
stable when it is merged into mainline:

https://git.kernel.org/next/linux-next/c/ebfac7b778fac8b0e8e92ec91d0b055f046b4604
https://github.com/ClangBuiltLinux/linux/issues/1250

Cheers,
Nathan
