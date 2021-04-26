Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40A936AFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhDZIXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhDZIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:23:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E61C061574;
        Mon, 26 Apr 2021 01:22:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p17so652113pjz.3;
        Mon, 26 Apr 2021 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyVyK6NZHpEBoT8Dh2MKzH5N2Nwh3NVtxSsAuNCzreA=;
        b=KD3qCBndmR4TwscZh6X8h9DgEAtH4PeoOnCG66VNlrk9P8UZI2Wu534oU7Il/pPHoL
         VaNY2DQm3mFGNdd7E283OoMWcZqkWK4ClEy7VkVAHkeIlRvh6OjhJ03Z5EXVb5PBXnwB
         pRFCTC39slumj5QwwlUz2acSkPvTHzfl6w6JHhIdnsvXTos3ate2ezbBSeJYP3VAV+1j
         Uir5d2VHRMt3FJCC7t9C1itOtQZjAKLApWzF2OkevEfqobWt7zw3Hd2wVRR+mm7uU8CJ
         /yTatM2g7CMp4q9fcgkJtb+6TYehVM9Wh/MXUXYNG+GklvnD7ZRUYlw4f00r27XcdpZa
         629Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyVyK6NZHpEBoT8Dh2MKzH5N2Nwh3NVtxSsAuNCzreA=;
        b=VsXTCQWb2QRcQLiWSH6DryysV8V1zYFTsn1i8ffVC1dq58yM18D1AYGK7h2nwj36xS
         nfJZKQnPhC3qiRZRPdJLxcZrL3i9jW77GVzEo43GhKWABuR+paM2ckssrw+krL7a5+cL
         4cFe0tNwsSI01pqOw8Pkxcbnq0gAD+mIcpRvGt2uRT9D76qG6VgGD6RXGmi2lRAVYZ1H
         CqjUXdGbXtOZ7ZfBMq/FAUkmsM11vN3jQ8jP2GrmsyethN/ZxOp4WYHLzziMxXyMLq6F
         7P5LA+V0wCqMJgvd8vXqU2VUhmQu/CjwZyTXeIP1owY//ilRhy3UHtz7ecBoDOCTefSv
         MiyA==
X-Gm-Message-State: AOAM533d3CR4yx1cW5UKEBNF+YavX3qW449zi/IEYbUtkM4CVCOiZt0y
        qX3GP5bz6AtBW0LiY4ykTnYV1EGRtaitdyOvDKzmtIdu8RA=
X-Google-Smtp-Source: ABdhPJwnKOwW7l0uVAF5Dr0g52/3HxdSbXZgt63VQpp1yw1IjB+8ND2NP69oqvTiPDS/He6DkF0ABUV1dBmqzZsSp2M=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr17196879plq.17.1619425365521; Mon, 26
 Apr 2021 01:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <202103162301.oomY9NwI-lkp@intel.com> <ac51550d-c72e-4a85-ed0e-a4cddbf495be@infradead.org>
In-Reply-To: <ac51550d-c72e-4a85-ed0e-a4cddbf495be@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Apr 2021 11:22:29 +0300
Message-ID: <CAHp75VdZ6v7zV4_4YJ-rXAE2_ZLZw04AHib1yGPiwYS_JYYGOg@mail.gmail.com>
Subject: Re: ingenic-adc.c:undefined reference to `clk_get_parent'
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 8:43 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> [add linux-clk + maintainers]
>
> On 3/16/21 8:54 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1a4431a5db2bf800c647ee0ed87f2727b8d6c29c
> > commit: a07a4fe5ff460e99293c0d682421920d54e31d7f iio:adc:ingenic: drop of_match_ptr protection and include mod_devicetable.h
> > date:   8 months ago
> > config: mips-randconfig-p001-20210316 (attached as .config)
> > compiler: mips-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a07a4fe5ff460e99293c0d682421920d54e31d7f
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout a07a4fe5ff460e99293c0d682421920d54e31d7f
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
> >>> ingenic-adc.c:(.text+0x8c): undefined reference to `clk_get_parent'
> >    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
> >    ingenic-adc.c:(.text+0x164): undefined reference to `clk_get_parent'
>
> Hi,
>
> My guess (analysis) suggests that this problem is due to
> a difference in when clk_get_parent() is available between
> <linux/clk.h> where it depends on CONFIG_HAVE_CLK and
> drivers/clk/clk.c, which is built iff CONFIG_COMMON_CLK.
>
> Any comments/suggestions?

I haven't looked into it, but IIRC MIPS has its own clock API
implementation (or I mixed it with another arch?) and that's the root
of many issues like this around the kernel.

-- 
With Best Regards,
Andy Shevchenko
