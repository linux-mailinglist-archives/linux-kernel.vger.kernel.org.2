Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE90D34D7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhC2TES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhC2TED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:04:03 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE61C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:04:03 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id by2so6970732qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9S+bGUd9aZDaRnQzBvs27iCy/h9nzkF8Ov8dhaqiwqs=;
        b=eWVXCoWrV8VfDiWNZAeerOHLN4/+KZHc03zq3r0KE8I7mB0bFCyogNkYJnwAObQ/9l
         dSS3wmIQ9AHl7DFQwLS2qEbx5OWChy0qTCHSEUoE85fShY/WtO+pOP1gd9SIzdoL+Dxo
         ByqvFEtvo6iFkUhPhrREjF2WdKy2pMnbckytPCCoIcpSm1LMGu+ZUVp9YIhv+HWfaz9o
         wph+f/9mwniABA7vFYM/16ez9a78XtsWiJYjnrec5xsJE2EksF5Fxcq3zUo1gEnuRIwf
         6g1S3HzEmQOH3mxGHAvr8NFf8dPLxkrOpxlowPchkyxsnX8ZNpnA7zYzkMF4Qfiz53VG
         lZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9S+bGUd9aZDaRnQzBvs27iCy/h9nzkF8Ov8dhaqiwqs=;
        b=TZEtsq/Uv2KgCjocEntW9DrFF0+ZPlIdeSCIOmfoznozEYoi7CSdeiQYztWBOoy/EK
         F/ZpY3AI2hrMvadsfmP/Ky6eH8xX4Ay7Q13tTIthdtWGkV8QphUBZoFDImidUBCnrLfx
         z0RhuU3UYuG5yvONMakV5rElrBFcI8d24QSi5sxDm6LELb5Fq+bG2RNVbbnKZBRA0dZR
         WsChTXEfxE9PxAGbG3NuUP9AxvfjqI1Q0YZ5YFJJcHfPV53sch2GhZlPK/2uTAp4ok4B
         L12V3F7MP/sAOPBHd3r+82B+vcAw2EUOpk1ksyOcAzZG/kPFRHWSHJFHF3sv/8frHOSd
         uHhA==
X-Gm-Message-State: AOAM530mB2mWYATrURNIjbCJKbUPT0d42IzaZF5NVTQKasMWOIEHB3q+
        IhXhB43S9Smqo1izPn7kK6A=
X-Google-Smtp-Source: ABdhPJyfgVjidUPOZW0SNRMRivEZvWFn55bXuPEiPx11dxdOv6v/f7jaRvGcnLTF1L839SzGH9FtvA==
X-Received: by 2002:a05:6214:b04:: with SMTP id u4mr26665394qvj.0.1617044642357;
        Mon, 29 Mar 2021 12:04:02 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id 6sm11637739qth.82.2021.03.29.12.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:04:02 -0700 (PDT)
Subject: Re: Linux 5.12-rc5
To:     Rob Herring <robh@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wg89U6PLp1AGhaqUx4KAZtkvKS6kuNmb+zObQhf1jez+g@mail.gmail.com>
 <20210329020746.GA250550@roeck-us.net>
 <CAHk-=wiMoP9PifpuUnQ3xmAM_LmGARr+fxFuOSX1rvh2mz35Mw@mail.gmail.com>
 <CAL_JsqKxLy3Gc8d1Q23AQaWTKLmc_a28tokZZ08rHnV2qU0iew@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <824f80dc-7936-4f7b-b298-1b2c2ad60716@gmail.com>
Date:   Mon, 29 Mar 2021 14:04:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKxLy3Gc8d1Q23AQaWTKLmc_a28tokZZ08rHnV2qU0iew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 1:41 PM, Rob Herring wrote:
> n Mon, Mar 29, 2021 at 1:05 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Sun, Mar 28, 2021 at 7:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> This is not really a new problem. I enabled devicetree unit tests
>>> in the openrisc kernel and was rewarded with a crash.
>>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>> has all the glorious details.
>>
>> Hmm.
>>
>> I'm not sure I love that patch.
>>
>> I don't think the patch is _wrong_ per se, but if that "require 8 byte
>> alignment" is a problem, then this seems to be papering over the issue
>> rather than fixing it.
>>
>> So your patch protects from a NULL pointer dereference, but the
>> underlying issue seems to be a regression, and the fix sounds like the
>> kernel shouldn't be so strict about alignment requirements.
> 
> In the interest of the DT unittests not panicking and halting boot, I
> think we should handle NULL pointer.

Agreed.

> 
>> I guess we could make ARCH_SLAB_MINALIGN be at least 8 (perhaps only
>> if the allocations is >= 8) but honestly, I don't think libfdt merits
>> making such a big change. Small allocations are actually not uncommon
>> in the kernel, and on 32-bit architectures I think 4-byte allocations
>> are normal.
>>
>> So I'd be inclined to just remove the new
>>
>>         /* The device tree must be at an 8-byte aligned address */
>>         if ((uintptr_t)fdt & 7)
>>                 return -FDT_ERR_ALIGNMENT;
>>
>> check in scripts/dtc/libfdt/fdt.c which I assume is the source of the
>> problem. Rob?
> 
> That is the source, but I'd rather not remove it as we try to avoid
> any modifications from upstream. And we've found a couple of cases of
> not following documented alignment requirements.

Agreed to not remove.  We can be properly aligned without changing
kmemdup().

> 
>> Your patch to then avoid the NULL pointer dereference seems to be then
>> an additional safety, but not fixing the actual regression.
> 
> I think the right fix is not using kmemdup which copies the unittest dtb.A

This is not the only place a kmemdup() is used by overlays.

I'll create a patch this week to fix all of the kmemdup() locations and add
the null pointer check.

-Frank

> 
> Rob
> 

