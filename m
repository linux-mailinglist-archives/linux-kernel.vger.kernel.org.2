Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2439739EC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFHCwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:52:42 -0400
Received: from m34-101.88.com ([104.250.34.101]:33469 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230383AbhFHCwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=xUaGAt6dsBLnHGBH9MeHDJlZAZQLNcC9SmU6Q
        irRb1U=; b=gen0TRKr1R3Yqr91W358mbyodixECbegANUEUzmwQMMA+zFd5D22S
        E+cL4k1ofo4R8zMrPeCiJrrLCsfKhKcWvwRKRPCTIngsb2PyhtvzOqs2yLydWpVC
        C9eEsuiXykKIAQOfmVzoozgslmxhfHYT/5vP/4iMD54o5T+H2Tp27U=
Received: from [0.0.0.0] (unknown [113.251.8.115])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgD3kjaW2r5gMe4DAA--.11224S3;
        Tue, 08 Jun 2021 10:48:55 +0800 (CST)
Subject: Re: [PATCH] docs/zh_CN: add a translation for index
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>
References: <20210607093433.39160-1-src.res@email.cn>
 <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
 <f9418c90-fe60-b26c-18d3-ecd3e9c506ab@email.cn>
 <CAMU9jJq95fasAjbosE23gziHNL5zAcC-OUe-=uqDMefXCif-rw@mail.gmail.com>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <02eb1a41-d1f8-535b-c545-aa0514a50555@email.cn>
Date:   Tue, 8 Jun 2021 10:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMU9jJq95fasAjbosE23gziHNL5zAcC-OUe-=uqDMefXCif-rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgD3kjaW2r5gMe4DAA--.11224S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGryxJFy3uw43ZFyrGFWrGrg_yoW5Ww1rpa
        1DKa4fKa1DAw13Crn2g3WxCF45tas7Ga1aqr1DK3sagr1qy3s3tr47tF909Fy8Xry8AFyq
        qrWakrZakw1YyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUymb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWUuVWrJwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
        xvr21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1U
        Jr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UbID7UUUUU=
X-Originating-IP: [113.251.8.115]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/8 上午9:41, teng sterling 写道:
> Hu Haowen <src.res@email.cn> 于2021年6月7日周一 下午9:52写道：
>>
>> 在 2021/6/7 下午9:40, teng sterling 写道:
>>> CC siyanteng@loongson.cn
>>> Hu Haowen <src.res@email.cn> 于2021年6月7日周一 下午5:37写道：
>>>> The original file has added a former intro in commit b51208d41c6a4e7fc2f0
>>>> ("docs: Tweak the top-level Sphinx page") and hence update the Chinese
>>>> version for it.
>>>>
>>>> Signed-off-by: Hu Haowen <src.res@email.cn>
>>>> ---
>>>>    Documentation/translations/zh_CN/index.rst | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
>>>> index 1f953d3439a5..003126abc0d6 100644
>>>> --- a/Documentation/translations/zh_CN/index.rst
>>>> +++ b/Documentation/translations/zh_CN/index.rst
>>>> @@ -17,6 +17,11 @@
>>>>       **翻译计划:*kernel's documentation*
>>>>       内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
>>>>
>>>> +这是内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一项正
>>> how about:
>>>
>>> 这是中文内核文档树的顶级目录。
>>
>> But the English version says "kernel's documentation". It seems that we
>> should add an explanation for readers in order to drag them out of the
>> dilemma on whether he or she should update En version at first, as your
>> thought picking ideas from "disclaimer-zh_CN".
>>
>> What's your opinion, maintainers?
> When the original documentation is updated, the Chinese documentation
> has to follow. I think we have reached a consensus on this point.
> However, this file is described in this directory as zh_CN, so I think
> it needs to be localized. But the localization will conflict with
> "disclaimer-zh_CN".


Hmm... That's an issue. Does that mean we should edit "disclaimer-zh_CN"
as well to avoid the conflict?


Thx,

Hu Haowen


> Thanks,
> Yanteng
>>
>>>> +在进行的工作；当我们努力将许多分散的文件整合成一个连贯的整体时尤其如此。另
>>>> +外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
>>> 中文内核文档进行改进；
>>>> +上的linux-doc邮件列表。
>>> 上的linux-doc邮件列表，先改进原始英文文档，再将其翻译为中文后，更新相应的中文文档。
>>>> +
>>>>    许可证文档
>>>>    ----------
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

