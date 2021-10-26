Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8243B879
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhJZRql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhJZRqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:46:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B429C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:44:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so15452518edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tmXVzuh5dkyrAII+ZVrZrBIPLN2O4THznBgHQCPFnbQ=;
        b=Dqi3PP/SSAWFWG3gfFkOGyGSEegQad3EgGyE34NDLLAELVK50eCq1MDlOhgmBPwOU6
         so2oMwx8riSKbOO2mzEapG+9A6CRdtzRiSu3Y2NZ918aQTUcvOnEQBpUTC0i7yFT18qw
         XvmE3p37xBMf/1zXADOuvDJFF8+rbErRKKvQ6WrLtvKyH7G9Jp1nujOWNxj50IVXj1wm
         BpYRzv7tWEq4TDOG+41TYA22vLr1Kg734dVaWfNKDwROR+iCblGttPlsJw1JRqIkUDFg
         EF5y6WjI+0R4VxsGN6ksjPs0HRVys6LuGpN9HdX8BTjsZwe4H7dpGfgVwHlCsQhkgT0U
         TA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tmXVzuh5dkyrAII+ZVrZrBIPLN2O4THznBgHQCPFnbQ=;
        b=tI5F5UZ/RtNWcI46B7oacGAGpfjkQXw7s52GoF6ctzXb+ZC6gfsadx/o0Gs/VeBnUG
         IAgXST/d0VDlumMZbTSjm/pi+36vxXi9QyrI/UjE/FXvSC5GbMUaathZHKZ915iZT1g0
         tYATjmXQAA6NEiqGEA57fhHHAU1fMvw5C380ok8CFuhgKBYA9e2eSb0VNaKltQbnaAaG
         PW9AjjWmeGE9m8gy1PMmjLavBuAQCekjtO7HIn1XRUlX5v1AmWW5G+p0oaG7v9EGN+B9
         mvwA8Y9dCZpZpR/ew0gmmksmYMt36CrEJuxk6VF98XV0RlBbTV93MC8HeqnpJVfOTEG+
         RW/Q==
X-Gm-Message-State: AOAM531Tz6CI28s2hGLZEPozOmJqECy3899izlbBUe3BDxFxtnXMF376
        M43+fViSGGkToKS7uNn+cNmVvtbTDdQD9dIhSlaMIpY6cXgJjA==
X-Google-Smtp-Source: ABdhPJzpc5E2MH0dqfxYAdQeV4sDDHg8gxDgPhXTBuOBsaV+P2Ti1CzuJ28DAy8IRpeA3OQ6rZ34ANCraRU5f+j8IkI=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr23553041edu.357.1635270254187;
 Tue, 26 Oct 2021 10:44:14 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Oct 2021 23:14:03 +0530
Message-ID: <CA+G9fYuAuu3vXMh_Re9Vcrne2BvAbJz=zujeoh5NQ8qmQqs2Mg@mail.gmail.com>
Subject: parisc: sched.h:2138:38: error: 'const struct thread_info' has no
 member named 'cpu'
To:     linux-parisc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please ignore this email if it is already reported ]

Regression found on parisc gcc-8/9/10 and gcc-11 built with defconfig
Following build warnings / errors reported on linux next 20211026.

metadata:
    git_describe: next-20211026
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: 2376e5fe91bc (\"Add linux-next specific files for 20211026\")
    target_arch: parisc
    toolchain: gcc-10

build error :
--------------
In file included from <command-line>:
/builds/linux/include/linux/sched.h: In function 'task_cpu':
/builds/linux/include/linux/sched.h:2138:38: error: 'const struct
thread_info' has no member named 'cpu'
 2138 |  return READ_ONCE(task_thread_info(p)->cpu);
      |                                      ^~


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
-----------
https://builds.tuxbuild.com/202T6V9WW7HdyiYW1pERBsc94FT/build.log

build config:
-------------
https://builds.tuxbuild.com/202T6V9WW7HdyiYW1pERBsc94FT/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch parisc --toolchain gcc-10
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org
