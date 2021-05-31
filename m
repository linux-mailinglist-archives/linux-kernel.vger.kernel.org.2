Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B597395986
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEaLPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEaLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:15:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4DDC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:14:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k7so6579261ejv.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mHC6kg9c+4sLUzLIkVSoHdH42qTJPJ/8ZqONWvVOQN0=;
        b=z5yUUnRi/TBcBsaMjZNTifZJV+AgaBYq/soAnh2Q+oWuOqvte2/H1j8bHIPvOwehUe
         N89aOoo8EKBS9/WZJA+TQX0PKiFDQ1M7ybnP9ldNHmI0/ULlMWcCYNK9iEJoM9VshWbm
         GqpzSW7IcyFDTz2I84DP2du0oEeVXS1/4NUFsJHIQUvf4hp/lvO4NxXL87feLUQUNPiN
         KWev3s7XH9NfUXJp9YdTqV5VJXUz7ioI1sYZhiCi251lfqz6OO9rQqb31aWvwBWe/3M3
         ANgwsSWIsbJQdyr1q5LyJsgd7Am1fkhoGaW3C5+JCWZoGkGOhQApT+awZh1YXHFDgNGx
         YQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mHC6kg9c+4sLUzLIkVSoHdH42qTJPJ/8ZqONWvVOQN0=;
        b=lOhfBMfS/MHjk5skf3FpZqla6zgfrrYta22pe1rsJZP8kifgN8mBoq0U8/DzaZ8AyO
         blgXqHKQKqyAYJonzS3ZabyuERJ7+AuIYZq8kwnK70ctPe9N4XwcudwUZ/njPLhMT8+y
         zHo+W48Kce8mSzt/EpMO+X6i4B5aLdhpJEtLlWqC0QMuDN6Id/xe5o4ZWXSjKATsK00C
         MSTyqBzSREWlVFcpfDXYng/AoIefJNzZiVJG56WEWotsA+vVvrIREbCfXjL24oMuVd98
         8c7UDAaPhJOYcLjQmrM83d9bGgaBwWtVxrNI+aHrVxb4oe2vA0FNXEozbKDqL4oqBmOE
         ihxg==
X-Gm-Message-State: AOAM531jsvlsPyizyRyNnhGB3ru/PMTo5JrF6u+dxdQZEKx3vNMbMrej
        xnCyQVVbOGMd1LU2tXKOT1dsGwqtGi7v0mz90YrVGw==
X-Google-Smtp-Source: ABdhPJzXk8Lt3DpQOUGgad2UrC1f81NDzrAdSNkKHcfoTv1hmTY1uZJWL0xTaw63yS+39qpClAeAWEe88VN/O4pp3F8=
X-Received: by 2002:a17:906:8318:: with SMTP id j24mr3744182ejx.375.1622459643368;
 Mon, 31 May 2021 04:14:03 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 31 May 2021 16:43:52 +0530
Message-ID: <CA+G9fYtwjDoDr=hrSGLg4x5pv3Kq-MbCTzohy3=yLLN7P-Czqw@mail.gmail.com>
Subject: [stable-rc] 5.12 arch/arm64/kvm/arm.c:722:8: error: use of undeclared
 label 'out'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-stable <stable@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux stable-rc 5.12 arm64 builds failed due to these warnings / errors.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'
arch/arm64/kvm/arm.c:722:8: error: use of undeclared label 'out'
                goto out;
                     ^
arch/arm64/kvm/arm.c:918:1: warning: unused label 'out' [-Wunused-label]
out:
^~~~
1 warning and 1 error generated.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

step to reproduce:
------------------------

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


tuxmake --runtime podman --target-arch arm64 --toolchain gcc-9
--kconfig defconfig --kconfig-add
https://builds.tuxbuild.com/1tILLnkg7Rqf4tsdhjS3VoZDrdk/config

--
Linaro LKFT
https://lkft.linaro.org
