Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E71346BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhCWWQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhCWWPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:15:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA11C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:15:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 184so27685610ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfMZah0K8UP5R6bi3ZoMbEq+3WDbUSDtHxKNt9kk6c4=;
        b=kBSDOo/qv85giNSwvUUj9lnf2sjB8cEmkTdzqgaEhDZWbmpBgjJNcOKkEsHjQ32tMO
         MshlKI5rAqXl2nJsmQVfA/v0BpoVBzfKKHqIpk0h3OFpw+vv9NbgCfjfSruLQ+06fccv
         a3K0k/YU9pCBy1SkdYAZrH1Rj6XVpQ5KLFEvXV/2h0W6SFP9pqJ+EVsWNye4jSyVsHM4
         rVyrISTevnZLr5ZEAZNZPetj9RYMKa/k3YQk3VZ+V42oXSbszjGCpXV3Y0nq2Meaw02I
         /y+0VyWAcnVzTNVGcCg1RyR5Yn6ixy2lCrLEMEcer80PnGFfEyXGQNhdvqZ0hRvuhMqy
         EEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfMZah0K8UP5R6bi3ZoMbEq+3WDbUSDtHxKNt9kk6c4=;
        b=fVOkYZf7YAMC3x4DIrlcj16ui4kiBcdj5h7BJJjMf/VDtBGiwpvSjR3TEQ/ceYmrUm
         FGkiJPkA5qbUcX0v0oIlzt7MvQgmzohaAMr4saPuWWt0EDvKwiGSIpn65x5mQgZTNsbA
         xEf+VRfzUymgl1rQZBAm3H3gBmQZQcv6CKMq2HC4PcsTT82KVd/Z8Rkd21z2/C/Twdpj
         /mKcj+jLdrVz805zjTEuNanVrpJZFkfs7dLWaHMNXqiRZevehFN3SdDwMBiJ8qILYB1/
         XTaNYY10pluaDFPOHXOGELRr/oan6BhcjzpOF2IQ8SWMq0UP/Yv2JVqjn8R7ufht+eOS
         v2Iw==
X-Gm-Message-State: AOAM533KoBkGg9WhdjlcoiovTma0jvQ+JVG8Nta/UI6nshbp+1CcmGI8
        XMfkEjg1+8b6SzQLX7cjFMNoRgC7MVs7COqn8BzWQA==
X-Google-Smtp-Source: ABdhPJzjOCzTp/5IeIW8q17BrHpY9adtSlyIEOWdTpBzx6nJzUFbjspu+0APOuYABwcydfYYAmJtSS1xXWtq2ET+M04=
X-Received: by 2002:a2e:868e:: with SMTP id l14mr37001lji.479.1616537740161;
 Tue, 23 Mar 2021 15:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <202103201405.UV0ZEGEW-lkp@intel.com>
In-Reply-To: <202103201405.UV0ZEGEW-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Mar 2021 15:15:29 -0700
Message-ID: <CAKwvOdnik8k7-xMmwtVbwtnispGt03C0acPAPWJRuo7t+VkftQ@mail.gmail.com>
Subject: Re: drivers/gpu/drm/i915/gvt/gtt.c:267:19: error: unused function 'get_pt_type'
To:     Changbin Du <changbin.du@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 11:45 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1c273e10bc0cc7efb933e0ca10e260cdfc9f0b8c
> commit: 9f4069b055d1508c833115df7493b6e0001e5c9b drm/i915: re-disable -Wframe-address

This in unrelated to my change.

+ Changbin, Zhenyu (authors of 3aff3512802) and Zhi (author of
054f4eba2a298) in case there's any interest in fixing this up.
Otherwise I don't think these tiny helpful functions were meant to be
used somewhere but are not, so there's not much value in cleaning them
up.

> date:   11 months ago
> config: x86_64-randconfig-a016-20210319 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project fcc1ce00931751ac02498986feb37744e9ace8de)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f4069b055d1508c833115df7493b6e0001e5c9b
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9f4069b055d1508c833115df7493b6e0001e5c9b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> drivers/gpu/drm/i915/gvt/gtt.c:267:19: error: unused function 'get_pt_type' [-Werror,-Wunused-function]
>    static inline int get_pt_type(int type)
>                      ^
> >> drivers/gpu/drm/i915/gvt/gtt.c:590:20: error: unused function 'ppgtt_set_guest_root_entry' [-Werror,-Wunused-function]
>    static inline void ppgtt_set_guest_root_entry(struct intel_vgpu_mm *mm,
>                       ^
>    2 errors generated.
>
>
> vim +/get_pt_type +267 drivers/gpu/drm/i915/gvt/gtt.c
>
> 2707e44466881d6 Zhi Wang 2016-03-28  266
> 054f4eba2a2985b Zhi Wang 2017-10-10 @267  static inline int get_pt_type(int type)
> 054f4eba2a2985b Zhi Wang 2017-10-10  268  {
> 054f4eba2a2985b Zhi Wang 2017-10-10  269        return gtt_type_table[type].pt_type;
> 054f4eba2a2985b Zhi Wang 2017-10-10  270  }
> 054f4eba2a2985b Zhi Wang 2017-10-10  271
>
> :::::: The code at line 267 was first introduced by commit
> :::::: 054f4eba2a2985b1db43353b7b5ce90e96cf9bb9 drm/i915/gvt: Introduce page table type of current level in GTT type enumerations
>
> :::::: TO: Zhi Wang <zhi.a.wang@intel.com>
> :::::: CC: Zhenyu Wang <zhenyuw@linux.intel.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
