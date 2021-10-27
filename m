Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58F443C9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbhJ0Mqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbhJ0Mqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:46:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E7C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:44:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so10094359edj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CUP4vrt1rUdvfDXyrscKzMJOp93zpu22SaFg7PrBhiA=;
        b=CcPOQ4OiOX2pt/+YZ+a+5+PtsWF58l5SIZlH7c0NMdqivhouLD+fqU1vUJ422nap8B
         pXvW4gzg5Z+Ti/2tVTyhRbxCD7rdEYI6XvjOMGWYQbKtmy/pc7QvOVhwNyQu184WqIC5
         2tV2MOHw276tD+nGtZmQG8Ba/v3g6qUs6plqIh/ut+JOLhXhZtwqwhtVKZkucfTLZabK
         9jdO5soJ/DOaLWObW8ethd2/N1Hps4tn1zIRZlUR+lKmFJg0biwKXf65CD45k1qXdJAt
         r0adfgL8DZmSWiXmeRX4XaBTp+PL5NT81t0OI1CJjwfUDicLP4x//QMngQR/4rme5oOn
         r9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CUP4vrt1rUdvfDXyrscKzMJOp93zpu22SaFg7PrBhiA=;
        b=IAz43F73pN7tssC9zxrhthFk+48yk/9jM5qRH/kakYcj9WQcEFZ4cyMX9jahvw/pU6
         LUybS5NErczmnuBRESsPh1XD0QRk3zHYT+DalA9sBoIm8ukuIc0EF+JY9X/nZjC+pMHB
         XmVuF2eLFjRh/rF8H2JigrJ68wq69eHTRcEQfeELjdeMR96gfSNEQOTE8il2fwZuTadE
         DV8e8x205o66orNBb5S41yW2vvgI0CJqzhkZnIh8i6WdnsqwJEkpYpXkN58KGM4o14dk
         Be7/UwkBFDi/+DzpfaA/jkAdPdnWVzUAe2+T/uIjFNHC0OpDceNVp3FFfZccYFvchsmY
         SXgA==
X-Gm-Message-State: AOAM530aNBy4JfqzFTZVruMUdWAJ4lvQbN0kd8shsegulsW9Wc8dWqUC
        2Syc71ZeiprNCJf+Hw5qut6jG7Cos1q8t2za+K4hOA==
X-Google-Smtp-Source: ABdhPJzwVWeqcvccpIgdrAd8nGZnO+VjAujcw0FniNnKHAKDWNnTXb7Z/uiWrqylHJantGjdST3K827hkeW2H4l5IBA=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr30220760edu.357.1635338652901;
 Wed, 27 Oct 2021 05:44:12 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 Oct 2021 18:14:01 +0530
Message-ID: <CA+G9fYsOdhqbgRwuV7RD5k3Wh3n_Cb_EmMnkYOJ+4wZi-7MgrQ@mail.gmail.com>
Subject: ERROR: modpost: module drm_cma_helper uses symbol dma_buf_vunmap from
 namespace DMA_BUF, but does not import it.
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression found on arm64 gcc-10 and gcc-11 built with defconfig
Following build warnings / errors reported on linux next 20211027.

metadata:
    git_describe: next-20211027
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: ae5179317e79 (\"Add linux-next specific files for 20211027\")
    target_arch: arm64
    toolchain: gcc-11

build error :
--------------
ERROR: modpost: module drm_cma_helper uses symbol dma_buf_vunmap from
namespace DMA_BUF, but does not import it.
ERROR: modpost: module drm_cma_helper uses symbol dma_buf_vmap from
namespace DMA_BUF, but does not import it.
make[2]: *** [/builds/linux/scripts/Makefile.modpost:134:
modules-only.symvers] Error 1
make[2]: *** Deleting file 'modules-only.symvers'
make[2]: Target '__modpost' not remade because of errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
-----------
https://builds.tuxbuild.com/205SAU159J0g6lSlRRS11o5hHyY/build.log

build config:
-------------
https://builds.tuxbuild.com/205SAU159J0g6lSlRRS11o5hHyY/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org
