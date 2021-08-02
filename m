Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F123DDAE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhHBOYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbhHBOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:24:17 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44222C09B139
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:17:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id m11so11710666qtx.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lU4fWdbkHIbaESmwaFovFXTvcyMDqKiNbuZS1etsQvI=;
        b=cZBXn9YhMfiAIO+dsYROQ3IWMF2xrwr/imdQK8VJ7V8HB//j9+/Gf7NZt3McnI0FHm
         zV4T8AbA+c0ffAmttlbSkJ5j0lOV9hxjUpfIpB7rxmiaJaZErZxYX41VD1Qc5ADnL+rf
         bKI1TBtTilGKl7XkGUiCRw2DvfKsZsQZB1rdxrN5CfnvtABm6jA4CAe1AaJyRJA2GBgm
         UyGEku2mLmZ27L/H6fqvgKqAbas09hFDzaAFxujdBHG/XhGrSd+rPxR28AuGKuJqpOaj
         WPXfb/COMjYz0jHEjjmxxIMX3w75rto0/U3u2ihRY9jzFnD0VQrxJS3+pPqaDYffFDjU
         4Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lU4fWdbkHIbaESmwaFovFXTvcyMDqKiNbuZS1etsQvI=;
        b=OY3s/6aOevYclDmRSJSrYW0JW3nykJZg+dgF4emMvxFMNKf+WezzcqdYsVNAloA25P
         +8Rxtjwds01vE0QYCEdkHnHl6DK4cH6KIuuo1OmGgo5ct53v6aQt7cseF7W/SH4oszCc
         xdRRQtJjF+4Ssgy3zudAveQp3hZ3mTyNd/eOoU+ajANmbpB07RKa5JLYJw2XD8Xq+Vn9
         fS2CgqEBlUyKYzw20CvfcESSdmwUpLKoHZfR76/uFhuwJ+vBl9hK+1TXw7QrOVKXODPd
         pVKOCbsU6zkhM5WRIMyUVf9i/21tKfciWmA+6KuzRzNgREDTrFbKAaKOHUHJtgCdg0wQ
         tl1g==
X-Gm-Message-State: AOAM530xC62j49ZcqgAguElXxb10nNhxeJR8VS0ILK1neYfrkBQgW3HJ
        e60ZaIszMV9bMKWPQ78GjI4=
X-Google-Smtp-Source: ABdhPJxskWloj0/7FVsnJ9YivMN7uJRmjhpENWZRjSDDthn/8KsLqyfoYAd5DWnMSTmFXtyiNUdlfA==
X-Received: by 2002:a05:622a:1a9f:: with SMTP id s31mr14445494qtc.151.1627913846469;
        Mon, 02 Aug 2021 07:17:26 -0700 (PDT)
Received: from [192.168.1.201] (pool-74-96-87-9.washdc.fios.verizon.net. [74.96.87.9])
        by smtp.googlemail.com with ESMTPSA id q11sm5812336qkm.56.2021.08.02.07.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 07:17:25 -0700 (PDT)
From:   Sean Anderson <seanga2@gmail.com>
Subject: Re: [kbuild] drivers/pinctrl/pinctrl-k210.c:970 k210_fpioa_probe()
 warn: 'pdata->clk' not released on lines: 962,968.
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
Cc:     "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <202107302010.QfgLffbI-lkp@intel.com>
 <DM6PR04MB708187FE0B622791011BEEB7E7EE9@DM6PR04MB7081.namprd04.prod.outlook.com>
Message-ID: <68285071-073b-6d84-0650-02e77965c878@gmail.com>
Date:   Mon, 2 Aug 2021 10:17:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB708187FE0B622791011BEEB7E7EE9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/21 6:50 PM, Damien Le Moal wrote:
> On 2021/07/30 22:46, Dan Carpenter wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
>> head:   764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
>> commit: d4c34d09ab03e1e631fe195ddf35365a1273be9c pinctrl: Add RISC-V Canaan Kendryte K210 FPIOA driver
>> config: riscv-randconfig-m031-20210730 (attached as .config)
>> compiler: riscv64-linux-gcc (GCC) 10.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> smatch warnings:
>> drivers/pinctrl/pinctrl-k210.c:970 k210_fpioa_probe() warn: 'pdata->clk' not released on lines: 962,968.
>>
>> vim +970 drivers/pinctrl/pinctrl-k210.c
>>
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  925  static int k210_fpioa_probe(struct platform_device *pdev)
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  926  {
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  927  	struct device *dev = &pdev->dev;
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  928  	struct device_node *np = dev->of_node;
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  929  	struct k210_fpioa_data *pdata;
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  930  	int ret;
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  931
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  932  	dev_info(dev, "K210 FPIOA pin controller\n");
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  933
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  934  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  935  	if (!pdata)
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  936  		return -ENOMEM;
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  937
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  938  	pdata->dev = dev;
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  939  	platform_set_drvdata(pdev, pdata);
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  940
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  941  	pdata->fpioa = devm_platform_ioremap_resource(pdev, 0);
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  942  	if (IS_ERR(pdata->fpioa))
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  943  		return PTR_ERR(pdata->fpioa);
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  944
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  945  	pdata->clk = devm_clk_get(dev, "ref");
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  946  	if (IS_ERR(pdata->clk))
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  947  		return PTR_ERR(pdata->clk);
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  948
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  949  	ret = clk_prepare_enable(pdata->clk);
>>                                                        ^^^^^^^^^^^^^^^^^^
>>
>>
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  950  	if (ret)
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  951  		return ret;
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  952
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  953  	pdata->pclk = devm_clk_get_optional(dev, "pclk");
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  954  	if (!IS_ERR(pdata->pclk))
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  955  		clk_prepare_enable(pdata->pclk);
>>                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> No error handling
>>
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  956
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  957  	pdata->sysctl_map =
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  958  		syscon_regmap_lookup_by_phandle_args(np,
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  959  						"canaan,k210-sysctl-power",
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  960  						1, &pdata->power_offset);
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  961  	if (IS_ERR(pdata->sysctl_map))
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  962  		return PTR_ERR(pdata->sysctl_map);
>>
>> Do we need to clk_unprepare_disable() before returning?
>>
>>
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  963
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  964  	k210_fpioa_init_ties(pdata);
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  965
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  966  	pdata->pctl = pinctrl_register(&k210_pinctrl_desc, dev, (void *)pdata);
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  967  	if (IS_ERR(pdata->pctl))
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  968  		return PTR_ERR(pdata->pctl);
>>
>> Here too.
> 
> I can add the clk_unprepare_disable() call to avoid the warning, but that is
> rather pointless as the system will not boot at all if there is an error here.
> Thoughts ?

IMO, you should still handle the error so the user gets some warning
about not being able to enable the clock instead of crashing at some
later point.

--Sean

> 
>>
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  969
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12 @970  	return 0;
>> d4c34d09ab03e1 Damien Le Moal 2021-01-12  971  }
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
>> _______________________________________________
>> kbuild mailing list -- kbuild@lists.01.org
>> To unsubscribe send an email to kbuild-leave@lists.01.org
>>
>>
> 
> 

