Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1603741B84A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbhI1U23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242315AbhI1U22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:28:28 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D381C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:26:48 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b12so317384ilf.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oB1STMFxd2csSkl8IVlp20V6oUL88X9VqIf6wV2nNYM=;
        b=cvGdKIORLe2S+zKWVexAroERaaQrNTAwn/jv4gFIHlSk+LC2Zqjl6pW2h99Yiufmbk
         f4PESEjpImEgoZ6pynUwpxjV93QT63a7KVnt+VC0+juRVtia13z2VugvLYFPs1IyVahJ
         fw6hbhoyt1rKcXnH/HmvrICYbmsWZK74Ynqrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oB1STMFxd2csSkl8IVlp20V6oUL88X9VqIf6wV2nNYM=;
        b=SkbGz50qL8s4Iq4J0Rf59NZiV3RvbrmwRrXaYLCY8gqYVdWJq1G8NFxqDlJqbDG8iB
         NnuqMLaezbcMnhN0fmSe6mBjUi7/xGUl00+24DRUrjJ3LC+X20IlFkrniBvTpc224P7c
         hXdS/hhJdKZL/ASi9ZtEcjC3keH1vpKAC3UpBSCOzWgoBI7vhx7ZO74sniFd962gtrnH
         VOcaNQushd36PJqjua+KUHWNqh32fUsQS/6ab9bG/TU+tsWhQ2SCS2+m4/+/LFca9gRY
         OoRVnFBfwsly9p5FW0V4zoZhlXoiKkQ2ZgJSFu/sx6Es17Tul9qE7HX2UG0CdRglreQI
         x+cw==
X-Gm-Message-State: AOAM532kh/HtDmheUq4pBL11w5ms28C5KOUsDN6yh+LI5744oaW+ZsBj
        MjMCGt2Zq2fz68KP2rwri33C8wK6SvsYXQ==
X-Google-Smtp-Source: ABdhPJyRgVWGfienCjo8mnTyc0MDwDLl7LV4NIGQfS3u2332ZC7t3p7FOpskbVLw8i4ui6/aeH6pYQ==
X-Received: by 2002:a05:6e02:d86:: with SMTP id i6mr6019551ilj.272.1632860807518;
        Tue, 28 Sep 2021 13:26:47 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id v7sm28376ilm.19.2021.09.28.13.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:26:47 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id b10so198669ioq.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:26:46 -0700 (PDT)
X-Received: by 2002:a05:6638:dcc:: with SMTP id m12mr6353650jaj.68.1632860806568;
 Tue, 28 Sep 2021 13:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <202109290438.wHIL8nIE-lkp@intel.com>
In-Reply-To: <202109290438.wHIL8nIE-lkp@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Sep 2021 13:26:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WkUEkkkfGa+6QJSBvj8EgVrnGYYbd6RrC_5HdTue=mDw@mail.gmail.com>
Message-ID: <CAD=FV=WkUEkkkfGa+6QJSBvj8EgVrnGYYbd6RrC_5HdTue=mDw@mail.gmail.com>
Subject: Re: drivers/hid/i2c-hid/i2c-hid-core.c:867:4: warning: format
 specifies type 'unsigned short' but the argument has type 'int'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 28, 2021 at 1:16 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6fd3ec5c7af58d5d6b598fba22ac387645af33f4
> commit: b33752c300232d7f95dd9a4353947d0c9e6a0e52 HID: i2c-hid: Reorganize so ACPI and OF are separate modules
> date:   8 months ago
> config: arm64-randconfig-r016-20210927 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b33752c300232d7f95dd9a4353947d0c9e6a0e52
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b33752c300232d7f95dd9a4353947d0c9e6a0e52
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/hid/i2c-hid/i2c-hid-core.c:867:4: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
>                            le16_to_cpu(hdesc->bcdVersion));
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
>            _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                  ~~~     ^~~~~~~~~~~
>    include/linux/byteorder/generic.h:91:21: note: expanded from macro 'le16_to_cpu'
>    #define le16_to_cpu __le16_to_cpu
>                        ^
>    include/uapi/linux/byteorder/big_endian.h:36:26: note: expanded from macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
>            (__builtin_constant_p((__u16)(x)) ?     \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Definitely not something new introduced by my commit. Also seems like
something wrong in the compiler or in the generic Linux header files?
It sure seems like if you call le16_to_cpu() you should be able to
assume that the type is "unsigned short" and not "int".

-Doug
