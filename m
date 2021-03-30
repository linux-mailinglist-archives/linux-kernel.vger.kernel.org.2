Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0225134DD49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC3BB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC3BBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:01:04 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F8FC061762;
        Mon, 29 Mar 2021 18:01:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so14025646oty.12;
        Mon, 29 Mar 2021 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9UTYKvzTiJrxHjVk8ibIWhjc8BbX4oL9HwCRVc6pGZA=;
        b=FQnW7nl2gOgbGNRz7bAs+Pn2CtmY7jye2ZtXRvyV/diU5z2w62B2IP1fcP+/S1s/9T
         BHa7stPeKy5udsuat3aLagW0eUElch8uQU4TzWpPWn/2cvssrnDz8g8RCs/QfmpYQJlm
         DCQdttwYbB+TtgFgYsvhmlBCk+9JCHT0mtgNyB8ZJIWTwnJI1SDcOE4s1O/XRFQGQLhv
         EFeSBk+OTTkFTR/IhJIzSCfngwoRuu/VeAMMESBwMsNyeSlT5LDJvDashl3vyVwYe84L
         Pd2rmgHfwh0MyxWb8k9t8EgTXbXjNXzCmmV7WMYuN9hd5aF5wpWcwfjpWnj33faj0LiC
         Wmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9UTYKvzTiJrxHjVk8ibIWhjc8BbX4oL9HwCRVc6pGZA=;
        b=b8PNFoXPDzNAXrHdgAQEvlXqasPe9Rh7s4K/FilQZRDI/OdO5UBm2/Ro5Xt6AkX4BV
         IFFJonh1wUn/gtXCio2hY7ajZs/PdROFjaQylvNGrOzJEn9T3IW8sMGFx/EoaPHVRqJv
         th7I3lSbci1n/8w9SFP6ub951EgeVGTgT2m9f3wbi5h+Rqm0urQu8xYhN6OjLVznb59N
         gityDKin73KeQ5sS++n04AnFMcHBMGL3tWp01lrqxOwrHo4mLq8WUaa6mcRewCaLK6N7
         IPLXZyYF4ZCSv148lRaKuqRn+UQD9IoWNYIQSwjowMgqgPi6Jv2EHCKVElCcXwVd52Ne
         nWjA==
X-Gm-Message-State: AOAM5311Ul11wKRuv1wwcv4Q3Qa0d5aqWg7YnDk0p3m1Jq+Gt8f3Dgsp
        ffdKcd2OK1YuZQpBc+DH3yeHBZaur1c=
X-Google-Smtp-Source: ABdhPJzY/aRM+RNfLcojh8pAfQqDVfHU5Rwk/gL3fRw3kR96QVn4grGeFEYxGiwoZvZiYK1O0VNSBA==
X-Received: by 2002:a9d:6296:: with SMTP id x22mr24367511otk.196.1617066062919;
        Mon, 29 Mar 2021 18:01:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 62sm2990358oto.60.2021.03.29.18.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 18:01:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (nzxt-kraken2) mark and order concurrent accesses
To:     Jonas Malaco <jonas@protocubo.io>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210329082211.86716-1-jonas@protocubo.io>
 <20210329215339.GH220164@roeck-us.net>
 <20210330002131.s2qz3dr6bwr6jz25@calvin.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <56ebbf0f-cdcb-d5af-e1ad-c7604597566e@roeck-us.net>
Date:   Mon, 29 Mar 2021 18:01:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210330002131.s2qz3dr6bwr6jz25@calvin.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 5:21 PM, Jonas Malaco wrote:
> On Mon, Mar 29, 2021 at 02:53:39PM -0700, Guenter Roeck wrote:
>> On Mon, Mar 29, 2021 at 05:22:01AM -0300, Jonas Malaco wrote:
>>> To avoid a spinlock, the driver explores concurrent memory accesses
>>> between _raw_event and _read, having the former updating fields on a
>>> data structure while the latter could be reading from them.  Because
>>> these are "plain" accesses, those are data races according to the Linux
>>> kernel memory model (LKMM).
>>>
>>> Data races are undefined behavior in both C11 and LKMM.  In practice,
>>> the compiler is free to make optimizations assuming there is no data
>>> race, including load tearing, load fusing and many others,[1] most of
>>> which could result in corruption of the values reported to user-space.
>>>
>>> Prevent undesirable optimizations to those concurrent accesses by
>>> marking them with READ_ONCE() and WRITE_ONCE().  This also removes the
>>> data races, according to the LKMM, because both loads and stores to each
>>> location are now "marked" accesses.
>>>
>>> As a special case, use smp_load_acquire() and smp_load_release() when
>>> loading and storing ->updated, as it is used to track the validity of
>>> the other values, and thus has to be stored after and loaded before
>>> them.  These imply READ_ONCE()/WRITE_ONCE() but also ensure the desired
>>> order of memory accesses.
>>>
>>> [1] https://lwn.net/Articles/793253/
>>>
>>
>> I think you lost me a bit there. What out-of-order accesses that would be
>> triggered by a compiler optimization are you concerned about here ?
>> The only "problem" I can think of is that priv->updated may have been
>> written before the actual values. The impact would be ... zero. An
>> attribute read would return "stale" data for a few microseconds.
>> Why is that a concern, and what difference does it make ?
> 
> The impact of out-of-order accesses to priv->updated is indeed minimal.
> 
> That said, smp_load_acquire() and smp_store_release() were meant to
> prevent reordering at runtime, and only affect architectures other than
> x86.  READ_ONCE() and WRITE_ONCE() would already prevent reordering from
> compiler optimizations, and x86 provides the load-acquire/store-release
> semantics by default.
> 
> But the reordering issue is not a concern to me, I got carried away when
> adding READ_ONCE()/WRITE_ONCE().  While smp_load_acquire() and
> smp_store_release() make the code work more like I intend it to, they
> are (small) costs we can spare.
> 
> I still think that READ_ONCE()/WRITE_ONCE() are necessary, including for
> priv->updated.  Do you agree?
> 

No. What is the point ? The order of writes doesn't matter, the writes won't
be randomly dropped, and it doesn't matter if the reader reports old values
for a couple of microseconds either. This would be different if the values
were used as synchronization primitives or similar, but that isn't the case
here. As for priv->updated, if you are concerned about lost reports and
the 4th report is received a few microseconds before the read, I'd suggest
to loosen the interval a bit instead.

Supposedly we are getting reports every 500ms. We have two situations:
- More than three reports are lost, making priv->updated somewhat relevant.
  In this case, it doesn't matter if outdated values are reported for
  a few uS since most/many/some reports are outdated more than a second
  anyway.
- A report is received but old values are reported for a few uS. That
  doesn't matter either because reports are always outdated anyway by
  much more than a few uS anyway, and the code already tolerates up to
  2 seconds of lost reports.

Sorry, I completely fail to see the problem you are trying to solve here.

Guenter
