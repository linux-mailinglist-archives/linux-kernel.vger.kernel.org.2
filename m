Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE80E3B85AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhF3PEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhF3PEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:04:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C09C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:02:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso1567451pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ce93WYNUWWgctHBD8L4llA3RCD0/wpsmbWB0udgSEoc=;
        b=Xmtyge+K6C4X7DYPEO+cFkR/uhdKHTspq7z99Jeiyr/LQMY11Hgqw0Q/pzdHsaNXAR
         oXkrQj12a10XLHsZ56U1gXoqhCwHRwVhTnH8lbiJJYjqZ4eTDPnLiBDGSX1K2Q0sCANA
         e+Y/983EoaV8uRuMUYeaFXuonT2d5Y2u+4vc9/074MXu/UzFcC9C7iwH+hct048C620F
         5efSG/EfHKxTaa4aPW74M316AKf5p/th7KLoKpNUfkZHXY5czbQQSAHiD7lBAfg4pcA6
         +WjnIAzG9Mv4AhWWISe5kyRfb5GEen/H5M067tugcYedMBUy4Y8WsBbUftxfqkyh9fXw
         p0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ce93WYNUWWgctHBD8L4llA3RCD0/wpsmbWB0udgSEoc=;
        b=VnzrQmlpE0v8p53HiiPKzt+pr7BvG9ctgQ1Rw++DJDuS/l8KvkEZ9pATYMfd4Qfh6T
         SAZwwpBspie0vrAT9JyVbr7tDySdzOo+SAqKmZ4H6IgHK3rkupFcdFHLLqfYxCd271iu
         Q7hBbvuuL/GqMr7VntsolYjBUvdBJJgZTE1r4TWMBuDM3jm+f2rfpFUpXNZi6HB7BAZZ
         F5Njkr7GGLx9y//oerZYFsvSbFZJPY51QBImoxmcqfQLLE5uNmF8R++M0ZInd78fe1qo
         yBkIvHX6kT9Q1rcxeaZpDsX64fHmHhZHdTJue2ETAUvZmhj0CSd7WuVE8DVZtOdUDm9N
         8zFA==
X-Gm-Message-State: AOAM533DLFAjFz5KruoguSMD2i6U3G6HcZH8h0NBMlzVbAwpwrwJGsLY
        QWHGoSaoGX/WXwu7bBW+9izxcNHnFiMKYLScIyOUKF7em6k=
X-Google-Smtp-Source: ABdhPJzKL8K4FYdEw8Enr5tvediKzjzxlipW61+vgidF0cdlSNZ5AdbpCoFHKZFzFbf8TqBaIL7ERuAyULdWTiaPXsw=
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr4938970pjq.129.1625065320967;
 Wed, 30 Jun 2021 08:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <202106302248.hjiEwaRv-lkp@intel.com>
In-Reply-To: <202106302248.hjiEwaRv-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Jun 2021 18:01:23 +0300
Message-ID: <CAHp75VcmWntAs16QmexFHKzTOtP-vEOoPODo4jA0_-LeJ2NvBA@mail.gmail.com>
Subject: Re: ERROR: modpost: "clk_get_parent" [drivers/iio/adc/ingenic-adc.ko] undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 5:53 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   007b350a58754a93ca9fe50c498cc27780171153
> commit: a07a4fe5ff460e99293c0d682421920d54e31d7f iio:adc:ingenic: drop of_match_ptr protection and include mod_devicetable.h
> date:   12 months ago
> config: mips-randconfig-r014-20210630 (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a07a4fe5ff460e99293c0d682421920d54e31d7f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a07a4fe5ff460e99293c0d682421920d54e31d7f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "clk_get_parent" [drivers/iio/adc/ingenic-adc.ko] undefined!

Obviously the above mentioned commit has nothing to do with the error here.

Either MIPS has a lack of clk_get_parent() stub or...?


-- 
With Best Regards,
Andy Shevchenko
