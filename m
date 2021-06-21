Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626003AE8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:08:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC494C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:06:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x16so13451607pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dhey6DNL2ogOKRIaHxi5hPlcQvIhtGNJ9mhZh8P/uYk=;
        b=ULxBuc2F6IPVX+cShFxvY1JhiCxC+L0UzFLuU+mVY/5lcpXxMsnlp+60FyM17ISCBV
         QWv6JHa9i11Lrn+BLzEtjCQeteNQ6Ej1j3OKpQmTZSRgz9E/pOLzXwupmTSgOQhmf3Dm
         cCIZNKHbLKlbd8LqjEs5KFQ1RLIe7eL5ARaFmW1vyzQ3cLw/rzMqdmtS5zY4qNbuA7Vi
         vpNCCR3iMiuNjkIGc+5iG8Q2zI7GdJVj8xR9FYj8cehFWoFKD1DxhXm44TYtyfXkQsst
         fUXDbuw400IFWVVTKmDbS0ND37jKTQyiFbrUEWzkLMQosDqgdYSwtK79XgoEi2jHiuxd
         Bd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dhey6DNL2ogOKRIaHxi5hPlcQvIhtGNJ9mhZh8P/uYk=;
        b=G5yKMuduSITmQI2ref/eLc1vGE7KrHfk/BNLSqYu/sW5V1xvB9DnDmdPMGTe9XhuhW
         PekoyP6DSQVODGqwnvOnCtZ1gjgEBraWh1rJNAx7vOKd9ADX4YmB9SDlCYBvBdyF+D8B
         gxp3+thizAUdM9lhCma9CAh0VFx5Yrk7YVdDRildRMBDwr7LKwr/QjBSgD1LPuMFGiBr
         LOQIXnscsawvD+tYir9PULceNFUxtVpw8t5cEWZeu8CukrStYEEbQnpIamrfEqfWeoDY
         gqV6rww32WgkIWXtDQXjhSdce1VmaGc1wnqnXoFP5B/hOyDtVeTiAhZiTh08oDJ/saNF
         +A6Q==
X-Gm-Message-State: AOAM531GfgIDbdhe2xhI6keOwZU96GUG1J3UGR3txaaTFJXM8UpTq6Yy
        5XGCDGGU3QeWjNAM9pgMO00=
X-Google-Smtp-Source: ABdhPJy84cCGRZRvi+wLEb1t6F6ufWp1R7DByF9uonyAIuiEd0htSIni+2U/w3M5ujFeBBFO3FOkzg==
X-Received: by 2002:a65:4109:: with SMTP id w9mr23161356pgp.24.1624277180341;
        Mon, 21 Jun 2021 05:06:20 -0700 (PDT)
Received: from gmail.com (36-229-229-123.dynamic-ip.hinet.net. [36.229.229.123])
        by smtp.gmail.com with ESMTPSA id nv1sm15363076pjb.43.2021.06.21.05.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 05:06:19 -0700 (PDT)
Date:   Mon, 21 Jun 2021 20:06:16 +0800
From:   Jhih-Ming Huang <fbihjmeric@gmail.com>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: make[2]: *** No rule to make target
 '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/crypto/cmac.ko',
 needed by '__modinst'.
Message-ID: <20210621120616.vp4foapbgexf3nsn@gmail.com>
References: <202106211900.eGQt5TX8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106211900.eGQt5TX8-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 07:47:07PM +0800, kernel test robot wrote:
> Hi Jhih-Ming,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://github.com/0day-ci/linux/commits/UPDATE-20210621-162141/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
> head:   970a74bfa214d0d2e888d70974dd570293811429
> commit: 970a74bfa214d0d2e888d70974dd570293811429 rtw_security: fix cast to restricted __le32
> date:   3 hours ago
> config: x86_64-randconfig-a012-20210621 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project e1adf90826a57b674eee79b071fb46c1f5683cd0)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/970a74bfa214d0d2e888d70974dd570293811429
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review UPDATE-20210621-162141/Jhih-Ming-Huang/rtw_security-fix-cast-to-restricted-__le32/20210616-131056
>         git checkout 970a74bfa214d0d2e888d70974dd570293811429
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/Makefile:148: CONFIG_X86_X32 enabled but no binutils support
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/crypto/cmac.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/crypto/md5.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/crypto/sha512_generic.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/drivers/net/net_failover.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/drivers/net/virtio_net.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/fs/cifs/cifs.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/fs/nfs/nfsv4.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/lib/crypto/libarc4.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/net/core/failover.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/net/dns_resolver/dns_resolver.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/970a74bfa214d0d2e888d70974dd570293811429/lib/modules/5.13.0-rc6+/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko', needed by '__modinst'.
>    make[2]: Target '__modinst' not remade because of errors.
>    make[1]: *** [Makefile:1770: modules_install] Error 2
>    make: *** [Makefile:215: __sub-make] Error 2
>    make: Target 'modules_install' not remade because of errors.
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

I got this failed build message, and I think it might not be due to my patch.

But I am not sure. If I am wrong, please correct me.
or someone could hint me that it's due to which patch.

thanks.

jmhuang
