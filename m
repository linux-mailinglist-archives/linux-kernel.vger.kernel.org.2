Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB74B426534
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhJHH1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232458AbhJHH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633677936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrRRjHrMBPuEyYQ9nABVBskOpOCiCccfhJMKB+/G8Zw=;
        b=Rbrg2MAE8Gh56SqG7CgVbecWbILF3t7z4PuCCz/buxH+zunqtVEVAZgoUy26B6JxTsXuMg
        5K7bab8TXx8pvb4Vlc3m9TrgVn6m7BtG+YixDCVIvQ4ulspse97pXTqiY/9bsAU95O+tQw
        SCNe3UVjyftDEogKPaeMlKSpfMb1s8w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-JGhutHXONcyaMOgo_dKP4A-1; Fri, 08 Oct 2021 03:25:35 -0400
X-MC-Unique: JGhutHXONcyaMOgo_dKP4A-1
Received: by mail-wr1-f72.google.com with SMTP id r25-20020adfab59000000b001609ddd5579so6567736wrc.21
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 00:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wrRRjHrMBPuEyYQ9nABVBskOpOCiCccfhJMKB+/G8Zw=;
        b=LbpGiiZzOgAMquaGwwgNOzbRjgTiMcIUUjRx90lUxQexNQJ2seTgADsrPEBvm21w5n
         zjtSa9x3+H0eZQZ5iQWjDd9wJqtqjbbqglv5q5hIR4DgXnmgulP5FFqYEB5AEdlCyw2R
         m7HcDsgUdadqp/2VwJFdc4ptiEh9b0XogW/RpDEKBYknSU/AnKREp8rdtOqbc9e6Slb4
         YS7gOZF2VV/PXq/3jQVsRgMfMDIVV9essEN91fs5oqJnjxhc1gdhfNkUYd7iHynL16ju
         HMrALHLvroqG+MUbLVByOdzau6NWF9OMJll66l1yObZhvRKwQozAI3Ehg/5aXFAzx5wa
         65jA==
X-Gm-Message-State: AOAM532ewg2+jeQvaByNoDzdOEopth8OOlYd4JtoW7tRTRdLeX4L6Ov9
        unTKKAqP5fZ8VceBYvFQ3TDZAoSWxThytIBg9m+lfGY7sAMiCqIWTCaLfoEipkmS9jEljPDiHZA
        ReVi8ttc/3rH8jgz+xB1k1gfd
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr1623945wmq.151.1633677934627;
        Fri, 08 Oct 2021 00:25:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx459d2wlytshtk9NfSLWJYxGFmOB+upXoDoldpSkMwornUH6TcLSGnAaLaf9rS4XzkmXVfxw==
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr1623928wmq.151.1633677934392;
        Fri, 08 Oct 2021 00:25:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k9sm1554498wrz.22.2021.10.08.00.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 00:25:33 -0700 (PDT)
Message-ID: <1616f9d2-5530-1266-6734-b5d64cb20658@redhat.com>
Date:   Fri, 8 Oct 2021 09:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 1/5] RISC-V: Mark the existing SBI v0.1 implementation
 as legacy
Content-Language: en-US
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
References: <20211008032036.2201971-1-atish.patra@wdc.com>
 <20211008032036.2201971-2-atish.patra@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211008032036.2201971-2-atish.patra@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/21 05:20, Atish Patra wrote:
> The existing SBI specification impelementation follows v0.1 or legacy
> specification. The latest specification known as v0.2 allows more
> scalability and performance improvements.
> 
> Rename the existing implementation as legacy and provide a way to allow
> future extensions.
> 
> Signed-off-by: Atish Patra<atish.patra@wdc.com>
> ---
>   arch/riscv/include/asm/kvm_vcpu_sbi.h |  29 +++++
>   arch/riscv/kvm/vcpu_sbi.c             | 149 ++++++++++++++++++++------
>   2 files changed, 148 insertions(+), 30 deletions(-)
>   create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi.h

It's bikeshedding I know, but still: every time somebody calls something 
"legacy", a kitten dies.  Please use kvm_sbi_ext_0_1_handler and 
vcpu_sbi_ext_0_1.

Paolo

