Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE5323B17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhBXLMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhBXLEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:04:07 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58ADC061793
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:02:52 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DltLD6zbxz1s0Br;
        Wed, 24 Feb 2021 12:02:44 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DltLD6J2xz1r13Y;
        Wed, 24 Feb 2021 12:02:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id C65dSZQMuRwa; Wed, 24 Feb 2021 12:02:42 +0100 (CET)
X-Auth-Info: AzEMq/rhpBSWVMD9XvQLi8U/+QL68CRH6dnsMBbKKyM=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 24 Feb 2021 12:02:42 +0100 (CET)
Subject: Re: (.text.ks8851_probe_common+0x370): undefined reference to
 `__this_module'
To:     Arnd Bergmann <arnd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
References: <202102221437.vHlLwHmG-lkp@intel.com>
 <33c7cb1f-b6c0-24bf-0e6c-23d5472e4c29@infradead.org>
 <CAK8P3a1zfwJs3=mhvTGpLLak1Lqq6N-4N+zHrh-4KMRE75HP8w@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <bb6e7759-0600-cbd0-c99c-e053285d094f@denx.de>
Date:   Wed, 24 Feb 2021 12:02:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1zfwJs3=mhvTGpLLak1Lqq6N-4N+zHrh-4KMRE75HP8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 9:38 AM, Arnd Bergmann wrote:
> On Wed, Feb 24, 2021 at 3:38 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 2/21/21 10:12 PM, kernel test robot wrote:
>>> Hi Marek,
>>>
>>> FYI, the error/warning still remains.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   31caf8b2a847214be856f843e251fc2ed2cd1075
>>> commit: ef3631220d2b3d8d14cf64464760505baa60d6ac net: ks8851: Register MDIO bus and the internal PHY
>>> date:   7 weeks ago
>>> config: parisc-randconfig-r034-20210222 (attached as .config)
>>> compiler: hppa-linux-gcc (GCC) 9.3.0
>>> reproduce (this is a W=1 build):
>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef3631220d2b3d8d14cf64464760505baa60d6ac
>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>           git fetch --no-tags linus master
>>>           git checkout ef3631220d2b3d8d14cf64464760505baa60d6ac
>>>           # save the attached .config to linux build tree
>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>      hppa-linux-ld: drivers/net/ethernet/micrel/ks8851_common.o: in function `ks8851_probe_common':
>>>>> (.text.ks8851_probe_common+0x370): undefined reference to `__this_module'
>>>>> hppa-linux-ld: (.text.ks8851_probe_common+0x374): undefined reference to `__this_module'
>>
>> Hey Arnd-
>>
>> I wanted to see if you had any ideas about this problem.
>>
>> CONFIG_KS8851=y
>> CONFIG_KS8851_MLL=m
>>
>> The problem is that 2 drivers share some common code, but in one case
>> the shared code is builtin and for the other driver it is a loadable
>> module. The common code is first built as builtin, so it does not have
>> the "__this_module" symbol.
> 
> This is the patch I sent for it:
> 
> https://lore.kernel.org/lkml/20210125121937.3900988-1-arnd@kernel.org/T/#u

I was under the impression that the patch was already applied, wasn't it?
