Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B13B4261A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 03:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJHBRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhJHBRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 21:17:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F3C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 18:15:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s16so6851719pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q5qcFsX/507ZfWeOd0zCJMBIYkqAMWpOwqpuf9YHF8Y=;
        b=B7FNos2STpdpmBn/v4n1nigAXB8wqwlQcCF8LEMm+UrVSqdVA/sPfUgaZE0pU4PwVM
         4bK3W3XaNLNlrycVAFCCoE/8Vo2Pz2Rt8Sxgjp+F4dxSakPWvg91/tdbTKcA77R5AQPt
         eShoQLZKtTzOPYSfqp6AYwUEsQ178iHNBdRh88iINwgqFN/KdVgNlhj/a/tpavfyyCDJ
         Emypv6iXFkGF/xx34Dink1DWo/Nay+TSM/E4qhBSk6hUs38wKjB1tdohc9s7GCWEGY1+
         J/A5maxWolIqiKIE8BTfAaJ4jYqpgLir08LsSM1nMLTX6gXbA6zDBOS6YokSTxseh0NN
         oJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q5qcFsX/507ZfWeOd0zCJMBIYkqAMWpOwqpuf9YHF8Y=;
        b=UEtjAmzmj7LcCI3FaunvaJUDxtCVyoXwmirLnV4mSMQ16I3SgjeCVpm1qxpTp+ga3X
         qDbJYsVwsmwDsWx4OV1LcbUClk3km3CYIRGeTP2syTvJd7U+SKSGxe+uI/H81qhWz69j
         9lpezDPypVrgvto/GhQ+O6N+2L42YwYcpClzZ92LZD4SQ7Y5mDdLoOoeQ3BMvRpl1zre
         44lo2Ne4eLb11uYjHxk1XU7vPPxs3/RQYQQmYbaXJvjetRjaAso+W0D/UNglZQVwYq4c
         X+cE8IgSLgcUlR1vSTM95Hco10kxmshMmjCayb9O3rjjLbwzMSWRsts7MQRdmvfE3jVC
         yybA==
X-Gm-Message-State: AOAM532Xelm6I4fcMpr0jptzlbHK9KSUvXghTTC9BfRuW+EOZQoY/aQW
        6ZYcQlshB9oTK7qlyBKesyU=
X-Google-Smtp-Source: ABdhPJyhLnzHX4HmOi193muw8/podPYTgbGYvY0nSztGhKGzCBkJivo83KSITCWdNvbmIVlfc/6KRQ==
X-Received: by 2002:a63:df05:: with SMTP id u5mr2266398pgg.323.1633655745932;
        Thu, 07 Oct 2021 18:15:45 -0700 (PDT)
Received: from localhost ([240e:473:4f20:9f4:f021:c1d4:a827:22ec])
        by smtp.gmail.com with ESMTPSA id e10sm509750pgr.85.2021.10.07.18.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 18:15:45 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Fri, 8 Oct 2021 09:11:52 +0800
To:     Dave Young <dyoung@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Coiby Xu <coxu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kexec, KEYS: make the code in bzImage64_verify_sig
 public
Message-ID: <20211008011152.6rcdmn2aiojjfagu@localhost.localdomain>
References: <20210927005004.36367-1-coiby.xu@gmail.com>
 <20210927005004.36367-2-coiby.xu@gmail.com>
 <YVWyPu3pDvnEfATe@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YVWyPu3pDvnEfATe@dhcp-128-65.nay.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Thu, Sep 30, 2021 at 08:49:02PM +0800, Dave Young wrote:
>Hi Coiby,
>On 09/27/21 at 08:50am, Coiby Xu wrote:
>> From: Coiby Xu <coxu@redhat.com>
>>
>> The code in bzImage64_verify_sig could make use of system keyrings including
>> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
>> signed kernel image as PE file. Move it to a public function.
>>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>>  include/linux/kexec.h             |  3 +++
>>  kernel/kexec_file.c               | 15 +++++++++++++++
>>  3 files changed, 19 insertions(+), 12 deletions(-)
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
>> index 33400ff051a8..85ed6984ad8f 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -106,6 +106,21 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>>  {
>>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>>  }
>> +
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
>
>Since the function is moved as generic code, the kconfig option
>CONFIG_KEXEC_BZIMAGE_VERIFY_SIG can be removed.

>
>Instead a CONFIG_KEXEC_PEFILE_VERIFY_SIG can be added so that it does
>not need to be compiled for only platform which support UEFI pefile
>signature verification.  And the related arch kexec_file kconfig can
>just select it.


Thanks for the suggestion! I notice KEXEC_BZIMAGE_VERIFY_SIG depends 
on SIGNED_PE_FILE_VERIFICATION and selects SYSTEM_TRUSTED_KEYRING. So 
maybe SIGNED_PE_FILE_VERIFICATION could do the job of 
CONFIG_KEXEC_PEFILE_VERIFY_SIG. And arch/arm64/Kconfig also have 
KEXEC_IMAGE_VERIFY_SIG. So maybe it's better we don't keep
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG.

>
>Coiby, can you try above?
>
>>  #endif
>>
>>  /*
>> --
>> 2.33.0
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>>
>
>Thanks
>Dave
>

-- 
Best regards,
Coiby
