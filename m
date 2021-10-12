Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD9429C21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhJLD5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhJLD5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634010948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YoYvM8PhozW8gxgDOhvrZOZiheEs01KQvgUeRR1+zVY=;
        b=AxeksgkygXviDJ5x8gU6WVEJ5QKY8AhEDrB0kzPOM471ZYqy16+DxIf1c+y+ePo5dhSIoB
        VSTociMsCWDh/S8nmoLvzxS+p73PwNoVUm8LXmBunfeRGp/TTpcF9Kk83mNoaM68ZQJsnX
        Xl02HebaCqzAOEGnm8khEdl2+aXXvr8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-itmQWhF4Mk6ioYUz3NpUQQ-1; Mon, 11 Oct 2021 23:55:47 -0400
X-MC-Unique: itmQWhF4Mk6ioYUz3NpUQQ-1
Received: by mail-pl1-f198.google.com with SMTP id v7-20020a1709029a0700b0013daaeaa33eso8357044plp.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YoYvM8PhozW8gxgDOhvrZOZiheEs01KQvgUeRR1+zVY=;
        b=HS7koKAfIzXO4LZtDlMydZxiPFHruglaCCk0RgN5/1xubiS1DwFnDxIHs+6HU56fNn
         84D6CbxLbH7Z1Tg+TsFcM45jsGp9Ijjk2CElNXt+xKTBNwrVrH97tK4ejnVvZTO8V9SZ
         itoexnC0aS5J6WmON5C/gUptdy/eK1rGmkPQFH8v5XxzdiusKagVBUQMxjkGfggOGdqS
         UVe7NJ3ia7IBDJhCpamdy6SL8xG/BrGLJeo2JIeW3l+QLSzixxdnfQ4k+yEYZu1XLn/2
         KsmmKTBkP09fXzbah80SI2FF9pNeiHBfBoJewPKAlUUkcK36vDlNol67zTAEDT8B8SQe
         fRPA==
X-Gm-Message-State: AOAM5332sZUd1HSuqO6bAziU5x98jCv6yOVTLfwbzPlU1zrYTfe6DFa6
        aKj9TseMw6KiuX44XG/8FosSVH8qWpERO7ftBVKial5o4nVBrIRM8EOXX7lwkhaqs+EbyIumrI+
        QF9YC2qhl7/nzrqnuMqE6+gxJ
X-Received: by 2002:a63:101c:: with SMTP id f28mr20960303pgl.330.1634010946218;
        Mon, 11 Oct 2021 20:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWkaGJHCKhE9XQzjdlS2sQ9kBrFdP3eRl2h1hNmNX7/NMTQ8ccyR9IksEGh14NuiEOKeAbDQ==
X-Received: by 2002:a63:101c:: with SMTP id f28mr20960284pgl.330.1634010945865;
        Mon, 11 Oct 2021 20:55:45 -0700 (PDT)
Received: from localhost ([240e:473:3d20:1751:1e64:fb29:9d2c:2d0f])
        by smtp.gmail.com with ESMTPSA id d18sm9924269pgk.24.2021.10.11.20.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 20:55:45 -0700 (PDT)
Date:   Tue, 12 Oct 2021 11:53:24 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
Message-ID: <20211012035324.ctwuaaaig5yin7ve@localhost.localdomain>
References: <20211009095458.297191-1-coxu@redhat.com>
 <20211009095458.297191-2-coxu@redhat.com>
 <87ily3br3n.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ily3br3n.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 08:58:36AM -0500, Eric W. Biederman wrote:
>Coiby Xu <coxu@redhat.com> writes:
>
>> The code in bzImage64_verify_sig could make use of system keyrings including
>> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
>> signed kernel image as PE file. Make it generic so both x86_64 and arm64 can
>> use it.
>
>The naming is problematic.
>
>At a minimum please name the new function kexec_kernel_verify_pe_sig.
>AKA what you named it without the "arch_" prefix.  A function named with
>an "arch_" prefix  implies that it has an architecture specific
>implementation.

Thanks for bringing up this issue and providing the fix and the explanation.

>
>It looks like arch_kexec_kernel_verify_sig should be killed as well
>as it only has one implementation in the generic code.  And the code
>should always call kexec_image_verify_sig_default.  Not that you should
>do that but I am pointing it out as it seems that is the bad example you
>are copying.

Yes, you are right about it. This is a leftover issue of commit 
9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,powerpc: factor 
out kexec_file_ops functions"),
     
     As arch_kexec_kernel_image_{probe,load}(),
     arch_kimage_file_post_load_cleanup() and arch_kexec_kernel_verify_sig()
     are almost duplicated among architectures, they can be commonalized with
     an architecture-defined kexec_file_ops array.  So let's factor them out.

That commit moves the architecture specific implementation of 
arch_kexec_kernel_verify_sig to kexec_file_ops->verify_sig. So actually 
arch_kexec_kernel_verify_sig should be removed. Then we rename
kexec_image_verify_sig_default to kimage_validate_signature and call 
it in kimage_validate_signature directly. I'll include a new patch to do 
the clean-up work in v3.

>
>Eric
>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>>  include/linux/kexec.h             |  3 +++
>>  kernel/kexec_file.c               | 17 +++++++++++++++++
>>  3 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index 170d0fd68b1f..4136dd3be5a9 100644
>> --- a/arch/x86/kernel/kexec-bzimage64.c
>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>> @@ -17,7 +17,6 @@
>>  #include <linux/kernel.h>
>>  #include <linux/mm.h>
>>  #include <linux/efi.h>
>> -#include <linux/verification.h>
>>
>>  #include <asm/bootparam.h>
>>  #include <asm/setup.h>
>> @@ -531,17 +530,7 @@ static int bzImage64_cleanup(void *loader_data)
>>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>>  {
>> -	int ret;
>> -
>> -	ret = verify_pefile_signature(kernel, kernel_len,
>> -				      VERIFY_USE_SECONDARY_KEYRING,
>> -				      VERIFYING_KEXEC_PE_SIGNATURE);
>> -	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
>> -		ret = verify_pefile_signature(kernel, kernel_len,
>> -					      VERIFY_USE_PLATFORM_KEYRING,
>> -					      VERIFYING_KEXEC_PE_SIGNATURE);
>> -	}
>> -	return ret;
>> +	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
>>  }
>>  #endif
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0c994ae37729..d45f32336dbe 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -19,6 +19,7 @@
>>  #include <asm/io.h>
>>
>>  #include <uapi/linux/kexec.h>
>> +#include <linux/verification.h>
>>
>>  #ifdef CONFIG_KEXEC_CORE
>>  #include <linux/list.h>
>> @@ -199,6 +200,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
>>  #ifdef CONFIG_KEXEC_SIG
>>  int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>>  				 unsigned long buf_len);
>> +int arch_kexec_kernel_verify_pe_sig(const char *kernel,
>> +				    unsigned long kernel_len);
>>  #endif
>>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 33400ff051a8..0530275b7aa3 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -106,6 +106,23 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>>  {
>>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>>  }
>> +
>> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>> +int arch_kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
>> +{
>> +	int ret;
>> +
>> +	ret = verify_pefile_signature(kernel, kernel_len,
>> +				      VERIFY_USE_SECONDARY_KEYRING,
>> +				      VERIFYING_KEXEC_PE_SIGNATURE);
>> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
>> +		ret = verify_pefile_signature(kernel, kernel_len,
>> +					      VERIFY_USE_PLATFORM_KEYRING,
>> +					      VERIFYING_KEXEC_PE_SIGNATURE);
>> +	}
>> +	return ret;
>> +}
>> +#endif
>>  #endif
>>
>>  /*
>

-- 
Best regards,
Coiby

