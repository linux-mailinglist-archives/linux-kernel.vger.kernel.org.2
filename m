Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3875838071D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhENKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhENKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:24:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:23:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k5so5634965pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1Vb3CkCdQRckZoK8BO0wpd0OERz+s8v1RVB8LrgGLQ=;
        b=HKFSFq+zwoD39PvtdIP1PMUASr/z2W/BtRLnSbtk0XM87XPcgoKvzHpoJOQG9yj6wh
         3lLROw7NlLCljFBrK7VjcXDLCEwEaGFvUSSZoH0vZO2Nz8heb1r/6o1QAzxsGqSD4qUD
         vvkJJC6JfHGxTNwfYeE4ER2bnGr39FX37GvfNxgP6Gv1DU0LRDr/792ST9Q39CfMjqHy
         cYXzDOyb7JQQa6DxdmIwSfPUyUgmexYG21r388iy53dJXHQLH1Nr28N0I2PwqATurT7x
         PVLQjFoPx2JRAHeTuXTb6vggUqk/OARkWT1EhLpIEJFqUVeMBznf1wr+NjPwCr/hmuZ8
         u06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1Vb3CkCdQRckZoK8BO0wpd0OERz+s8v1RVB8LrgGLQ=;
        b=rprE9FDwcEGviBYTG4I7/6YS5HcfRGfQPPQ5Vwn1cD3baTLKj11JkPksg/GOWtw+Mu
         WHCY52j53PJBM/GaNOvyLq5Qg8GpC+/iVDleIKaYg4QQ5zACt1+K7chqlAr7cgxMLl5u
         ee/Y8HLgqPSRk5shT55evqFvI798LIg98UGkgsiW2nj/Q8pBLx+LCke5Xu7JnOVC7cg9
         UwWORTVwMqF+9d8Wx6hC+m1dCp8pEis5u2O2MW1wbGb5gEI58eSSkBvxEsXVnISCr4Ay
         mITV4aZrodgqZLA2Zr4DdQlpdYZxdp24DRJQ5gk/8/hF583ay/R9Aeu5CYv256efiJU6
         FNRA==
X-Gm-Message-State: AOAM53091/1C8KPg+lKIIlfaIVN5PMWEatvNYQQ1xK96Ik5RMsK1xqo3
        yKgGWZ8rOHSMVom+MmEc+ys7TmKrXCjsNrerXE7j8A==
X-Google-Smtp-Source: ABdhPJwcn9zwcZJUJ80DsdbUERAMq22UrUAk6Y3ZTkjNzgjmzDKZKMxA/hFkdYZvbKLkA34JWDdtzJN+UExtQmWpSnw=
X-Received: by 2002:a17:90b:224c:: with SMTP id hk12mr52091638pjb.37.1620987821429;
 Fri, 14 May 2021 03:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <202105132239.YLq2DvEA-lkp@intel.com>
In-Reply-To: <202105132239.YLq2DvEA-lkp@intel.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Fri, 14 May 2021 18:23:30 +0800
Message-ID: <CABvJ_xhxog_MoNZFWnog+_vSBOXAX8+_KbnfyCrue5TGzDS20w@mail.gmail.com>
Subject: Re: arch/riscv/errata/sifive/errata_cip_453.S:25: Error: Improper
 shift amount (38)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
The resolved patch "0e0d49925" lacks a change, so this error still happens.
I apologize for any inconvenience caused by this stupid mistake.

Vincent Chen

On Thu, May 13, 2021 at 10:38 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Vincent,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c06a2ba62fc401b7aaefd23f5d0bc06d2457ccc1
> commit: 800149a77c2cb8746a94457939b1ba1e37d2c14e riscv: sifive: Apply errata "cip-453" patch
> date:   2 weeks ago
> config: riscv-randconfig-r023-20210513 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=800149a77c2cb8746a94457939b1ba1e37d2c14e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 800149a77c2cb8746a94457939b1ba1e37d2c14e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/riscv/errata/sifive/errata_cip_453.S: Assembler messages:
> >> arch/riscv/errata/sifive/errata_cip_453.S:25: Error: Improper shift amount (38)
>    arch/riscv/errata/sifive/errata_cip_453.S:25: Error: Improper shift amount (39)
>    arch/riscv/errata/sifive/errata_cip_453.S:35: Error: Improper shift amount (38)
>    arch/riscv/errata/sifive/errata_cip_453.S:35: Error: Improper shift amount (39)
>
>
> vim +25 arch/riscv/errata/sifive/errata_cip_453.S
>
>     23
>     24  ENTRY(sifive_cip_453_page_fault_trp)
>   > 25          ADD_SIGN_EXT a0, t0, t1
>     26  #ifdef CONFIG_MMU
>     27          la t0, do_page_fault
>     28  #else
>     29          la t0, do_trap_unknown
>     30  #endif
>     31          jr t0
>     32  END(sifive_cip_453_page_fault_trp)
>     33
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
