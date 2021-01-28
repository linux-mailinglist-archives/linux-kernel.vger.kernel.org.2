Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E96307FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhA1Ulh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhA1Uld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:41:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED9CC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dT3QLKJD/CzMv+auklBWXRdST9SnwaARKpGCe857cJ0=; b=nuQOLXVqY2MjTtXxAILYKw41tk
        jyJg8pr2cEU+9hhmxv4hQT8RrWGzu+1djgNfxn/1WaZbw+lRYL4U2UdE1rouz6pOzz/AZOW/ejcF0
        sheib5b4TsD8uZs4OyocLBoDFrwp/BibSRxDjzUJIigWMh9BcguGHG/DZ98WRjuTysfD5rqK4T3cV
        vQiFULoTt5zE70ElMNaQdPihLHrgejOroaYQzJ6TnFt9SJ9P4M27wcsNWxZllBWzLiWEl55Emb/B/
        p56uwDL/CIsROoQ6/dWMFLJ1LYjypFT3omLVwZxUrMoiFiRjSrf9ayQu2TfhntcVlXlfRyBZuq4oQ
        QD1tnNYw==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5E5w-000531-Is; Thu, 28 Jan 2021 20:40:48 +0000
Subject: Re: Kconfig-induced build errors: CONFIG_PAGE_OFFSET
To:     Atish Patra <atishp@atishpatra.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <b67f8941-6624-d814-e6d3-2ddfdfbdf7dd@infradead.org>
 <CAOnJCUJc0-x-gmLAKxb9ULjOX1yBjxZvwi4=_0ETH-L7JtKhNw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e90a2745-7ca6-ce78-63c8-5aaf31602eab@infradead.org>
Date:   Thu, 28 Jan 2021 12:40:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCUJc0-x-gmLAKxb9ULjOX1yBjxZvwi4=_0ETH-L7JtKhNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 12:07 PM, Atish Patra wrote:
> On Wed, Jan 27, 2021 at 7:18 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi,
>>
>> I took a riscv-32 .config from kernel test robot (it was for a clang build)
>> and did a "make olddefconfig" (using gcc tools) and got build errors
>> due to this config item from arch/riscv/Kconfig;
>>
>>
>> config PAGE_OFFSET
>>         hex
>>         default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
>>         default 0x80000000 if 64BIT && !MMU
>>         default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>>         default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>>
>> PAGE_OFFSET is undefined for the case of 32BIT && MAXPHYSMEM_2GB.
> 
> Because, RV32 doesn't support 2GB physical memory yet.
> 
> The compilation errors can be fixed by not allowing MAXPHYSMEM_2GB for RV32 and
> MAXPHYSMEM_1GB for RV64. How about this ?
> 
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -253,8 +253,10 @@ choice
>         default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
> 
>         config MAXPHYSMEM_1GB
> +               depends on 32BIT
>                 bool "1GiB"
>         config MAXPHYSMEM_2GB
> +               depends on 64BIT && CMODEL_MEDLOW
>                 bool "2GiB"
>         config MAXPHYSMEM_128GB
>                 depends on 64BIT && CMODEL_MEDANY
Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

