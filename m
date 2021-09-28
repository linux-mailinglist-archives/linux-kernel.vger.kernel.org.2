Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5469041AFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbhI1NKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbhI1NK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:10:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAB9C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:08:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r83-20020a1c4456000000b0030cfc00ca5fso2225048wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/pci3M3EmSbgPBjAtl2mKWnbVJOKuoEiANMdEV1uPKg=;
        b=uSZyvJoDVGXGX/a/IzC4ADZk9Cz8kgSd4043p3xqj9D8eOb4CEsb2Je6kCJ5ahaByE
         oYFG6nejLHIzdjnEp/cKcKqP4bbEfXK79L/ZZ72dfIU52JvOaWYQyoA/NaU7vM1uYZAn
         b1GJrMUNVLLV6D/n/DIj/oyypta2/9UcmPSh2boH6GpvszdIqQvGJnPMdJTHWqFH1JuQ
         CEwB6oXYD8a6G3MxBM1Khhm+fTjPXjgKTWZYDuFfmWE1UmzHkD6pznGv3vL/seLJDqMv
         9xov61DmqyWFYRneiRLAIt9JkaUgahCFjrDKe9xA74mrnvCUI7qdJ+1auQnA7xxYSnQA
         53RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/pci3M3EmSbgPBjAtl2mKWnbVJOKuoEiANMdEV1uPKg=;
        b=6UoW2gUAJLQuQgJdvywGdAXzzu06DPiEjm9XVgNvgCJu6VrA/WQ+GLzC/pC+RYm+QS
         3ezmGQ2ezqQ4HJ1T9tf4MZCjxBB96QTJjp4NDpOgN93sLbNbJDh6V88vJTQyPDvcCWuw
         rAQpKcOuVxReUBbWqjp4uH+ydrxLbNGGqR9zBDGBwkbvv5RTE5gA4GOBZUaRGpHzPokk
         CGLqP9AS2gPvyotjJjxOFlt5zI1t7MGucwlDe0wOvjoeD/x/f/yxiNyFISlEksPLkq3n
         ud7dVGvqwgrEDg5m3SBldfuinSKDmlWI52RF/GM0c5ubHZYAar02C/+wWdXTGk5efCZx
         ORiQ==
X-Gm-Message-State: AOAM533w2i6jJjmma/nfLuJvgCt2BotbeqBicTTY8JH/3N/sdqPfNnuU
        YxBFF2vWP4l5lcmJb7uqJnY4kegxBmvKqkGP8mZpk/3g
X-Google-Smtp-Source: ABdhPJx9si3gvf6klG8ush3Kigexntv0Df2BAGFr573gGTZgq5bCwA/Af71JfWe1fuVEk/nIQ4tNHg==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr4492075wmh.137.1632834527413;
        Tue, 28 Sep 2021 06:08:47 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:269:e210:8445:bcf4:c79d:3156? ([2a01:e0a:269:e210:8445:bcf4:c79d:3156])
        by smtp.gmail.com with ESMTPSA id 1sm3113897wms.0.2021.09.28.06.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 06:08:47 -0700 (PDT)
From:   Jerome Forissier <jerome@forissier.org>
Subject: optee: regression with kernel v5.14 (virtualization)
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Volodymyr Babchuk <vlad.babchuk@gmail.com>
Message-ID: <a0e1c245-8209-a173-18c4-d21433bf46bf@forissier.org>
Date:   Tue, 28 Sep 2021 15:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I met an issue when testing OP-TEE with the latest released kernel
(v5.14). The kernel won't boot when virtualization is enabled. More
precisely, the boot hangs as the optee driver is probed. The last line
on the console is:

[xxx] optee: probing for conduit method.

The issue can easily be reproduced in the QEMU OP-TEE environment as
documented in [1]:

$ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
$ repo sync -j10
$ cd linux
$ git fetch github --unshallow
$ git checkout v5.14
$ cd ../build
$ make -j2 toolchains
$ make -j10 XEN_BOOT=y run

[Note, if you switch between XEN_BOOT=y and the default build, you need
to "make arm-tf-clean"]

git bisect points at commit b5c10dd04b74 ("optee: Clear stale cache
entries during initialization") and reverting this commit on top of
v5.14 does resolve the issue.

Any idea what's wrong?

[1]
https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8

Thanks,
-- 
Jerome
