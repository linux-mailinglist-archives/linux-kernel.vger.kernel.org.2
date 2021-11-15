Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B6644FCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 02:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhKOBGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 20:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhKOBF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 20:05:56 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A0BC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 17:03:01 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so12551658pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 17:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0wYfZsXO/8nAgMWn045UCqWhDAzRKt2mkV/Pv3fZiTM=;
        b=kCpDvtjBbqRr5QUjGY0vb2qc+6kZMe3hsuXElygZm4XFjco9KwA+Ho+uHxbQ/wW+Q5
         NWbc6GbBMXg+V9jek47K54yojUT7YQndtpgcfI9DXdTeaXRHY2I/3CjxL2K3H+IxeKr8
         4SiOzPhZa6puPYQvEx7n9qNXPigmBRCYjRBUemUXRXZVv0QpuhZlbMp81+fwhpV8ZNhF
         5cFC0QAC1CRJf9duat+ljJrD3+6gndJIBjO90hLxeTFkArxlnQn4DEQkRNyoLAS8ETQ3
         lx/xTr42Xqw3YQLasBLLhDgNGOd/UG8F4+z6jvpMONZ7vXSRxdPxv4MTFQnf8Sr6670O
         VvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wYfZsXO/8nAgMWn045UCqWhDAzRKt2mkV/Pv3fZiTM=;
        b=ciXKzez0GwTXIWpDmZppHT/GfS7yXaOY6dDABPbkQhNXuInasZzUwfjueHoo4wUcq8
         VKAUR+E2Y+bBLitEhPybu9rkJBPquuNLPJVsB6flbaRBbJNzD2s8Ig+XESfL46z39L02
         LTgia6aRk6HuB2NiU/V3lRmaw2zoG3pCmHVX94gg/pEiWcETVNrqKnREMcSiCmoXMk3e
         1SuB4iLahM19ZY1RH/Aj7sJC5kOBuSrHIHGfCggsxKsSI2OBzd5EpiuEpida+Smf7FzT
         Iv447quQh3DtTZ3gSNUif4pdw4zThgFRNctI3CQre/vrBF+oU3sNpDTXUvT75LSEPDgZ
         awzw==
X-Gm-Message-State: AOAM530O5k8NG1wH3YEjC8HBP3XYj2V3DR3HQ+gG2ldJfUd7eNmTvIHM
        UXaVo+/STBhlaeHbRa0nLAqpACh4ehSUMCBQD+4=
X-Google-Smtp-Source: ABdhPJwk4N8wcfreUeIlMRKxYo5iIHJGnCkxCzDoWHjbrwJ7aBSqs3wacp2fzt9jK2MqI4vvyvnVZQ==
X-Received: by 2002:a17:90b:4a92:: with SMTP id lp18mr42067896pjb.55.1636938181241;
        Sun, 14 Nov 2021 17:03:01 -0800 (PST)
Received: from x1 ([156.146.34.6])
        by smtp.gmail.com with ESMTPSA id g17sm13164648pfv.136.2021.11.14.17.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 17:03:00 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:02:53 -0800
From:   Drew Fustini <drew@beagleboard.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: drivers/clocksource/timer-pistachio.c:74:22: warning: variable
 'overflow' set but not used
Message-ID: <20211115010253.GA325926@x1>
References: <202111120738.oAGjK5L8-lkp@intel.com>
 <20211114212938.GA317441@x1>
 <552daf37-c5eb-6634-7456-3fa39c74ebcb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552daf37-c5eb-6634-7456-3fa39c74ebcb@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 11:17:38PM +0100, Daniel Lezcano wrote:
> On 14/11/2021 22:29, Drew Fustini wrote:
> > On Fri, Nov 12, 2021 at 07:05:48AM +0800, kernel test robot wrote:
> >> Hi Drew,
> >>
> >> FYI, the error/warning still remains.
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   debe436e77c72fcee804fb867f275e6d31aa999c
> >> commit: a47d7ef4550d08fb428ea4c3f1a9c71674212208 clocksource/drivers/pistachio: Fix trivial typo
> >> date:   7 months ago
> >> config: mips-randconfig-r012-20210927 (attached as .config)
> >> compiler: mips-linux-gcc (GCC) 11.2.0
> >> reproduce (this is a W=1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a47d7ef4550d08fb428ea4c3f1a9c71674212208
> >>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>         git fetch --no-tags linus master
> >>         git checkout a47d7ef4550d08fb428ea4c3f1a9c71674212208
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips 
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All warnings (new ones prefixed by >>):
> >>
> >>    drivers/clocksource/timer-pistachio.c: In function 'pistachio_clocksource_read_cycles':
> >>>> drivers/clocksource/timer-pistachio.c:74:22: warning: variable 'overflow' set but not used [-Wunused-but-set-variable]
> >>       74 |         u32 counter, overflow;
> >>          |                      ^~~~~~~~
> >>
> >>
> >> vim +/overflow +74 drivers/clocksource/timer-pistachio.c
> >>
> >>     69	
> >>     70	static u64 notrace
> >>     71	pistachio_clocksource_read_cycles(struct clocksource *cs)
> >>     72	{
> >>     73		struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
> >>   > 74		u32 counter, overflow;
> >>     75		unsigned long flags;
> >>     76	
> >>     77		/*
> >>     78		 * The counter value is only refreshed after the overflow value is read.
> >>     79		 * And they must be read in strict order, hence raw spin lock added.
> >>     80		 */
> >>     81	
> >>     82		raw_spin_lock_irqsave(&pcs->lock, flags);
> >>     83		overflow = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
> 
> overflow is set here but then never reused in the function. So a call to
> gpt_readl without getting the return value is fine.
> 
> The warning is different from 'variable is unused'

Thank you for pointing that out.  I was reading it incorrectly.

As for this function, it seems that warning is a false positive as
the act of reading TIMER_CURRENT_OVERFLOW_VALUE causes the hardware
to refresh TIMER_CURRENT_VALUE.

Thanks,
Drew
