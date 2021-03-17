Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07233F1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhCQN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhCQN5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:57:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03315C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 06:57:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bf3so2369331edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i1gCxZGZSMzxgSNyMhX3tkzSKQY+iuylSLD+XBIGr7E=;
        b=uPpwp0XTkSDTqp8X40Pz+t3UZRCUltGqTvZDsNQbzXq8G8U/Dg4D2LLYmDPOgaMEgl
         g/nq4Lyt6AqSZnJD5HL28jRY9HsffEiQFeTC4Le2wjPAXxnFJq/Wl+s0v8bFv7uHRlCn
         j+Uy3y7vezbK4BPj7UAzkvHk/yTm6ek0dsnzVdaw75imafDv4zZkxeD+aoJHaJQQCKN5
         ldkLSAN0nAT0SIwVruZEklALtrJ81hqKKAezgGxwuaevq0oHwiCMOMNYkO4yakE96dPt
         JmHHOSfi0je1HqRaJBIaQPrdY0NVw6TVcBjkdqL2XAkQCVhmoyN4WOp96l3fwkVeWrqB
         zfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i1gCxZGZSMzxgSNyMhX3tkzSKQY+iuylSLD+XBIGr7E=;
        b=lMo0K+OU1BFXYD5UmjRA03x5eQ2h3UnVoEVqc8QrTRUAS73IzfU8VigAGni9n7DfXa
         tSeCDq+tPIbIrbswk9p/e8u+IMXw4Hj77Shg4iKjf8LkFGbFUPtkhnlQLNBZt79oOjF3
         jx+96wRT/sJLUY72E4YoIbK0+3x6r898ca7/38wz6mTDVc3otSOHx5YZF0mOISmve5A+
         ntbbzc7hh4aG2At5IFGPSegGkxbO0ytNPm4sB+EpHQTHF7z22hTXekrBPDCDRk7979YO
         /zR7iOGbkpJmZoqsnRwIR4XoxSjpd/hP6paEyfklEy14qfHUq64Re1LM+o8K1uSiQEmW
         YJ+g==
X-Gm-Message-State: AOAM531X1gPrW0JrxR5abLn1D7F9C0av9eK6Pw3BicERjiRhJClDBgZb
        9jbQKNitWdkSRWIp6tucTyTtfccb0M8rrD+7CJ+lkA==
X-Google-Smtp-Source: ABdhPJzkWhVM8jqQi9BXdesgx5DtxP+Xvg1AmdN0Gv4go/Gz3YU0cgIo+Hur9+9mYwuhVnYzAdLOOsgHTAMJJQP+qZE=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr42917252edd.78.1615989420684;
 Wed, 17 Mar 2021 06:57:00 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Mar 2021 19:26:49 +0530
Message-ID: <CA+G9fYtBw0HAv5OOAycK2rZ_m2Sj73krXPJ0iDzT+O8qtc19SQ@mail.gmail.com>
Subject: s390: kernel/entry.o: in function `sys_call_table_emu':
 (.rodata+0x1bc0): undefined reference to `__s390_'
To:     linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        lkft-triage@lists.linaro.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Nixiaoming <nixiaoming@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next 20210317 tag building s390 architecture failed.
 - s390 (defconfig) with gcc-8 - Failed
 - s390 (defconfig) with gcc-9 - Failed
 - s390 (defconfig) with gcc-10 - Failed

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=s390
CROSS_COMPILE=s390x-linux-gnu- 'CC=sccache s390x-linux-gnu-gcc'
'HOSTCC=sccache gcc'
s390x-linux-gnu-ld: arch/s390/kernel/entry.o: in function `sys_call_table_emu':
(.rodata+0x1bc0): undefined reference to `__s390_'
make[1]: *** [/builds/linux/Makefile:1212: vmlinux] Error 1

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
--------------------
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

tuxmake --runtime podman --target-arch s390 --toolchain gcc-9
--kconfig defconfig

-- 
Linaro LKFT
https://lkft.linaro.org
