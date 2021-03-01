Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68513276B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 05:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhCAEdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 23:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhCAEdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 23:33:23 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2EAC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 20:31:11 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n10so10676894pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 20:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mSJn4TXBF6F/cVvF14ipvDPkOG0Djovk3aa2cutiBzI=;
        b=ZCAPQW3oFP/1789rizFEPJiPEA/23hEmg/vlI03caB+Z83ojrpN/gjLPbY/9/cEIYR
         1he1v/1Jj/2u3++xS0EbYo94JxW1XP3X2mSe4kDYN9yENnlqivXUG/c2/9muwWIqT4dg
         1QIwTOfzTT3GXJOKOM5NIzS4f6ZX6GolbqvK48AoZGiqjFR2soYAYVyUeNEGUgZfOIku
         QrGanBeuhffZa9saVFXh29oUzCnGa6jwK0ubuE2Gle9ZwsLwzWQPfudCNHW/gszAE0OU
         YtiWtaM0ZRYQk0/+7v65MLVmc3VB1jG+DgT7XmROI7A0GJCB1jMEduFtEv5araZIG8zr
         tO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mSJn4TXBF6F/cVvF14ipvDPkOG0Djovk3aa2cutiBzI=;
        b=eDdbY+HDfmRo5FLDPhbBAw02YYiqKcp+GGWAf/XQ+Stj/PszCcLnpZrygGVXvowETA
         k+j0SWAqN718iGW6FE6dPInrgs1N3AuOfFfsLtgBUkecbn3fM9rWVMZQ/ArrS65yxRBb
         Zv+jJJre7+Tt40pQbgSYlLCZx4vT7Mrr9qgSS5NtNu1rweUeZVnpsGfC/1NyjIw/QsJA
         GTxwYjAydSRssuzczPRKaPL/Wwu0UIIUangXBJ1g3bDXKIFhUkjuRimsvV0PNx/wHxJG
         DeVR2pq3Un2A6hK5jq8wKvDEHbgt8+FKymlTwpNAFlT9wF0iRH2Mmjst6mW1traS+xVi
         rPeA==
X-Gm-Message-State: AOAM533oCY8if6sYxkRJhuqHDS6J03IbLnJS4QCk0FKQml7yODTJdMLP
        HHvNJsEV62fd9MNbJjv15WeNcg==
X-Google-Smtp-Source: ABdhPJx+qk9U65QsoeT8bQt8peEZroxv8wHtOZVcvAwVJNXOBsq42bfqNOz+jFPNzuK4RbJQLgqKOg==
X-Received: by 2002:a63:c702:: with SMTP id n2mr12041155pgg.382.1614573070993;
        Sun, 28 Feb 2021 20:31:10 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id w188sm15948916pfw.177.2021.02.28.20.31.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 20:31:10 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:01:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/opp/of.c:959:12: warning: stack frame size of 2064 bytes
 in function '_of_add_table_indexed'
Message-ID: <20210301043107.h73hc4vkhl76dmju@vireshk-i7>
References: <202102280251.dKJVeVYC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102280251.dKJVeVYC-lkp@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-02-21, 02:11, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3fb6d0e00efc958d01c2f109c8453033a2d96796
> commit: 406e47652161d4f0d9bc4cd6237b36c51497ec75 opp: Create _of_add_table_indexed() to reduce code duplication
> date:   4 weeks ago
> config: powerpc64-randconfig-r002-20210227 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 83bc7815c4235786111aa2abf7193292e4a602f5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc64 cross compiling tool for clang build
>         # apt-get install binutils-powerpc64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=406e47652161d4f0d9bc4cd6237b36c51497ec75
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 406e47652161d4f0d9bc4cd6237b36c51497ec75
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/opp/of.c:959:12: warning: stack frame size of 2064 bytes in function '_of_add_table_indexed' [-Wframe-larger-than=]
>    static int _of_add_table_indexed(struct device *dev, int index)
>               ^
>    1 warning generated.
> 
> 
> vim +/_of_add_table_indexed +959 drivers/opp/of.c
> 
>    958	
>  > 959	static int _of_add_table_indexed(struct device *dev, int index)
>    960	{
>    961		struct opp_table *opp_table;
>    962		int ret, count;

Is this a false positive ?

-- 
viresh
