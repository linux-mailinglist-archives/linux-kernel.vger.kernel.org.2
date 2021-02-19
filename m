Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1127831FCD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBSQJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBSQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:09:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A836C061786
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:08:39 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v22so10758558edx.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=p7Qeq2s5Xnq9l0SeDvPjf0XHN3FRE6tEzdDl2ybtrE8=;
        b=La2J+a6v9usT3u6H9nSsx6mX/B7G1xzcjtvBWy0mQZVxr6VqQKalpmPhTgFcgOD4Vu
         HXlygKNzkKKBr6DdDrdft4DJO2zdsPc47LkPmIpZBG8rYVm0ktjRGMvIeUf/hhJp9QWi
         qCBPRLjozKe0opoP3Ng9Mmtz1s0kzKOQvp1cijTFRn3oTfuzRuFzhoYyLBMDZ3s9mW1m
         hFd9Wx+etS7Htm8sdz2N1DzpvcRs7axOm7kl8j7mYdmlMNnemgXakbEOXx+gmxfG9wHj
         8ipbajako4VqmFrb+R/KsG4fTov3KLFe0kLdy/Yym5lp3JmcZahwBtflqAL4vUrHUIu/
         fpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=p7Qeq2s5Xnq9l0SeDvPjf0XHN3FRE6tEzdDl2ybtrE8=;
        b=KLIpwv5sC+vnTAcwSsuZyfLvRcYGDHsA2sF8devAxHHkz6BLLcGuvDmRpIk5MmjW6T
         A/ez/8+ajz7pF9hd/lgRRq+8/9KzN7kkjLXCfrbpdiLOp45teaL1BMVXFM/81gaAcDS/
         UY3zkmtv1FKUphppNuOFIXR6pC/w2Q9d1YBB35caeahUetZkt/XDAVS/D3WwJQK4lPkT
         xAD8MpCByXnQTRHr+fWSImeuBxlrh4EE4SBzVrxRs2yYuiSZ9uuY1TOu4kcKf+vku97n
         m3SVXC85LsZ0Smi2TA4NTn+lrnUNcYQqZIWVDSFpp1PMdqDN0oqlj2kKRuplnO4itGWR
         oH2A==
X-Gm-Message-State: AOAM530EUOZ6jcan2La85gFHRSUkYEQT5lJYN7Z+zwxR1FQyjCdFfQ5i
        +YQzIx8uWsxDp6538vZARMMiYvpRPIDvHUVFfBcAw2pr20nJ5f6z
X-Google-Smtp-Source: ABdhPJxBmySrnWZ/vg0O8Qkfho1wlcFSgXK2V4Ud9uDDW6ULyimn6/qyiCiMbqfas5SmTbq1t+NM1VoYsO4dC2dF+00=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr9901048edd.52.1613750917592;
 Fri, 19 Feb 2021 08:08:37 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 19 Feb 2021 21:38:26 +0530
Message-ID: <CA+G9fYt1Bk=DW1VoPgWe9ZHHoHu+6OyZi7ndMJHmoR14uJePyQ@mail.gmail.com>
Subject: [next]: fs/io_uring.c:6171:10: error: implicit declaration of
 function 'io_sendmsg_prep_async'; did you mean 'io_req_prep_async'?
To:     linux-mips@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        io-uring@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next tag 20210219 arm and mips builds failed due to below error.

Following build configs failed
arm (s3c6400_defconfig) with gcc-8
arm (s3c6400_defconfig) with gcc-9
arm (s3c6400_defconfig) with gcc-10

mips (e55_defconfig) with gcc-8
mips (e55_defconfig) with gcc-9
mips (e55_defconfig) with gcc-10

fs/io_uring.c:6171:10: error: implicit declaration of function
'io_sendmsg_prep_async'; did you mean 'io_req_prep_async'?
[-Werror=implicit-function-declaration]
   return io_sendmsg_prep_async(req);
          ^~~~~~~~~~~~~~~~~~~~~
          io_req_prep_async

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Steps to reproduce:
-----------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch arm --toolchain gcc-10
--kconfig s3c6400_defconfig
or
tuxmake --runtime podman --target-arch mips --toolchain gcc-9
--kconfig e55_defconfig


-- 
Linaro LKFT
https://lkft.linaro.org
