Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EC30B700
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 06:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBBFXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 00:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBBFXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 00:23:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABAEC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 21:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=E7W54VTybuwmAytLZB5iQUp/AOyj0bb29g+gbwnx5qA=; b=VQHkouFqWYDv0kOXcWNSwXS182
        FXAb/iOjf3HvfON//jC/NLaUIFaq+lrFp7qOvV8QNKOFZmvAtruM6tsjgqKMwSxlbo7h/4u+vezKR
        Z41gP99IWXmDEtYjxCCYQG8Gy0rTL6X/uuDbz5gyrmGZeiv0ir82KfY/8Os24GwiOhsplV20gEO83
        SdqRVjW4VTyjQIw4YlvC6RbZ7TgyBYO02rvjm8DS8g6Fw5LOHggC2BvqUHh0w6CzUX6bqdKittKRz
        Z2l4R3s3xQyyPLmFzCWLTtnI2uw0AXcHpRfHav7oQmA1jSPbjohTUYvFu9QZBXOfbHx827T2YcxxT
        wcFWUc2w==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6o8w-000639-0R; Tue, 02 Feb 2021 05:22:26 +0000
Subject: Re: [kbuild-all] Re: s390-linux-ld: ll_temac_main.c:undefined
 reference to `devm_platform_ioremap_resource_byname'
To:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Wang Hai <wanghai38@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202102010812.qthaghhK-lkp@intel.com>
 <ac0c1ba8-d7c7-1868-db25-ccf063effec8@infradead.org>
 <1606d1eb-2e10-185c-7f80-1a1538da03c8@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8044e33e-018a-839b-4f71-38510d576f6e@infradead.org>
Date:   Mon, 1 Feb 2021 21:22:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606d1eb-2e10-185c-7f80-1a1538da03c8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 9:09 PM, Rong Chen wrote:
> 
> 
> On 2/2/21 6:38 AM, Randy Dunlap wrote:
>> On 1/31/21 4:06 PM, kernel test robot wrote:
>>> Hi Wang,
>>>
>>> FYI, the error/warning still remains.
>>>
>>> tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   1048ba83fb1c00cd24172e23e8263972f6b5d9ac
>>> commit: bd69058f50d5ffa659423bcfa6fe6280ce9c760a net: ll_temac: Use devm_platform_ioremap_resource_byname()
>>> date:   6 months ago
>>> config: s390-randconfig-r034-20210201 (attached as .config)
>>
>> Hi robot,
>>
>> Instead of hit & miss with s390 randconfigs, you could do what I did:
>> (all for arch/s390/):
> 
> Hi Randy,
> 
> Thanks for the advice, do you mean we don't need to test randconfig for arch s390?

You should still do randconfig testing for s390 (for other problems), but the robot has been
sending out a lot of build errors similar to this one, using different randconfig files.

I am just saying that you can find all of the ioremap/iounmap/devm_io* type build errors
in one kernel config file as described above.

> 
> Best Regards,
> Rong Chen
> 
>>
>> $ make allmodconfig
>> $ scripts/config -d PCI  ## this also disables HAS_IOMEM
>> $ make oldconfig
>> $ make all
>>
>> The latter gives a full list of drivers etc. that use iomemp/ioremap etc. as well as dev_io* variants instead of just a few random ones.
>>
>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     s390-linux-ld: drivers/net/ethernet/xilinx/ll_temac_main.o: in function `temac_probe':
>>>     ll_temac_main.c:(.text+0x39b6): undefined reference to `devm_platform_ioremap_resource_byname'
>>>>> s390-linux-ld: ll_temac_main.c:(.text+0x3a4c): undefined reference to `devm_platform_ioremap_resource_byname'
>>>     s390-linux-ld: ll_temac_main.c:(.text+0x3bce): undefined reference to `devm_ioremap'
>>>     s390-linux-ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
>>>     xilinx_axienet_main.c:(.text+0x844): undefined reference to `devm_ioremap_resource'
>> _______________________________________________


-- 
~Randy

