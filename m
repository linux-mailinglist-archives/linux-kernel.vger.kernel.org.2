Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AC3B596B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhF1HFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhF1HFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:05:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AA9C061766;
        Mon, 28 Jun 2021 00:02:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nd37so28179765ejc.3;
        Mon, 28 Jun 2021 00:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=snyk/AXhy7GrEZfzYc6ccI7tWOy8mp8ddfAE4nP28I0=;
        b=OY0RRvBe/Cqd+CA8HKJkufMQUsqyWewAmN8AWozUQNEAlXTy7PI2hFZp90dydyOGYv
         IVBVkWUjgs6hIApJ+PrF7WVhzHqryi7ZyfbvxPpTdFthWxjdueBeFOYQCSFJl9w570Qz
         yszUQYaM8jrDnM+YVp6x7z0CwUa22QQAtZlMa0I3m8ZIovclykMX7h8wnQJcIZVNSATB
         D9mv6SgzI5SGIQgQwSB3fpW6YzhNxXgDTkzFsxgaBBNigtJVxOikts1U9uCcXBSA88iK
         njFtoZOljz2mSgejEZzHzrTE1xTNXk8WGBuD3YY/Jd7EcyyYZiLWfWZMoInQOPHr9pb7
         SkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=snyk/AXhy7GrEZfzYc6ccI7tWOy8mp8ddfAE4nP28I0=;
        b=Gjy1knYR0Ksa8e90xAmOhGSeqJ5DgUO7Dtp+oyS2W/UpJVvnYtVXXrDclAXvUsvj7L
         vhfp0An8imw+WCKH09TrpJd42BUxDMZgfiPQuyRJLNtSzt9UUr4bFBXf+M2NKa/KiKw8
         X5P2t4D/HkSxBobLR97NFONWjriGAY9AeTNiAoc8Ae4iL2Lh9HuVPTb9qZgZyynYDas/
         ELwsqNfFGw44AJeKXH3vZBBCBvvZiJk1FAk9jdsWWMi9mKje8L7bJpf6DASogk2Ncsur
         o2v/FptSjJjxdPnIL/pgl3u9v8GHOPRygMHs1hFRIkSeNNepMCGU64pjF48A+e81LAJt
         xm0w==
X-Gm-Message-State: AOAM530GV2nBdF4d4JJsbyrDZ3aeNqT1eg44XTGSwoUpkC6E0eeNr2ZK
        /RtmjafKfmMjR9SqpvfonEk=
X-Google-Smtp-Source: ABdhPJx1lPR7HFV30XJf1MGFUhzIqBWRw2VoffegpfT7ONKQn3Nj8iS1mXX/AYdwm1esMzeZr7hB1A==
X-Received: by 2002:a17:906:6ad3:: with SMTP id q19mr22626207ejs.11.1624863756946;
        Mon, 28 Jun 2021 00:02:36 -0700 (PDT)
Received: from ubuntu2004 ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id i21sm6444348ejo.9.2021.06.28.00.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:02:36 -0700 (PDT)
Date:   Mon, 28 Jun 2021 10:02:34 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: owl-s500: Add ethernet support
Message-ID: <20210628070234.GA1003245@ubuntu2004>
References: <222ee0c2cb431619f558dce9726585ac92f65e00.1623401998.git.cristian.ciocaltea@gmail.com>
 <202106162101.RfHWePKS-lkp@intel.com>
 <20210628062235.GA4033@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628062235.GA4033@workstation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On Mon, Jun 28, 2021 at 11:52:35AM +0530, Manivannan Sadhasivam wrote:
> Hi Cristi,
> 
> On Wed, Jun 16, 2021 at 09:30:13PM +0800, kernel test robot wrote:
> > Hi Cristian,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on robh/for-next]
> > [also build test ERROR on v5.13-rc6 next-20210615]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Cristian-Ciocaltea/Add-Ethernet-DTS-for-Actions-Semi-Owl-S500-SoCs/20210616-121106
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > config: arm-randconfig-r025-20210615 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/87e17f86112592e0805d0a081914f7b2eeb2770d
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Cristian-Ciocaltea/Add-Ethernet-DTS-for-Actions-Semi-Owl-S500-SoCs/20210616-121106
> >         git checkout 87e17f86112592e0805d0a081914f7b2eeb2770d
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> Error: arch/arm/boot/dts/owl-s500.dtsi:332.19-20 syntax error
> > >> FATAL ERROR: Unable to parse input tree
> 
> Did you look into this error? Looks like CLK_ETHERNET is not defined in
> the s500 CMU binding.

CLK_ETHERNET is introduced through patches 5 & 6 from the patch series:
"[PATCH v3 0/6] Improve clock support for Actions S500 SoC"

Most probably those patches were not applied to the tested kernel tree
and that's why the robot reported the error.

Thanks,
Cristi

> Today I saw that the clk patches are applied but then it is later for me
> to send the dts patches for v5.14. So please fix this error and
> resubmit, I'll take them for v5.15.
> 
> Thanks,
> Mani
> 
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
