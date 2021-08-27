Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39A3F9BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbhH0PtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbhH0PtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:49:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085BC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:48:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d16so12206000ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jcMOhlnO/6zhJtyyv3sIOHX5NmMWJ45ZG4zs+/T+Fqg=;
        b=cRZBwnLHWS+ul5vbl3qc6LvDiTEf5Ljw7GZjWrgNHaXLMLiIb2PMIiJjWqPGJK2fLD
         rgluypfeUEycuj33q45UE/bSZJJJqrkwHtwJhJGmXGB9wTm0sxSatVJPwKb+PDJTkR2B
         b3ZdAp3NNk7MEXqNeW+T1VdpyXCx/G7OKsDyXU8WZwuHfm6sLuIf3PecCyzYxtQKY4tF
         HKBUZ6ZhCeQ8IuABnNqpNyBnzQoT6jCK5748q5c+rnlIY9pA5lhzdT1LRImzezabEmWr
         GBMqjNl97VN0eUUJf/ahlEXLMhwoz6j6+p5NaS1RFa3JHktmpoM66Kqunb7tYa8BS+Xv
         gJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jcMOhlnO/6zhJtyyv3sIOHX5NmMWJ45ZG4zs+/T+Fqg=;
        b=PZ/qFUJJg/WMtJl2OMc5WlvHzXZlv1bEocUAqhOxghydxOsC7ACTa00mB+GbTa78Rq
         re/etMXiffpCdMQJCbt39RBuntCNG+dG5fZW5yX5t5ii5lucudzWWqaaBsw6+3/X0hzT
         EIYMD4XHLavydoIP2ekFt9W0khAnmbOMY1LMqAlFbZSjU0M34AxzWavAKr1CqdAPaIIW
         GznlLQ7vbUZPuc9fI7vPx3u+pDPwi8YpryYwLmRFjgkkabAXTHL+RXB51DKEn44L6rvZ
         S59cvMD+8Y9WKCVk4+nG5bgkFw1OSA+F4DxQGr1cWhOJkydmmQ7Z13MJ0U1bsDhSkDN1
         AR+g==
X-Gm-Message-State: AOAM532C4WtrzCBrBy93jf6o1mnYIxOcC+VwiePV0lU4tF/vPQiqIyD2
        00WXw+thNeecor+/kkf5h+A=
X-Google-Smtp-Source: ABdhPJyPWMiQzroJM0napci9LaVujtLp905psMmo8OoG//1nJdaD/WhJISRrDOOvnwu/fA0wXBXr3w==
X-Received: by 2002:a2e:a49c:: with SMTP id h28mr8363318lji.510.1630079302471;
        Fri, 27 Aug 2021 08:48:22 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id r22sm627800lfm.7.2021.08.27.08.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 08:48:22 -0700 (PDT)
Subject: Re: [PATCH linux-next] drivers:r8188eu: remove unneeded variable
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     CGEL <cgel.zte@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210825061531.69678-1-deng.changcheng@zte.com.cn>
 <68520ae2-23a8-7948-7feb-aa9a69cc0c59@gmail.com>
Message-ID: <5c6a1d8b-eadc-71ed-5dfa-f2d7615522af@gmail.com>
Date:   Fri, 27 Aug 2021 18:48:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <68520ae2-23a8-7948-7feb-aa9a69cc0c59@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 6:42 PM, Pavel Skripkin wrote:
> On 8/25/21 9:15 AM, CGEL wrote:
>> From: Jing Yangyang <jing.yangyang@zte.com.cn>
>> 
>> Eliminate the following coccicheck warning:
>> ./drivers/staging/r8188eu/os_dep/os_intfs.c:505:6-12:
>>   Unneeded variable "status". Return "_SUCCESS" on line 577
>> ./drivers/staging/r8188eu/os_dep/os_intfs.c:772: 4-7:
>>    Unneeded variable "ret". Return "_SUCCESS" on line 818
>> ./drivers/staging/r8188eu/os_dep/os_intfs.c:823:4-8:
>> Unneeded variable "ret8". Return "_SUCCESS" on line 849
>> 
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>

And, please, change subject line to "staging: r8188eu: ..." :)



With regards,
Pavel Skripkin
