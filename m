Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62B83FF3C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347277AbhIBTGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347293AbhIBTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:06:31 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE7C061760
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 12:05:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y18so3883015ioc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OXZqISKb+3/D+M8ylFbCk/JGwY6mKgD1ydjQnDG3zVs=;
        b=VJFpFBPmPT4XwBset+uhhMg0ISb1GCW1kJjLzIvNCL6HihhiJecjUCX07oZc/ZuJGY
         qbmY2IykKGetWm3LUH4WhEUUzZ39SbZtGtHYSMpesWA1DF77FM11s8tG6kP3bSF6y9/5
         6chGfyevjD+mUyFhMOpZqj2gO6AVIq/S6RJXEgNVPynXqZAGJILUKdqd03De4g4i84yi
         ypJJjl8uuEB3rk4a1LWCiB9AShM+Q7UqbkrhsghMrlYGi8pyiP5Dkk33SUomc0xmAi7x
         hO6JQR4aX9BLCZ4dQ9VKPwIRfe+QexBmGZHuj9v5A8+Rx8EvwIGYFAqS8vlF7RtNa9dE
         j0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OXZqISKb+3/D+M8ylFbCk/JGwY6mKgD1ydjQnDG3zVs=;
        b=c+XMtpmsOfkNohhucyy9XuWmEa+CawDm8RXa3XkreMoVTjmJa7Y9kT56ZritIyfEx5
         n9+aC4tw8AqKXiOlqA9fnsrmviOaVhBsQ2rzJh8kc5cKG0UUffSUwiLThpjzgf/9yYgr
         AwvRVWyEPO/9wYF3OdbgrmkThe1idLTOfuHLvSE+eeyU7i+jVMJSg3V42FzIcHTRpFT1
         Z5nlENZRujWFQnjvRrImBv2mEIjdpbRe9kOPuxSOkzSHvyjGMF/wscTSPwjx6OHrLnCn
         3zHjpp19wkgoRxWJrILYomJr+k5ZpJiV+URWTUokXpkginsJfQlKjjR0I+pVAtzGgF8d
         fwrg==
X-Gm-Message-State: AOAM531MH0ofnPGHa88SHH32mrkmJ3WPfYAATxzFAuFG6tULI2bdBO9q
        wKH3ylfNjYJ2zNkJBY+fuel8dv7OSP3OHg==
X-Google-Smtp-Source: ABdhPJyLVCBeT3FHrHbpJg7PKehRjUVDZaZR/dOXMi9h3h3zHQzyUMZdd7pRDdLHSiB0SYn02kYOpw==
X-Received: by 2002:a05:6638:1642:: with SMTP id a2mr4130653jat.88.1630609532376;
        Thu, 02 Sep 2021 12:05:32 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b12sm1389830ilo.44.2021.09.02.12.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 12:05:31 -0700 (PDT)
Subject: Re: slub: BUG: Invalid wait context
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <3b7661a1-dbde-ea54-f880-99777c95ae22@kernel.dk>
 <YTEeTK83KNBmuJLC@casper.infradead.org>
 <91af18d0-64cb-71ac-e9f4-4135fe02cb33@kernel.dk>
 <YTEf2MEkEdMVAuRF@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b884d2b-bcac-4967-d792-f7653084c38d@kernel.dk>
Date:   Thu, 2 Sep 2021 13:05:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTEf2MEkEdMVAuRF@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 1:02 PM, Matthew Wilcox wrote:
> On Thu, Sep 02, 2021 at 12:59:33PM -0600, Jens Axboe wrote:
>> On 9/2/21 12:56 PM, Matthew Wilcox wrote:
>>> On Thu, Sep 02, 2021 at 10:22:23AM -0600, Jens Axboe wrote:
>>>> Hi,
>>>>
>>>> Booting current -git yields the below splat. I'm assuming this is
>>>> related to the new RT stuff, where spin_lock() can sleep. This obviously
>>>> won't fly off IPI.
>>>
>>> You want to turn off PROVE_RAW_LOCK_NESTING for the moment.
>>
>> Because?
> 
>         help
>          Enable the raw_spinlock vs. spinlock nesting checks which ensure
>          that the lock nesting rules for PREEMPT_RT enabled kernels are
>          not violated.
> 
>          NOTE: There are known nesting problems. So if you enable this
>          option expect lockdep splats until these problems have been fully
>          addressed which is work in progress. This config switch allows to
>          identify and analyze these problems. It will be removed and the
>          check permanently enabled once the main issues have been fixed.
> 
>          If unsure, select N.

This isn't a new text, it's been like that for quite a while. The warning
is new on -git with that option.

-- 
Jens Axboe

