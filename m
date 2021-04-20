Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858AC365E05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhDTRAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhDTRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:00:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=TI4itBKQrnK7N1+JRagb2I2ih0zdOQqO0BJD+m1+J+E=; b=Efg3zCDE1rabqGaoQ6dxC/sGNP
        JSg7HrYEToXqF82hOhGoqKSsocoaloP9I/2h37JrEE3hJoq2KHJ4n30eFYrH66f0MDRbODNy9//1R
        n/GRxRCB0AK9Anck2IJkpeGZt625cWN2Bw1b8jgdDJqRbGarGlEa1ykjeLlG8wF88gz2Jy/AT7psA
        0qhRwXxiHZBlRwiuyUbYhvS3v2xBHMTWs5/kB8/gklgpz+xkngrFvsAkuX7M05CeM63cK02JQ5Orf
        TDnlQ1VOFvUC/YKgethsrqU2a88xlebs0rvNW8PaXUAnraEQXbUkNLXsV6zDByjUQ/etlzasHMeHr
        cEB/U2ig==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYtid-00FPkL-Ia; Tue, 20 Apr 2021 16:59:42 +0000
Subject: Re: (.text.ks8851_probe_common+0x370): undefined reference to
 `__this_module'
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, Marek Vasut <marex@denx.de>,
        Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
References: <202102221437.vHlLwHmG-lkp@intel.com>
 <33c7cb1f-b6c0-24bf-0e6c-23d5472e4c29@infradead.org>
 <CAK8P3a1zfwJs3=mhvTGpLLak1Lqq6N-4N+zHrh-4KMRE75HP8w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <75670aaa-9904-a331-40c1-f1d8a2f92d30@infradead.org>
Date:   Tue, 20 Apr 2021 09:59:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1zfwJs3=mhvTGpLLak1Lqq6N-4N+zHrh-4KMRE75HP8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 12:38 AM, Arnd Bergmann wrote:
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
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef3631220d2b3d8d14cf64464760505baa60d6ac
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout ef3631220d2b3d8d14cf64464760505baa60d6ac
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     hppa-linux-ld: drivers/net/ethernet/micrel/ks8851_common.o: in function `ks8851_probe_common':
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

It would be nice to have some patch merged. :)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.
-- 
~Randy

