Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3D33C3507
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhGJPCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhGJPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 11:02:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA828C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 07:59:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l2so18845813edt.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iwTsN5XOKXGhzX4XQB3p4yZQwijxEvvf7WDBj5MTa9A=;
        b=UZR7w0fUXOBaXILPOT6PxJCRyaCG+vo4HEC7wf6nVb1nO/MVCduuCzWZzrduiRdprX
         9wmIzTxnu4/qog/8zxgcLvVHY7FYCb4o3ea3XF7UiEi9fi9C6Uqpmp0rUmRzeUtcdM2J
         zt+eVvDISVMwdzZiIqMcmXgDYio3GhzTD7XiIlKxp44oFAgeat/G0FQKMNHiubUAEslR
         WsM+jJx/lZRyqQYlMt54+x6RMaiLgWTMM0bXAhWFL326DR9bQJdNJN8DxV4mOAkcT0Qi
         usBJpO/xyHjKpjLuSrrswdI4DARn6S7QQpPJE057xKQlV81/igb5fZjxaRxcI4hSiL8a
         WLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iwTsN5XOKXGhzX4XQB3p4yZQwijxEvvf7WDBj5MTa9A=;
        b=FjPrxDP+Rjl/GUMrXgLe+AufmtwwVY9ftiJVtHv9pcWu8WAvAQKVYcMvZRn2uZONyi
         eIBmEwQtprDO3HExCaMz2xchg8ir+cNdrIxpqhAZUhUddP1KEFDmVEsCsmn91Ifj9Vwt
         YLNQ4mMTWw5pb2OizK7J21sVV+71CXCeAVnDzHZT0gXK5fpqmeSi980ZiTnbzTvzrRYh
         jGfXpPw5hVGH+a0ToCK/OU5iDDmzy3SzfuETqEiSs1eaVLrmrEaQ5tENjV0NxehoJzf+
         90O9IXDhSOEFKx2KoQlMrv5fg9Kf4HpR02nIJ0h/VINeZSgap7Ue6EJAF6k9o3QzL/Ee
         ZZZg==
X-Gm-Message-State: AOAM532YJhJiiCAJYsaNX6UrxYuUEaJtRzMKoxkbRCx1s/DGcK7lMazg
        T/uA7X/8FrqHD3EUIQdumolFuaPk/fRIzK0qPpC6QA==
X-Google-Smtp-Source: ABdhPJwEISgCDO6/PMaZvrOPVUKQiplGmAwbZYCHwVAalCGrawZ22ynWE1pg8CCGrCpGnuERXiXNA/32bRarctOdYDA=
X-Received: by 2002:a05:6402:90a:: with SMTP id g10mr54186908edz.365.1625929181816;
 Sat, 10 Jul 2021 07:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210628144256.34524-1-sashal@kernel.org>
In-Reply-To: <20210628144256.34524-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 10 Jul 2021 20:29:30 +0530
Message-ID: <CA+G9fYv6u7fWHqz6-5Wk9iAk0D5eSSDQEAO+FW_0RS30Yuix=g@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/57] 4.4.274-rc1 review
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 at 20:16, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 4.4.274 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 30 Jun 2021 02:42:54 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-4.4.y&id2=3Dv4.4.273
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha


Results from Linaro=E2=80=99s test farm.
Regressions on arm64 noticed compared with v4.4.273.
GOOD: v4.4.273
BAD: v4.4.274

Regressions found on  arm64 juno-r2 and qemu_arm64 device.
ltp-containers-tests failed:
- netns_comm_ip_ipv6_ioctl
- netns_comm_ns_exec_ipv6_ioctl
- netns_comm_ip_ipv6_netlink
- netns_breakns_ns_exec_ipv6_netlink
- netns_breakns_ns_exec_ipv4_ioctl
- netns_netlink
- netns_comm_ip_ipv4_netlink
- netns_breakns_ns_exec_ipv4_netlink
- netns_breakns_ip_ipv6_netlink
- netns_breakns_ip_ipv4_ioctl
- netns_comm_ns_exec_ipv4_netlink
- netns_comm_ip_ipv4_ioctl
- netns_comm_ns_exec_ipv4_ioctl
- netns_comm_ns_exec_ipv6_netlink
- netns_breakns_ip_ipv6_ioctl
- netns_breakns_ip_ipv4_netlink
- netns_breakns_ns_exec_ipv6_ioctl


Test output log:
-----------------
module tun: overflow in relocation type 261 val fffffdfffc000654
open: No such device
netns_netlink.c:103: TBROK: adding interface failed

netns_breakns 1 TINFO: timeout per run is 0h 15m 0s
module veth: overflow in relocation type 261 val fffffdfffc040000
module veth: overflow in relocation type 261 val fffffdfffc080000
RTNETLINK answers: Operation not supported
netns_breakns 1 TBROK: unable to create veth pair devices
Cannot find device \"veth0\"

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


We have started the git bisection script to find the first bad commit causi=
ng
these LTP netns test failures.

--
Linaro LKFT
https://lkft.linaro.org
