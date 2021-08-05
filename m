Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0193E1E23
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhHEVuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 17:50:05 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.164]:37520 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234746AbhHEVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 17:50:01 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 6CC191E21F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 16:49:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BlFIm1qSqK61iBlFIm4Xye; Thu, 05 Aug 2021 16:49:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a4vAYZN12jXuxE4AG3Yv7D5Z+TPfpOMAcdil9c80T/g=; b=ZF468vcGqhZA/+n+JijJQBVH/Y
        J/L85VTfmDXKjAvHL0ttXgb5Z8MMUupniW6NUOgQSnKtXqFZA000KMJlAuk+b8kR0a26r1rwS68oL
        k0qo0Lra2RJrGT3yUwsNJj7lQjLMzKi4sw6oyjx9QBY71OL2OF7SgniwDKya3mTVy1wg8w5nLAfzl
        bquaIT83BIJIYiPdFGh1uac9SGeSP7fsMevD4RcFEV3S1cK/Z3NfvOngHC2ShDeV7ftb/iQQrjWV6
        YcOCZ5pluNW1C6G2ZyOCh8jLs2QRytcwFOKX6OfardAghNZMYqijyRSvZjuRJqNZKmOLe43lfEaTL
        ziqNRZ7g==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:47584 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mBlFH-001QJz-Rl; Thu, 05 Aug 2021 16:49:43 -0500
Subject: Re: [gustavoars-linux:for-next/clang-fallthrough 1/1] warning:
 fallthrough annotation in unreachable code/
To:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
References: <202108051403.tBfqfI49-lkp@intel.com>
 <YQw2P8esj8PMNRQn@Ryzen-9-3900X.localdomain>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <19cb5505-9f81-3fc2-394e-365a5b230cba@embeddedor.com>
Date:   Thu, 5 Aug 2021 16:52:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQw2P8esj8PMNRQn@Ryzen-9-3900X.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1mBlFH-001QJz-Rl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:47584
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/21 14:04, Nathan Chancellor wrote:
> On Thu, Aug 05, 2021 at 02:21:34PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/clang-fallthrough
>> head:   58d0d2d2e7dc1b1a4997bb9c47d6cf428f2d3a00
>> commit: 58d0d2d2e7dc1b1a4997bb9c47d6cf428f2d3a00 [1/1] Revert "Revert "Makefile: Enable -Wimplicit-fallthrough for Clang""
>> config: hexagon-randconfig-r023-20210804 (attached as .config)
>> compiler: clang version 12.0.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=58d0d2d2e7dc1b1a4997bb9c47d6cf428f2d3a00
>>         git remote add gustavoars-linux https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
>>         git fetch --no-tags gustavoars-linux for-next/clang-fallthrough
>>         git checkout 58d0d2d2e7dc1b1a4997bb9c47d6cf428f2d3a00
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>>>> warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>>    2 warnings generated.
> 
> With a newer version of clang that shows proper line numbers:

Yep; I've been using mainline since you told us about commit
	
	1b4800c26259 ("[clang][parser] Set source ranges for GNU-style attributes")

:)

> Which is already being tracked: https://github.com/ClangBuiltLinux/linux/issues/1429

Hopefully, this will be solved soon: https://bugs.llvm.org/show_bug.cgi?id=51094 (fingers crossed).

Thanks
--
Gustavo
