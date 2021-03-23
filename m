Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8054334589F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCWHZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhCWHZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:25:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59199C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:25:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x26so13366146pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tUyNdn8QB3VLpF2CNzu3DTFDZsp8jl7Ah1JuY2OPmzs=;
        b=CWLjVZFE9xAJxOxeTBt0QIkiayq4Xi3X+wbnAWNsP8TbQSfBbBOxgrdpE9JEpicgzV
         +ZQTiZPyovON6d3U8nuP/TCaN+B3RyNPn5uIY8TyPnkcR0ithscMU4W30G4lmlPY/MEB
         ckEfG1GhpuSp0va2L36yYNq70wXJyNp5Yax7KqSA0lsbXJptmHU0aXj4Pw5qLHZljtCm
         s1Q6IANNXL6a/EBIQuMDpQ748NPd5gm7zOzlIYCutkjlHuMdXJtbmAF8TqZlfjwWJoxK
         Lg034SYDP2BQXnZ9NAHMAldu10JZepS5bT6vc5q737V7n/Od+hq1g4/w/OEVtoEueELD
         cHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tUyNdn8QB3VLpF2CNzu3DTFDZsp8jl7Ah1JuY2OPmzs=;
        b=G31SNVPVcEzt3RII6ImJiYYw1q1LDEcKK9V34G1GQ53Jwd6/AE4QGC0Ol/3jiy9pc3
         ZJE6vHcrIT95XTteJwDrXgxMG5kb14Cu/NS+4cSQcfymuHmZnc+NWIu99H9wWcTD/VUp
         ou+gu81jbw/e/qkJ1qDQcYuxu2pbZm7YkNp1wKSRs7ywmfBMcTcIHG0Exi19auo5Kent
         Y6RDizDUZnigjX3JkaAb5OMtKlWyv2Fd+8MdF7aLTe+iH976ftZARkqeDWB4o8ugj64X
         T2JRJ6SviySyFnAhkAtNjdVGJnQuwtqfHq1MPlaIJKNR5hHyC8NXLIwA/XsotvANSRhd
         MP+g==
X-Gm-Message-State: AOAM530mNpsjJRSRvad1ck73Kk3UR550KyVF3i97HUXscom/tcuGwK93
        51XvloN6JXRJK/QRuBd96BYr8EEeOReSHg==
X-Google-Smtp-Source: ABdhPJyY527OWHFAv5imJde5wjfyVkz8FZ5/mN5T5mlK4UfF9vzUmzCl8Mwr/Kd8mtv3xzCIZZlabg==
X-Received: by 2002:a17:902:b7c5:b029:e6:1a9f:5f55 with SMTP id v5-20020a170902b7c5b02900e61a9f5f55mr3854418plz.57.1616484336894;
        Tue, 23 Mar 2021 00:25:36 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id j20sm1523915pjn.27.2021.03.23.00.25.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 00:25:36 -0700 (PDT)
Date:   Tue, 23 Mar 2021 12:55:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/opp/of.c:959:12: warning: stack frame size of 1056 bytes
 in function '_of_add_table_indexed'
Message-ID: <20210323072534.sif6hfei4zx5tzn3@vireshk-i7>
References: <202103231522.N0bCxZ97-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103231522.N0bCxZ97-lkp@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-21, 15:23, kernel test robot wrote:
> Hi Viresh,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   84196390620ac0e5070ae36af84c137c6216a7dc
> commit: 406e47652161d4f0d9bc4cd6237b36c51497ec75 opp: Create _of_add_table_indexed() to reduce code duplication
> date:   7 weeks ago
> config: powerpc64-randconfig-r023-20210323 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 14696baaf4c43fe53f738bc292bbe169eed93d5d)
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
> >> drivers/opp/of.c:959:12: warning: stack frame size of 1056 bytes in function '_of_add_table_indexed' [-Wframe-larger-than=]
>    static int _of_add_table_indexed(struct device *dev, int index)
>               ^
>    1 warning generated.

I have reported this on 1st march as well. Looks to be false positive.

-- 
viresh
