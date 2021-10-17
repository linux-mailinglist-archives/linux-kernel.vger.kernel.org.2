Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD6430874
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245575AbhJQLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242072AbhJQLpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:45:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19107C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:43:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v17so35563962wrv.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w43DUiLVu811xq4h9m7lzBE38oZ98PZ1zshE3bWj7o8=;
        b=DbFlZLiG0MN0WOZuyaG/l8Si2MvzjNcxOd4FdBV9pm/jJLgBiD0xgZowc3Z3BIj9cl
         dWzNFrr8BnpSJSr8SoajqBQCR/pca6u4gg7mvhn1R9e3EgzYtBjrRSJXPHV3YtzSYVji
         G5OL00Y0XWRfOsdpiQm6XUiFens0IobzI8ukYjgbLR+P0tlo/hUE4NSJXRk5JGaRPFY3
         CaiX8wzBBHw0AFG6KUo4Ez03jklEQEDKSLkFz2qSvtYeE7dfzTaGTkDfmme8IS5DM1id
         0dhsEKHhfBS5VzxLtY1HMmh2l8UDBQ0fw1NfEis2K0RW228H4ZfIGEsRpYt2kT/6ZnfK
         z1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w43DUiLVu811xq4h9m7lzBE38oZ98PZ1zshE3bWj7o8=;
        b=sFiQAdfaH5BEVKdn7YqycTDZEj2Alrlvop3xCA8mKzc3mY2sfExtqd+ZStVLWJhVEC
         qJoYyrR+qRwQoa2KvQYbgSEdheA/mzyTlUGSx7nYo/Iy00UImUBIODWbuGGZ2ozwucVN
         EUG2a5mvGXEB77UzsQ2tB3A1CVi2GmOWlrkGdPklh49WHwBLaFKoisNuubptqzpOkqOl
         fHrVxZlJaOLYkbeBmYLVtkjeo021GDVyN2EQwSaHI+DAtaX1YUPFnOn6d558lJsoiZM8
         ar01rpmyAaJETrjuEbWw/qGw0SVL/SIa/baFnDX5xicsbVer9Rbl5sYn5Qk3sxzrupBp
         vIMQ==
X-Gm-Message-State: AOAM531fcHhCYbMjTVklBnlxU88CMvEU0xCz8aBiSoQZycYj6tAS75/Z
        6SfhHsMdSJzlcqUktGvVmp0=
X-Google-Smtp-Source: ABdhPJw+wMcjBrWpM02et9VFMg3YLgHJHyeU2EXD50X3FyZPqcg4zj9rtPL9pEND3JNan09AJajmSw==
X-Received: by 2002:adf:a411:: with SMTP id d17mr28486301wra.393.1634470984667;
        Sun, 17 Oct 2021 04:43:04 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id 25sm15967705wmo.18.2021.10.17.04.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 04:43:04 -0700 (PDT)
Message-ID: <4531a88c-2b35-e409-b7f9-cb4253c9c708@gmail.com>
Date:   Sun, 17 Oct 2021 13:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: r8188eu: remove unused constants and variables
Content-Language: en-US
To:     Martin Kaiser <lists@kaiser.cx>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20211017111705.18989-1-straube.linux@gmail.com>
 <20211017112356.b4dwrrxfcgwskhy3@viti.kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211017112356.b4dwrrxfcgwskhy3@viti.kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/21 13:23, Martin Kaiser wrote:
> Thus wrote Michael Straube (straube.linux@gmail.com):
> 
>> Remove some unused constants and variables that are left over from
>> previous cleanup patches.
> 
>> Suggested-by: Martin Kaiser <martin@kaiser.cx>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   drivers/staging/r8188eu/hal/odm.c          |  8 --------
>>   drivers/staging/r8188eu/hal/odm_HWConfig.c |  3 ---
>>   drivers/staging/r8188eu/include/odm.h      | 17 -----------------
>>   3 files changed, 28 deletions(-)

> 
> 
> Hi Michael,
> 
> Looks good, thanks.
> 
> Acked-by: Martin Kaiser <martin@kaiser.cx>
> 

Thank you, Martin.

Greg, I forgot to mention that this patch should be applied on top of
the series.

[PATCH 0/7] staging: r8188eu: odm cleanups

Thanks,
Michael
