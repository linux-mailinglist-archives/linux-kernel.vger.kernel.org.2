Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E6407548
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 08:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhIKGHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 02:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIKGHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 02:07:38 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91937C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:06:26 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c79so6247216oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YRsAXOR+B9ZJhLqPByr9zY9zfv70ssIn9o4Iz9oUNV8=;
        b=DmTbOXYDZvaasRAHqyn3tRk6ZDWQwiSJCvLqHPgOjrfi+DncylQXr0s73a5T3R5tMt
         ZcPpThiF5bKh5DRKeWRr8XLgLZWu7NxT9E0ENYdpthJGhnyqDrpS2HzPTojKB/SKFf4x
         RYpANlTLh3UdEjG9K3X9hah4iALnBNenu6QafBmR7Gc2ZQC3zeMTyuW5b5iuxpKZfW2M
         z572RlDP2JacXhU8tm14dHBOo6C3axJjs+t+BsDpWKmSEAJxGp/KcGC6LOJhKlfrXQYy
         sl6oej7eSLCJGH7vef6OnIUX57a1ASf9XVDCXKBphi1p1fQb44p6BnfASu8YqWC5EHrI
         54Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YRsAXOR+B9ZJhLqPByr9zY9zfv70ssIn9o4Iz9oUNV8=;
        b=FaTedoe5bSP+6PtzMutk2mxUy3H9va/XVF9kquFt1xcO6JWqseGjFu5riweug7jKcF
         qk740A0euqaAwqKQyda+boyQxnNFQ6zZ8nbIVjjIaVMwLZaCF7fW4pMy5RxQiBN4TXHM
         AsBkrsUcAu6lJ+scCI0QzNIUYouZOgwoadFqA7ixwAlEdEVzC2/y/3Ww7U4lbIURrni+
         DRrhF2Ll18xSy1DPDMjSWWreKUrhYPOzZiuX9aXuQip5vFVX7IAuS0A0+P5FcNKYX8nn
         9TrfBFt1hrh5Vt7pbfIRsV6dsqI7H3R1pfJyfxc+pAHHXccG+UowQwiIjKhj9xQIx5vE
         aFvQ==
X-Gm-Message-State: AOAM532R0KIhqXrHYsqHT4+/yzm0T3XfTwKEedEp2+8t+8Icel3vfei5
        U1CaBu9l8AbtAINprLTGHp8Ae1+CmyS/23zpDbk=
X-Google-Smtp-Source: ABdhPJxKYHEPa4g89Ud9G/MK85H6caqR3uD39776+VSORo9NcviayvA2g0mOM983eyNkxvb8lObN/A==
X-Received: by 2002:aca:6747:: with SMTP id b7mr919629oiy.134.1631340385072;
        Fri, 10 Sep 2021 23:06:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id bi41sm238534oib.54.2021.09.10.23.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 23:06:24 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:06:24 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Sep 2021 23:06:19 PDT (-0700)
Subject:     Re: [PATCH] riscv: add rv32 and rv64 randconfig build targets
In-Reply-To: <25894c79-120f-8885-34cd-2e9dec0017ba@infradead.org>
CC:     linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-a1bcb222-57a9-4ef5-82bc-bed70d1a7e38@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 07:29:30 PDT (-0700), rdunlap@infradead.org wrote:
> Hi,
> Any comments on this patch?

Sorry, I must have missed this one.  It looks great, it's just that I 
don't see your Signed-off-by on the original patch.

> thanks.
>
> On 7/16/21 9:44 PM, Randy Dunlap wrote:
>> Add the ability to do randconfig build targets for both
>> rv32 and rv64.
>>
>> Based on a similar patch by Michael Ellerman for PowerPC.
>>
>> Usage:
>>    make ARCH=riscv rv32_randconfig
>> or
>>    make ARCH=riscv rv64_randconfig
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: linux-riscv@lists.infradead.org
>>
>>   arch/riscv/Makefile              |   10 ++++++++++
>>   arch/riscv/configs/32-bit.config |    2 ++
>>   arch/riscv/configs/64-bit.config |    2 ++
>>   3 files changed, 14 insertions(+)
>>
>> --- linux-next-20210715.orig/arch/riscv/Makefile
>> +++ linux-next-20210715/arch/riscv/Makefile
>> @@ -132,3 +132,13 @@ zinstall install:
>>
>>   archclean:
>>   	$(Q)$(MAKE) $(clean)=$(boot)
>> +
>> +PHONY += rv32_randconfig
>> +rv32_randconfig:
>> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/32-bit.config \
>> +		-f $(srctree)/Makefile randconfig
>> +
>> +PHONY += rv64_randconfig
>> +rv64_randconfig:
>> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
>> +		-f $(srctree)/Makefile randconfig
>> --- /dev/null
>> +++ linux-next-20210715/arch/riscv/configs/32-bit.config
>> @@ -0,0 +1,2 @@
>> +CONFIG_ARCH_RV32I=y
>> +CONFIG_32BIT=y
>> --- /dev/null
>> +++ linux-next-20210715/arch/riscv/configs/64-bit.config
>> @@ -0,0 +1,2 @@
>> +CONFIG_ARCH_RV64I=y
>> +CONFIG_64BIT=y
>>
