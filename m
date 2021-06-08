Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275D539EFEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhFHHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:50:22 -0400
Received: from [43.250.32.171] ([43.250.32.171]:27434 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230324AbhFHHuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=ExzjQ8xn2UaHZDK9aremB/vKD8THp7Kt2W3bv
        w39Tds=; b=U2n5+EACRYCSCMNi2uTN42vh1vimcACC1G0P0xU0XZ+lfJJvBKdfQ
        o/MozPU2XuxAyOmdcm/FuhThpLpTJLA+wOq0Ay3zx5yzx8OYysFuDWGIglzYNoE8
        u/ua0sB+WA16yNGieYlr8DnYoix0XMZYrlsg+y3ww1CcN7Zr6u6RIM=
Received: from [0.0.0.0] (unknown [113.251.8.115])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgAnwzbEIL9g50gEAA--.12162S3;
        Tue, 08 Jun 2021 15:48:20 +0800 (CST)
Subject: Re: [PATCH v2] docs/zh_CN: add a translation for index
To:     Alex Shi <seakeel@gmail.com>, bobwxc@email.cn, alexs@kernel.org,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210608035323.63728-1-src.res@email.cn>
 <9dcbf22d-f415-db19-da45-421d19c2f757@gmail.com>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <dc9d8baf-d77b-251a-1a7a-baea2a634907@email.cn>
Date:   Tue, 8 Jun 2021 15:48:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9dcbf22d-f415-db19-da45-421d19c2f757@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgAnwzbEIL9g50gEAA--.12162S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryfurWrZF4kGF48Wr18Grg_yoW8WF4rpF
        1DKryfK3Z3Ar12krn2g3W7CF4UG3Z7Ca15Xryjq3sagr43trs3Krsrtr90ga4IqrWxAF98
        AF4SkFWkGa4ayrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv
        8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjVKZXUUUUU=
X-Originating-IP: [113.251.8.115]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/8 下午2:30, Alex Shi 写道:
>
> On 6/8/21 11:53 AM, Hu Haowen wrote:
>> The original file has added a former intro in commit b51208d41c6a4e7fc2f0
>> ("docs: Tweak the top-level Sphinx page") and hence update the Chinese
>> version for it.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
>> ---
>>   Documentation/translations/zh_CN/index.rst | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
>> index 1f953d3439a5..cb8595c0364c 100644
>> --- a/Documentation/translations/zh_CN/index.rst
>> +++ b/Documentation/translations/zh_CN/index.rst
>> @@ -17,6 +17,13 @@
>>      **翻译计划:**
>>      内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
>>   
>> +这是中文内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一
>> +项正在进行的工作；当我们努力将许多分散的文件整合成一个连贯的整体时尤其如此。
>> +另外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
> for Chinese doc, we just encourage for polish and translation, contents
> change should go to English first.
>
>> +上的linux-doc邮件列表。
>> +
>> +.. include:: ./disclaimer-zh_CN.rst
> don't include this file, 2 of index are different. and not a exact copy.


Alright, correcting them.


Thx,

Hu Haowen


>> +
>>   许可证文档
>>   ----------
>>   
>>

