Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21E43A4AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 00:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFKWr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 18:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFKWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 18:47:23 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 15:45:22 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 5so32824897ioe.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 15:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xXgtc2a812WbOwUgteqiwpKHqvHn2zU6NCj+s0gCiUg=;
        b=c0SIGJ88ohLjl2HfT/CDCCzhoHvhw3vQcijzfAgxaGj3ziLqY98ylpNEdwyi4ZYiIy
         AN0qrHAWRuW/XwqBAmfWqM0qvIxmluzT2W36dx5Mc6WfXpe73C7CvoHRAhx2UDdMCTc1
         OW5UVN805paBVZcr5p3G5s+etr34liykK6wbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xXgtc2a812WbOwUgteqiwpKHqvHn2zU6NCj+s0gCiUg=;
        b=ZKA4HP33OwuilOjjiDvkHKaCd6HG0KpdYV5EE1pP3PWGOnoS0yr1MnrfQMyVtPdqwR
         TUAtC9TtrNagem1irLm2MhYMaV7HkTBie+CkarBWpzvgYnMlnRXmRW9bFE0pKh5Ttz38
         oFlOnc8yRoDKTvoVVb83q/5WP7hHxNpbm7s5Sx93lMfhHM1GLZMXr1Hcxf5z4WMZK80H
         1utOSqemBZa8pq4Oxkv+Ng//sYxZK83Vht7LO+/KjqxzTZZZedOLbrBLVxVi59vQFSff
         y3TWSV4uRI77Y6Vq5q98ifvPIK+SpxaeYFvuPFNIEqzqbZr8y1wlrw31WvgABdVsGUC/
         DP2Q==
X-Gm-Message-State: AOAM532WQTiGTmPnwWIrdXeRjSppQKn7FBIDdSKfSBm4ufsk3z8KIuor
        jz8Nbl9Ktrw2kkUNEqeUXEmMkw==
X-Google-Smtp-Source: ABdhPJxJJIF6snEw4w1Ne6eoIiotz2QkFrb9tZBQiqNlnwUb9VM1XLwMIR49Ra7s9SAVqwiRp7eYyw==
X-Received: by 2002:a05:6602:1234:: with SMTP id z20mr5007745iot.167.1623451521393;
        Fri, 11 Jun 2021 15:45:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q23sm4416936ior.46.2021.06.11.15.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 15:45:20 -0700 (PDT)
Subject: Re: [PATCH v8 3/5] selftests/sgx: Dump enclave memory map
To:     Jarkko Sakkinen <jarkko@kernel.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <20210610083021.392269-3-jarkko@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bb39b6af-5921-64e8-793b-5ef4b150153e@linuxfoundation.org>
Date:   Fri, 11 Jun 2021 16:45:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610083021.392269-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/21 2:30 AM, Jarkko Sakkinen wrote:
> Often, it's useful to check whether /proc/self/maps looks sane when
> dealing with memory mapped objects, especially when they are JIT'ish
> dynamically constructed objects. Therefore, dump "/dev/sgx_enclave"
> matching lines from the memory map in FIXTURE_SETUP().
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   tools/testing/selftests/sgx/main.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 6da19b6bf287..14030f8b85ff 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -117,6 +117,8 @@ FIXTURE_SETUP(enclave)
>   	Elf64_Sym *sgx_enter_enclave_sym = NULL;
>   	struct vdso_symtab symtab;
>   	struct encl_segment *seg;
> +	char maps_line[256];
> +	FILE *maps_file;
>   	unsigned int i;
>   	void *addr;
>   
> @@ -167,6 +169,18 @@ FIXTURE_SETUP(enclave)
>   	memset(&self->run, 0, sizeof(self->run));
>   	self->run.tcs = self->encl.encl_base;
>   
> +	maps_file = fopen("/proc/self/maps", "r");

I almost applied these. Does this require root access, if so,
please add logic to skip the test if non-root user runs it.

Same comments for all other paths that might require root access.

thanks,
-- Shuah
