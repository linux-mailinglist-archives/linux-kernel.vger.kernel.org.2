Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA43CF0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353965AbhGTAJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbhGSXuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:50:25 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087AC0613A9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:29:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t143so22738136oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 17:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K9hlFT7XN9rDzlqLkCTqQZQKsdldq2qTv8vpb0ZPDu0=;
        b=AyFR+DDdy/gDS1GogjMjC80sHdqWbTJqltHhCtcircYskN67OB+OWTKJ3SS+h8xUYD
         w2QXoTF5CA4/CU0d1lECQLxNbJFGCNbAs3SKGWCbBZ//MnCeUtuatvzVOOdamXtOIkF3
         UQ4r34gQLU2RZwoefsMp0PhHRUTLk7b+kqH4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K9hlFT7XN9rDzlqLkCTqQZQKsdldq2qTv8vpb0ZPDu0=;
        b=YVHMDfY2/Gm90tf0l7BCmcyHTmHB1VHiVyXPvJdmYGi9zbVym3Iq4oW3nzmjUcGQMl
         asLCoKTLfm8hoHGu8OAK3iNP57ORjvSDswJAYLP2l7TqlhYfj0J6837uSukUeP7wEjQS
         kXaYGDuuD83HSFEC5VGe4xC4Wp72mnefrXspn5AVWp23PkV1cP0xCaK3pHRDOr2hiah+
         4pQQNrsndGrdg6Mv8cXAs612Yas4xJwsocxcrH6dWPr4j8ffzqE12pSMojDCAFALxTcj
         QISb9C4DzCpKqulQIJk3dXK+R9RYCDA3XOeRA4u/knW7OWmricxpxDfBm/3iVl/V+G0d
         76bg==
X-Gm-Message-State: AOAM532MsjZeSq3dVP+pWmCxLM3RY7yJBDdSPREbpHl2jO4m00IqnVQo
        +0X4gpsQQ0dNaEPvwmR2EVeTTw==
X-Google-Smtp-Source: ABdhPJx5cZCdQiqJiAaL6oqJ8M/Y7oeIq5EEANev3JMcHM5BnJSoC41yixG8KwGrHh32UO/8dqnZow==
X-Received: by 2002:a54:4515:: with SMTP id l21mr3322848oil.54.1626740944502;
        Mon, 19 Jul 2021 17:29:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r1sm3646738ooi.21.2021.07.19.17.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 17:29:04 -0700 (PDT)
Subject: Re: [PATCH 5.12 000/289] 5.12.19-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210719183557.768945788@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9a549bf3-c522-8a18-6c41-5b1dbd85e221@linuxfoundation.org>
Date:   Mon, 19 Jul 2021 18:29:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210719183557.768945788@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 12:36 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.19 release.
> There are 289 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jul 2021 18:35:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.19-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

