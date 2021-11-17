Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E7454D79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbhKQS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhKQS6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:58:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FDDC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:55:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso2889178wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbsC1YV+J4+wgwK4NyPt7SAXRLb/j1t3oTsRnz//xNQ=;
        b=NReV/C7t5JP1f7B15jYDp8ihTgacrINNH6POK/GC+E7a1T4rk18XfxVsFrJ/rKK544
         LMdJvf0qCQgkllUDYpXpc20klQAUwOAL0PN4wAdmqEhPc6XiDuisqqKPSAGvEbf2YRz4
         AEtGGorCl/LQ4su3ZTWXa6M0qzh4gbf7NjB4d1mYrL85ypKA2Thu6+5vmubf8sL1c05Z
         4msKabk8bKhgTWyWcsJhE8xtFuMa0zeBLjLa2S+EPbuajqpkFievlVXyKw24PcWYkG9q
         f5dgJ/srkMwkNCKJpwaZv2fBXqpzles47RIhqoPI2mqDAYZDte1jYz/XYlWDpMVtDvBt
         ulig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbsC1YV+J4+wgwK4NyPt7SAXRLb/j1t3oTsRnz//xNQ=;
        b=v8QDCZdc7xT1CQPr05EvuMc/hw6Mor+9R/2vSV5Ly4IfwaADD6EMC21ycJHBOIS1e7
         HhKp+sEqIQKMRSbTIlB7F3H9lTo12ulbXhOv5Z6MwgwaQfC/AfFK44DSuRCa9ePPkEUi
         NmQsg0ap0+IBvKglnPa/D8CFHSLjWDY5x3Q7AXwulgEo4C/z9gpOw9IaCxHA60CJYhc3
         mxfBCTnymfvhw3RctBSuEs0pZ61Wj0UcfrH1rZgWQAAyH0DrKrQUTNkOJ1GWM2yud0Sg
         UaiOLaXjEXnlGpHcuQF6OgSx/pIRrcx93kZlSgFImJ2hpqCZLG6zluZxKXQw/Nr9rxCu
         OjdA==
X-Gm-Message-State: AOAM530qSuHfxPHSmE7r8+kri02b0C/jGtsFVTz/Do0ztw69LjejWnWP
        tzWD1BUBYU9DocLsVlVohER2DR8IS75VrcponXw2IQ==
X-Google-Smtp-Source: ABdhPJzUCiaV0jnUWV0OkQawvb0/Pw2Tr0ufZk0qd4N4QvYTUTgo5zR5x4C9sAoWkMvUCCUiTQccCnwIxDXX+aXirJo=
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr2291198wml.49.1637175339771;
 Wed, 17 Nov 2021 10:55:39 -0800 (PST)
MIME-Version: 1.0
References: <202111180219.YkyoBMpf-lkp@intel.com>
In-Reply-To: <202111180219.YkyoBMpf-lkp@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 17 Nov 2021 10:55:28 -0800
Message-ID: <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:46 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> head:   d31c3c683ee668ba5d87c0730610442fd672525f
> commit: d31c3c683ee668ba5d87c0730610442fd672525f [1/1] x86/csum: Rewrite/optimize csum_partial()
> config: um-x86_64_defconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=d31c3c683ee668ba5d87c0730610442fd672525f
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip x86/core
>         git checkout d31c3c683ee668ba5d87c0730610442fd672525f
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um SUBARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/x86/um/../lib/csum-partial_64.c: In function 'csum_partial':
> >> arch/x86/um/../lib/csum-partial_64.c:98:12: error: implicit declaration of function 'load_unaligned_zeropad' [-Werror=implicit-function-declaration]
>       98 |   trail = (load_unaligned_zeropad(buff) << shift) >> shift;
>          |            ^~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>
>

Hmmm... it seems we need to guard this with CONFIG_DCACHE_WORD_ACCESS ?
