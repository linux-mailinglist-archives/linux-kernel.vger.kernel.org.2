Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC5844D3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhKKJMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:12:46 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42571 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKKJMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:12:45 -0500
Received: by mail-lj1-f174.google.com with SMTP id z8so10616965ljz.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ICMwE6mBU3+U59AMD72+KMhqe68grwCU5PoU7EorW2E=;
        b=CVbJfheAO9udHmXOuo+J3CnEe1htJmd9DhEU3O7yVClVj9YbWspI2ZhFjUpzkqedCo
         JADZTTYB6pHVr17dFbdy1//V39UT3fVrTk0r5ibe63ql07dQbJHwrBRRhWgaM+9Mg1sr
         BZFt81OQBxKcbmLnFLfiXnCNizgeWy+EMwh3BWhK3vKldasblQZR4yZGyXUPzEcE/Oep
         gpr5NIdty+pNjrgUdPlSQ+vAQTuWsbDiEROnQN61bpnYpqzb2FT0tRR+4nhU1nKHfUiW
         +65eCK4ZFZ7sclP3g6Ee35oEkqSHFCE73eszaITYm7cuWZiVpqJ7i7VpDeLmm37wbXan
         +MTw==
X-Gm-Message-State: AOAM5315caovxVQoh/iGCVklwwrAfGTph1UKDP23AcM/ulvieE3J2Orf
        azCoHrvOnor/FVF0DjBmVSZXAIuEZMY=
X-Google-Smtp-Source: ABdhPJwRYmxG9S6JONHhgNQ4iKqSBWy7Ma3yC3kdqEIiehIZMPZaGoRHcDt4hdiy+8RV/qxGwoU46Q==
X-Received: by 2002:a2e:1546:: with SMTP id 6mr5873356ljv.479.1636621795410;
        Thu, 11 Nov 2021 01:09:55 -0800 (PST)
Received: from [192.168.0.27] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.googlemail.com with ESMTPSA id l13sm255562lfh.270.2021.11.11.01.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 01:09:54 -0800 (PST)
Message-ID: <414fa559-59f3-5ede-37f6-0ba07a91dd1d@kernel.org>
Date:   Thu, 11 Nov 2021 10:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: arch/arm/mach-s3c/gpio-samsung.c:1309:14: warning: no previous
 prototype for 's3c2410_modify_misccr'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202111110424.gJwFXEma-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <202111110424.gJwFXEma-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2021 21:56, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   89d714ab6043bca7356b5c823f5335f5dce1f930
> commit: 71b9114d2c13a648fbe6523dd859e611c316ad90 ARM: s3c: move into a common directory
> date:   1 year, 3 months ago
> config: arm-randconfig-r006-20211002 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71b9114d2c13a648fbe6523dd859e611c316ad90
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 71b9114d2c13a648fbe6523dd859e611c316ad90
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> arch/arm/mach-s3c/gpio-samsung.c:1309:14: warning: no previous prototype for 's3c2410_modify_misccr' [-Wmissing-prototypes]
>     1309 | unsigned int s3c2410_modify_misccr(unsigned int clear, unsigned int change)
>          |              ^~~~~~~~~~~~~~~~~~~~~
> 
> 

I'll fix it, thanks!


Best regards,
Krzysztof
