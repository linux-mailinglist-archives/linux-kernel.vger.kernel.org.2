Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7653322036
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhBVTeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhBVTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:32:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94378C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:31:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j9so23506346edp.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rfD3SQQQMFNXhoku1DuM9YNETkjiInlQqLxzMPB+06o=;
        b=YpHljT4Ga2eO3EY/dNO9BmFJwzZeGSfTks8A+bBFwniD2PfwOHKnZt6sAdWuJBLxpW
         0OaruBiNpdFIXCpMgB9QxDmmmrdAdT7PdxZV/gu8bq09KfMW5K9ug3RjgfPXEaEbh7y7
         SVgmBjkr6IfzaLIC6F6azYUp51aK+9WBC1vKYVPhwOsOKdi2uCGAcm+NVeZbTJNTOrEP
         3S5AOkp4tUG0XFEUjRpedkO03k92eL05PecdiCk78tqDs+IbqrMZ2ToKYtIFsJThRuPn
         rj545Zxxy336D3wzJEGaHgW5ddiVVhVntitnKGcafGFqFwWQltTcxRQXN7Owj7FVDyNG
         ooQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rfD3SQQQMFNXhoku1DuM9YNETkjiInlQqLxzMPB+06o=;
        b=Ul8Sen/QUAz2acgATOBV+A6CRg59jcvA6McZl0eMfX4qOazw8f2Yxz++tsOO8gtjn3
         1R+zXuewzLw6QysEXpZkd2VEF5fhJ9cgblnrq41EQL073qDmHV/0HK7wndc7RnOFXPLZ
         8h93iBEqW6u/lhEiW9tEe4pu+QlOKavtRBW9z/jVYWmIYTf8jDY4izTkUKw4OSCgIBRF
         NIGoXxjNooYVV2pIQGva4iGjKsiI32VCvoBty/JALOTw2G7n+wCTc8UfCUd7Iub7nZAZ
         xo1cvQ88+NCkpNYNSdls02WFA229Gx+f/CR3EhDrjbhvHeLtke3Dxwg10/vd8seUnhUk
         uN1w==
X-Gm-Message-State: AOAM531zzBJrDkWkLORJFjVvSJ+WhCItAJvO6L16IBfNKb56gNrx+bn1
        znWAC866P5kLmGXtlJ+U/yJqvrHcE1h16LpN9Wnh2g==
X-Google-Smtp-Source: ABdhPJz1ZSe8d/8OXHSAuecImATRhx4QxBYS0eX7KL1GhhMNUsOQ8MrKRTrhZ6b6E8E1Gk3qkaRCCDc87fL8iZQ0jgw=
X-Received: by 2002:aa7:d38b:: with SMTP id x11mr24007272edq.23.1614022287226;
 Mon, 22 Feb 2021 11:31:27 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Feb 2021 01:01:16 +0530
Message-ID: <CA+G9fYuE4ELVDju=LESHnphL4Z2DT5YQjdh9rNgr5D1x5gZxgg@mail.gmail.com>
Subject: clang-12: tun: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err -2)
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, X86 ML <x86@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following test regressions reported after upgrade to clang-12 from clang-10.
Regression detected on Linux mainline and stable-rc 5.4, 5.10 and 5.11.

qemu-x86_64-clang-12 failed test cases,
  ltp-containers-tests:
    * netns_breakns_ip_ipv4_ioctl
    * netns_breakns_ip_ipv4_netlink
    * netns_breakns_ip_ipv6_ioctl
    * netns_breakns_ip_ipv6_netlink
    * netns_breakns_ns_exec_ipv4_ioctl
    * netns_breakns_ns_exec_ipv4_netlink
    * netns_breakns_ns_exec_ipv6_ioctl
    * netns_breakns_ns_exec_ipv6_netlink
    * netns_comm_ip_ipv4_ioctl
    * netns_comm_ip_ipv4_netlink
    * netns_comm_ip_ipv6_ioctl
    * netns_comm_ip_ipv6_netlink
    * netns_comm_ns_exec_ipv4_ioctl
    * netns_comm_ns_exec_ipv4_netlink
    * netns_comm_ns_exec_ipv6_ioctl
    * netns_comm_ns_exec_ipv6_netlink
    * netns_netlink

Test error log:
--------------
[   19.017163] tun: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err -2)
open: No such device
netns_netlink    1  TBROK  :  netns_netlink.c:143: system() failed
netns_netlink    2  TBROK  :  netns_netlink.c:143: Remaining cases broken
netns_breakns 1 TINFO: timeout per run is 0h 15m 0s
[   19.070922] veth: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err -2)
[   19.095171] veth: Unknown symbol _GLOBAL_OFFSET_TABLE_ (err -2)
Error: Unknown device type.[   19.101364] ip (751) used greatest stack
depth: 12088 bytes left

netns_breakns 1 TBROK: unable to create veth pair devices
Cannot find device \"veth0\"

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Full test error log link,
-------------------------
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.11.y/build/v5.11-13-g6380656c9227/testrun/4002283/suite/ltp-containers-tests/test/netns_breakns_ip_ipv4_ioctl/log
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.11-2899-g2c405d1ab8b3/testrun/3994442/suite/ltp-containers-tests/test/netns_breakns_ip_ipv4_ioctl/log

-- 
Linaro LKFT
https://lkft.linaro.org
