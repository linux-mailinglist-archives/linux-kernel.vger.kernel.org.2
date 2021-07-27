Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D648B3D7A87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhG0QHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhG0QHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:07:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE21C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:07:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso5527932pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=41KZtnxHDTjq33R3cspPiVcp1KGqcbGFtsZJe9L+sTI=;
        b=L8CDfrLRlHUtIrKfExGFrezK2kqp6UMINg3HAhRS0rfOxKQjUSrrz8piAVWfY2Jx9v
         g2PFlEGYXFoXjt8NWUcWXorPnGOcSVucqdwJngU2hIBLls1quAo7Y6XIdIE37UJaS7zk
         qXDtzrrdbvpdV0qfXKddL6Z3p/EBKTR6Nyb/SQOwnMfOkd6FMDg0BysYAuQBAIm2iqWy
         zKq50psToyXOuU/oUOYvTmGuzWqTfCJ4s7Fa3hBVYUQNEMBP32GZJq/c86j8+G4Np7T1
         JXOoEkcxxbYDx9Rhz4MrpzBPmDmhIW3HwDNZxTlro34gnq932rFJBkr9CauoXO83woSQ
         kdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41KZtnxHDTjq33R3cspPiVcp1KGqcbGFtsZJe9L+sTI=;
        b=n0nDWIqdHKL2C8q0e4WIp/UeEQq8s3vUh7UEYA51Zv72QtonHgHU/8VnWSyi9I4alE
         wTRqAZHnG6yu/LXfKCODXiq7NArIHbGTrbtqJGTPGasUud4PSHjOskQNulwYwCRw3GiB
         97clwA4sY0Or6AHA/J6gY8lG7ArzWMr5spdGx1gqnH8UuN4Ve1lHOWyzVl1DIdY8ObfS
         DQXd9gqOwyP2HLTwZ/1fbqJe69ATDVwV81dY0PsposgrZQgJlGjgUD1DQR1ycB1ajFuo
         t2kUVrk34Aj/KzgXkntrNpy+jmVE7D/MRCARGdVHwCOoxnXJehRIZHxhgj/afP1OVcwM
         MWvw==
X-Gm-Message-State: AOAM531WycvtCKHkxEd52QPRxpHObQo8MXW5Mqq54bk5BNSHSFhrB4Gz
        C9hpV9kcAGTlEKqcDzgDKTDVbG59VkAteQ==
X-Google-Smtp-Source: ABdhPJzXhkHI+CP6UpkNWhntNvK6ufrjkRf6EaWVF9EZH92Ydyw1gzv1WUoITGeapxUq2Wi6AYExNA==
X-Received: by 2002:a63:f904:: with SMTP id h4mr24444836pgi.238.1627402072627;
        Tue, 27 Jul 2021 09:07:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j185sm515591pfb.86.2021.07.27.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:07:52 -0700 (PDT)
Date:   Tue, 27 Jul 2021 16:07:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Aaron Lewis <aaronlewis@google.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Graf <graf@amazon.com>
Subject: Re: lib/x86_64/handlers.S:20: Error: unrecognized instruction `call
 route_exception'
Message-ID: <YQAvVGwJqUak1E0l@google.com>
References: <202107270520.DIJjv4ia-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107270520.DIJjv4ia-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021, kernel test robot wrote:
> Hi Aaron,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ff1176468d368232b684f75e82563369208bc371
> commit: 29faeb9632012d6c3fa4aa33c3d589b9ff18b206 selftests: kvm: Add exception handling to selftests
> date:   9 months ago
> config: openrisc-randconfig-s031-20210726 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 10.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29faeb9632012d6c3fa4aa33c3d589b9ff18b206
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 29faeb9632012d6c3fa4aa33c3d589b9ff18b206
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1
>         CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc
>         SHELL=/bin/bash -C tools/testing/selftests install

KVM's selftests don't play nice with cross-compiles for unsupported architectures.
arm64 and s390 have expilict x86_64 -> {arm64,s390} support from commit 66d69e081b52
("selftests: fix kvm relocatable native/cross builds and installs"), but for
anything else the Makefile assumes an x86_64 target.

Realistically, only test bots are going to run afoul of our laziness.  Do we care
enough to fix this up properly? 
