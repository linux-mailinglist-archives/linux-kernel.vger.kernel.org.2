Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C6329FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575090AbhCBDxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244013AbhCAV4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:56:44 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2FC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:56:03 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id g27so18147193iox.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m+RNcLgJhTs9T3Wtftg15wVRmRi1wCDJCjKpYbAY0/A=;
        b=MJQyacUUm3vZ2bwooIZwhAM7UiHVWUMGuNxoldnSizFWUkJFSUuiAxQumxjELNlgrb
         /eLcQ4Tg0Zhnf92Wx4Os7GEI0/YHaMh0qk35c7gl1Y2664dhnD6PDMN78CIpXohakeCE
         PCnXCEKP7IK02BuK2uLUqdBuRZkKEYnCTV67M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m+RNcLgJhTs9T3Wtftg15wVRmRi1wCDJCjKpYbAY0/A=;
        b=q8qc7dR6YRqtzwY1hcl6EdA4ENkEAoQKb+Olo/wwo/3qvfoSWUYcvtkLYxgw70WgoW
         cPrB+StnxuAeVJIuLBYsEoTiQFfx6C5yZRcQAElVGtJ+FwP07LiKYfLgfW59wTUvmzAq
         cdDsbK9+ZNtlgDLvFI06f5Mr4G8jXagbAz8IgzttfyHHShaNQUsqr3ds1gW9AesNlUuF
         33FdrZXoKe7dyG2dx7L+347PM65igpyUFiojofyZHKxLgs61uQKDA739yn4TiFqHa22n
         0lSJgSfp9e4LPXQ+0G2cYnFKU3dg/A8b2bXcYtIw9xKX6dmKw99mvVC4wSjLOh9kZtRn
         87Iw==
X-Gm-Message-State: AOAM533eNmY9BTSx00WQ6WOWMWyJ5M8Ze/oggOo154rvyTPTRiM/FCm6
        ByMIToPjz4tRi69uk3lU+RjEbw==
X-Google-Smtp-Source: ABdhPJxrp3JBhAwUOXubk6UYexoVXauvHts6BTPI4kdtwm1ee8jHrgNFGx0c9fELGfpFRK3RMIH/pw==
X-Received: by 2002:a05:6602:15cc:: with SMTP id f12mr15114491iow.32.1614635763161;
        Mon, 01 Mar 2021 13:56:03 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v3sm4688857ioh.25.2021.03.01.13.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 13:56:02 -0800 (PST)
Subject: Re: [PATCH] kunit: fix checkpatch warning
To:     Brendan Higgins <brendanhiggins@google.com>,
        Lucas Pires Stankus <lucas.p.stankus@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210226205410.nnwstno5xrsb5ci3@smtp.gmail.com>
 <CAFd5g47ebZFOA6myhJHykt=nG5SwgJmuVAjr=CSkeO06iNg5AA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3196393d-0e6a-d948-c695-3911daaeea4a@linuxfoundation.org>
Date:   Mon, 1 Mar 2021 14:56:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47ebZFOA6myhJHykt=nG5SwgJmuVAjr=CSkeO06iNg5AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 2:05 PM, Brendan Higgins wrote:
> On Fri, Feb 26, 2021 at 12:54 PM Lucas Pires Stankus
> <lucas.p.stankus@gmail.com> wrote:
>>
>> Tidy up code by fixing the following checkpatch warnings:
>> CHECK: Alignment should match open parenthesis
>> CHECK: Lines should not end with a '('
>>
>> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Thanks!
> 

Hi Lucas,

Please fix your Signed-off-by and resend this patch:

WARNING: From:/Signed-off-by: email name mismatch: 'From: Lucas Pires 
Stankus <lucas.p.stankus@gmail.com>' != 'Signed-off-by: Lucas Stankus 
<lucas.p.stankus@gmail.com>'

thanks,
-- Shuah
