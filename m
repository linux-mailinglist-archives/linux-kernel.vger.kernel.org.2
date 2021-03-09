Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D422332263
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhCIJzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:55:12 -0500
Received: from ozlabs.org ([203.11.71.1]:48167 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229799AbhCIJy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:54:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DvrCy5l2bz9sCD;
        Tue,  9 Mar 2021 20:54:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1615283697;
        bh=Ri8w2GYEiuBWXT9VNvVxkdDMG21BsNS2mKo2sif8myc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=paevZ6o8UaJVmUX2L2XTyeZZfeNqxqfjuWOHScSRtjZbMd+q1V7L317YqKeLEYR1l
         Qzl/avdN8X1Rq7D0u8Pt7Ux1VNRlA+QRkKDOCfcbRQALQXaMgXx/BFee7qpfRofAeO
         Ni+Eo3lZlkrE886yF6obtoh8LWQ8QVx2ik+J1nl4vHQdRVdiyDIgT3GDgq+VrM0w+f
         XOj8WcIr7tl5IFbuu4fQATKjIJFL5dtoUEslPfZt/+mwZVIhJ478fTgk6jw/uKyUx/
         CWgLrXRiR1m5TIDG9hd2HwPBgIQc8kqe86ESZsiNiG6tmlDR6XQAMOnvFiD/HfA4D0
         aj3HsDMUrHB3g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     ravi.bangoria@linux.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        paulus@samba.org, jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v4] powerpc/uprobes: Validation for prefixed instruction
In-Reply-To: <20210305115433.140769-1-ravi.bangoria@linux.ibm.com>
References: <20210305115433.140769-1-ravi.bangoria@linux.ibm.com>
Date:   Tue, 09 Mar 2021 20:54:45 +1100
Message-ID: <87ft14r6sa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> As per ISA 3.1, prefixed instruction should not cross 64-byte
> boundary. So don't allow Uprobe on such prefixed instruction.
>
> There are two ways probed instruction is changed in mapped pages.
> First, when Uprobe is activated, it searches for all the relevant
> pages and replace instruction in them. In this case, if that probe
> is on the 64-byte unaligned prefixed instruction, error out
> directly. Second, when Uprobe is already active and user maps a
> relevant page via mmap(), instruction is replaced via mmap() code
> path. But because Uprobe is invalid, entire mmap() operation can
> not be stopped. In this case just print an error and continue.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Do we have a Fixes: tag for this?

> ---
> v3: https://lore.kernel.org/r/20210304050529.59391-1-ravi.bangoria@linux.ibm.com
> v3->v4:
>   - CONFIG_PPC64 check was not required, remove it.
>   - Use SZ_ macros instead of hardcoded numbers.
>
>  arch/powerpc/kernel/uprobes.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
> index e8a63713e655..4cbfff6e94a3 100644
> --- a/arch/powerpc/kernel/uprobes.c
> +++ b/arch/powerpc/kernel/uprobes.c
> @@ -41,6 +41,13 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>  	if (addr & 0x03)
>  		return -EINVAL;
>  
> +	if (cpu_has_feature(CPU_FTR_ARCH_31) &&
> +	    ppc_inst_prefixed(auprobe->insn) &&
> +	    (addr & (SZ_64 - 4)) == SZ_64 - 4) {
> +		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
> +		return -EINVAL;

I realise we already did the 0x03 check above, but I still think this
would be clearer simply as:

	    (addr & 0x3f == 60)

cheers
