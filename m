Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE53AA6BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhFPWpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233244AbhFPWpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:45:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01B8C613BD;
        Wed, 16 Jun 2021 22:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623883403;
        bh=yMM3htA5Y5tTyramnAAxka7NwIQOSfhS4YKOBiTtUHo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mVUEI/LmxUsEbx62cQQ+U0YxT2LCwhMDM6j+nRg46nsTt+pwU02xdLEbfqUhx4eAj
         pOAfgQ+2dmajOvXkhJMV87wbHfirWwCMd5pLZP9oYfvjrKnirBhO/ld6K7cTexIoit
         RXQ/l4ESDLXvIAt50Mr2AjiF2Yml80lsUAMzU541mBmuJLXfFDYL8RxyNdZ2jckYDK
         KqNjvIHRMR0VRbry3ZgoCC7zxtDAhc5DM9DXlP76YdEXMeLE8+CyQ/sDIPudQ2Q0OP
         Gz6L0vH12g7aO53iiJjr7IPkj8Y0cCWMnaIBaGY5RbdjDMHmcaRVQz7fDUq/wOgThF
         NiMz91dMLpDUA==
Subject: Re: drivers/crypto/talitos.c:3328:12: warning: stack frame size of
 1040 bytes in function 'talitos_probe'
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <202106100743.JgPkQBD1-lkp@intel.com>
 <29dbb338-f42b-8665-a58f-5242df1b12f9@csgroup.eu>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <a2dc22ce-30af-0cb0-130c-1078e7ef52a5@kernel.org>
Date:   Wed, 16 Jun 2021 15:43:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <29dbb338-f42b-8665-a58f-5242df1b12f9@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/2021 10:01 PM, Christophe Leroy wrote:
> 
> 
> Le 10/06/2021 à 01:50, kernel test robot a écrit :
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   368094df48e680fa51cedb68537408cfa64b788e
>> commit: 43a942d27eaaf33bca560121cbe42f3637e92880 crypto: talitos - Fix 
>> ctr(aes) on SEC1
>> date:   4 months ago
>> config: powerpc-randconfig-r031-20210610 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 
>> d2012d965d60c3258b3a69d024491698f8aec386)
> 
> That's likely a CLANG issue.
> 
> With the same commit and the same .config, talitos_probe() has a frame 
> of 112 bytes when built with GCC 11
> 
> Christophe

It is probably the same root cause as 
https://github.com/ClangBuiltLinux/linux/issues/1379 because I can 
reproduce it with mpc83xx_defconfig + CONFIG_UBSAN=y + 
CONFIG_UBSAN_ALIGNMENT=y.

Cheers,
Nathan

>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install powerpc cross compiling tool for clang build
>>          # apt-get install binutils-powerpc-linux-gnu
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=43a942d27eaaf33bca560121cbe42f3637e92880 
>>
>>          git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 43a942d27eaaf33bca560121cbe42f3637e92880
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
>> ARCH=powerpc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     __do_insb
>>     ^
>>     arch/powerpc/include/asm/io.h:556:56: note: expanded from macro 
>> '__do_insb'
>>     #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), 
>> (b), (n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from drivers/crypto/talitos.c:19:
>>     In file included from include/linux/interrupt.h:11:
>>     In file included from include/linux/hardirq.h:10:
>>     In file included from arch/powerpc/include/asm/hardirq.h:6:
>>     In file included from include/linux/irq.h:20:
>>     In file included from include/linux/io.h:13:
>>     In file included from arch/powerpc/include/asm/io.h:619:
>>     arch/powerpc/include/asm/io-defs.h:45:1: warning: performing 
>> pointer arithmetic on a null pointer has undefined behavior 
>> [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 
>> 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:225:1: note: expanded from here
>>     __do_insw
>>     ^
>>     arch/powerpc/include/asm/io.h:557:56: note: expanded from macro 
>> '__do_insw'
>>     #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), 
>> (b), (n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from drivers/crypto/talitos.c:19:
>>     In file included from include/linux/interrupt.h:11:
>>     In file included from include/linux/hardirq.h:10:
>>     In file included from arch/powerpc/include/asm/hardirq.h:6:
>>     In file included from include/linux/irq.h:20:
>>     In file included from include/linux/io.h:13:
>>     In file included from arch/powerpc/include/asm/io.h:619:
>>     arch/powerpc/include/asm/io-defs.h:47:1: warning: performing 
>> pointer arithmetic on a null pointer has undefined behavior 
>> [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 
>> 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:227:1: note: expanded from here
>>     __do_insl
>>     ^
>>     arch/powerpc/include/asm/io.h:558:56: note: expanded from macro 
>> '__do_insl'
>>     #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), 
>> (b), (n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from drivers/crypto/talitos.c:19:
>>     In file included from include/linux/interrupt.h:11:
>>     In file included from include/linux/hardirq.h:10:
>>     In file included from arch/powerpc/include/asm/hardirq.h:6:
>>     In file included from include/linux/irq.h:20:
>>     In file included from include/linux/io.h:13:
>>     In file included from arch/powerpc/include/asm/io.h:619:
>>     arch/powerpc/include/asm/io-defs.h:49:1: warning: performing 
>> pointer arithmetic on a null pointer has undefined behavior 
>> [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned 
>> long c),
>>     
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
>>
>>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 
>> 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:229:1: note: expanded from here
>>     __do_outsb
>>     ^
>>     arch/powerpc/include/asm/io.h:559:58: note: expanded from macro 
>> '__do_outsb'
>>     #define __do_outsb(p, b, n)     
>> writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                             ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from drivers/crypto/talitos.c:19:
>>     In file included from include/linux/interrupt.h:11:
>>     In file included from include/linux/hardirq.h:10:
>>     In file included from arch/powerpc/include/asm/hardirq.h:6:
>>     In file included from include/linux/irq.h:20:
>>     In file included from include/linux/io.h:13:
>>     In file included from arch/powerpc/include/asm/io.h:619:
>>     arch/powerpc/include/asm/io-defs.h:51:1: warning: performing 
>> pointer arithmetic on a null pointer has undefined behavior 
>> [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned 
>> long c),
>>     
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
>>
>>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 
>> 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:231:1: note: expanded from here
>>     __do_outsw
>>     ^
>>     arch/powerpc/include/asm/io.h:560:58: note: expanded from macro 
>> '__do_outsw'
>>     #define __do_outsw(p, b, n)     
>> writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                             ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from drivers/crypto/talitos.c:19:
>>     In file included from include/linux/interrupt.h:11:
>>     In file included from include/linux/hardirq.h:10:
>>     In file included from arch/powerpc/include/asm/hardirq.h:6:
>>     In file included from include/linux/irq.h:20:
>>     In file included from include/linux/io.h:13:
>>     In file included from arch/powerpc/include/asm/io.h:619:
>>     arch/powerpc/include/asm/io-defs.h:53:1: warning: performing 
>> pointer arithmetic on a null pointer has undefined behavior 
>> [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned 
>> long c),
>>     
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
>>
>>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 
>> 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:233:1: note: expanded from here
>>     __do_outsl
>>     ^
>>     arch/powerpc/include/asm/io.h:561:58: note: expanded from macro 
>> '__do_outsl'
>>     #define __do_outsl(p, b, n)     
>> writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                             ~~~~~~~~~~~~~~~~~~~~~^
>>>> drivers/crypto/talitos.c:3328:12: warning: stack frame size of 1040 
>>>> bytes in function 'talitos_probe' [-Wframe-larger-than=]
>>     static int talitos_probe(struct platform_device *ofdev)
>>                ^
>>     8 warnings generated.
>>
>>
>> vim +/talitos_probe +3328 drivers/crypto/talitos.c
>>
>> c3e337f88a5b37 Kim Phillips     2011-11-21  3327
>> 1c48a5c93da631 Grant Likely     2011-02-17 @3328  static int 
>> talitos_probe(struct platform_device *ofdev)
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3329  {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3330      struct device 
>> *dev = &ofdev->dev;
>> 61c7a080a5a061 Grant Likely     2010-04-13  3331      struct 
>> device_node *np = ofdev->dev.of_node;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3332      struct 
>> talitos_private *priv;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3333      int i, err;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3334      int stride;
>> fd5ea7f011932d LEROY Christophe 2017-10-06  3335      struct resource 
>> *res;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3336
>> 24b92ff276e8f6 LEROY Christophe 2017-10-06  3337      priv = 
>> devm_kzalloc(dev, sizeof(struct talitos_private), GFP_KERNEL);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3338      if (!priv)
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3339          return -ENOMEM;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3340
>> f3de9cb1ca6ce3 Kevin Hao        2014-01-28  3341      
>> INIT_LIST_HEAD(&priv->alg_list);
>> f3de9cb1ca6ce3 Kevin Hao        2014-01-28  3342
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3343      
>> dev_set_drvdata(dev, priv);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3344
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3345      priv->ofdev = 
>> ofdev;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3346
>> 511d63cb193292 Horia Geanta     2012-03-30  3347      
>> spin_lock_init(&priv->reg_lock);
>> 511d63cb193292 Horia Geanta     2012-03-30  3348
>> fd5ea7f011932d LEROY Christophe 2017-10-06  3349      res = 
>> platform_get_resource(ofdev, IORESOURCE_MEM, 0);
>> fd5ea7f011932d LEROY Christophe 2017-10-06  3350      if (!res)
>> fd5ea7f011932d LEROY Christophe 2017-10-06  3351          return -ENXIO;
>> fd5ea7f011932d LEROY Christophe 2017-10-06  3352      priv->reg = 
>> devm_ioremap(dev, res->start, resource_size(res));
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3353      if (!priv->reg) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3354          dev_err(dev, 
>> "failed to of_iomap\n");
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3355          err = -ENOMEM;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3356          goto err_out;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3357      }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3358
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3359      /* get SEC 
>> version capabilities from device tree */
>> fa14c6cfcecb00 LEROY Christophe 2017-10-06  3360      
>> of_property_read_u32(np, "fsl,num-channels", &priv->num_channels);
>> fa14c6cfcecb00 LEROY Christophe 2017-10-06  3361      
>> of_property_read_u32(np, "fsl,channel-fifo-len", &priv->chfifo_len);
>> fa14c6cfcecb00 LEROY Christophe 2017-10-06  3362      
>> of_property_read_u32(np, "fsl,exec-units-mask", &priv->exec_units);
>> fa14c6cfcecb00 LEROY Christophe 2017-10-06  3363      
>> of_property_read_u32(np, "fsl,descriptor-types-mask",
>> fa14c6cfcecb00 LEROY Christophe 2017-10-06  3364                   
>> &priv->desc_types);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3365
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3366      if 
>> (!is_power_of_2(priv->num_channels) || !priv->chfifo_len ||
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3367          
>> !priv->exec_units || !priv->desc_types) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3368          dev_err(dev, 
>> "invalid property data in device tree node\n");
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3369          err = -EINVAL;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3370          goto err_out;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3371      }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3372
>> f3c85bc1bc72b4 Lee Nipper       2008-07-30  3373      if 
>> (of_device_is_compatible(np, "fsl,sec3.0"))
>> f3c85bc1bc72b4 Lee Nipper       2008-07-30  3374          
>> priv->features |= TALITOS_FTR_SRC_LINK_TBL_LEN_INCLUDES_EXTENT;
>> f3c85bc1bc72b4 Lee Nipper       2008-07-30  3375
>> fe5720e2b7c1e8 Kim Phillips     2008-10-12  3376      if 
>> (of_device_is_compatible(np, "fsl,sec2.1"))
>> 60f208d7836216 Kim Phillips     2010-05-19  3377          
>> priv->features |= TALITOS_FTR_HW_AUTH_CHECK |
>> 79b3a418e09024 Lee Nipper       2011-11-21  3378                    
>> TALITOS_FTR_SHA224_HWINIT |
>> 79b3a418e09024 Lee Nipper       2011-11-21  3379                    
>> TALITOS_FTR_HMAC_OK;
>> fe5720e2b7c1e8 Kim Phillips     2008-10-12  3380
>> 21590888490ce2 LEROY Christophe 2015-04-17  3381      if 
>> (of_device_is_compatible(np, "fsl,sec1.0"))
>> 21590888490ce2 LEROY Christophe 2015-04-17  3382          
>> priv->features |= TALITOS_FTR_SEC1;
>> 21590888490ce2 LEROY Christophe 2015-04-17  3383
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3384      if 
>> (of_device_is_compatible(np, "fsl,sec1.2")) {
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3385          
>> priv->reg_deu = priv->reg + TALITOS12_DEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3386          
>> priv->reg_aesu = priv->reg + TALITOS12_AESU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3387          
>> priv->reg_mdeu = priv->reg + TALITOS12_MDEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3388          stride = 
>> TALITOS1_CH_STRIDE;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3389      } else if 
>> (of_device_is_compatible(np, "fsl,sec1.0")) {
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3390          
>> priv->reg_deu = priv->reg + TALITOS10_DEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3391          
>> priv->reg_aesu = priv->reg + TALITOS10_AESU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3392          
>> priv->reg_mdeu = priv->reg + TALITOS10_MDEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3393          
>> priv->reg_afeu = priv->reg + TALITOS10_AFEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3394          
>> priv->reg_rngu = priv->reg + TALITOS10_RNGU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3395          
>> priv->reg_pkeu = priv->reg + TALITOS10_PKEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3396          stride = 
>> TALITOS1_CH_STRIDE;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3397      } else {
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3398          
>> priv->reg_deu = priv->reg + TALITOS2_DEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3399          
>> priv->reg_aesu = priv->reg + TALITOS2_AESU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3400          
>> priv->reg_mdeu = priv->reg + TALITOS2_MDEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3401          
>> priv->reg_afeu = priv->reg + TALITOS2_AFEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3402          
>> priv->reg_rngu = priv->reg + TALITOS2_RNGU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3403          
>> priv->reg_pkeu = priv->reg + TALITOS2_PKEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3404          
>> priv->reg_keu = priv->reg + TALITOS2_KEU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3405          
>> priv->reg_crcu = priv->reg + TALITOS2_CRCU;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3406          stride = 
>> TALITOS2_CH_STRIDE;
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3407      }
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3408
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3409      err = 
>> talitos_probe_irq(ofdev);
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3410      if (err)
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3411          goto err_out;
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3412
>> c8c74647b2945e Christophe Leroy 2019-06-17  3413      if 
>> (has_ftr_sec1(priv)) {
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3414          if 
>> (priv->num_channels == 1)
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3415              
>> tasklet_init(&priv->done_task[0], talitos1_done_ch0,
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3416                       
>> (unsigned long)dev);
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3417          else
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3418              
>> tasklet_init(&priv->done_task[0], talitos1_done_4ch,
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3419                       
>> (unsigned long)dev);
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3420      } else {
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3421          if 
>> (priv->irq[1]) {
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3422              
>> tasklet_init(&priv->done_task[0], talitos2_done_ch0_2,
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3423                       
>> (unsigned long)dev);
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3424              
>> tasklet_init(&priv->done_task[1], talitos2_done_ch1_3,
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3425                       
>> (unsigned long)dev);
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3426          } else if 
>> (priv->num_channels == 1) {
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3427              
>> tasklet_init(&priv->done_task[0], talitos2_done_ch0,
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3428                       
>> (unsigned long)dev);
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3429          } else {
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3430              
>> tasklet_init(&priv->done_task[0], talitos2_done_4ch,
>> 9c02e2852fcabf LEROY Christophe 2017-10-06  3431                       
>> (unsigned long)dev);
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3432          }
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3433      }
>> dd3c0987f5426d LEROY Christophe 2015-04-17  3434
>> a86854d0c599b3 Kees Cook        2018-06-12  3435      priv->chan = 
>> devm_kcalloc(dev,
>> a86854d0c599b3 Kees Cook        2018-06-12  3436                    
>> priv->num_channels,
>> a86854d0c599b3 Kees Cook        2018-06-12  3437                    
>> sizeof(struct talitos_channel),
>> a86854d0c599b3 Kees Cook        2018-06-12  3438                    
>> GFP_KERNEL);
>> 4b992628812137 Kim Phillips     2009-08-13  3439      if (!priv->chan) {
>> 4b992628812137 Kim Phillips     2009-08-13  3440          dev_err(dev, 
>> "failed to allocate channel management space\n");
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3441          err = -ENOMEM;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3442          goto err_out;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3443      }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3444
>> f641ddddc3ad13 Martin Hicks     2015-03-03  3445      priv->fifo_len = 
>> roundup_pow_of_two(priv->chfifo_len);
>> f641ddddc3ad13 Martin Hicks     2015-03-03  3446
>> c3e337f88a5b37 Kim Phillips     2011-11-21  3447      for (i = 0; i < 
>> priv->num_channels; i++) {
>> 5fa7fa147b1572 LEROY Christophe 2015-04-17  3448          
>> priv->chan[i].reg = priv->reg + stride * (i + 1);
>> 2cdba3cf6ffc1f Kim Phillips     2011-12-12  3449          if 
>> (!priv->irq[1] || !(i & 1))
>> c3e337f88a5b37 Kim Phillips     2011-11-21  3450              
>> priv->chan[i].reg += TALITOS_CH_BASE_OFFSET;
>> ad42d5fc853832 Kim Phillips     2011-11-21  3451
>> 4b992628812137 Kim Phillips     2009-08-13  3452          
>> spin_lock_init(&priv->chan[i].head_lock);
>> 4b992628812137 Kim Phillips     2009-08-13  3453          
>> spin_lock_init(&priv->chan[i].tail_lock);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3454
>> a86854d0c599b3 Kees Cook        2018-06-12  3455          
>> priv->chan[i].fifo = devm_kcalloc(dev,
>> a86854d0c599b3 Kees Cook        2018-06-12  
>> 3456                          priv->fifo_len,
>> a86854d0c599b3 Kees Cook        2018-06-12  
>> 3457                          sizeof(struct talitos_request),
>> a86854d0c599b3 Kees Cook        2018-06-12  
>> 3458                          GFP_KERNEL);
>> 4b992628812137 Kim Phillips     2009-08-13  3459          if 
>> (!priv->chan[i].fifo) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3460              
>> dev_err(dev, "failed to allocate request fifo %d\n", i);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3461              err = 
>> -ENOMEM;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3462              goto 
>> err_out;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3463          }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3464
>> 4b992628812137 Kim Phillips     2009-08-13  3465          
>> atomic_set(&priv->chan[i].submit_count,
>> 4b992628812137 Kim Phillips     2009-08-13  3466                 
>> -(priv->chfifo_len - 1));
>> f641ddddc3ad13 Martin Hicks     2015-03-03  3467      }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3468
>> 81eb024c7e63f5 Kim Phillips     2009-08-13  3469      
>> dma_set_mask(dev, DMA_BIT_MASK(36));
>> 81eb024c7e63f5 Kim Phillips     2009-08-13  3470
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3471      /* reset and 
>> initialize the h/w */
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3472      err = 
>> init_device(dev);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3473      if (err) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3474          dev_err(dev, 
>> "failed to initialize device\n");
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3475          goto err_out;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3476      }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3477
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3478      /* register the 
>> RNG, if available */
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3479      if 
>> (hw_supports(dev, DESC_HDR_SEL0_RNG)) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3480          err = 
>> talitos_register_rng(dev);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3481          if (err) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3482              
>> dev_err(dev, "failed to register hwrng: %d\n", err);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3483              goto 
>> err_out;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3484          } else
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3485              
>> dev_info(dev, "hwrng\n");
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3486      }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3487
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3488      /* register 
>> crypto algorithms the device supports */
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3489      for (i = 0; i < 
>> ARRAY_SIZE(driver_algs); i++) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3490          if 
>> (hw_supports(dev, driver_algs[i].desc_hdr_template)) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3491              struct 
>> talitos_crypto_alg *t_alg;
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3492              struct 
>> crypto_alg *alg = NULL;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3493
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3494              t_alg = 
>> talitos_alg_alloc(dev, &driver_algs[i]);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3495              if 
>> (IS_ERR(t_alg)) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3496                  err 
>> = PTR_ERR(t_alg);
>> 0b2730d8d8b38e Kim Phillips     2011-12-12  3497                  if 
>> (err == -ENOTSUPP)
>> 79b3a418e09024 Lee Nipper       2011-11-21  3498                      
>> continue;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3499                  goto 
>> err_out;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3500              }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3501
>> acbf7c627fb59d Lee Nipper       2010-05-19  3502              switch 
>> (t_alg->algt.type) {
>> 373960d794d2b0 Ard Biesheuvel   2019-11-09  3503              case 
>> CRYPTO_ALG_TYPE_SKCIPHER:
>> 373960d794d2b0 Ard Biesheuvel   2019-11-09  3504                  err 
>> = crypto_register_skcipher(
>> 373960d794d2b0 Ard Biesheuvel   2019-11-09  
>> 3505                          &t_alg->algt.alg.skcipher);
>> 373960d794d2b0 Ard Biesheuvel   2019-11-09  3506                  alg 
>> = &t_alg->algt.alg.skcipher.base;
>> acbf7c627fb59d Lee Nipper       2010-05-19  3507                  break;
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3508
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3509              case 
>> CRYPTO_ALG_TYPE_AEAD:
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3510                  err 
>> = crypto_register_aead(
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3511                      
>> &t_alg->algt.alg.aead);
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3512                  alg 
>> = &t_alg->algt.alg.aead.base;
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3513                  break;
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3514
>> acbf7c627fb59d Lee Nipper       2010-05-19  3515              case 
>> CRYPTO_ALG_TYPE_AHASH:
>> acbf7c627fb59d Lee Nipper       2010-05-19  3516                  err 
>> = crypto_register_ahash(
>> acbf7c627fb59d Lee Nipper       2010-05-19  
>> 3517                          &t_alg->algt.alg.hash);
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3518                  alg 
>> = &t_alg->algt.alg.hash.halg.base;
>> acbf7c627fb59d Lee Nipper       2010-05-19  3519                  break;
>> acbf7c627fb59d Lee Nipper       2010-05-19  3520              }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3521              if (err) {
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3522                  
>> dev_err(dev, "%s alg registration failed\n",
>> aeb4c132f33d21 Herbert Xu       2015-07-30  3523                      
>> alg->cra_driver_name);
>> 24b92ff276e8f6 LEROY Christophe 2017-10-06  3524                  
>> devm_kfree(dev, t_alg);
>> 991155bacb91c9 Horia Geanta     2013-03-20  3525              } else
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3526                  
>> list_add_tail(&t_alg->entry, &priv->alg_list);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3527          }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3528      }
>> 5b859b6ebb18b3 Kim Phillips     2011-11-21  3529      if 
>> (!list_empty(&priv->alg_list))
>> 5b859b6ebb18b3 Kim Phillips     2011-11-21  3530          
>> dev_info(dev, "%s algorithms registered in /proc/crypto\n",
>> 5b859b6ebb18b3 Kim Phillips     2011-11-21  3531               (char 
>> *)of_get_property(np, "compatible", NULL));
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3532
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3533      return 0;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3534
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3535  err_out:
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3536      
>> talitos_remove(ofdev);
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3537
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3538      return err;
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3539  }
>> 9c4a79653b35ef Kim Phillips     2008-06-23  3540
>>
>> :::::: The code at line 3328 was first introduced by commit
>> :::::: 1c48a5c93da63132b92c4bbcd18e690c51539df6 dt: Eliminate 
>> of_platform_{,un}register_driver
>>
>> :::::: TO: Grant Likely <grant.likely@secretlab.ca>
>> :::::: CC: Grant Likely <grant.likely@secretlab.ca>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 

