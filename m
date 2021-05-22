Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB038D2B1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 02:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhEVA4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 20:56:00 -0400
Received: from [43.250.32.171] ([43.250.32.171]:35694 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230280AbhEVAz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 20:55:58 -0400
X-Greylist: delayed 32311 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 20:55:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=QNzULVlqtCRAzUYUP/TQwy/HPpivKZoYM/ZmN
        /vc5w0=; b=mZZbTbrAXbLhoAg+nHNGkFas9xyNjiwAXK9+HoEz9NfIh8cv3ft7l
        TdI0UatznSnZ3/p34Cq0SuYiGN9f1HKLdnnJw32AkCrs69Mr4RfvMe6/ripSA1HQ
        TPvMnc6x+sp7Zl78gJ2cWnHyTjb2MZGkfSbMu2muiDMLN6IVnv+piI=
Received: from [0.0.0.0] (unknown [113.251.14.223])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgDHjkFCVqhgSK43AA--.21755S3;
        Sat, 22 May 2021 08:54:29 +0800 (CST)
Subject: Re: [PATCH] docs/zh_CN: update a translation in zh_CN/dev-tools/gcov
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, bernard@vivo.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210521155551.29176-1-src.res@email.cn>
 <20210521165319.GA18245@bobwxc.top>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <fd635b2a-1551-26df-a32c-86b97df5d328@email.cn>
Date:   Sat, 22 May 2021 08:54:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521165319.GA18245@bobwxc.top>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgDHjkFCVqhgSK43AA--.21755S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy5CF4DXr1UGryUGF1Utrb_yoW8XFyxpr
        WkKFWxK3Z2vF1UC3yxWF4Utr18uFyxuw4UGF18twnagrsxZrZ5KrZxtr90gFyfuFWfZFWr
        ZF4FvFyF9w1jka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Jr0_Jr4l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWxJr1UJwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4
        CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7VU0mhF7UUUUU==
X-Originating-IP: [113.251.14.223]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/22 上午12:53, Wu X.C. wrote:
> On Fri, May 21, 2021 at 11:55:51PM +0800, Hu Haowen wrote:
>> The original file has added some words in commit c797997a244cd2c58908
>> ("Documentation: dev-tools: Add Testing Overview"), hence update the
>> Chinese translation of them.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
>> ---
>>   Documentation/translations/zh_CN/dev-tools/index.rst | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
>> index fd73c479917b..7ba02fc392a6 100644
>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>> @@ -11,6 +11,9 @@
>>   目前这些文档已经整理在一起，不需要再花费额外的精力。
>>   欢迎任何补丁。
>>   
>> +有关测试专用工具的简要概述，参见
>> +Documentation/dev-tools/testing-overview.rst
>> +
>>   .. class:: toc-title
>>   
>>   	   目录
>> -- 
>> 2.25.1
Currently working on testing-overview.rst. This will be done soon but
still require some time. After the translation I'll send you another
patch on testing-overview.rst with v2.

Thanks,
Hu Haowen
> Looks not bad.
> Are you already working on translating testing-overview.rst?
> If not, please also add todo entry of testing-overview.rst with v2.
>
> Acked-by: Wu XiangCheng <bobwxc@email.cn>
>
> Thanks,
> Wu X.C.
>

