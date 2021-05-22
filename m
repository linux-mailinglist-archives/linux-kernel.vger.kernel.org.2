Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EEE38D59A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhEVL16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 07:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhEVL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 07:27:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103CDC061574;
        Sat, 22 May 2021 04:26:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q6so12296269pjj.2;
        Sat, 22 May 2021 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8kh6iJCxppwsBbpPOa+gb5iEakg7K3WV07g7y012eVI=;
        b=QN9RdDCl/yL9Bhr+K7e6V5VOzBbLcjJULkIhY+7UtQFxPiDcqcGUIDLN3zx9iEAS8j
         JAfWRIDGp6vDUilN+6B2XpYXroWBGwi13Xj9ahIw0WkqchVkzzfaO9XXAQ0etoGax7nf
         VWEJk87pR72jNJTQ6TSXkDfyly0KEv0QBq6isS2loi3JUPrtgGhIQA2XDhm/MNGMHjvG
         fGn+BSHAyGRCovQDtV1tB0IiXeB0mSCtU1zkiiABe660Gxxk2U8EFDPIP/PFXWNz1dj8
         rQxOk7sFjuDSzXyf3v5tcCY24+NUqSzmMT6bN6RxcxaHN7j5nyRcmVPwueMRabQsNQ3V
         CHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8kh6iJCxppwsBbpPOa+gb5iEakg7K3WV07g7y012eVI=;
        b=p1uXYaZEuc8mSNL35cmCkJunwByIavqBnptiF+kOXXhgj3CuzY1YTvhX+K22EmeBQb
         3VumRAZB8p+Koi4/Gdtpt9i/IYNf7gvOui3eS4UzoFwN4u/ineZaC0XOUddlFHbujIgu
         L5sDglAoB4yz8bBYCqpg6yQdYpgvjTwhTPc3hGS3ENKo9MImxlkRQMWvlFCBCL4VYiqc
         Ap8hFdWOHXcQtD1iwGL9TFMNGz4aTdy39mS2Tdf1LKL5dDMPAD2xfj/EoHgeGlD69Vz3
         7i1Ya7NznS/ITM5kSlSsC54NhdislgnrBk73AKOMd2Bm5gMBhQLK9opDQ6+F8Dh3a2pn
         qDmg==
X-Gm-Message-State: AOAM5301JeXqRFrxEvSjxkDI9aTuM0z7QiXVgoTGtM93KQIAAGptXfRv
        y1wGDpT0p4AnqtStiuC0ARJ2hQMjz2eKcg==
X-Google-Smtp-Source: ABdhPJym71RIY1/mswIr0hXTkGC0Mmfmk+uWlyOjsnF+G20vsMcWooVOUlvDZUj5N1SgF7irx5V8/Q==
X-Received: by 2002:a17:903:1c3:b029:f1:ecf4:f971 with SMTP id e3-20020a17090301c3b02900f1ecf4f971mr16849834plh.6.1621682785266;
        Sat, 22 May 2021 04:26:25 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a93f:d9c2:4477:9177:8c76? ([2405:201:600d:a93f:d9c2:4477:9177:8c76])
        by smtp.gmail.com with ESMTPSA id t14sm6046050pfg.168.2021.05.22.04.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 04:26:24 -0700 (PDT)
Subject: Re: [PATCH] Phonet: fix kernel-doc syntax in file headers
To:     =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>
Cc:     courmisch@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210520182159.31462-1-yashsri421@gmail.com>
 <52313028.m8L9TnScQ9@philogene>
From:   Aditya Srivastava <yashsri421@gmail.com>
Message-ID: <2970b6b6-1450-8eec-a9e9-45629af9417f@gmail.com>
Date:   Sat, 22 May 2021 16:56:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <52313028.m8L9TnScQ9@philogene>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/5/21 2:57 pm, Rémi Denis-Courmont wrote:
> Le jeudi 20 mai 2021, 21:21:59 EEST Aditya Srivastava a écrit :
>> The opening comment mark '/**' is used for highlighting the beginning of
>> kernel-doc comments.
>> The header for include/*/linux/phonet.h files follows this syntax, but
>> the content inside does not comply with kernel-doc.
>>
>> This line was probably not meant for kernel-doc parsing, but is parsed
>> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
>> causes unexpected warning from kernel-doc.
>> For e.g., running scripts/kernel-doc -none include/linux/phonet.h emits:
>> warning: This comment starts with '/**', but isn't a kernel-doc comment.
>> Refer Documentation/doc-guide/kernel-doc.rst * file phonet.h
>>
>> Provide a simple fix by replacing this occurrence with general comment
>> format, i.e. '/*', to prevent kernel-doc from parsing it.
>>
>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> 
> You could just as well remove the stray "file XX" lines but OK.
> 
> Acked-by: Rémi Denis-Courmont <courmisch@gmail.com.>
> 


Hi Remi and Randy
Thanks for reviewing :)
I'll be sending a v2 with removed filenames

Thanks
Aditya
