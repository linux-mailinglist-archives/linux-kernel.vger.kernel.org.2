Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B3C4208BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhJDJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbhJDJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633340967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EeuBT38IBksFVSzljiek+n7kBS7W4m7e8iDQ7I8r+Fk=;
        b=fJfhbWw/hYjraKy6cmPpAYK0tEUhJ/L7JfZsPely2YlCQ3hldK1/NkbOtU5NPe6taOCbAt
        pr47AOt1txU6Moo+oWKi852E1o48aS68r5gTdK91ZN3QuhFr6IyzXOFFMeGEhMMo6HP1y0
        R76/CKWc8dmO95DV/8H4cHiWKaDYA9s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-qMOEA5nJMMWx7e_cz05qcQ-1; Mon, 04 Oct 2021 05:49:26 -0400
X-MC-Unique: qMOEA5nJMMWx7e_cz05qcQ-1
Received: by mail-ed1-f71.google.com with SMTP id k10-20020a508aca000000b003dad77857f7so724043edk.22
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 02:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EeuBT38IBksFVSzljiek+n7kBS7W4m7e8iDQ7I8r+Fk=;
        b=OYXtcDkj0JgoDSSficEYvMnbgHj3kiQeZTo2UxTevfMtiRAEl65jWXPxUaYi2xk1nI
         LUnpSsE82iNGTPy+v8o8ZS1BKRR7p4t1bKvCf5ZiKiV3EpC/LBFqXmIAhGjogjDnGdv5
         QcRZzKrNeJhAt52oNM1pRUo3SG4fah6mc4wLG2vpHxlqswfLc9jc7JoqTcg4NLSKPRTE
         lM/+KFodr9t0kt0dllP2y6B9YDLJ/SMuFuEAc4ZISsj9rtLMiPV6mEByHN2jO4+MURXn
         GZDX+QuN7fIumd5RT7HK1Jhmt478/UnzAgqSIaFNXDXXfNc+GvjtqefV9SVzJwMD+fRp
         GegA==
X-Gm-Message-State: AOAM530MblWCtIhfUTao5Ll1TtJ2RNWrN0MlJU0k7svscr4hH+cmdD5a
        zTwNAq4V1yjOEdOP9keRABt0fZ7iGnV6XKWGHaScGVGwkFP6suryWp1kbEKVHGWPhxcA1saCri6
        QzOc0IbBHdD3OF4nwyBNJdRqs
X-Received: by 2002:aa7:c988:: with SMTP id c8mr9032041edt.94.1633340962882;
        Mon, 04 Oct 2021 02:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq2Fiq+9N1f2ghwd9NRBIT8c/6Ka2pFtouf328fiO9vvxzvKrkxSCkkOQd2eKpTr+oE/1GGA==
X-Received: by 2002:aa7:c988:: with SMTP id c8mr9031803edt.94.1633340959617;
        Mon, 04 Oct 2021 02:49:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id p8sm6233000ejo.2.2021.10.04.02.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 02:49:19 -0700 (PDT)
Message-ID: <c4773ecc-053f-9bc6-03af-5039397a4531@redhat.com>
Date:   Mon, 4 Oct 2021 11:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [BUG] [5.15] Compilation error in arch/x86/kvm/mmu/spte.h with
 clang-14
Content-Language: en-US
To:     torvic9@mailbox.org, "seanjc@google.com" <seanjc@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>
References: <1446878298.170497.1633338512925@office.mailbox.org>
 <b6abc5a3-39ea-b463-9df5-f50bdcb16d08@redhat.com>
 <936688112.157288.1633339838738@office.mailbox.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <936688112.157288.1633339838738@office.mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/21 11:30, torvic9@mailbox.org wrote:
> 
>> Paolo Bonzini <pbonzini@redhat.com> hat am 04.10.2021 11:26 geschrieben:
>>
>>   
>> On 04/10/21 11:08, torvic9@mailbox.org wrote:
>>> I encounter the following issue when compiling 5.15-rc4 with clang-14:
>>>
>>> In file included from arch/x86/kvm/mmu/mmu.c:27:
>>> arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>>>           return __is_bad_mt_xwr(rsvd_check, spte) |
>>>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>                                                    ||
>>> arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning
>>
>> The warning is wrong, as mentioned in the line right above:
> 
> So it's an issue with clang-14 then?
> (I add Nick and Nathan)

My clang here doesn't have the option, so I'm going to ask---are you 
using W=1?  I can see why clang is warning for KVM's code, but in my 
opinion such a check should only be in -Wextra.

Paolo

>>
>>           /*
>>            * Use a bitwise-OR instead of a logical-OR to aggregate the reserved
>>            * bits and EPT's invalid memtype/XWR checks to avoid an extra Jcc
>>            * (this is extremely unlikely to be short-circuited as true).
>>            */
>>
>> Paolo
> 

