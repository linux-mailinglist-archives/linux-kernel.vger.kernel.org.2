Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C573DEB8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhHCLGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhHCLGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:06:47 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B9C061757;
        Tue,  3 Aug 2021 04:06:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a19so27753228oiw.6;
        Tue, 03 Aug 2021 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUCMsyWVC5nqDt+/pqXl+IAnxIIadmdGAWl6iK82XkQ=;
        b=pHGEN430fPFq577eTfEEJ/NxMt/7LmXFXeurWJv4SI3xPyUA69XqxNxJuI4YGHYsa3
         AZgs9i5AJ6Nhm8qdEaHR51SkZJ2l5H+8HBtFoXet/F+O0b/A28pwgghP44Wgd6a2FUZK
         +32vbOfZOiXSWn8bVYY862TR+MS5STiSqBVbixpgQkVYAVCBAYwUbdjAWDVIol9O1pXc
         HQTKeMZkDcBnT1oHtBSLO8tEA3RmhkKf/L2P4OCEk2ytbjAFxK/IVZNiuAL9n9+5IeBe
         64PvNzs93tsgBNfsZOt9+dN66KEP1u8LypyQkmGcIDQcw2vdNgm2GRDPz7i+bpPRXcxx
         P3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUCMsyWVC5nqDt+/pqXl+IAnxIIadmdGAWl6iK82XkQ=;
        b=OytgaY0KjwyLaLx/dwPHo1t4+liONgGzXMjTTWJQs6ek9NagfeOxEvZJZz32Ml9Ynw
         ss2a5ItoJx0m7ZF2OWRx+2l5T9hJBb2Qo37qPS0R4u+X7daNkpoVY3O8H6Kn1gBrIAVB
         9kbkS2Y6RcLOaab15MyRIG9J8Qv/HapTjkP319hltCm5OiGFE7qi7JDTPsHHgtmbHRS0
         ni1QU0T2YT+C5kUXyacJa2YLk16zyr8VTxMpRAY9DPjUkp2r/7I9cjw8MmypbD50yKy8
         krt7vYZJ6ocoyiJuZgzw5bRgEss4Z6su96Y/1w5gvl26/7AJPZdqAUBZ/rm3OLeiG4c7
         1OCg==
X-Gm-Message-State: AOAM531/e2Z3RreP/YiSDwXlrHu4xZ7e84fnXwNgwvKD7t8MnXS9viGj
        U0M5sWkGSrr65LUD8qQy/H+xebnHii0=
X-Google-Smtp-Source: ABdhPJygUKdOxCVVuEgHQp7Q0u4U5nfxIyXQ6vnHRcQ28N4gAV66JxiHI25ikJUnPJ7AlNVmgZzArw==
X-Received: by 2002:a05:6808:188a:: with SMTP id bi10mr14346372oib.73.1627988795500;
        Tue, 03 Aug 2021 04:06:35 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com. [2603:8090:2005:39b3::1010])
        by smtp.gmail.com with ESMTPSA id c2sm2192783ooo.28.2021.08.03.04.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 04:06:34 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update STAGING - REALTEK RTL8188EU DRIVERS
To:     Phillip Potter <phil@philpotter.co.uk>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210803071811.8142-1-lukas.bulwahn@gmail.com>
 <CAA=Fs0=V_gcfDUxn1m9OkR78cht0S=j02BsHajG1A3vuGTqQJw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <5e1c7274-61c8-87fd-a281-11d9e7cbbfb4@lwfinger.net>
Date:   Tue, 3 Aug 2021 06:06:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAA=Fs0=V_gcfDUxn1m9OkR78cht0S=j02BsHajG1A3vuGTqQJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 3:56 AM, Phillip Potter wrote:
> On Tue, 3 Aug 2021 at 08:18, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>
>> Commit 55dfa29b43d2 ("staging: rtl8188eu: remove rtl8188eu driver from
>> staging dir") removes ./drivers/staging/rtl8188eu, but misses to adjust
>> the STAGING - REALTEK RTL8188EU DRIVERS section in MAINTAINERS.
>>
>> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>>
>>    no file matches    F:    drivers/staging/rtl8188eu/
>>
>> A refurnished rtl8188eu driver is available in ./drivers/staging/r8188eu/
>> and there is no existing section in MAINTAINERS for that directory.
>>
>> So, reuse the STAGING - REALTEK RTL8188EU DRIVERS section and point to the
>> refurnished driver with its current developers and maintainers according
>> to the current git log.
>>
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> ---
>> applies cleanly on next-20210803
>>
>> Philipp, Larry, please ack.
>>
>> Greg, please pick this minor cleanup on your staging-next tree.
>>
>>   MAINTAINERS | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 36aee8517ab0..ef32c02b3e4d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17723,8 +17723,9 @@ F:      drivers/staging/olpc_dcon/
>>
>>   STAGING - REALTEK RTL8188EU DRIVERS
>>   M:     Larry Finger <Larry.Finger@lwfinger.net>
>> -S:     Odd Fixes
>> -F:     drivers/staging/rtl8188eu/
>> +M:     Phillip Potter <phil@philpotter.co.uk>
>> +S:     Supported
>> +F:     drivers/staging/r8188eu/
>>
>>   STAGING - REALTEK RTL8712U DRIVERS
>>   M:     Larry Finger <Larry.Finger@lwfinger.net>
>> --
>> 2.17.1
>>
> Sorry, not sure how I missed this :-)
> 
> Acked-by: Phillip Potter <phil@philpotter.co.uk>
> 
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

