Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3180E3E1F50
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhHEXYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhHEXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:24:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBF0C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 16:23:52 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id n6so9291113ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47DQLvtp4ztjhlhi+MnYXklbjCJaPGn/G49mrBRqTus=;
        b=rHqn6IRzSOxAV2XWjy54lh6YeMg/2a70afq/Hk/j1VmuUN6NpsxEz25LYnWS5LKon7
         lKjoKzXZYVEnD94O3NyvkLAThg5Mkh0B0ibRIrVPRJfCovodU4V5b/nkqLVcWYUam4Gb
         Z30f5zmYEN2FFEudIeny+FvrNFxkLs7KEhfgPBq6fECsaONt2O+U52oSYsQPDbLePpxt
         Htj4ElIMixweOxYhChvhzpvoosdNQ9DCuRfleo9mA+9OYJYeV25VRjwxOS7FH99jEeRG
         hz0JyXBrYEWoKWRra9aiBW/kDuJXyz4Dq+gxGPLHRKxFedyqjfkC876jA5rekNua288e
         CkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47DQLvtp4ztjhlhi+MnYXklbjCJaPGn/G49mrBRqTus=;
        b=BGEdawxN9iSl9pUGI8apkB07m4q5ySYVR15Nk7cvOe83pZkjDxDcJiEzPkO1XYG7zg
         HSBBP8krrN6KHitNCmBXib24jocVnv6l3Kki6RG/orCBijOJQkLTJq+VOP/yz8RAZK+H
         GFFwWkGt8OeMcJy1FCWWzbWk2GeFH+l0lCD3jAjCOI197YqFPf2Wzffn6SV/v8LrRGSw
         aiPam0FFC9lLdPKDaffWXSsye+aw6TADQjWeZaBGEzYjvBqaj1MAKNE913zqO0wwRJuA
         z6fBnHxven0oznnz6Czpb6H/AXROr51EtpPNLJxW6+K7iWxC9HREPbMEDoQbZqfR3jnB
         uLTA==
X-Gm-Message-State: AOAM530m2Cw/PsP4xO7TAR7N+mfeob8/Akgy8bzujPuACe2xQ+ePBiDs
        Iks/AqYYLtcpTnFW+fIhgqzdNPeKmy1dHvOAnf5fYPRhpgC6IDs/
X-Google-Smtp-Source: ABdhPJxJqsDZYK+zTrKpHR/WGOAJHzqAxDx5HJhRSJns86qkPnv24HqIlnmCzXa7UFQhWhJU97kgYj5LBQz+MYOtpgs=
X-Received: by 2002:a05:651c:38f:: with SMTP id e15mr4651454ljp.233.1628205831069;
 Thu, 05 Aug 2021 16:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <202108060412.oMqAe0rc-lkp@intel.com>
In-Reply-To: <202108060412.oMqAe0rc-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 5 Aug 2021 16:23:40 -0700
Message-ID: <CAKwvOdk6PNK1unJ2Yym4WHV=AXjdYwEyfWf_fPxO013ZtJa6Yw@mail.gmail.com>
Subject: Re: [linux-stable-rc:linux-4.19.y 1181/1498] ERROR:
 "__compiletime_assert_491" [drivers/gpu/drm/i915/i915.ko] undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 1:24 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> head:   7457eed4b647560ae1b1800c295efc5f1db22e4b
> commit: 7c29fd831799d09474dfdae556207b7102647a45 [1181/1498] lib/string.c: implement stpcpy
> config: x86_64-randconfig-r024-20210805 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 31a71a393f65d9e07b5b0756fef9dd16690950ee)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=7c29fd831799d09474dfdae556207b7102647a45
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-4.19.y
>         git checkout 7c29fd831799d09474dfdae556207b7102647a45
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> ERROR: "__compiletime_assert_491" [drivers/gpu/drm/i915/i915.ko] undefined!

^ I'm actively trying to improve these diagnostics in LLVM at the
moment. Hopefully that will make this report clearer!
https://reviews.llvm.org/D106030

>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
