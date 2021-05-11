Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F037ACA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhEKRFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:05:42 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:35492 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbhEKRFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:05:40 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BGqP0G018350;
        Tue, 11 May 2021 17:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=4W2HWQZOaTJdMYcnOz+dQwaVTouq0WnhcmLTNH5PSts=;
 b=Rt0BX2IUlhFTAAkwv6fp+ye0RYZX+crg8jbW7857VH9Ppdm9SZfKRw++hKd28aNsPo+a
 /vxg5VoI0kKSkiUMgiJZnaSAKReB8NbZa6CWqFmZt/8iaaEDSBnFfHdNMEG+JcL9tGaQ
 5bGC+my5+EpcQ1D8Lhm5rxSEnYq2ZzLl6PjMVdMy3NQ0G9kty8TLKe0PdBEdJnFyG5v7
 8/qF4ti58d+WsDZQrlnN+dIjspXJW4S9yymN2UKNvfMMBnV+tL3acR6Goch8jb+eH+UW
 25gTl2AVrpPMNPQ9eBhC9HlnXNh6GrhxWktIXPwin7kzKKwZwljQG5naCHF3zkZSofR5 uw== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 38fcbgqsnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 17:04:14 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 743515C;
        Tue, 11 May 2021 17:04:13 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.198.103])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 67CF646;
        Tue, 11 May 2021 17:04:12 +0000 (UTC)
Date:   Tue, 11 May 2021 12:04:12 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] x86/irq: remove unused vectors from
 <asm/irq_vectors.h>
Message-ID: <YJq5DKN4ZCJns2wr@swahl-home.5wahls.com>
References: <20210511005531.1065536-1-hpa@zytor.com>
 <20210511005531.1065536-7-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511005531.1065536-7-hpa@zytor.com>
X-Proofpoint-ORIG-GUID: 83KbdN9TNeaJViPGeElUQcx-xyyt8pjf
X-Proofpoint-GUID: 83KbdN9TNeaJViPGeElUQcx-xyyt8pjf
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=822 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1011 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Steve Wahl <steve.wahl@hpe.com>

Yes, we believe UV_BAU_MESSAGE is one we missed in some earlier code
cleanup, and agree with its removal.

On Mon, May 10, 2021 at 05:55:31PM -0700, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> UV_BAU_MESSAGE is defined but not used anywhere in the
> kernel. Presumably this is a stale vector number that can be
> reclaimed.
> 
> MCE_VECTOR is not an actual vector: #MC is an exception, not an
> interrupt vector, and as such is correctly described as
> X86_TRAP_MC. MCE_VECTOR is not used anywhere is the kernel.
> 
> Note that NMI_VECTOR *is* used; specifically it is the vector number
> programmed into the APIC LVT when an NMI interrupt is configured. At
> the moment it is always numerically identical to X86_TRAP_NMI, that is
> not necessarily going to be the case indefinitely.
> 
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>  arch/x86/include/asm/irq_vectors.h       | 4 ++--
>  tools/arch/x86/include/asm/irq_vectors.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index d2ef35927770..43dcb9284208 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -26,8 +26,8 @@
>   * This file enumerates the exact layout of them:
>   */
>  
> +/* This is used as an interrupt vector when programming the APIC. */
>  #define NMI_VECTOR			0x02
> -#define MCE_VECTOR			0x12
>  
>  /*
>   * IDT vectors usable for external interrupt sources start at 0x20.
> @@ -84,7 +84,7 @@
>   */
>  #define IRQ_WORK_VECTOR			0xf6
>  
> -#define UV_BAU_MESSAGE			0xf5
> +/* 0xf5 - unused, was UV_BAU_MESSAGE */
>  #define DEFERRED_ERROR_VECTOR		0xf4
>  
>  /* Vector on which hypervisor callbacks will be delivered */
> diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
> index d2ef35927770..43dcb9284208 100644
> --- a/tools/arch/x86/include/asm/irq_vectors.h
> +++ b/tools/arch/x86/include/asm/irq_vectors.h
> @@ -26,8 +26,8 @@
>   * This file enumerates the exact layout of them:
>   */
>  
> +/* This is used as an interrupt vector when programming the APIC. */
>  #define NMI_VECTOR			0x02
> -#define MCE_VECTOR			0x12
>  
>  /*
>   * IDT vectors usable for external interrupt sources start at 0x20.
> @@ -84,7 +84,7 @@
>   */
>  #define IRQ_WORK_VECTOR			0xf6
>  
> -#define UV_BAU_MESSAGE			0xf5
> +/* 0xf5 - unused, was UV_BAU_MESSAGE */
>  #define DEFERRED_ERROR_VECTOR		0xf4
>  
>  /* Vector on which hypervisor callbacks will be delivered */
> -- 
> 2.31.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
