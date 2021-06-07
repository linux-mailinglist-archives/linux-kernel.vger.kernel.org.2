Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF439DE1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFGNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:55:18 -0400
Received: from m34-101.88.com ([104.250.34.101]:2830 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230251AbhFGNzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=FZ7dl7fMd4mO4j2KR+PoAnwlQNNdGg/FOBsgb
        OC5jtY=; b=fBglc3bfOvg+aUYh7Jj+3LafceZU4dw/keD7ZTc2bhJoPjSm3fA9L
        Lpk0ZlPNUz1sna1cxIHdXGwxAgeFOFn0+mp789Kp+IpUa1AUQrWcYpY2IklUHKfF
        bUznH+zfXDp3BBA7Ngq4W+ysGzxAg83LtIUSLxmhKx/QdpgPqx5AmA=
Received: from [0.0.0.0] (unknown [113.251.8.115])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBXLv1dJL5g2sMDAA--.11253S3;
        Mon, 07 Jun 2021 21:51:26 +0800 (CST)
Subject: Re: [PATCH] docs/zh_CN: add a translation for index
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>
References: <20210607093433.39160-1-src.res@email.cn>
 <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <f9418c90-fe60-b26c-18d3-ecd3e9c506ab@email.cn>
Date:   Mon, 7 Jun 2021 21:51:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgBXLv1dJL5g2sMDAA--.11253S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw18ZFyUWFWDJw4xGF15Arb_yoW8tr15pF
        4DKrWfK3WkJrnrCwn2ga4xCF45J3Z7Ka13Wr1DK3sagr1DAr9FqrW3tF90gFyxXryIyFyq
        qrWayrsYk3WayFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUymb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWUuVWrJwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIc
        xG8wCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1U
        JwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UVGQDUUUUU=
X-Originating-IP: [113.251.8.115]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/7 下午9:40, teng sterling 写道:
> CC siyanteng@loongson.cn
> Hu Haowen <src.res@email.cn> 于2021年6月7日周一 下午5:37写道：
>> The original file has added a former intro in commit b51208d41c6a4e7fc2f0
>> ("docs: Tweak the top-level Sphinx page") and hence update the Chinese
>> version for it.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
>> ---
>>   Documentation/translations/zh_CN/index.rst | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
>> index 1f953d3439a5..003126abc0d6 100644
>> --- a/Documentation/translations/zh_CN/index.rst
>> +++ b/Documentation/translations/zh_CN/index.rst
>> @@ -17,6 +17,11 @@
>>      **翻译计划:*kernel's documentation*
>>      内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
>>
>> +这是内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一项正
> how about:
>
> 这是中文内核文档树的顶级目录。


But the English version says "kernel's documentation". It seems that we
should add an explanation for readers in order to drag them out of the
dilemma on whether he or she should update En version at first, as your
thought picking ideas from "disclaimer-zh_CN".

What's your opinion, maintainers?


>> +在进行的工作；当我们努力将许多分散的文件整合成一个连贯的整体时尤其如此。另
>> +外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
> 中文内核文档进行改进；
>> +上的linux-doc邮件列表。
> 上的linux-doc邮件列表，先改进原始英文文档，再将其翻译为中文后，更新相应的中文文档。
>> +
>>   许可证文档
>>   ----------
>>
>> --
>> 2.25.1
>>
> BTW, I think these are similar to "disclaimer-zh_CN", but not as good
> as the latter.
>
> Alex and Xiangcheng, what do you think?
>
> Thanks,
> Yanteng

