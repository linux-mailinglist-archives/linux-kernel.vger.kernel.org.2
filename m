Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D539EEAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFHG1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:27:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F22DC061574;
        Mon,  7 Jun 2021 23:25:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i34so9304296pgl.9;
        Mon, 07 Jun 2021 23:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RrqMQQw+zyDQz8W5Pf4InGemf1VZYUDcnFyZS7qTzmw=;
        b=tETnaZW3TpJpc/8X40JYpd3IMJhYRTq7v4i7TgrcC6nGZ3pHtI7tB1VRmbs1dT3qzr
         FTHQnZEL55KfxWo25Jve8S3HKtxvwiAtG/u1YwC2RVu6VqRtj0qWWaqdNbFdy+vtRYZJ
         6PffoA26B3WYdHdT3SFGlVUvqp0ForXf4o3nbsxqAse6suHV8NrfkrdXadg0b1M7OpQF
         a3R+UUAeJgYwCaeIMFovExKWcpKAKgF1O2LpwIf4WEHbT/hCHZeqaSSQeucmSqoD+chj
         ocB7NOG8J5bs9DjuGmUGYE7yWgrNJRvqd8rey+G+wC2u9RP2gYkodrYAjKjJ1/qWLpa7
         9/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RrqMQQw+zyDQz8W5Pf4InGemf1VZYUDcnFyZS7qTzmw=;
        b=nYRq/6AdSeb3Uhu4e2Ba9W5655EbaiIT2oP7/oIcOnLSVYhp7xY5KYZg8qqx1qXGbr
         jKNoe3PIZFjGnTIppVxT6cmwzo9q4TkP918SXYHZz3iOqKmUia1dY32eA/ht5beRZKJB
         reySU/7HJ060b32YSsrztQF6YtIOabQv88csTIavKanmn8DlXY1nZSuffR9d1coKui6g
         vDL7QlATqyIUpdaNoFPIJkltS3XGrhDgFriDpCpnjoHQJDho5tWgp28tfsQNnd7NsW8L
         KHwBfDrbVglhVZXbPhyuIjdQH0ZGqce3w9n11RphCfF/AYYKcZUYe0iI8H4SKyFSyAE+
         UiVQ==
X-Gm-Message-State: AOAM531EtPvT9t79xlrCupW8CZChCtcptTRIapBi/xo4rLu0CKAD0Lf3
        2NHELzfOWQc+1PZ/BcBC+l4=
X-Google-Smtp-Source: ABdhPJyc1MNUiOLHKeDCFRslLq0cck6M5tuxOM0JqIS6J2BJu/nREQ98nY+ZnSgsf1CZkVgQzgkL+w==
X-Received: by 2002:aa7:85d3:0:b029:2ef:109a:7f08 with SMTP id z19-20020aa785d30000b02902ef109a7f08mr10326163pfn.23.1623133548479;
        Mon, 07 Jun 2021 23:25:48 -0700 (PDT)
Received: from [10.104.8.180] ([119.28.155.243])
        by smtp.gmail.com with ESMTPSA id w10sm9950791pfg.196.2021.06.07.23.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 23:25:48 -0700 (PDT)
Subject: Re: [PATCH] docs/zh_CN: add a translation for index
To:     Hu Haowen <src.res@email.cn>,
        teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>
References: <20210607093433.39160-1-src.res@email.cn>
 <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
 <f9418c90-fe60-b26c-18d3-ecd3e9c506ab@email.cn>
 <CAMU9jJq95fasAjbosE23gziHNL5zAcC-OUe-=uqDMefXCif-rw@mail.gmail.com>
 <02eb1a41-d1f8-535b-c545-aa0514a50555@email.cn>
From:   Alex Shi <seakeel@gmail.com>
Message-ID: <970431f4-86fc-e81b-eec4-c3c276ca0242@gmail.com>
Date:   Tue, 8 Jun 2021 14:25:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <02eb1a41-d1f8-535b-c545-aa0514a50555@email.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 10:48 AM, Hu Haowen wrote:
> 
> 在 2021/6/8 上午9:41, teng sterling 写道:
>> Hu Haowen <src.res@email.cn> 于2021年6月7日周一 下午9:52写道：
>>>
>>> 在 2021/6/7 下午9:40, teng sterling 写道:
>>>> CC siyanteng@loongson.cn
>>>> Hu Haowen <src.res@email.cn> 于2021年6月7日周一 下午5:37写道：
>>>>> The original file has added a former intro in commit b51208d41c6a4e7fc2f0
>>>>> ("docs: Tweak the top-level Sphinx page") and hence update the Chinese
>>>>> version for it.
>>>>>
>>>>> Signed-off-by: Hu Haowen <src.res@email.cn>
>>>>> ---
>>>>>    Documentation/translations/zh_CN/index.rst | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
>>>>> index 1f953d3439a5..003126abc0d6 100644
>>>>> --- a/Documentation/translations/zh_CN/index.rst
>>>>> +++ b/Documentation/translations/zh_CN/index.rst
>>>>> @@ -17,6 +17,11 @@
>>>>>       **翻译计划:*kernel's documentation*
>>>>>       内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
>>>>>
>>>>> +这是内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一项正
>>>> how about:
>>>>
>>>> 这是中文内核文档树的顶级目录。
>>>
>>> But the English version says "kernel's documentation". It seems that we
>>> should add an explanation for readers in order to drag them out of the
>>> dilemma on whether he or she should update En version at first, as your
>>> thought picking ideas from "disclaimer-zh_CN".
>>>
>>> What's your opinion, maintainers?
>> When the original documentation is updated, the Chinese documentation
>> has to follow. I think we have reached a consensus on this point.
>> However, this file is described in this directory as zh_CN, so I think
>> it needs to be localized. But the localization will conflict with
>> "disclaimer-zh_CN".
> 
> 
> Hmm... That's an issue. Does that mean we should edit "disclaimer-zh_CN"
> as well to avoid the conflict?
> 

the disclaimer is for single docs, shorter is better. For this file, we don't
have to copy exactly from original index.rst. 

Thanks
Alex
