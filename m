Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D759B407232
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhIJT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:58:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92654C061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:57:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b200so3799716iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tBrvKO9A/dPwPbpROFlIDW4gM0sK3mcNXTt1Pn9aYHY=;
        b=Wr4Gh3KIEFBM+ACEtKQQkB6ZOkXVsSDftDicx8567wKbGFHG5dCUuH68Dx+CuM8TK6
         gQ7djhp5EGDI/HV2+EvnV7cWz7JpEknCAap1HFt6xk8PkkNW9U41GiHMY9RrY2jHgCC4
         CKNW6+usqWdG2oQzFX3bYmPoBwgjJQdRUpxKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tBrvKO9A/dPwPbpROFlIDW4gM0sK3mcNXTt1Pn9aYHY=;
        b=cTq0JbUSDbQr5IiqeMxgju4OvGyw8cTZR+Q9QQZ9tAS/JMAKkPNmKTglm48NtBqI53
         iKK/qwN0C16jmBtZA4rNrOBFsxh6MItLLNJXSSS/6P0a3jj+3Q9OAqexXXfFd4Boo89+
         c/cw4sRh0ymuVWz3rpcHPNCoevOQ0sWddaVUherDjS4F4en45HyCLRi3K+zPEuz7Kso2
         W49CSafnFw3ucOZhGlsUgZT+HGJvCWZtGRKRDKzcUaaUp9rG2TAF0fCElbDzyIZ8MpJK
         DHKwmFFPG6MhQRcG4eXO7dRWTbLmcAOb+zY3TkLtGgt47mG53Uw2nmUg+NmZOg7iv66p
         +qRw==
X-Gm-Message-State: AOAM532Ow4+38sue4QXBe35f//RJzCZKV0ZsbdlXK1kIg34a8K/phcGv
        YCUEEXxTna1pJ7kef3PjVCyLcQ==
X-Google-Smtp-Source: ABdhPJyP48qJEKgFnhFD8cbEzB1AQlheLGpbQaL1VD3/gyzpnzXEXw6tsqrQNdt45Z3xGwS0dvg2og==
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr8297816ioa.136.1631303825973;
        Fri, 10 Sep 2021 12:57:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a17sm2999141ilp.75.2021.09.10.12.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 12:57:05 -0700 (PDT)
Subject: Re: After KUnit update for Linux 5.15-rc1 - unable to share VFAT
 filesystem via samba
To:     Arthur Marsh <arthur.marsh@internode.on.net>
Cc:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
 <f1d84102-6edf-271f-52f9-0d4bbc85c0c7@linuxfoundation.org>
 <C1ACE9E0-2EDF-4F55-A6F1-B9143F62514B@internode.on.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <843ce49e-4adf-c3c4-83e1-8fb114589cc6@linuxfoundation.org>
Date:   Fri, 10 Sep 2021 13:57:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <C1ACE9E0-2EDF-4F55-A6F1-B9143F62514B@internode.on.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 12:33 PM, Arthur Marsh wrote:
>> Can you send your config and dmesg? This will help determine if
>> KUNIT is enabled - it shouldn't be.
> 
> # CONFIG_KUNIT is not set
> 
> I am re-running the git-bisect without the " - - fs/fat" qualifier but it will take a few days.
> 

Can you run a quick test reverting the following one
at a time to isolate:

b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd (this is the other one in
you bisect log)

c815f04ba94940fbc303a6ea9669e7da87f8e77d (This is the KUnit patch)
(This one shouldn't be in play without CONFIG_KUNIT)

thanks,
-- Shuah
