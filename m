Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85FF3CA594
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhGOSjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGOSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:39:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F12C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:36:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x17so9474732edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=py0H+k5h/ZuAsiNBGfoJ/fJ9Xrc4RVo0tGcEIp7wr58=;
        b=GPcikvq6JdId9Y04B2RPX1yex35xMhtxZFYlfw/jodPrrHcoichfTJ2kQUHd+6/BTu
         4rN7gqkk2sI5C3w2WnkGLjkn2tGd/17OIP2EgBql5owhbEKCmoVIVT7R49N+p5XW6yHR
         x1JAa31o3ozf+fKnwWLaRYAE5s9mymmlTrFi1Vp9oX3FdRjLckHM0VJmJJVP0+hw4HRV
         3tj6jf07Wj3TXxB9deXFrMgDlOoXnW1vhDm1Qgi/7Er5DEUmq+eYd3PX88ZW6Ht9ZIIL
         u7K0fCNwhaXBIZPVN1/qxy4WzMs5LeRpdxeSacqZ9L+MsTZrQlCdS4CsAGmjLTO/7lS3
         ILqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=py0H+k5h/ZuAsiNBGfoJ/fJ9Xrc4RVo0tGcEIp7wr58=;
        b=ULPzSb16RB82lrB0E2qGBbFiOLim3rbPqAgoAWbDLSkoe3K8GzcVH8F07lVrALfDuQ
         GwnBfe5O/UQW5WDAXrYh/EWDppE0/MVjvRwlTcTesCy1KH6p+ybRwwi0yRq1huujGc22
         c9OQl/o+8ekl76s/3rDBntMP4OYQuHc3aryQntAspTTjSYliaJR1gMPRI7JuLQqtbLHl
         nQYG2KxCGcP5XFL8wl/ROUZkk3KPVL644oTtubYxl8vF+L6i+EmOqWM0YaBl2aTxuezU
         OP2HVp+6PqrJ55Aqm7WGhUMSgl1KMMyb1Si4NVyQUFVQsCrkBQVoaErH9Qg5e5FEGit5
         sE/Q==
X-Gm-Message-State: AOAM530MwxYiuIBdo0xxW3ecv1ORH6nTouUMQbp3hgmvAe+vBHtTxAS0
        nEKuFOVt1fdbksrzvpn4G4+m9FF7JLyLFiR+SMHHzw==
X-Google-Smtp-Source: ABdhPJzlv8cmBWD9/VgIPNmfVD2ZCTF+x4xbuUWROHswx3Iz92Npgp1ge+LkJA7Elx3YHN/Jrk6n/8HQd2VUC+K0Fwk=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr8949075edu.221.1626374183845;
 Thu, 15 Jul 2021 11:36:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 16 Jul 2021 00:06:12 +0530
Message-ID: <CA+G9fYshrRFN=Qa62eLKPbKHpRt0L-FuRrp0ebc29gdBqFMxeA@mail.gmail.com>
Subject: submit.c:27:17: error: expected ')' before '__VA_OPT__' current->comm
 __VA_OPT__(,) __VA_ARGS__)
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression detected on  Linux next tag 20210715 for arm64 due to the
following patch with
 - gcc-7 - FAILED
 -  clang-10 - FAILED
 -  clang-11- FAILED
But PASS with gcc-11 and clang-12

drm/tegra: Implement job submission part of new UAPI
Implement the job submission IOCTL with a minimum feature set.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Build error:
------------
  CC [M]  drivers/gpu/drm/tegra/submit.o
In file included include/linux/device.h:15:0,
                 include/linux/host1x.h:9,
                 drivers/gpu/drm/tegra/submit.c:6:
drivers/gpu/drm/tegra/submit.c: In function 'submit_copy_gather_data':
drivers/gpu/drm/tegra/submit.c:27:17: error: expected ')' before '__VA_OPT__'
   current->comm __VA_OPT__(,) __VA_ARGS__)
                 ^
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ref:
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/1425953551#L197

https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=juno,label=docker-buster-lkft/1068/consoleText

--
Linaro LKFT
https://lkft.linaro.org
