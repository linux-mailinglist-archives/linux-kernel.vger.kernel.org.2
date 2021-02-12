Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE731A6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhBLVVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhBLVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:21:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44738C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OdLNQjlOR2vB9Y6nhT8J21qxlU8H8NZPbgdS4aFu35g=; b=o14i6sDqr3cpiq0ins84UsakUh
        hoOm2qqXfBs1x1HIu46Gr3SBjUsF3zbHwr/a+DcV+k7HCLbxRl48+S4I0xWO0HEV7cZHfRNXSa7zC
        l5m1v1SYsTTGcPmAv1n6aGO74e8eLeP02QVQUiG9lR46kEbAPBl2LtVrMvGMk58I8Fc2HDG2f0ZsW
        KJbT6SJA4aaYr0LIXf8lYsQrFPiJMSWNN31E4QOIdO17bXEkbVcK2PtbHoq0t8IbZgHSLrG4SARzq
        W8+rbaMXPg+FpiI6MroQ1Zs9xy9sgVcz+QFnje+sfJ+KBFkVvdb/luHeZnuSjWAlSMkXTWSzJoV1u
        2BhosBPw==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAfru-0003ZW-Je; Fri, 12 Feb 2021 21:20:50 +0000
Subject: Re: [PATCH] x86: vdso: fix printf() format warnings in vdso2c.h
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
References: <20210209012305.31062-1-rdunlap@infradead.org>
 <YCZe0hCn3zpdziir@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4a0685aa-c7d7-7064-9f01-0b96cf32dee7@infradead.org>
Date:   Fri, 12 Feb 2021 13:20:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCZe0hCn3zpdziir@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:56 AM, Jarkko Sakkinen wrote:
> On Mon, Feb 08, 2021 at 05:23:05PM -0800, Randy Dunlap wrote:
>> Use %zu instead of %lu for size_t to prevent w printf()
>> format warnings in vdso2c.h
>>
>>   HOSTCC  arch/x86/entry/vdso/vdso2c
>> In file included from ../arch/x86/entry/vdso/vdso2c.c:162:
>> ../arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
>> ../arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>>    38 |  fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>>       |                                                  ~~^              ~~~
>> In file included from ../arch/x86/entry/vdso/vdso2c.c:166:
>> ../arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
>> ../arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>>    38 |  fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>>       |                                                  ~~^              ~~~
>>
>> Fixes: 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO functions")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: x86@kernel.org
> 
> Just a *question*: should SOB be the last? Seeing this 2nd time today, and
> just not used to it. That's why asking.

I'll have to let someone else answer that. AFAICT, it's not documented.

I have read (in email) that when adding Acked-by, Tested-by, Reviewed-by, etc.,
that those should be added at the end of the list in chronological
order, but that doesn't tell us where to put the Cc: list.


> Anyway, thank you.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks. Added at the end of the list. :)


>> ---
>>  arch/x86/entry/vdso/vdso2c.h |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-511-rc7.orig/arch/x86/entry/vdso/vdso2c.h
>> +++ lnx-511-rc7/arch/x86/entry/vdso/vdso2c.h
>> @@ -35,7 +35,7 @@ static void BITSFUNC(extract)(const unsi
>>  	if (offset + len > data_len)
>>  		fail("section to extract overruns input data");
>>  
>> -	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>> +	fprintf(outfile, "static const unsigned char %s[%zu] = {", name, len);
>>  	BITSFUNC(copy)(outfile, data + offset, len);
>>  	fprintf(outfile, "\n};\n\n");
>>  }
>>
> 
> /Jarkko
> 


-- 
~Randy

