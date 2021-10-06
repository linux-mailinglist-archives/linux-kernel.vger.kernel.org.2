Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FFF423D79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhJFMLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238117AbhJFMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633522148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDEUDd9F1mbhCTF+9tuTd3gtq0vD73lOJfICp/hOhTQ=;
        b=M3WEkrrJivVbGlYA5OBt8pGKOemIzN3unuJwQhVZ6SZV+VHUztdxxtOJ0wW7jAV0ywCNbv
        9/jHii6WzSCE3PJBRs0MTeWMvYwhdsOg1NrZbcEv89V0KfnB9LneUsBtTPKnnWXDIaDCr1
        fYV3qwZWiVoSYGqIEiqx/ScsITbs1Es=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-qVLdz260MMGWIsCqzdGuFA-1; Wed, 06 Oct 2021 08:09:07 -0400
X-MC-Unique: qVLdz260MMGWIsCqzdGuFA-1
Received: by mail-wr1-f70.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so1871223wrh.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 05:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jDEUDd9F1mbhCTF+9tuTd3gtq0vD73lOJfICp/hOhTQ=;
        b=B9Zcxoj5HVnwZYZ5PJtmaSuVU4fYIbKxoGHmlMj2ry5ZukuseT7fV2+G9oUHGXeTFk
         fS20O8UNv0vLYlnArxTT8N8cyisQrEqPtVQW3qo/y9gGQa54nEm42RxHyzjP80d2XwoW
         2E5DCUbQoOY53JBxpo3dd3llpNFXBrNqS/gr4opbb5HiRftlk+ip+AaXrYYIj+8+MVqa
         cmgng9Rl2gIOppR28WM1Oq6pNgusenuRw6l3IDXou/Aic6BGBfbbCdtHiNEYZSHSw9QI
         /Yh15NuBC4xxWj8Xf5Nu/59EuSdhOTw+zYoYtpMhpZ6lEt7avVFrmyIWcAGUzwLUOmsy
         /IaA==
X-Gm-Message-State: AOAM5303W9SmBeUTKmC3qBG0inofNRwhTp74unzqY70bfEJrJiMn2l2J
        TCGZcJ8ezPqRXtRrCEAKg5cO1dpuw0DrmnT//PE+KfWTNlDDtjyGwpNh/n7q9zP/kBwDbGXBifg
        xW8bES0Fj1tnK2bxSP6flowPQ1XvNYYJ/oNRUpzkVSF3P2Rx0Zippr5NbA2XQuRIL4FDK+xfY
X-Received: by 2002:a1c:7910:: with SMTP id l16mr7955167wme.128.1633522146138;
        Wed, 06 Oct 2021 05:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4TYB1Jy2IgydUW9bzfNSEGzwXaUBnXnryugqaajvIbJbmW6pSZbAoUR1gTE+cTlIL/XV4wA==
X-Received: by 2002:a1c:7910:: with SMTP id l16mr7955111wme.128.1633522145736;
        Wed, 06 Oct 2021 05:09:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id r19sm4680282wmp.43.2021.10.06.05.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 05:09:05 -0700 (PDT)
Subject: Re: [PATCH] memory: remove unused CONFIG_MEM_BLOCK_SIZE
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211006120354.7468-1-lukas.bulwahn@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <476ea5f7-53be-1a4e-c461-ff2e4a359bd0@redhat.com>
Date:   Wed, 6 Oct 2021 14:09:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211006120354.7468-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.21 14:03, Lukas Bulwahn wrote:
> Commit 3947be1969a9 ("[PATCH] memory hotplug: sysfs and add/remove
> functions") defines CONFIG_MEM_BLOCK_SIZE, but this has never been
> utilized anywhere.
> 
> It is a good practice to keep the CONFIG_* defines exclusively for the
> Kbuild system. So, drop this unused definition.
> 
> This issue was noticed due to running ./scripts/checkkconfigsymbols.py.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   include/linux/memory.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index c46ff374d48d..a216829df280 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -143,7 +143,6 @@ typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
>   extern int walk_memory_blocks(unsigned long start, unsigned long size,
>   			      void *arg, walk_memory_blocks_func_t func);
>   extern int for_each_memory_block(void *arg, walk_memory_blocks_func_t func);
> -#define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
>   
>   extern int memory_group_register_static(int nid, unsigned long max_pages);
>   extern int memory_group_register_dynamic(int nid, unsigned long unit_pages);
> 


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

