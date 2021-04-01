Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1D351A34
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhDAR6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234928AbhDARlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617298880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N67tP/cWMXXurwei0joW1yBuUziKJgKYd5FwjSdOqh4=;
        b=A7Y3d2nDvOFfl42+0gLN2RI2Dix/Lccu+LugJO5Z3CwJaa3eVXjKC5O+yOHpG3uE+ZmTbV
        Y11nsOHmwNCDHVbVtpAprfhkYJ4rcM8gpRgseAt6qvHKUWed0XC5oAuq6i0pB4U5QwOkFQ
        FfwrMXYxcGUW3hE54CenFFevNvhQTws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-VZQStQ-eMQK1jv4Y00sEBg-1; Thu, 01 Apr 2021 09:40:51 -0400
X-MC-Unique: VZQStQ-eMQK1jv4Y00sEBg-1
Received: by mail-wr1-f70.google.com with SMTP id p12so2770533wrn.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N67tP/cWMXXurwei0joW1yBuUziKJgKYd5FwjSdOqh4=;
        b=WyG5gqAX1BAzWMfJTJN/mHQl+MJaegXrVsDkFpc47ezt/6pg5KNcsXcZnRXoQueGVJ
         bttS6hdgycEhlASA9xlgjawRXZvpxnCF7sk67b4FhP2ALLb8ux0cP0QoeSw++mc+2MN7
         JdJFzrfznr7qYlINW9uxAXcwOTdoklUXFnZ0DOQOpCD/dQQPEtJjXWeDLVD68BOkoFkL
         nk0kvltwb3Ixi2eC4laAzbOLpkRpVn/qDs2HBJQ9nH3UBV6qhMyDA/S9WOIMjrm7Ox26
         IdAUAWNrUcY0DA9OOI1i2DhCaijBRi0twVlyETwDGsQtLr/uEVyE1j244EcEw0Wanpcy
         PAfw==
X-Gm-Message-State: AOAM531RvBomHjazUxoJDd+KoCf6TFZpiYn3s3vSVb6UjBDpB2Q7UUH+
        YHwSHRyTK1pNgzG9p6iN0t9XZrwf9rQOCgtc52ijNz7aloSFC5uQtYIfM/+XurcFXwx4XW5rrqc
        QXev3FAzhYWvShIEq9qaRgAK5Z2yyPovyHedH/Vc7IqeKo/JG4Q0KZr7Oq2dBJWYMDA9QCo7kfE
        PW
X-Received: by 2002:adf:c389:: with SMTP id p9mr9742776wrf.410.1617284450315;
        Thu, 01 Apr 2021 06:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqC9R0CT9YL9ywrfb28aPzSYFB3USCVSvRIboUtdqBPNvYChIbneJ4bIlG0w03NGjVZ/IQLg==
X-Received: by 2002:adf:c389:: with SMTP id p9mr9742741wrf.410.1617284450088;
        Thu, 01 Apr 2021 06:40:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q17sm9892094wrv.25.2021.04.01.06.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:40:49 -0700 (PDT)
Subject: Re: [PATCH v17 01/17] RISC-V: Add hypervisor extension related CSR
 defines
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Alexander Graf <graf@amazon.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210401133435.383959-1-anup.patel@wdc.com>
 <20210401133435.383959-2-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92f495ff-c07a-2e4c-bd55-18079ab6e4dd@redhat.com>
Date:   Thu, 1 Apr 2021 15:40:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401133435.383959-2-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/21 15:34, Anup Patel wrote:
> This patch extends asm/csr.h by adding RISC-V hypervisor extension
> related defines.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>
> ---
>   arch/riscv/include/asm/csr.h | 89 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)

Palmer, are you willing to put this patch in a topic branch, or ack it, 
so that we can finally merge KVM to either arch/riscv/kvm or 
drivers/staging/riscv/kvm?

If not, I still believe that we should merge KVM for RISC-V to staging 
and therefore move these new definitions to a separate file.

Paolo

> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index caadfc1d7487..bdf00bd558e4 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -30,6 +30,8 @@
>   #define SR_XS_CLEAN	_AC(0x00010000, UL)
>   #define SR_XS_DIRTY	_AC(0x00018000, UL)
>   
> +#define SR_MXR		_AC(0x00080000, UL)
> +
>   #ifndef CONFIG_64BIT
>   #define SR_SD		_AC(0x80000000, UL) /* FS/XS dirty */
>   #else
> @@ -58,22 +60,32 @@
>   
>   /* Interrupt causes (minus the high bit) */
>   #define IRQ_S_SOFT		1
> +#define IRQ_VS_SOFT		2
>   #define IRQ_M_SOFT		3
>   #define IRQ_S_TIMER		5
> +#define IRQ_VS_TIMER		6
>   #define IRQ_M_TIMER		7
>   #define IRQ_S_EXT		9
> +#define IRQ_VS_EXT		10
>   #define IRQ_M_EXT		11
>   
>   /* Exception causes */
>   #define EXC_INST_MISALIGNED	0
>   #define EXC_INST_ACCESS		1
> +#define EXC_INST_ILLEGAL	2
>   #define EXC_BREAKPOINT		3
>   #define EXC_LOAD_ACCESS		5
>   #define EXC_STORE_ACCESS	7
>   #define EXC_SYSCALL		8
> +#define EXC_HYPERVISOR_SYSCALL	9
> +#define EXC_SUPERVISOR_SYSCALL	10
>   #define EXC_INST_PAGE_FAULT	12
>   #define EXC_LOAD_PAGE_FAULT	13
>   #define EXC_STORE_PAGE_FAULT	15
> +#define EXC_INST_GUEST_PAGE_FAULT	20
> +#define EXC_LOAD_GUEST_PAGE_FAULT	21
> +#define EXC_VIRTUAL_INST_FAULT	22
> +#define EXC_STORE_GUEST_PAGE_FAULT	23
>   
>   /* PMP configuration */
>   #define PMP_R			0x01
> @@ -85,6 +97,58 @@
>   #define PMP_A_NAPOT		0x18
>   #define PMP_L			0x80
>   
> +/* HSTATUS flags */
> +#ifdef CONFIG_64BIT
> +#define HSTATUS_VSXL		_AC(0x300000000, UL)
> +#define HSTATUS_VSXL_SHIFT	32
> +#endif
> +#define HSTATUS_VTSR		_AC(0x00400000, UL)
> +#define HSTATUS_VTW		_AC(0x00200000, UL)
> +#define HSTATUS_VTVM		_AC(0x00100000, UL)
> +#define HSTATUS_VGEIN		_AC(0x0003f000, UL)
> +#define HSTATUS_VGEIN_SHIFT	12
> +#define HSTATUS_HU		_AC(0x00000200, UL)
> +#define HSTATUS_SPVP		_AC(0x00000100, UL)
> +#define HSTATUS_SPV		_AC(0x00000080, UL)
> +#define HSTATUS_GVA		_AC(0x00000040, UL)
> +#define HSTATUS_VSBE		_AC(0x00000020, UL)
> +
> +/* HGATP flags */
> +#define HGATP_MODE_OFF		_AC(0, UL)
> +#define HGATP_MODE_SV32X4	_AC(1, UL)
> +#define HGATP_MODE_SV39X4	_AC(8, UL)
> +#define HGATP_MODE_SV48X4	_AC(9, UL)
> +
> +#define HGATP32_MODE_SHIFT	31
> +#define HGATP32_VMID_SHIFT	22
> +#define HGATP32_VMID_MASK	_AC(0x1FC00000, UL)
> +#define HGATP32_PPN		_AC(0x003FFFFF, UL)
> +
> +#define HGATP64_MODE_SHIFT	60
> +#define HGATP64_VMID_SHIFT	44
> +#define HGATP64_VMID_MASK	_AC(0x03FFF00000000000, UL)
> +#define HGATP64_PPN		_AC(0x00000FFFFFFFFFFF, UL)
> +
> +#define HGATP_PAGE_SHIFT	12
> +
> +#ifdef CONFIG_64BIT
> +#define HGATP_PPN		HGATP64_PPN
> +#define HGATP_VMID_SHIFT	HGATP64_VMID_SHIFT
> +#define HGATP_VMID_MASK		HGATP64_VMID_MASK
> +#define HGATP_MODE_SHIFT	HGATP64_MODE_SHIFT
> +#else
> +#define HGATP_PPN		HGATP32_PPN
> +#define HGATP_VMID_SHIFT	HGATP32_VMID_SHIFT
> +#define HGATP_VMID_MASK		HGATP32_VMID_MASK
> +#define HGATP_MODE_SHIFT	HGATP32_MODE_SHIFT
> +#endif
> +
> +/* VSIP & HVIP relation */
> +#define VSIP_TO_HVIP_SHIFT	(IRQ_VS_SOFT - IRQ_S_SOFT)
> +#define VSIP_VALID_MASK		((_AC(1, UL) << IRQ_S_SOFT) | \
> +				 (_AC(1, UL) << IRQ_S_TIMER) | \
> +				 (_AC(1, UL) << IRQ_S_EXT))
> +
>   /* symbolic CSR names: */
>   #define CSR_CYCLE		0xc00
>   #define CSR_TIME		0xc01
> @@ -104,6 +168,31 @@
>   #define CSR_SIP			0x144
>   #define CSR_SATP		0x180
>   
> +#define CSR_VSSTATUS		0x200
> +#define CSR_VSIE		0x204
> +#define CSR_VSTVEC		0x205
> +#define CSR_VSSCRATCH		0x240
> +#define CSR_VSEPC		0x241
> +#define CSR_VSCAUSE		0x242
> +#define CSR_VSTVAL		0x243
> +#define CSR_VSIP		0x244
> +#define CSR_VSATP		0x280
> +
> +#define CSR_HSTATUS		0x600
> +#define CSR_HEDELEG		0x602
> +#define CSR_HIDELEG		0x603
> +#define CSR_HIE			0x604
> +#define CSR_HTIMEDELTA		0x605
> +#define CSR_HCOUNTEREN		0x606
> +#define CSR_HGEIE		0x607
> +#define CSR_HTIMEDELTAH		0x615
> +#define CSR_HTVAL		0x643
> +#define CSR_HIP			0x644
> +#define CSR_HVIP		0x645
> +#define CSR_HTINST		0x64a
> +#define CSR_HGATP		0x680
> +#define CSR_HGEIP		0xe12
> +
>   #define CSR_MSTATUS		0x300
>   #define CSR_MISA		0x301
>   #define CSR_MIE			0x304
> 

