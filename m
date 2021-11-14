Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E46044FBD4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 22:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhKNVdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 16:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhKNVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 16:32:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE66C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:29:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so2108094pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3oJ866IaHCk6upGJyjgTThiEwH/md/C8YGLWrggZM0=;
        b=c/R2OfjHJPWdTgc4AgN1Zkbd7OndiY10vuNDybALIXr2OvrBEH5q2OdNSGME1X4Z+b
         ncBioNCZnOX2wI+osbEk509B80ONMyRo9sqROTStbapUp3+Q50ZLrSpU9SoEdSyrzU3g
         LwVRVBxWRu8uSguAXW8JEN1VjwpEys+BoIk0H91i9pndfidLck/6cEg+mS9zwB6UztZw
         vZ4edMVaIZevrPmsoyVJUH5447rzFys/oOp5uqwjjFzsehyJDbozwTmWa3IW2bylI7yZ
         hOX/Uk2HBDK1RYTV6CZrx0vxWG00GFKmyG/U5KwgA/grKpJABdjDyQkNjP9+P1Sf0AyG
         EGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3oJ866IaHCk6upGJyjgTThiEwH/md/C8YGLWrggZM0=;
        b=G15FceZGFk0xXLvkTyN8omR38d3eOCSIBkcjaPzl4Mf8Hpo/rYY0mrX7IQzegLvhG5
         Ik1RjVDXDDWcIGQ7pdpDxFvGxTwW5gFDHrPs6zRMK9+D1n9vVSpo2hReGWRuRGocz/6G
         xRI50Yjs7EkWx5siv7s+CTeL5kMyWTeS8j2Buk93otQg/bREgzmF6zb8FgyFltzUUjGn
         05Qoczq6lw8gtK6A/UM5MFIlZYBQHmDc+eAiiW5kc88baXqCzGhbC6U+r9NEjZZv4vSF
         DCEQ3kRfWRxBdqt+xAKmK20LGhPuT7ggncZllktIElp2chFnQw/neuWdc9koTvhIJTwB
         /Sxg==
X-Gm-Message-State: AOAM530lyE9hQg/A16dWSwSoWld4RXGPqH1CkTwIdG/vE8kFjm4vsQPk
        crb++9eMcWM+oyDQ/iqWBUBMeA==
X-Google-Smtp-Source: ABdhPJwdbC85BuiMtq147psLL00XVQwOqRHlj6KtzJoUBFIzvYW1agL6cqIPwk4Oxlu188+/QrFHMA==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr59276896pjb.161.1636925391695;
        Sun, 14 Nov 2021 13:29:51 -0800 (PST)
Received: from x1 ([156.146.34.6])
        by smtp.gmail.com with ESMTPSA id qe2sm8620421pjb.42.2021.11.14.13.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 13:29:51 -0800 (PST)
Date:   Sun, 14 Nov 2021 13:29:38 -0800
From:   Drew Fustini <drew@beagleboard.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: drivers/clocksource/timer-pistachio.c:74:22: warning: variable
 'overflow' set but not used
Message-ID: <20211114212938.GA317441@x1>
References: <202111120738.oAGjK5L8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111120738.oAGjK5L8-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 07:05:48AM +0800, kernel test robot wrote:
> Hi Drew,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   debe436e77c72fcee804fb867f275e6d31aa999c
> commit: a47d7ef4550d08fb428ea4c3f1a9c71674212208 clocksource/drivers/pistachio: Fix trivial typo
> date:   7 months ago
> config: mips-randconfig-r012-20210927 (attached as .config)
> compiler: mips-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a47d7ef4550d08fb428ea4c3f1a9c71674212208
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a47d7ef4550d08fb428ea4c3f1a9c71674212208
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/clocksource/timer-pistachio.c: In function 'pistachio_clocksource_read_cycles':
> >> drivers/clocksource/timer-pistachio.c:74:22: warning: variable 'overflow' set but not used [-Wunused-but-set-variable]
>       74 |         u32 counter, overflow;
>          |                      ^~~~~~~~
> 
> 
> vim +/overflow +74 drivers/clocksource/timer-pistachio.c
> 
>     69	
>     70	static u64 notrace
>     71	pistachio_clocksource_read_cycles(struct clocksource *cs)
>     72	{
>     73		struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
>   > 74		u32 counter, overflow;
>     75		unsigned long flags;
>     76	
>     77		/*
>     78		 * The counter value is only refreshed after the overflow value is read.
>     79		 * And they must be read in strict order, hence raw spin lock added.
>     80		 */
>     81	
>     82		raw_spin_lock_irqsave(&pcs->lock, flags);
>     83		overflow = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);

I fail to see how variable 'overflow' set but not used as the return
value of gpt_readl() is unconditionally assigned to 'overflow'.

Am I missing something?

Thanks,
Drew
