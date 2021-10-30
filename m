Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7188B440721
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 05:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhJ3DwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 23:52:22 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47228 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJ3DwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 23:52:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:59486)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mgfNL-002uma-RR; Fri, 29 Oct 2021 21:49:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47698 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mgfNI-005pIg-Du; Fri, 29 Oct 2021 21:49:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Liao Chang <liaochang1@huawei.com>
Cc:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mick@ics.forth.gr>, <jszhang@kernel.org>,
        <guoren@linux.alibaba.com>, <penberg@kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>,
        <changbin.du@intel.com>, <alex@ghiti.fr>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>
References: <20211030031832.165457-1-liaochang1@huawei.com>
        <20211030031832.165457-3-liaochang1@huawei.com>
Date:   Fri, 29 Oct 2021 22:49:09 -0500
In-Reply-To: <20211030031832.165457-3-liaochang1@huawei.com> (Liao Chang's
        message of "Sat, 30 Oct 2021 11:18:31 +0800")
Message-ID: <87ee83goju.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mgfNI-005pIg-Du;;;mid=<87ee83goju.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18f7M3MHRYDgl23l5rWQ+6xsslUtaUkAZ0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4755]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Liao Chang <liaochang1@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2721 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (0.5%), b_tie_ro: 10 (0.4%), parse: 1.40
        (0.1%), extract_message_metadata: 17 (0.6%), get_uri_detail_list: 1.98
        (0.1%), tests_pri_-1000: 11 (0.4%), tests_pri_-950: 1.89 (0.1%),
        tests_pri_-900: 1.39 (0.1%), tests_pri_-90: 64 (2.4%), check_bayes: 63
        (2.3%), b_tokenize: 9 (0.3%), b_tok_get_all: 9 (0.3%), b_comp_prob:
        3.0 (0.1%), b_tok_touch_all: 38 (1.4%), b_finish: 1.14 (0.0%),
        tests_pri_0: 2581 (94.9%), check_dkim_signature: 0.86 (0.0%),
        check_dkim_adsp: 3.3 (0.1%), poll_dns_idle: 0.83 (0.0%), tests_pri_10:
        6 (0.2%), tests_pri_500: 19 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] RISC-V: use memcpy for kexec_file mode
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liao Chang <liaochang1@huawei.com> writes:

> The pointer to buffer loading kernel binaries is in kernel space for
> kexec_fil mode, When copy_from_user copies data from pointer to a block
> of memory, it checkes that the pointer is in the user space range, on
> RISCV-V that is:
>
> static inline bool __access_ok(unsigned long addr, unsigned long size)
> {
> 	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
> }
>
> and TASK_SIZE is 0x4000000000 for 64-bits, which now causes
> copy_from_user to reject the access of the field 'buf' of struct
> kexec_segment that is in range [CONFIG_PAGE_OFFSET - VMALLOC_SIZE,
> CONFIG_PAGE_OFFSET), is invalid user space pointer.
>
> This patch fixes this issue by skipping access_ok(), use mempcy() instead.

I am a bit confused.

Why is machine_kexec ever calling copy_from_user?  That seems wrong in
all cases.

Even worse then having a copy_from_user is having data that you don't
know if you should call copy_from_user on.

There is most definitely a bug here.  Can someone please sort it out
without making the kernel guess what kind of memory it is copying from.

Eric



> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/kernel/machine_kexec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index e6eca271a4d6..4a5db856919b 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -65,7 +65,9 @@ machine_kexec_prepare(struct kimage *image)
>  		if (image->segment[i].memsz <= sizeof(fdt))
>  			continue;
>  
> -		if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
> +		if (image->file_mode)
> +			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
> +		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
>  			continue;
>  
>  		if (fdt_check_header(&fdt))
