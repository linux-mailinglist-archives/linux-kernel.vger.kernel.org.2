Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E47F45F6EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 23:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbhKZWoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 17:44:01 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39553 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243757AbhKZWmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 17:42:00 -0500
Received: by mail-pf1-f169.google.com with SMTP id i12so10157526pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 14:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MiJphoBmVhNFPT/wcZKae8pCULUw8u3DXyyuIxPFFoQ=;
        b=6Uam8D4ZS2my2TUFT9FRfgBHz4HfLSfElFRCPdvlPKr3rNm+9REWZGo8vVDotTeBlR
         C5OcrI+hOnODaL8NbI21VIpPRqJbeERxRl0B7tlVzK3QLWhlOFWVvdAF7k8Hcl/yvfjG
         Ht26R2m25OV/HSUCh1qYNFokOBEa5nrpahVfkO21zZPOYv3GekWLwmPQqpN2RewxqjdX
         DqYIY442fz4+C+Fb1Aav4PxQTXxdEI3MplqQ8PUuqkPIE9G0IJt2RI4wIKotJa0F5C6M
         liHjkj5grLcx2y5SSAWJrPQFZJn68i5fhYkMpXCfmwmVO25XLAGwC9inPsl3SMVPisHy
         9b6Q==
X-Gm-Message-State: AOAM533prHyNW2XetSoj8KFZuiXJRtEkAmH/5GSrMEiGhF4HaiNALlfr
        KLltxBqtw+TSygCWv1sFvUs=
X-Google-Smtp-Source: ABdhPJxyXoqCF5BemDwzMjWtBArkWtscBbxKccx1tzuWe+1f5Akk7+/C/kPrV0lrgpzh8UT0MxfWTQ==
X-Received: by 2002:a63:5b4d:: with SMTP id l13mr11538128pgm.120.1637966326943;
        Fri, 26 Nov 2021 14:38:46 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id t3sm9186037pfg.94.2021.11.26.14.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 14:38:46 -0800 (PST)
Message-ID: <daf91b05-4529-f3fe-957b-fce23f7cf763@acm.org>
Date:   Fri, 26 Nov 2021 14:38:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: esp_scsi.c:undefined reference to `scsi_done'
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <202111252028.JcclVVMH-lkp@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <202111252028.JcclVVMH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 04:18, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
> commit: f8ab27d9649440a4fa6e77bbea939a62fd44df27 scsi: esp_scsi: Call scsi_done() directly
> date:   6 weeks ago
> config: mips-buildonly-randconfig-r002-20211124 (https://download.01.org/0day-ci/archive/20211125/202111252028.JcclVVMH-lkp@intel.com/config)
> compiler: mips64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f8ab27d9649440a4fa6e77bbea939a62fd44df27
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout f8ab27d9649440a4fa6e77bbea939a62fd44df27
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_setsync':
>     esp_scsi.c:(.text+0xc04): undefined reference to `spi_display_xfer_agreement'

(+Masahiro Yamada)

In the config file mentioned above I found the following:

CONFIG_SCSI_SPI_ATTRS=m
CONFIG_JAZZ_ESP=y

And in drivers/scsi/Kconfig I found the following:

config JAZZ_ESP
	bool "MIPS JAZZ FAS216 SCSI support"
	depends on MACH_JAZZ && SCSI
	select SCSI_SPI_ATTRS
	help
	  [ ... ]

I think this indicates a bug in the kbuild infrastructure: if 
CONFIG_JAZZ_ESP is set to 'y' then CONFIG_SCSI_SPI_ATTRS also should be 
set to 'y'.

Thanks,

Bart.
