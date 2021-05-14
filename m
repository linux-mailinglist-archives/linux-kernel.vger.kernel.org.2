Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADFA38053D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhENI3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233437AbhENI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620980902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5w0DUc6v8+Ohu3/Un9/gp8Wn9KzAdxtOI/JJ1rmwYuM=;
        b=MHWi8GD/J3rduRLKttZBW3JY0KkuPatrQQYcDZFRbDItAePYepy44RJZIRbdHPgMd6x83A
        72RUsCFXXFPPtvclIm0Y+7+tLuuyNcSaWOOnRNKp6EMGbvoGiT7jaqBWnYuK7KA2JIHhVY
        RrXbJDN5izvfRIbTh6mMblSZpOWP5VI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-TWF5BPoNN3OXSHGn_2XIWw-1; Fri, 14 May 2021 04:28:20 -0400
X-MC-Unique: TWF5BPoNN3OXSHGn_2XIWw-1
Received: by mail-ed1-f70.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so15981987edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5w0DUc6v8+Ohu3/Un9/gp8Wn9KzAdxtOI/JJ1rmwYuM=;
        b=gUoJaSnyuaBZst2yFvCu15DcUwbQV+qfuog5+EDyqYcM5UVaIXh8BPvVZkpiLtO0I1
         bcOYNROMU9ceSnmAU513q4PQqrORJk5QWbjlhmCmnM5bEEsyweS4Mrt2DWb9BxaRO8sX
         OEBoboH1yyFAwdv7CoVE9T/DQT/0vQd/ZENORWrhrOlGdwn4nVnY3izr1LUR0Chbptmo
         RXOgpyqmp8QMT8zXhz3a4IYspYLvakk9d4DDb57wh9h2QKexAZ7wRCpyv963PZF303lq
         r18wF5viZeUPZVrlx3vGT6KFLw08fNECppjx/eVMHchONRBjIAuLwM5Qb+j18qMJrfAj
         Sing==
X-Gm-Message-State: AOAM530bw8UCodmx/AsC/f1twOBsZ+V9jSnI/kIlprYvcd+RemeqYEme
        MBYFpkcH3I9+x8b4rKCmjWOR7JeMmeLsOy79XWT62J3tlUuHK7Oq8OVl8WAaIVijWkwE9/usVyg
        jSBTe9/dXFEUpNmug1acDT0SC
X-Received: by 2002:aa7:c510:: with SMTP id o16mr54629553edq.310.1620980898808;
        Fri, 14 May 2021 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAa7CtEGRAWr1lF7BGwkWkyoH00MJ3yOs2g5NJWUfLIy+27BD8PFUUKz633oLeJlXdgmtb9Q==
X-Received: by 2002:aa7:c510:: with SMTP id o16mr54629525edq.310.1620980898588;
        Fri, 14 May 2021 01:28:18 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id s4sm4090012edq.96.2021.05.14.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:28:18 -0700 (PDT)
Subject: Re: [PATCH v19 2/8] riscv/Kconfig: make direct map manipulation
 options depend on MMU
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, kernel test robot <lkp@intel.com>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <adb9f79a-8b9a-0302-e83c-03ad17d3743b@redhat.com>
Date:   Fri, 14 May 2021 10:28:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.05.21 20:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> ARCH_HAS_SET_DIRECT_MAP and ARCH_HAS_SET_MEMORY configuration options have
> no meaning when CONFIG_MMU is disabled and there is no point to enable
> them for the nommu case.
> 
> Add an explicit dependency on MMU for these options.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   arch/riscv/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a8ad8eb76120..c426e7d20907 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -26,8 +26,8 @@ config RISCV
>   	select ARCH_HAS_KCOV
>   	select ARCH_HAS_MMIOWB
>   	select ARCH_HAS_PTE_SPECIAL
> -	select ARCH_HAS_SET_DIRECT_MAP
> -	select ARCH_HAS_SET_MEMORY
> +	select ARCH_HAS_SET_DIRECT_MAP if MMU
> +	select ARCH_HAS_SET_MEMORY if MMU
>   	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>   	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

