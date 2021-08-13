Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048333EBC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhHMSyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhHMSyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:54:13 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65167C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:53:46 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id be20so17244681oib.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w/q5TpmhXtwE97hfUFtXadpNp8zPMY0oD8ZlmGnSHRg=;
        b=S9WsONofc4SyP+/yj8JqnZeQ6HcCuUkMSd1rc4T0/KNl7Z6pmTce/e39X3wjTWeRMS
         aDdFrpT+I5YzCSbfHkIdutSBtgxmP4A2fQ/U/wlxDu8Q0UoyICmgBrjwU6ghgNZ4nTuQ
         BWCQedhyV9HR0R4SB/lLsUhxAAtsluYWLn/Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w/q5TpmhXtwE97hfUFtXadpNp8zPMY0oD8ZlmGnSHRg=;
        b=CWtsQ/SCxK+plT9nykLPmZ/QuhKummbg9WJ3bi+qpcezuszLt5HJXT8fCK6mbPe60M
         XIhxXD5Y4c+RRVq5PAJUmVMUwEpSxHkVYMAe+9yPqMhNfQnEUIZrIGhST0EMVW31n1ik
         4oTC+O9/idJssCxfsfaEGOQX7QLPcbKJ9I4q9EoS2wIl2KYW+sdeodoPEK/MZPqbgtsm
         LAO782UMZAsd8kraSismv4UNQE9G+ZsDFTeZSLY9BbrgxrLS+JanivM06bUkWZnTqXfh
         zP5mCi7OZj+5+RZCXwhDyedPwEpbPX6u+qNlKdaiFVnC6cLnVo5AAqSWhx97BYppP+d3
         L3iA==
X-Gm-Message-State: AOAM531cLDMAvV/YV4S82fKu8TxePgaFaEAcwfG4/SNl7zHALZwxwgdi
        WHSRTwbViGT0swzVyRGXaYT+RQ==
X-Google-Smtp-Source: ABdhPJwnZcOOBZbpWswVfhbAAHEPrKTCAXZGjNpPeup8tKCA3LBcBy4NO9eLDTMORYk8niZKL0YwJg==
X-Received: by 2002:a54:468d:: with SMTP id k13mr3333895oic.125.1628880825829;
        Fri, 13 Aug 2021 11:53:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p64sm533827oib.4.2021.08.13.11.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 11:53:45 -0700 (PDT)
Subject: Re: [PATCH v4 1/8] x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
To:     Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210809093127.76264-1-jarkko@kernel.org>
 <20210809093127.76264-2-jarkko@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <df28390f-dbb3-79fa-258f-1c8477c10c04@linuxfoundation.org>
Date:   Fri, 13 Aug 2021 12:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210809093127.76264-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 3:31 AM, Jarkko Sakkinen wrote:
> Just like normal memory, SGX memory can be overcommitted.  SGX has its
> own reclaim mechanism which kicks in when physical SGX memory (Enclave
> Page Cache / EPC) is exhausted.  That reclaim mechanism is relatively
> rarely exercised and needs selftests to poke at it.
> 
> The amount of EPC on the system is determined by the BIOS and it varies
> wildly between systems.  It can be dozens of MB on desktops, or many GB
> on servers.
> 
> To run in a reasonable amount of time, the selftest needs to know how
> much EPC there is in the system.
> 
> Introduce a new debugfs file to export that information.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> 
> v3:
> * Describe the units of sgx_total_mem in Dcumentation/x86/sgx.rst.
> * Rewrite of the commit message (suggested by Dave):
>    https://lore.kernel.org/linux-sgx/5d3614af-2393-6744-9d85-7001241ca76e@intel.com/
> 
> v2:
> * sgx_nr_all_pages -> sgx_total_mem
> 
>   Documentation/x86/sgx.rst      |  6 ++++++
>   arch/x86/kernel/cpu/sgx/main.c | 10 +++++++++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
> index dd0ac96ff9ef..f11bfb331b93 100644
> --- a/Documentation/x86/sgx.rst
> +++ b/Documentation/x86/sgx.rst
> @@ -250,3 +250,9 @@ user wants to deploy SGX applications both on the host and in guests
>   on the same machine, the user should reserve enough EPC (by taking out
>   total virtual EPC size of all SGX VMs from the physical EPC size) for
>   host SGX applications so they can run with acceptable performance.
> +
> +Debugging
> +=========
> +
> +*/sys/kernel/debug/x86/sgx_total_mem* contains an integer describing
> +the total SGX reserved memory in bytes, available in the system.
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 63d3de02bbcc..b65da19a53ee 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*  Copyright(c) 2016-20 Intel Corporation. */
>   
> +#include <linux/debugfs.h>
>   #include <linux/file.h>
>   #include <linux/freezer.h>
>   #include <linux/highmem.h>
> @@ -28,7 +29,10 @@ static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
>   static LIST_HEAD(sgx_active_page_list);
>   static DEFINE_SPINLOCK(sgx_reclaimer_lock);
>   
> -/* The free page list lock protected variables prepend the lock. */
> +/* Total EPC memory available in bytes. */
> +static unsigned long sgx_total_mem;
> +
> +/* The number of free EPC pages in all nodes. */
>   static unsigned long sgx_nr_free_pages;
>   
>   /* Nodes with one or more EPC sections. */
> @@ -656,6 +660,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
>   		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>   	}
>   
> +	sgx_total_mem += nr_pages * PAGE_SIZE;
> +
>   	return true;
>   }
>   
> @@ -823,6 +829,8 @@ static int __init sgx_init(void)
>   	if (sgx_vepc_init() && ret)
>   		goto err_provision;
>   
> +	debugfs_create_ulong("sgx_total_mem", 0444, arch_debugfs_dir, &sgx_total_mem);

dbugfs init dependency would be met I assume by this time?

> +
>   	return 0;
>   
>   err_provision:
> 

