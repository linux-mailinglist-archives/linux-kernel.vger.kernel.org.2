Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3779C455DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhKRObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhKRObt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:31:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C6CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:28:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso4952202wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ek2MBZLoeaA0AclziQQ1yT2rYvKs9JmjXLOhBqB1ikI=;
        b=LCLMzl/APOueaFvm4ni8PJ87/DstNswH/g3mhvjSrAbfVEvZrmBy/QPR3MF62Rb3uX
         CocVB//JwxM2WGqpFW2WbI3dqutSn9IgYrD0NQSUliaW8xphKTmzKS3n+LUxR7SQ0Fdi
         ghBxfK/v0BaneIioQMjECKzY7EOkq6vPI1+oqiA1HPnW6T6UZ/zBZZFUEYpdmsrRuqba
         NTeS/7ygr7kQMpDC/IpA/Hi8oWRfrlpg6SPHW1uoeYaNEcihLmTxzoTzDsFQTAHnzapt
         c8I2cOYoJ75R2Cjta39NZTIGap00EJvH6+tGEO5g4bgpPD2DcksmLNLy2tof8g0L1W5t
         444A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ek2MBZLoeaA0AclziQQ1yT2rYvKs9JmjXLOhBqB1ikI=;
        b=Y4jyfXHZF9kWRNL5uR3COQQBix+SvPUxZhCNyEazPPcZzsKWLfcZdI0mVucqXGTcij
         dctavqYCQQk1RXPQu1buy9LfKlBhu5ImsTDCIjiqtZy6gH+P/Uil0Lva7o+Gz99ApM+O
         oPDn3Ldpkj/99OvAQiqmcTTquADVK4rYDuNZCjiLTS0H00th57ljJ5KRiyc4enQVXd1g
         B6JoJLU+MZeXVXNFwOYZQ/u86S6N45yfPIfkcb4hLGWiLW8t1hdo1/hbqqWPcCjgwJcg
         QyuzCBv7R6YQ2oLobcbIdrtbTkw49VZaNO+akSPveYc0vJlFjpfspVb0Z65w1XKPrZNO
         SXTw==
X-Gm-Message-State: AOAM531TDsemhXpzt1fKWLweext2WBXWVSoKb13foTZumhZzt+/ZpyYD
        zn0xOBzCZXlyie04emdQMgRArPPg13jJAg==
X-Google-Smtp-Source: ABdhPJzg2Gj8T7315lCel5MtvhDqz2HiXMYGVv3Km6bFf7nrbInFnVomr8hYnJXjr5MJEY6c/xkOYQ==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr10699666wmk.78.1637245727711;
        Thu, 18 Nov 2021 06:28:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:62a8:7207:ea06:dbf7? ([2a01:e34:ed2f:f020:62a8:7207:ea06:dbf7])
        by smtp.googlemail.com with ESMTPSA id r7sm8641wrq.29.2021.11.18.06.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 06:28:47 -0800 (PST)
Subject: Re: [RFC] DT: bindings: Powerzone new bindings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>
References: <20211115223911.982330-1-daniel.lezcano@linaro.org>
 <CAK8P3a0fLzjFSHRDHT7-eEnk0+E4zPrk-_g53ROs_dmyc3g1EA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0aac9bea-486d-6b39-94ae-e56b18800535@linaro.org>
Date:   Thu, 18 Nov 2021 15:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0fLzjFSHRDHT7-eEnk0+E4zPrk-_g53ROs_dmyc3g1EA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arnd,

thanks you for your feedbacks.

I'll wait for feedbacks from Rob and propose a version with implementation.

On 18/11/2021 14:33, Arnd Bergmann wrote:
> On Mon, Nov 15, 2021 at 11:39 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The proposed bindings are describing a powerzone, a power capping
>> capable place to act on and where we can read the power
>> consumption. The powerzone semantic is also found on the Intel
>> platform with the RAPL register.
>>
>> The powerzone can also represent a group of children powerzones, hence
>> the description can result on a hierarchy.
>>
>> The description gives the power constraint dependencies to apply on a
>> specific group of logically or physically aggregated devices. They do
>> not represent the physical location or the power domains of the SoC
>> even if the description could be similar.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Hi Daniel,
> 
> This looks reasonable to me, based on what I remember from previous
> discussions, but it would be good if you could summarize the points that
> have already been discussed in the past, e.g. which approaches you have
> tried out before and how you ended  up here, including links to mailing
> list archives.
> 
> I know you've been at this for quite some time now, but I can never
> remember the bits that we discussed in the past myself.
> 
>         Arnd
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
