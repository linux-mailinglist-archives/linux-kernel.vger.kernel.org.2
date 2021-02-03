Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2330E020
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBCQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:52:36 -0500
Received: from m12-18.163.com ([220.181.12.18]:40539 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhBCQw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=iUx7s
        +/DKVp3DxsSpc1Y2LnuMJ54yLkUM+yW3DiA9Nk=; b=lrvnskDhqqKaUHxSlVVp7
        1MfLch+NMMsP32dMjoUitzrLBN6uGeVFtsSjTvPGKIYRTjR7XBVardXEqaWPfZrK
        xKrvujJDobg4NlsCVCGIyBimMEglVRPJhSgNxgRvI3gEqWJPNp3MBif3nUb09/oR
        HwPPkcJn63CCOaGSey3zTc=
Received: from [192.168.31.187] (unknown [117.139.251.135])
        by smtp14 (Coremail) with SMTP id EsCowAAX_9yArxpgKMnQSQ--.6413S2;
        Wed, 03 Feb 2021 22:13:21 +0800 (CST)
Subject: Re: [PATCH] arm64/ptdump:display the Linear Mapping start marker
To:     Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hailong Liu <liu.hailong6@zte.com.cn>
References: <20210202150749.10104-1-liuhailongg6@163.com>
 <c032e6aa-7101-fb3c-09be-425d77877efe@infradead.org>
From:   Hailong Liu <liuhailongg6@163.com>
Message-ID: <6c9d204f-4693-7878-d0d0-e4f0c0bdbfd7@163.com>
Date:   Wed, 3 Feb 2021 22:13:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c032e6aa-7101-fb3c-09be-425d77877efe@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EsCowAAX_9yArxpgKMnQSQ--.6413S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgeT5DUUUU
X-Originating-IP: [117.139.251.135]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/xtbBFQEuYFXlnx+9swAAsk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 3:39 AM, Randy Dunlap wrote:
> On 2/2/21 7:07 AM, Hailong Liu wrote:
>> From: Hailong Liu <liu.hailong6@zte.com.cn>
>>
>> The current /sys/kernel/debug/kernel_page_tables does not display the
>> *Linear Mapping start* marker on arm64, which I think should be paired
>> with the *Linear Mapping start* marker.
> 
> paired with itself?  just asking.
Oh,sorry, it's a mistake. My original intention is to express that "start"
paired with "end".

Thanks for pointing out my mistake, and thank Will for fixing this.

