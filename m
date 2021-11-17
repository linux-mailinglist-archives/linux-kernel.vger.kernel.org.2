Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BD145429B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhKQIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:30:50 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50168
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhKQIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:30:49 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 005CD40016
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637137669;
        bh=P95dsz5DnmdjZd6IIMhwxlUD+8WIlKXIhjrCFJuQBiY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bR9erVziguuB4GK69yq32UCG9AstcMTmwaywevrKKmO819sWct6ckvFyNuNRwdZwQ
         zcOjw6kTJD75FncufTx9J6mK4R2hwIyxoj1e2o0RJge7HkxopMgnu9KTh+F4/toVAK
         6BR3Fl137YFVpn4N923Zd5SbOTbW03lTsVdOzXrRuOwxIDctv5Jng3OiD1Di+rRMHp
         eX04UJGLgzmbzYqDD2UR6+UtZKkmoUK53jGdYZknCuZ5a4t+C/C07+7bQ9mkXFuS84
         +E6c4rj6WqSgCgBHpkLWrhb4U2gx9oeTzqNe15J6+pBtJM27VdCcgcxCpFOWUagjbs
         XrJDqyrfMOOVw==
Received: by mail-lf1-f72.google.com with SMTP id z1-20020a056512308100b003ff78e6402bso985628lfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P95dsz5DnmdjZd6IIMhwxlUD+8WIlKXIhjrCFJuQBiY=;
        b=Mgmk3gvBpvdAcd/kP/o2QqyGy7tud5cw2nFutWJ0u+X6RJ97O1keoMn9hNCyB300lO
         Fx7kdG4uOAAqv26KlaVd/IjdHk5ExSmms+0xZAEehIIR6nlSjI5wzYu5WO3was+ZSYRG
         MpNC0gIKudJ5dyeVLgT80aCP7OOP5Zgp7kqhdn/FA8CBuYMyWOHDikDOpa6gGo4YQoNG
         EVZPRl01gWJE8EodA5Z9I5QiT5EjLBcR3Or/RS9uOY9KwE8O6m3aLxwncpZvetT3Ku63
         QDhIiXyoFUPnA850KvHrOMsp2Yt8efJ1DfDPq5cBcsMoQNE8U/cMCPyVo8Pe/O+XggRl
         lsSg==
X-Gm-Message-State: AOAM5331X1Q7aaKEJPRRgnkNEb9QbGc2lrUkrpFZTUTVUWTliW6loL3c
        /S3HCMguxFOVZWtayp05l9jYEDP29b4+QoXaF89LlglLVewPFpKV1Ot00fyj+I9bthMFlklc9dQ
        LJHOSMQR7RjxNlHABJMCu/U6FIk57/criwbIIYoFHbA==
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr13039261lfd.177.1637137668142;
        Wed, 17 Nov 2021 00:27:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdracRFgDN5bjVOqJs9kEp8rGYLeXyKT3Z97paO0yilkiZKv3mOw7ITb5/C3y0gQHc7iq+FQ==
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr13039238lfd.177.1637137667915;
        Wed, 17 Nov 2021 00:27:47 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k5sm2085654lja.34.2021.11.17.00.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 00:27:47 -0800 (PST)
Message-ID: <e448d7b7-0a7d-7c88-271f-75ed5ac7e13a@canonical.com>
Date:   Wed, 17 Nov 2021 09:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [krzk-mem-ctrl:for-v5.17/renesas-rpc 5/5]
 drivers/memory/renesas-rpc-if.c:253:14: warning: cast to smaller integer type
 'enum rpcif_type' from 'const void *'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa-dev@sang-engineering.com>
References: <202111171118.XlLOUQ87-lkp@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <202111171118.XlLOUQ87-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2021 04:56, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-v5.17/renesas-rpc
> head:   b04cc0d912eb80d3c438b11d96ca847c3e77e8ab
> commit: b04cc0d912eb80d3c438b11d96ca847c3e77e8ab [5/5] memory: renesas-rpc-if: Add support for RZ/G2L
> config: x86_64-buildonly-randconfig-r002-20211116 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4c2cf3a314d9131b1b288e7c8ab0c75ac1b2be1d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git/commit/?id=b04cc0d912eb80d3c438b11d96ca847c3e77e8ab
>         git remote add krzk-mem-ctrl https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
>         git fetch --no-tags krzk-mem-ctrl for-v5.17/renesas-rpc
>         git checkout b04cc0d912eb80d3c438b11d96ca847c3e77e8ab
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/memory/renesas-rpc-if.c:253:14: warning: cast to smaller integer type 'enum rpcif_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>            rpc->type = (enum rpcif_type)of_device_get_match_data(dev);
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 

I am afraid several drivers repeat this pattern and will be affected as
well on clang. GCC does not complain (apparently cast is enough for
GCC), but still this has to be fixed. Maybe cast via  uintptr_t would
quite it?

Let me know when I can expect the fix.

Best regards,
Krzysztof
