Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950393435FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 01:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCVAaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 20:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCVA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 20:29:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 17:29:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so10234326pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=mN9M2gHDmHAMZP+50/Nsn8lRknSmspKGtmjuk7ePwS4=;
        b=LIWwyHHNktv8GP6XKK9oeK5MSL/7YlonGPEGcdfj73hiYJ3jW/UjEflWYG7ADC9ung
         +gQJhzdmo+TJ+pv7YoE+5JEPfYaCTZVrRo9hUj8H39b6bjycfjCDcvuoImxhv/1B9AxF
         F6hetDo8fEmbCZnSEQU3nAaVWQwEN1xZ6u7FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mN9M2gHDmHAMZP+50/Nsn8lRknSmspKGtmjuk7ePwS4=;
        b=NLCxWOkcXobQQCzNWmXOuxbgy0oMrgrZ1ocr76XPlxBEzMHS4hhk9b83iYJHLxwFcD
         Ongi721f0IKH/nY5+MuyvEcmiOaljDlZ2mHJXqm9+evTMgXpnLx3gY7A+9WIQgodvwzA
         ZhtbNi1/ePONjmS/kZzI19z7N6WsgebYkM6lwxD3gESEwT9dOonTawfPqSCBvYOP6BPT
         SXRJ8JdLGdmWUP5Ojex02hhh486iyyLcIg7i7mobj5Q7yuwOgrOjgnCX2sV/xPZ0LsZC
         wK5ecrXLYwVeZSxUxnHQwTkA3jZRuDYUsj2PTXDmcB7aguhq1YJbk3gYKge2k8+3lc3M
         XiSQ==
X-Gm-Message-State: AOAM532N+tOTVHDliId+G1BFEkGhy5NTjrLXQtPzFM85pM4BtbM8Chzj
        GiA39ODiaU7CSTMTfq7aBcxvgu/DHUgMyw==
X-Google-Smtp-Source: ABdhPJyZ/jN5TaWP814l7V73C6xJ4pkB8X56MyPwnqT5f4D8rK22D0Wcv1lAfC6UQf3ARiG2+GsELQ==
X-Received: by 2002:a17:903:228c:b029:e6:4c7e:1cbc with SMTP id b12-20020a170903228cb02900e64c7e1cbcmr24592365plh.38.1616372976026;
        Sun, 21 Mar 2021 17:29:36 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-b0f2-84a1-ce9a-a0fd.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b0f2:84a1:ce9a:a0fd])
        by smtp.gmail.com with ESMTPSA id i10sm12299634pgo.75.2021.03.21.17.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 17:29:35 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v11 1/6] kasan: allow an architecture to disable inline instrumentation
In-Reply-To: <20210320014606.GB77072@balbir-desktop>
References: <20210319144058.772525-1-dja@axtens.net> <20210319144058.772525-2-dja@axtens.net> <20210320014606.GB77072@balbir-desktop>
Date:   Mon, 22 Mar 2021 11:29:32 +1100
Message-ID: <87r1k8av4j.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <bsingharora@gmail.com> writes:

> On Sat, Mar 20, 2021 at 01:40:53AM +1100, Daniel Axtens wrote:
>> For annoying architectural reasons, it's very difficult to support inline
>> instrumentation on powerpc64.
>
> I think we can expand here and talk about how in hash mode, the vmalloc
> address space is in a region of memory different than where kernel virtual
> addresses are mapped. Did I recollect the reason correctly?

I think that's _a_ reason, but for radix mode (which is all I support at
the moment), the reason is a bit simpler. We call into generic code like
the DT parser and printk when we have translations off. The shadow
region lives at c00e.... which is not part of the linear mapping, so if
you try to access the shadow while in real mode you will access unmapped
memory and (at least on PowerNV) take a machine check.

>> 
>> Add a Kconfig flag to allow an arch to disable inline. (It's a bit
>> annoying to be 'backwards', but I'm not aware of any way to have
>> an arch force a symbol to be 'n', rather than 'y'.)
>> 
>> We also disable stack instrumentation in this case as it does things that
>> are functionally equivalent to inline instrumentation, namely adding
>> code that touches the shadow directly without going through a C helper.
>> 
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  lib/Kconfig.kasan | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>> index cffc2ebbf185..7e237dbb6df3 100644
>> --- a/lib/Kconfig.kasan
>> +++ b/lib/Kconfig.kasan
>> @@ -12,6 +12,9 @@ config HAVE_ARCH_KASAN_HW_TAGS
>>  config HAVE_ARCH_KASAN_VMALLOC
>>  	bool
>>  
>> +config ARCH_DISABLE_KASAN_INLINE
>> +	def_bool n
>> +
>
> Some comments on what arch's want to disable kasan inline would
> be helpful and why.

Sure, added.

Kind regards,
Daniel

