Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D913328AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhCIOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhCIObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615300311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wxc0JOBl2RBF1+7aJjyA1enwlsd5Pg9Cy0o76P8Xt28=;
        b=Vrjzc1dx4cN3RPT7ZabtyqvEXxtE45rtmKptSqabLFPfCNGtBt/9VzTDBC6KBo0ifFx8zr
        7y1xrfzsUYgc1vcDlUKZDK1Vpl1tPHByb72MB+uzI1bIl31VSw4bOhWVjReNH49KMVfu3P
        LH4RdmTxdE3lFuhRFSVncGHPG4kzYsY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-NRRVmDuSMWK8CYXCWYRd-Q-1; Tue, 09 Mar 2021 09:31:50 -0500
X-MC-Unique: NRRVmDuSMWK8CYXCWYRd-Q-1
Received: by mail-wr1-f71.google.com with SMTP id h5so6497057wrr.17
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wxc0JOBl2RBF1+7aJjyA1enwlsd5Pg9Cy0o76P8Xt28=;
        b=b6hdPIdp7wuEdyBcUZ380LdDHsXTP1vXTRYdNvhZZ2icfqPyMVpeeImdRFLnbwogTE
         Hp70e6AX+NcwtjRm61N3STAM9y+jtnMQh7akO4iAscxXSvJhLXS9yf1E9oL1synlPSfg
         OXmlcJEQCrFbPyNdEvTJHZJou1+AJZ+3sFVcvzrPQ8JaH1Gc+2YCu7Q4zsJFEdZatzPF
         7oakCX3J17Bb1Wa+nRnEWkNTBDoeabr5+qSTvVeH76VE8kbeqW+feoMEGWDLxuEDm9gh
         LRxuSltCFxOkj7FSS6QjwqkiYNpIrGoDYculgKu7YfAIOJeT+xke8PDE3WhvzD1Y8xGd
         NsHw==
X-Gm-Message-State: AOAM5329Ysdn1bYPG9R6iSgeLKFz5O0bbVZbOisjcZusNMmMBS8QZ2Dx
        Y6/XR/5Ch3mMhStSn6/maHKcfTmPXmeF6w1Vtk9xhvgb51CcgWDvHpKzmz8KANMHX59i5BjtkUe
        NC3Ei5BPVxRRwum9Bsco/2Tgc
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr4397627wmj.76.1615300306945;
        Tue, 09 Mar 2021 06:31:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwe6fPL8KgT0CCyUnW0sv7xFVyTbQ3cibYBJO95FfEYEQ6xRA737m7yzQnrL5w+cIr7adiPgw==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr4397600wmj.76.1615300306757;
        Tue, 09 Mar 2021 06:31:46 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id h20sm4222703wmp.38.2021.03.09.06.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:31:45 -0800 (PST)
Subject: Re: [RFC PATCH v2 13/13] objtool: arm64: Enable stack validation for
 arm64
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ycote@redhat.com,
        Raphael Gault <raphael.gault@arm.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
 <20210303170932.1838634-14-jthierry@redhat.com>
 <CAMj1kXEt36b6oPAz8wtpig+WBNCGaWhWcKQiAAfOBC2a5O0iVA@mail.gmail.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <4f9979a3-7902-e642-3abc-c18c72c3e9af@redhat.com>
Date:   Tue, 9 Mar 2021 15:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEt36b6oPAz8wtpig+WBNCGaWhWcKQiAAfOBC2a5O0iVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/21 11:25 AM, Ard Biesheuvel wrote:
> On Wed, 3 Mar 2021 at 18:10, Julien Thierry <jthierry@redhat.com> wrote:
>>
>> From: Raphael Gault <raphael.gault@arm.com>
>>
>> Add build option to run stack validation at compile time.
>>
>> When requiring stack validation, jump tables are disabled as it
>> simplifies objtool analysis (without having to introduce unreliable
>> artifacs). In local testing, this does not appear to significaly
>> affect final binary size nor system performance.
>>
>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   arch/arm64/Kconfig  | 1 +
>>   arch/arm64/Makefile | 4 ++++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 1f212b47a48a..928323c03318 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -187,6 +187,7 @@ config ARM64
>>          select MMU_GATHER_RCU_TABLE_FREE
>>          select HAVE_RSEQ
>>          select HAVE_STACKPROTECTOR
>> +       select HAVE_STACK_VALIDATION
>>          select HAVE_SYSCALL_TRACEPOINTS
>>          select HAVE_KPROBES
>>          select HAVE_KRETPROBES
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 5b84aec31ed3..b819fb2e8eda 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -136,6 +136,10 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
>>     CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>>   endif
>>
>> +ifeq ($(CONFIG_STACK_VALIDATION),y)
>> +KBUILD_CFLAGS  += -fno-jump-tables
>> +endif
>> +
> 
> This is a bit misleading: the Kconfig option in question is selected
> automatically in all cases, so jump tables are always disabled.
> 

So, at the moment, the arch Kconfig only advertises that arm64 has stack 
validation with objtool, but currently stack validation itself is not 
enabled by default.

> However, I think disabling jump tables make sense anyway, at least
> when building the relocatable kernel for KASLR: we currently don't use
> -fpic/fpie in that case when building the vmlinux objects (because we
> don't want/need GOT tables), and so jump tables are emitted using
> absolute addresses, which induce some space overhead in the image. (24
> bytes of RELA data per absolute address)
> 
> ... unless I am missing something, and jump tables can/will be emitted
> as relative, even when not compiling in PIC mode?
> 

Personally I don't have enough context to assess whether it's the way to 
go. But if nobody opposes I'm fine having -fno-jump-tables in the 
default arm64 CFLAGS.

Thanks,

-- 
Julien Thierry

