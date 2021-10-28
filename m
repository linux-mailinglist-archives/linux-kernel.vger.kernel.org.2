Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B1543E312
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhJ1OKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230265AbhJ1OKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635430061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/6u/2V3kbwOw+vCIQ7D9V9KhEUDROrBvfNcLoT9zUQ=;
        b=UTsa6i+wGl7hbT5TLvHPl+zcKKTc+NS1wd+63cInIpoxNn9IoC6uELtsDj5F4yS1quD0xA
        EOCDqHtxy1BHDQqd4d6ZoqUkIoeagcHr58jbyxx5kkTGR2HQquX94di3W1BXnQQdKJYiaV
        JYOpJ6lHCMhJTW60jA/A13vaVrnIeWs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-sWIUlx0ZPU6mHd356W8J6Q-1; Thu, 28 Oct 2021 10:07:39 -0400
X-MC-Unique: sWIUlx0ZPU6mHd356W8J6Q-1
Received: by mail-ed1-f71.google.com with SMTP id t1-20020a056402524100b003dd9a419eb5so5737878edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w/6u/2V3kbwOw+vCIQ7D9V9KhEUDROrBvfNcLoT9zUQ=;
        b=XpHZhGf4fC2JWJO6Ogb8oN7U8YalpyeXlft0Lo0GK/NWt9fxF8C/sHgbKmizn2Fcgd
         zcHpOPznQPPEPulGYq++Mrd7cEreDn1u+KHDxssU2F/dsP0HKhSjAt57sSxxCLySDrXl
         5+FRUPGzMjcDaqg/9acH25eXlQHO8T4vBHOEI7KO32h3tL7IPB2GQZND6uFuWTCMpbGp
         c37m0ge8h8XAVTvfqmWvpOWB71NyF4brUpCtvdmYyKvxlqf0bY0XVBqaRosozCmwiazE
         VADCErQVOXSGYEfwzVAiPxppf3/bPAmHuigukVFKZdITLa0Gixpwax9mBnqbIU7bSoUt
         SypQ==
X-Gm-Message-State: AOAM5338H5xFo0kBmSqacynunDW66e9B9RqdVoXhZbToEaj70ZpGaZHD
        5PU6j3cF7fUIyMqX8KsXt4/FQyMVVT1wCtERB94xLNMt1EiVQrx6+fCZVY7JY043S0oMEVJ7iOi
        GK4L2mG8ZYqMkV6b5wtO7PAyq
X-Received: by 2002:a17:906:7b42:: with SMTP id n2mr5716169ejo.428.1635430058053;
        Thu, 28 Oct 2021 07:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5XiquuYAH7SkWh2/xFy/qGlGMMv5yBFfuta79BJff+F3uPv7LPQF5rW36lriFN8dBTGu76g==
X-Received: by 2002:a17:906:7b42:: with SMTP id n2mr5716144ejo.428.1635430057860;
        Thu, 28 Oct 2021 07:07:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gt36sm1448349ejc.13.2021.10.28.07.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 07:07:37 -0700 (PDT)
Message-ID: <62fe1c8e-abe0-5de9-5c00-3549faae1dba@redhat.com>
Date:   Thu, 28 Oct 2021 16:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/3] RISC-V: KVM: Few assorted changes
Content-Language: en-US
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211026170136.2147619-1-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211026170136.2147619-1-anup.patel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/21 19:01, Anup Patel wrote:
> I had a few assorted KVM RISC-V changes which I wanted to sent after
> KVM RISC-V was merged hence this series.
> 
> These patches can also be found in riscv_kvm_assorted_v1 branch at:
> https://github.com/avpatel/linux.git
> 
> Anup Patel (3):
>    RISC-V: Enable KVM in RV64 and RV32 defconfigs as a module
>    RISC-V: KVM: Factor-out FP virtualization into separate sources
>    RISC-V: KVM: Fix GPA passed to __kvm_riscv_hfence_gvma_xyz() functions
> 
>   arch/riscv/configs/defconfig         |  15 ++-
>   arch/riscv/configs/rv32_defconfig    |   8 +-
>   arch/riscv/include/asm/kvm_host.h    |  10 +-
>   arch/riscv/include/asm/kvm_vcpu_fp.h |  59 +++++++++
>   arch/riscv/kvm/Makefile              |   1 +
>   arch/riscv/kvm/tlb.S                 |   4 +-
>   arch/riscv/kvm/vcpu.c                | 172 ---------------------------
>   arch/riscv/kvm/vcpu_fp.c             | 167 ++++++++++++++++++++++++++
>   8 files changed, 244 insertions(+), 192 deletions(-)
>   create mode 100644 arch/riscv/include/asm/kvm_vcpu_fp.h
>   create mode 100644 arch/riscv/kvm/vcpu_fp.c
> 

Queued 2+3, thanks.

Paolo

