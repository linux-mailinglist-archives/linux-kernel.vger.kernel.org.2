Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52031412EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhIUG5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhIUG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:57:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB29C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:56:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g41so44959672lfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2lP0KhRVUvQyWZhQ488eOsEIqUPPJSp/sF1BR/yQXNA=;
        b=NEpQsDXXuNMWEsogXhwZXw4ypkov14vzvRBxhT2TQD+U5CiVQ5t64wtt0SugLK5OQs
         HYua+NHNtV34Js5j1qfF3xrqCpUs+dG1ZvRltYVj6DokNycwnox+8LhdumLUL4S2Zx1N
         i5+CtjaG4+43ZCjC1Pdc/+supfjsgYP3RXW70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2lP0KhRVUvQyWZhQ488eOsEIqUPPJSp/sF1BR/yQXNA=;
        b=v2OrnMEpdPkutbtR3T8VuYeBTC5Ec9og2Krqtn86eyjzJKCLQwsv1il9GqgNMHrrvi
         mmL6Fe3EXP6E466z2XJsp/fNAJf/nhGiVYK/zXLU6HL1AwaWppC+CnMOIjA5q87Bo1Qs
         Kg4D+HAMvX3bHgAYzxSb9NJ8BGsDQ/oyseV1/yiGfpwDcKYZy/MiuCxz6blbgsapno5i
         +HZrGEkQ5zvrMryh74pVF3CTRRK/vPJ+lBa4f0xuM/wfjF9kBCE0/SJWb9HobNZiLzRa
         DJeZP3ker4N0MQF1akX4U0TIxFxxPgxQlS+rFQrKU2lQc3D98hB+EzryZxTF+Dy2P9O3
         C+fg==
X-Gm-Message-State: AOAM531lsRTxSEk0wpxqAi8yEqoF4nfqqLilF+B2+ehL6H33sswR32vV
        LJ8THKwwgdBHbHpEowA6NZ1Mhw==
X-Google-Smtp-Source: ABdhPJzmHrM5oxs0FqUN8u4NwCUaVUzt1evboU4++WOUrYJxYEr2dBeXzvQMRUp6ttPU5Wm/bDxShw==
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr9411631lfg.550.1632207382109;
        Mon, 20 Sep 2021 23:56:22 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p19sm656144lfr.210.2021.09.20.23.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 23:56:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] test_overflow: Regularize test reporting output
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-3-keescook@chromium.org>
 <CAKwvOdnYYa+72VhtJ4ug=SJVFn7w+n7Th+hKYE87BRDt4hvqOg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <eb6d02ae-e2ed-e7bd-c700-8a6d004d84ce@rasmusvillemoes.dk>
Date:   Tue, 21 Sep 2021 08:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnYYa+72VhtJ4ug=SJVFn7w+n7Th+hKYE87BRDt4hvqOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 00.10, Nick Desaulniers wrote:
> On Mon, Sep 20, 2021 at 11:09 AM Kees Cook <keescook@chromium.org> wrote:
>>

>> @@ -544,10 +544,7 @@ DEFINE_TEST_ALLOC(kmalloc,  kfree,      0, 1, 0);
>>  DEFINE_TEST_ALLOC(kmalloc_node,         kfree,      0, 1, 1);
>>  DEFINE_TEST_ALLOC(kzalloc,      kfree,      0, 1, 0);
>>  DEFINE_TEST_ALLOC(kzalloc_node,  kfree,             0, 1, 1);
>> -DEFINE_TEST_ALLOC(vmalloc,      vfree,      0, 0, 0);
>> -DEFINE_TEST_ALLOC(vmalloc_node,  vfree,             0, 0, 1);
>> -DEFINE_TEST_ALLOC(vzalloc,      vfree,      0, 0, 0);
>> -DEFINE_TEST_ALLOC(vzalloc_node,  vfree,             0, 0, 1);
>> +DEFINE_TEST_ALLOC(__vmalloc,    vfree,      0, 1, 0);
>>  DEFINE_TEST_ALLOC(kvmalloc,     kvfree,     0, 1, 0);
>>  DEFINE_TEST_ALLOC(kvmalloc_node, kvfree,     0, 1, 1);
>>  DEFINE_TEST_ALLOC(kvzalloc,     kvfree,     0, 1, 0);
>> @@ -559,8 +556,14 @@ static int __init test_overflow_allocation(void)
>>  {
>>         const char device_name[] = "overflow-test";
>>         struct device *dev;
>> +       int count = 0;
>>         int err = 0;
>>
>> +#define check_allocation_overflow(alloc)       ({      \
>> +       count++;                                        \
>> +       test_ ## alloc(dev);                            \
>> +})
>> +
>>         /* Create dummy device for devm_kmalloc()-family tests. */
>>         dev = root_device_register(device_name);
>>         if (IS_ERR(dev)) {
>> @@ -568,23 +571,22 @@ static int __init test_overflow_allocation(void)
>>                 return 1;
>>         }
>>
>> -       err |= test_kmalloc(NULL);
>> -       err |= test_kmalloc_node(NULL);
>> -       err |= test_kzalloc(NULL);
>> -       err |= test_kzalloc_node(NULL);
>> -       err |= test_kvmalloc(NULL);
>> -       err |= test_kvmalloc_node(NULL);
>> -       err |= test_kvzalloc(NULL);
>> -       err |= test_kvzalloc_node(NULL);
>> -       err |= test_vmalloc(NULL);
>> -       err |= test_vmalloc_node(NULL);
>> -       err |= test_vzalloc(NULL);
>> -       err |= test_vzalloc_node(NULL);
>> -       err |= test_devm_kmalloc(dev);
>> -       err |= test_devm_kzalloc(dev);
>> +       err |= check_allocation_overflow(kmalloc);
>> +       err |= check_allocation_overflow(kmalloc_node);
>> +       err |= check_allocation_overflow(kzalloc);
>> +       err |= check_allocation_overflow(kzalloc_node);
>> +       err |= check_allocation_overflow(__vmalloc);
>> +       err |= check_allocation_overflow(kvmalloc);
>> +       err |= check_allocation_overflow(kvmalloc_node);
>> +       err |= check_allocation_overflow(kvzalloc);
>> +       err |= check_allocation_overflow(kvzalloc_node);
>> +       err |= check_allocation_overflow(devm_kmalloc);
>> +       err |= check_allocation_overflow(devm_kzalloc);
>>
>>         device_unregister(dev);

I'd prefer if such a local helper macro was defined immediately prior to
the sequence of uses, and then #undef'ed at the end.

Other than that:

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
