Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2604932A921
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580728AbhCBSMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384630AbhCBPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:32:30 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C292C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:27:24 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id v12so19198222ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e79b35YG0+gbCiDJj+I5H6NghEAUI7GEkWLA6tEg4Gs=;
        b=IrRzArdgfVJVnwyHN0l6DUYd6q03xZbe5WO6GjoukZLcSYEk2SAZkuVEYpYNnInBKG
         aA11Abo4VkwO+cqjr5RfFYdhNNew8gF7Y1tXDnOn1gnc4LpTj0ZObGaGzV674P2JbLCH
         fpU2HPp3QK3RgfhbtjhrAuDv3ljEKuIO6o9aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e79b35YG0+gbCiDJj+I5H6NghEAUI7GEkWLA6tEg4Gs=;
        b=Cqc9fZkr0TPQ0g/UU7qDd37Ihn8IERaaEVrqlQIvpKTb0PEUbkY5f+w4eNCzYDSuEP
         nGDjNBmxH/rFF15LnVlUXOqEMVkvp5tQJuj1enqQx4QVsUzVg+iBCDXJxR8rt31fIKDU
         +fPu5v0wWb7wbTFNG/17vLXIcexSe59GrwksKPsjX/ODDPHUI3+UD1TBDF1qT1PHDpBG
         aycGfVy+X3qHzPzdFAccx71VnImrvmZxy3+SN1SL6E5fGBnz03XHhuvInHq6pUMaVW/h
         OYIRF1QDRzTtzvxDV9Tg7arTHkxdt21dgGma4AGOa9O0Q2pnYjlgZFQfY/BQsxDc/yYA
         igfg==
X-Gm-Message-State: AOAM532ZHIcwrgFffSAO8H6DLMSY1pPZM5rh1piOP8I/e8J8Q5a8Qr+B
        kuIUsoPLHLD12Op0GY5IdkkZ+A==
X-Google-Smtp-Source: ABdhPJztO3JExaOGej7r1rUpoB3z2m2zvTOXTtPpQ5UQVgKRMGDv9fZFfSTrouU/trOVqlMC87vJEA==
X-Received: by 2002:a05:6830:15cf:: with SMTP id j15mr18821705otr.268.1614698843545;
        Tue, 02 Mar 2021 07:27:23 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t2sm4586768otq.45.2021.03.02.07.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 07:27:23 -0800 (PST)
Subject: Re: [PATCH] selftests: gpio: update .gitignore
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210224185316.17942-1-brgl@bgdev.pl>
 <CACRpkdZ915TABrSt0A_1tM3Jt_op4gcCY1b-d2ocM7wjKJFoPA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b188690a-31e5-fca9-1226-9dbf7c9f9448@linuxfoundation.org>
Date:   Tue, 2 Mar 2021 08:27:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ915TABrSt0A_1tM3Jt_op4gcCY1b-d2ocM7wjKJFoPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 7:44 AM, Linus Walleij wrote:
> On Wed, Feb 24, 2021 at 7:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> The executable that we build for GPIO selftests was renamed to
>> gpio-mockup-cdev. Let's update .gitignore so that we don't show it
>> as an untracked file.
>>
>> Fixes: 8bc395a6a2e2 ("selftests: gpio: rework and simplify test implementation")
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
> 


Thank you. I will queue this up.

thanks,
-- Shuah
