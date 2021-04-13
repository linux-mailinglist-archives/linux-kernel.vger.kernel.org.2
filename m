Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3B35E540
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbhDMRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231512AbhDMRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618335788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=beOkS0kcTwMmsNGMKh0unRk5anjh46vtYQDhAjaR480=;
        b=I77DpvM+2MycF2GPyos+9VTPHxt7pMwSxqFQw9RWLlaSCHFUKAlSEldDqn066v4T82InDN
        diDo0xRJpkIAvlCUAS0HdtEvfceqQc6QAQLHxmWBLjyUxNem44XSt93+up7nVrM+24HgVy
        PgCesWpGT5UMSTc7zDnxDz7KtbUvV/s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-AsNl8BElMAmG3YAhjDUYvg-1; Tue, 13 Apr 2021 13:43:06 -0400
X-MC-Unique: AsNl8BElMAmG3YAhjDUYvg-1
Received: by mail-ej1-f69.google.com with SMTP id cd13so2426954ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=beOkS0kcTwMmsNGMKh0unRk5anjh46vtYQDhAjaR480=;
        b=gIsNjjYHxB2527Ev2iebj7aWK0Mj3sci3IeFwhIgCPHd1VxE2a+eZ4fFufT9Wme9Lt
         g4YCnZ1rEAZDG4i2EeFSdiqKPKfnu49OCPoW8QY6ck5nRARfmM+Q+jEr6IQySTlMKp1d
         DJ5oYTr4ObouUK7E04W3ABCS1LftcPBSw4dfgdFFHXr8ghUatjVqeEDlHqU/Ggg+K/1k
         2hkSEJLyMwTh256N9mieYC5JVgTYvzEIXrpzt62xqzMJhG24dt8nicjEe56lOdV+7yOV
         5kvzUn2fDRufAhj6Nvbe8hW2bQbbgZjQZR5LGbV290xhp9ZQdeuFZPwD5n8oKQl0CUFs
         4OGA==
X-Gm-Message-State: AOAM530YXvtGIhctNrO5pGcwtQG9+SMuS/dONcnU0zrX/mkhEzpPWCeL
        ZlXWy3ShcNIOu+jUVTulor5Y0lEXePwiovl7aX9G7IjchaKV5PgPZXX0463sIWwCpvmXCbbV0sx
        J/0dSrxVhJXAUA7EOC1YphW1Z
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr19768983ejc.443.1618335785199;
        Tue, 13 Apr 2021 10:43:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpgzFux6nkdNqUfv6qkAT92npTNxVvR1HWogGtm6C9PrwyY9ABfw/Itc31fSMl8+qAFyaJJQ==
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr19768968ejc.443.1618335784976;
        Tue, 13 Apr 2021 10:43:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c62e9.dip0.t-ipconnect.de. [91.12.98.233])
        by smtp.gmail.com with ESMTPSA id s5sm5243051ejq.52.2021.04.13.10.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 10:43:04 -0700 (PDT)
Subject: Re: [PATCH] ACPI: x86: Call acpi_boot_table_init() after
 acpi_table_upgrade()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <11752259.O9o76ZdvQC@kreacher>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <dea11d82-4fe5-ac23-585c-a1f74e076ca7@redhat.com>
Date:   Tue, 13 Apr 2021 19:43:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <11752259.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.21 16:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by
> ACPI tables") attempted to address an issue with reserving the memory
> occupied by ACPI tables, but it broke the initrd-based table override
> mechanism relied on by multiple users.
> 
> To restore the initrd-based ACPI table override functionality, move
> the acpi_boot_table_init() invocation in setup_arch() on x86 after
> the acpi_table_upgrade() one.
> 
> Fixes: 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> George, can you please check if this reintroduces the issue addressed by
> the above commit for you?
> 
> ---
>   arch/x86/kernel/setup.c |    5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/arch/x86/kernel/setup.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/setup.c
> +++ linux-pm/arch/x86/kernel/setup.c
> @@ -1045,9 +1045,6 @@ void __init setup_arch(char **cmdline_p)
>   
>   	cleanup_highmap();
>   
> -	/* Look for ACPI tables and reserve memory occupied by them. */
> -	acpi_boot_table_init();
> -
>   	memblock_set_current_limit(ISA_END_ADDRESS);
>   	e820__memblock_setup();
>   
> @@ -1132,6 +1129,8 @@ void __init setup_arch(char **cmdline_p)
>   	reserve_initrd();
>   
>   	acpi_table_upgrade();
> +	/* Look for ACPI tables and reserve memory occupied by them. */
> +	acpi_boot_table_init();
>   
>   	vsmp_init();

This is fairly late; especially, it's after actual allocations -- see 
e820__memblock_alloc_reserved_mpc_new().

Can't the table upgrade mechanism fix up when adjusting something? Some 
details on what actually breaks would be helpful.

-- 
Thanks,

David / dhildenb

