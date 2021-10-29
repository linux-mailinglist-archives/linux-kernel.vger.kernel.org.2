Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C32343F533
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 05:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJ2DJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 23:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhJ2DJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 23:09:51 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E4C061570;
        Thu, 28 Oct 2021 20:07:23 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id v29so6527625qtc.10;
        Thu, 28 Oct 2021 20:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JzpSqhfurME8Pq0Oj5kWfxHhRUriyDiyzwnmh7G0kCo=;
        b=APYTuOapfUYrLTwWxUvlvvWNhQqx8FvllGIngRYNIDU7++9ckmIOU3ZR44uClRjJkZ
         ZbSKW6rc9MIBk0D14RSS3XBIr3KuxWOlLaIvCzPZ63kil/c+J50mcKtY98KJTy3rok2t
         hfV28rmS/eG7025BSr1uxT7P2lPw3qRZfdiFCsa40YrNpeWZE3n0+2RhYmEi1aPTKqU7
         LQuPpbc4ABJDWOaH0Ggtzl8SWwg2NKL2uCRZJp9uiXSaS+pxLNynE4Lan0ZxTDbCGZeY
         jvSNd5eJrmX7SHWq83a8ZfVQsB0GTwXcm0vYl2D3Skrk4PPOlY0WUsI6mwfJ6IwvODW+
         Vl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JzpSqhfurME8Pq0Oj5kWfxHhRUriyDiyzwnmh7G0kCo=;
        b=kYE936bsaG9sp/iNQwMRebcQ6+lpt+iSCwy3owhOzDK7z8zSkd2ezgsM34uxdiFpYp
         kA592XQO0K3UJjLbjgy+6rl+wzpoS/bHFiHGXQObw1X+FjV78cr8N+uQvzYlIAdiFZSN
         lXvx4VW3qhsT8ROwh4rkXuD91fiJJIGyDNYGRrH59rbS/C6/bOs4yqrYV+xqzU5mgbsf
         MQK6efML1qRAxC+8BVMotZLQiNnzEdZ5SFkWmlJ+lDAjVMdaV/lpuMSKlfEVJaUYDNHJ
         Hz1HJqBmAD4gVPr8dF7sW8MRHLGHoulH4yhedoEtkaChIiaVeBVoslpet1toPIZNPNxQ
         N3QA==
X-Gm-Message-State: AOAM531GNKAJWt3yCy7PUzNz+8IAZe1qAOsP58H+BoXDyulvrprsXVGJ
        cLDSgmjBQKILr6QzonjpJSFF/aZr45o=
X-Google-Smtp-Source: ABdhPJx/OHw1cubR3WX0YUbY/1y+8ExPJySpa76Cs56rMMJTu84RLvUcDwT5R2sXGUWUEulzTAx37w==
X-Received: by 2002:a05:622a:1209:: with SMTP id y9mr9264405qtx.13.1635476842531;
        Thu, 28 Oct 2021 20:07:22 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id bq41sm3444283qkb.26.2021.10.28.20.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 20:07:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] of: unittest: fix dts for interrupt-map provider
 build warning
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211029005802.2047081-1-frowand.list@gmail.com>
 <CAL_JsqJujq0K9tF+m3qQ5GhC-yo7-vj9HRhF69UmrWA7tZv7DA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e353b41d-48f9-5349-8b89-bafe9ab5101e@gmail.com>
Date:   Thu, 28 Oct 2021 22:07:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJujq0K9tF+m3qQ5GhC-yo7-vj9HRhF69UmrWA7tZv7DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 9:07 PM, Rob Herring wrote:
> On Thu, Oct 28, 2021 at 7:58 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Fix kernel build warning:
>> drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
>>
>> A recently implemented dtc compiler warning reported the dts problem.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/unittest-data/tests-interrupts.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
>> index 9b60a549f502..8c2b91b998aa 100644
>> --- a/drivers/of/unittest-data/tests-interrupts.dtsi
>> +++ b/drivers/of/unittest-data/tests-interrupts.dtsi
>> @@ -31,6 +31,7 @@ test_intmap0: intmap0 {
>>
>>                         test_intmap1: intmap1 {
>>                                 #interrupt-cells = <2>;
>> +                               #address-cells = <1>;
> 
> Notice that we have 2 nodes with interrupt-map here. One has
> '#address-cells' and one doesn't. Why? Because we need to test that
> the code can handle both cases.> 
> The dtc warnings are more what should 'new' users do. I don't know
> what DTs don't have #address-cells, but my guess is ancient ones.
> 
> Rob
> 

I had hoped to build all of the .dts files in the Linux tree, with the
new dtc, but did not get to that today.  That should flush out any
cases that would result in build fail from the new approach of treating
all warnings as errors.  I may get to that tomorrow.

If there any any existing .dts files that will trigger the interrupt
map warning, will we require that they be fixed so that the build will
not fail?

-Frank
