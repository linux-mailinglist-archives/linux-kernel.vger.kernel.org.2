Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6DF39ECFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFHDWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:22:17 -0400
Received: from [43.250.32.171] ([43.250.32.171]:63915 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230398AbhFHDWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=eBySKfNr4sKufTNqDjgAPDrTeLkpnonNcNmU6
        kyPStU=; b=W22IiNNy9q4f2MF8cZzVrsmURVwoOG4L6tQvt5EuiVxTkU210Uwfb
        aicnEPqGenPqARBOtFDi8sV0ZYaO0jKwgB4vB9xBFScK1xtkbOLB/iPrA7SahfhG
        P2PKr3Fc+jQrSO/ssBL4t6ArToFBDCYFE52jJSC5TX5Nogeh2J3s5g=
Received: from [0.0.0.0] (unknown [113.251.8.115])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgD3kjb04b5gIvcDAA--.11317S3;
        Tue, 08 Jun 2021 11:20:20 +0800 (CST)
Subject: Re: [PATCH] docs/zh_CN: add a translation for index
To:     "Wu X.C." <bobwxc@email.cn>, teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>
References: <20210607093433.39160-1-src.res@email.cn>
 <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
 <CAMU9jJq5ykLjZK2NFo98FxuKDmJnSCcUGn2-N53ioX9nspBSLA@mail.gmail.com>
 <20210608030903.GB3207@bobwxc.top>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <24d4bd1d-cf74-179f-56a5-d28878a67d1e@email.cn>
Date:   Tue, 8 Jun 2021 11:20:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608030903.GB3207@bobwxc.top>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgD3kjb04b5gIvcDAA--.11317S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfWF18Ww4UCF48XFyxXwb_yoW8Kr1UpF
        1DKFyfKa1DJr1Ykrs2gw1xJF15t3WxGw43Xr1Ut3sagrs8tr9xtr43tas0gryxXryxAF98
        trWayFZ3C34ayFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv
        8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0Jj2VbgUUUUU=
X-Originating-IP: [113.251.8.115]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/8 上午11:09, Wu X.C. 写道:
> On Mon, Jun 07, 2021 at 09:43:37PM +0800, teng sterling wrote:
>> CC Xiangcheng
>>
>> teng sterling <sterlingteng@gmail.com> 于2021年6月7日周一 下午9:40写道：
>>> CC siyanteng@loongson.cn
>>> Hu Haowen <src.res@email.cn> 于2021年6月7日周一 下午5:37写道：
>>>> The original file has added a former intro in commit b51208d41c6a4e7fc2f0
>>>> ("docs: Tweak the top-level Sphinx page") and hence update the Chinese
>>>> version for it.
>>>>
>>>> Signed-off-by: Hu Haowen <src.res@email.cn>
>>>> ---
>>>>   Documentation/translations/zh_CN/index.rst | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
>>>> index 1f953d3439a5..003126abc0d6 100644
>>>> --- a/Documentation/translations/zh_CN/index.rst
>>>> +++ b/Documentation/translations/zh_CN/index.rst
>>>> @@ -17,6 +17,11 @@
>>>>      **翻译计划:**
>>>>      内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
>>>>
>>>> +这是内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一项正
>>> how about:
>>>
>>> 这是中文内核文档树的顶级目录。
>>>> +在进行的工作；当我们努力将许多分散的文件整合成一个连贯的整体时尤其如此。另
>>>> +外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
>>> 中文内核文档进行改进；
>>>> +上的linux-doc邮件列表。
>>> 上的linux-doc邮件列表，先改进原始英文文档，再将其翻译为中文后，更新相应的中文文档。
>>>> +
>>>>   许可证文档
>>>>   ----------
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>> BTW, I think these are similar to "disclaimer-zh_CN", but not as good
>>> as the latter.
>>>
>>> Alex and Xiangcheng, what do you think?
>>>
>>> Thanks,
>>> Yanteng
> I think,
>
> Use 中文内核文档树
>
> And then
>
> .. include:: ./disclaimer-zh_CN.rst


OK, fixing it and going to send patch v2.


Thx,

Hu Haowen


> Thanks,
> 	Wu X.C.

