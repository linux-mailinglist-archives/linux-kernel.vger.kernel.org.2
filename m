Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88821454693
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhKQMvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhKQMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:50:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A68C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:48:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y12so10488367eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0+pPOLiQ+Bx+O/8cdVHA4cV56t6Nx0HHUCPP6r/Idqk=;
        b=FHFa2rn7L3u8hCvKMpX5bxRkemL9eFYNq/1tuyoUSXp7Ns64bRjTZgBHzonQttEOCD
         /dqTVR+NwogiSf3W5fwpHgCDvrQF7uM0l9CVYhjt3WwAk/ANBn8D5BJOehsyNW6RmEFg
         xcXSgJdSaZJ822ZMGR9lVqWRU599nvvAsn6R6PTQ8//q6a2zz1nLMQdNzNcCqsZfSDir
         Bt4Nagk1Q9hgxNOvCRKVTJbkreUo2Fg59rajBreoeOImQ8vzeDqN+a1pXWWAqWYwUnE9
         VyUmt8heP7oGstzd2pNP+XA0wNxNKT6MIgTf/qDcV1qXPfSyrrdL8Z5N85b66XlREpsR
         p1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0+pPOLiQ+Bx+O/8cdVHA4cV56t6Nx0HHUCPP6r/Idqk=;
        b=xs4a1EyM747bZTVZlV11r10w5KuUht+fIMhutFqPz+x/yme5ybzqni/D2NtKC+1bFT
         jwfX15PWPYPGikvnXWAHRzc9hFEmAnH+sfjpqx9Ro7XbvbO5aVMwgfqKGv1U/lJrEwa6
         tcNXvWGg95607ucLQysDV8DLDlSQvwwUzNcHCnF0oLs7MarC7JiG8lf0fpeNEY5VkWKS
         oh2C45ub2iBv0bnbXNiiD1H+lJMAaMUL6cK482QSlsjaT65THKTiN75Z+sP3DtZLKCCF
         wkICR92L27DwxTu0tL7xfxpdjpHa6PGx3Q8wQXdDFMRzrV1ZImVvnVuE2TEmVr5uD1Zd
         ceFg==
X-Gm-Message-State: AOAM5301ttYo9hbkf1NoWBbetg1Ow6M7Ur8m5EMMMVcFSNkOP+y/ZxlJ
        TgLt5+poJX7+GmzTyWJa2w+kU55z0Z/wRN4kKOo3mA==
X-Google-Smtp-Source: ABdhPJz28fYHeqXhcc+iLV1bZJfwHWJ/e3SsWx1uhED8KTwRSA9ww/lp+tBCyWdkuUkqWXLoa59xgESlp9DXWsykCBQ=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr20996457ejq.567.1637153279161;
 Wed, 17 Nov 2021 04:47:59 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Nov 2021 18:17:48 +0530
Message-ID: <CA+G9fYsFwhPGCmsYoBkx+LTRWqaKrzQTLedZugnK2qieyTFoxQ@mail.gmail.com>
Subject: include/net/gro.h:413:22: error: implicit declaration of function 'csum_ipv6_magic
To:     Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression found on riscv and arc gcc-11 build.
Following build warnings / errors reported on linux next 20211117.

metadata:
    git_describe: next-20211117
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: fd96a4057bd0 (\"Add linux-next specific files for 20211117\")
    target_arch: riscv
    toolchain: gcc-11

build error :
--------------
In file included from net/core/dev.c:105:
include/net/gro.h: In function 'ip6_gro_compute_pseudo':
include/net/gro.h:413:22: error: implicit declaration of function
'csum_ipv6_magic'; did you mean 'csum_tcpudp_magic'?
[-Werror=implicit-function-declaration]
  return ~csum_unfold(csum_ipv6_magic(&iph->saddr, &iph->daddr,
                      ^~~~~~~~~~~~~~~
                      csum_tcpudp_magic
cc1: some warnings being treated as errors

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

link:
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/1790398957#L73

build link:
-----------
https://builds.tuxbuild.com/211schgBXkq5zjdda7io29wMONF/build.log

build config:
-------------
https://builds.tuxbuild.com/211schgBXkq5zjdda7io29wMONF/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
--kconfig defconfig

-- 
Linaro LKFT
https://lkft.linaro.org
