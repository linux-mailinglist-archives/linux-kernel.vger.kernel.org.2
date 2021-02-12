Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B582031A504
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhBLTIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBLTId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:08:33 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ECBC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:06:58 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id z18so142746ile.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=41R6qCDY/8NfbYuCG9FTh5tckGwo/C1ROCg7V+WW60I=;
        b=OaT7xFwBOZ0+5R5EzoiY52m0tMQujyW6KpViVkm/xpfriImjxyevrCWMW60cglSXgx
         Sw2R9nNDnUMALq9grjb6+lviTsauWlQa+PgW5PGMpnFB6wHKq02Dh+uB1CHUYjKfJypV
         qwJpTcmdeP+hJ8m2VrybqYdmnzrVbhW5hxhrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=41R6qCDY/8NfbYuCG9FTh5tckGwo/C1ROCg7V+WW60I=;
        b=qUrdxwgwpX/QP9A/J9ym560/ohFa2oGLTKIJVPVW9yVqdVqAfW4Zg7GzU5afaWV4NZ
         UQe/eUzeXW5wBx+Zm0djH/f2/Dev4xGLfnnfj2TEn4FtoBtxhg7YDD5ump0/vOKiA2+o
         WI8fioVhyqlBy0oZ860YBe153SVM843nsqHIeFLqyurr5HTRz+pRhUJo8++mc37W6JWu
         GEhRtzKVodwzADhbKSE8m/nzf4+wG8Er7+buk19TJ46LWI69zX9JITywg7aPPJijcPdh
         gnifiCXsFU1KIc8G4nL1vL+KSyeHwRC0F1naEzjeb7zgPHUTEyOBTD7iQdbOa6UpE1Y0
         qalw==
X-Gm-Message-State: AOAM531tsSh6ukQOOElZQru3CvGCGYtOP67pJex+dxpv0UXNfZzjj3pN
        xdx8PYP2w6aTiJesANrlspPvFHbLSqoVkg==
X-Google-Smtp-Source: ABdhPJzCLf67dxyoG6GNwbCZwq3WTq4i0gvkUrWAjINmoMjda0GmQBM+BnH61HfpcwpotGr/AOknOA==
X-Received: by 2002:a92:d351:: with SMTP id a17mr3455278ilh.59.1613156817784;
        Fri, 12 Feb 2021 11:06:57 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id e9sm4470134iob.43.2021.02.12.11.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 11:06:57 -0800 (PST)
Subject: Re: [PATCH 2/3] net:ethernet:rmnet:Support for downlink MAPv5 csum
 offload
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Sharath Chandra Vurukala <sharathv@codeaurora.org>,
        davem@davemloft.net, elder@kernel.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1613079324-20166-1-git-send-email-sharathv@codeaurora.org>
 <1613079324-20166-3-git-send-email-sharathv@codeaurora.org>
 <20210211180459.500654b4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1c4e21bf-5903-bc45-6d6e-64b68e494542@ieee.org>
 <20210212105120.01b04172@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <dfa87271-0ade-f8b5-b41f-1128353b3248@ieee.org>
Date:   Fri, 12 Feb 2021 13:06:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210212105120.01b04172@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 12:51 PM, Jakub Kicinski wrote:
> On Fri, 12 Feb 2021 08:01:15 -0600 Alex Elder wrote:
>> On 2/11/21 8:04 PM, Jakub Kicinski wrote:
>>> On Fri, 12 Feb 2021 03:05:23 +0530 Sharath Chandra Vurukala wrote:
>>>> +/* MAP CSUM headers */
>>>> +struct rmnet_map_v5_csum_header {
>>>> +	u8  next_hdr:1;
>>>> +	u8  header_type:7;
>>>> +	u8  hw_reserved:5;
>>>> +	u8  priority:1;
>>>> +	u8  hw_reserved_bit:1;
>>>> +	u8  csum_valid_required:1;
>>>> +	__be16 reserved;
>>>> +} __aligned(1);
>>>
>>> Will this work on big endian?
>>
>> Sort of related to this point...
>>
>> I'm sure the response to this will be to add two versions
>> of the definition, surrounded __LITTLE_ENDIAN_BITFIELD
>> and __BIG_ENDIAN_BITFIELD tests.
>>
>> I really find this non-intuitive, and every time I
>> look at it I have to think about it a bit to figure
>> out where the bits actually lie in the word.
>>
>> I know this pattern is used elsewhere in the networking
>> code, but that doesn't make it any easier for me to
>> understand...
>>
>> Can we used mask, defined in host byte order, to
>> specify the positions of these fields?
>>
>> I proposed a change at one time that did this and
>> this *_ENDIAN_BITFIELD thing was used instead.
>>
>> I will gladly implement this change (completely
>> separate from what's being done here), but thought
>> it might be best to see what people think about it
>> before doing that work.
> 
> Most definitely agree, please convert.

KS, would you like me to do this to the existing code
first?

I don't think it will take me very long.  If it were
a priority I could probably get it done by the end of
today, but I'd want to ensure the result worked for
the testing you do.

					-Alex
