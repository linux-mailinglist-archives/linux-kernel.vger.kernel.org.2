Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1323239ED12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFHD3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:29:50 -0400
Received: from [43.250.32.171] ([43.250.32.171]:64635 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230266AbhFHD3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=Nk+r/nw0K1jkAxKQYie9AVkKq1l7UpkfAMs8i
        N5fCmU=; b=DmRBNploC9GyITqJGkcw0sfve73SSiPu+mXCEUNyp+D9kd2Of8nnC
        ihe/Hi+e1LbLjCXTQqc7dOgYZYncf9pJDz4eLwshFaCms3poHbOIp2wZX86uuqQc
        oB8ynx3haRUQRRAdxny0D4VV0K65vPPC+ct6xmFYjBodO9kUcQBTRE=
Received: from [0.0.0.0] (unknown [113.251.8.115])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgD3kjaz475gRfkDAA--.11336S3;
        Tue, 08 Jun 2021 11:27:47 +0800 (CST)
Subject: Re: [PATCH v3] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, bernard@vivo.com,
        maskray@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210605120504.40246-1-src.res@email.cn>
 <20210608024439.GA3207@bobwxc.top>
 <01cd7a95-8b91-ad2f-ad94-80b06c1fe5c0@email.cn>
 <20210608031405.GC3207@bobwxc.top>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <487dc784-f116-5a3e-7dec-2808ca6c4ba9@email.cn>
Date:   Tue, 8 Jun 2021 11:27:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608031405.GC3207@bobwxc.top>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgD3kjaz475gRfkDAA--.11336S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4rtF13CFWrtrWDCr45ZFb_yoW8AF18p3
        yku3ZxJF4jgry2yrZa93W0qrnYkw1Fqr18X3W3KFy7XrWqyFnIkry7trZIgwn09rWIyFyF
        vF47WF9xC345Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv
        8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        j2VbgUUUUU=
X-Originating-IP: [113.251.8.115]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/8 上午11:14, Wu X.C. 写道:
> On Tue, Jun 08, 2021 at 10:53:20AM +0800, Hu Haowen wrote:
>> 在 2021/6/8 上午10:44, Wu X.C. 写道:
>>> On Sat, Jun 05, 2021 at 08:05:04PM +0800, Hu Haowen wrote:
>>>> Create new translations for dev-tools/testing-overview.rst and link it
>>>> to dev-tools/index.rst with TODOList modifications.
>>>>
>>>> Signed-off-by: Hu Haowen <src.res@email.cn>
>>>> ---
>>>>    .../translations/zh_CN/dev-tools/index.rst    |   5 +
>>>>    .../zh_CN/dev-tools/testing-overview.rst      | 110 ++++++++++++++++++
>>> [...]
>>>> +
>>>> +代码覆盖率工具
>>>> +==============
>>>> +
>>>> +支持两种不同代码之间的覆盖率测量工具。它们可以用来验证一项测试执行的
>>> Linux内核支持两种不同的代码覆盖率测试工具。
>>
>> But you mentioned that this sentence should be
>> "支持两种不同代码之间的覆盖率测量工具" in
>> the previous email. Should I take this version or the previous version?
>>
> Actually was "支持两种不同的代码覆盖率测试工具。"
> <https://lore.kernel.org/linux-doc/20210523140332.GA1097@bobwxc.top/>
>
> I forgot the head and you added something in the middle :)
>
> Please use the new version.


So here is nothing to be fixed now. Is this patch applied?

Thx,
Hu Haowen


> Thanks,
> 	Wu
>
>> Thx,
>>
>> Hu Haowen
>>
>>
>>>> +确切函数或代码行。这有助于决定内核被测试了多少，或用来查找合适的测试
>>>> +中没有覆盖到的极端情况。
>>>> +
>>> OK, good job!
>>>
>>> Just need to fix a small problem, after that
>>>
>>> Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
>>> Thanks,
>>> 	Wu X.C.

