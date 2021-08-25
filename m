Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D743F763A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhHYNqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbhHYNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:46:01 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F51C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:45:16 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id b4so14475459ilr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XVnwmb3uXk8+1b5/nov/HrYkqSqNgLeJ1iqRG3io5N0=;
        b=RQtGz41gdrHxJMSAR/9QsLqlxfSrX0hrSv7IbjruEEyWUYs0PDiNVtbcrdh86ZyG+k
         +u2CTpspyxSEDvNfXSzc+xiQsIO1akPDNkmpJD3ROH96aJbuyqkRhpqL584tmJEKke+b
         pywRAzsBSyWapg/6RA9iOO5t2CIuBxhbq7qCw2oj6TzE5jwk0RWNIT8b0PlI8/2niq3/
         x92u9l3DxfEchPc7CvO8+LNk7+TXcSEnFdD0ugkpgu7BdJHjSSi4R8Tpf/WsEphDzEwC
         O6Txj9pNNU9xUO9ChILv4MSeQQBo9C6H0fjgdcJMeh9MuDya6THtIVsKEI5qsuzmdS27
         2zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVnwmb3uXk8+1b5/nov/HrYkqSqNgLeJ1iqRG3io5N0=;
        b=FZoWUb6kbNUTRC0MamK5LTbUmNg/mofLAmQQCFiSrKii7sMS3MFzBTNu8Fuhj1OSOB
         Y8jWAcezIvRQEla8FvlTee73WCUXsefU0l4hadYeVt0W4aaCoe0eBabq8Or9b+ZcSlE1
         7cOKTOkgSdSq4+3pnR/bKiaPCwZ0YpDeRt+k1uAI9YSATofyXbbNn888lJFviE6PIskX
         G+gjYMzLH5M3ykLSHVlLlid0J5BioGfZvoxn7LveQb1SKXJyM+NbBIrzkva6sSRhn+To
         WJ1CnNsx/8P2LNAVN8ORMEOZVhNoua2G9QUY97CbBhSGONC+y5JHGP0n3KtF4VisqPrp
         dtlA==
X-Gm-Message-State: AOAM531HbCDX2xo2g1JqyWXcXA6bv7wdaW/zv90cXrO5pqwyd/bYLWrX
        mqXCtopD1TFnyDbnOKa3e6b4EQ==
X-Google-Smtp-Source: ABdhPJwNusjSb6QKB8DsRhuL2iL/qaGyFgeDyXoTeRFLXrUNExbto5enJ6RAGiTXnrs6B+7jby7tBw==
X-Received: by 2002:a05:6e02:13f0:: with SMTP id w16mr29929619ilj.268.1629899115683;
        Wed, 25 Aug 2021 06:45:15 -0700 (PDT)
Received: from [10.10.10.120] (047-035-132-030.res.spectrum.com. [47.35.132.30])
        by smtp.googlemail.com with ESMTPSA id k2sm11685057ior.40.2021.08.25.06.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 06:45:15 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH v2] staging: greybus: Convert uart.c from
 IDR to XArray
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alex Elder <elder@ieee.org>
Cc:     kernel test robot <lkp@intel.com>
References: <20210814181130.21383-1-fmdefrancesco@gmail.com>
 <5541b638-db1e-26f2-2682-81f35504c9a3@ieee.org>
 <1838037.Ul9q4Z07vA@localhost.localdomain>
From:   Alex Elder <elder@linaro.org>
Message-ID: <335f30c7-8ab4-d46a-d415-e994997a3fa5@linaro.org>
Date:   Wed, 25 Aug 2021 08:45:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1838037.Ul9q4Z07vA@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 12:20 AM, Fabio M. De Francesco wrote:
> On Monday, August 16, 2021 4:46:08 PM CEST Alex Elder wrote:
>> On 8/14/21 1:11 PM, Fabio M. De Francesco wrote:
>>> Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
>>> is more memory-efficient, parallelisable, and cache friendly. It takes
>>> advantage of RCU to perform lookups without locking. Furthermore, IDR is
>>> deprecated because XArray has a better (cleaner and more consistent) API.
>>
>> I haven't verified the use of the new API (yet) but I have a few
>> comments on your patch, below.
>>
>> 					-Alex
> 
> Dear Alex,
> 
> On August 16th I submitted the v3 of my patch ("staging: greybus: Convert uart.c 
> from IDR to XArray"), with changes based on the comments you provided.

Yes, I intend to review version 3.  I'm sorry I didn't respond to
your earlier message; I am on vacation this week.

					-Alex
> 
> Could you please take a few minutes to review this too? I would really appreciate it.
> 
> The v3 patch is at https://lore.kernel.org/lkml/20210816195000.736-1-fmdefrancesco@gmail.com/
> 
> Thanks,
> 
> Fabio
> 
> P.S.: I'd also like to know if you think it's worth converting IDA to XArray in order 
> to improve the Greybus driver in staging.
> 
>   
> 
> 
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 

