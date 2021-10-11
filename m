Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4245E429017
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbhJKOFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:05:00 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38908 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbhJKOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:02:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:32978)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mZvqh-007fHh-1d; Mon, 11 Oct 2021 08:00:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:37162 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mZvqf-004EpR-QP; Mon, 11 Oct 2021 08:00:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
References: <20211009095458.297191-1-coxu@redhat.com>
        <20211009095458.297191-2-coxu@redhat.com>
Date:   Mon, 11 Oct 2021 08:58:36 -0500
In-Reply-To: <20211009095458.297191-2-coxu@redhat.com> (Coiby Xu's message of
        "Sat, 9 Oct 2021 17:54:57 +0800")
Message-ID: <87ily3br3n.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mZvqf-004EpR-QP;;;mid=<87ily3br3n.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/o+ODauzQUhwR/xCs9RDYPu7Ki8f9PEWk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Coiby Xu <coxu@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 532 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 8 (1.6%), b_tie_ro: 7 (1.3%), parse: 1.00 (0.2%),
        extract_message_metadata: 4.3 (0.8%), get_uri_detail_list: 2.1 (0.4%),
        tests_pri_-1000: 4.0 (0.7%), tests_pri_-950: 1.29 (0.2%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 140 (26.3%), check_bayes:
        138 (26.0%), b_tokenize: 10 (1.8%), b_tok_get_all: 6 (1.1%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 117 (21.9%), b_finish: 0.99
        (0.2%), tests_pri_0: 355 (66.7%), check_dkim_signature: 0.75 (0.1%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 0.86 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/2] kexec, KEYS: make the code in bzImage64_verify_sig generic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coiby Xu <coxu@redhat.com> writes:

> The code in bzImage64_verify_sig could make use of system keyrings including
> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
> signed kernel image as PE file. Make it generic so both x86_64 and arm64 can 
> use it.

The naming is problematic.

At a minimum please name the new function kexec_kernel_verify_pe_sig.
AKA what you named it without the "arch_" prefix.  A function named with
an "arch_" prefix  implies that it has an architecture specific
implementation.

It looks like arch_kexec_kernel_verify_sig should be killed as well
as it only has one implementation in the generic code.  And the code
should always call kexec_image_verify_sig_default.  Not that you should
do that but I am pointing it out as it seems that is the bad example you
are copying.

Eric

> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>  include/linux/kexec.h             |  3 +++
>  kernel/kexec_file.c               | 17 +++++++++++++++++
>  3 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..4136dd3be5a9 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -17,7 +17,6 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/efi.h>
> -#include <linux/verification.h>
>  
>  #include <asm/bootparam.h>
>  #include <asm/setup.h>
> @@ -531,17 +530,7 @@ static int bzImage64_cleanup(void *loader_data)
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	int ret;
> -
> -	ret = verify_pefile_signature(kernel, kernel_len,
> -				      VERIFY_USE_SECONDARY_KEYRING,
> -				      VERIFYING_KEXEC_PE_SIGNATURE);
> -	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> -		ret = verify_pefile_signature(kernel, kernel_len,
> -					      VERIFY_USE_PLATFORM_KEYRING,
> -					      VERIFYING_KEXEC_PE_SIGNATURE);
> -	}
> -	return ret;
> +	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
>  }
>  #endif
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..d45f32336dbe 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -19,6 +19,7 @@
>  #include <asm/io.h>
>  
>  #include <uapi/linux/kexec.h>
> +#include <linux/verification.h>
>  
>  #ifdef CONFIG_KEXEC_CORE
>  #include <linux/list.h>
> @@ -199,6 +200,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
>  #ifdef CONFIG_KEXEC_SIG
>  int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  				 unsigned long buf_len);
> +int arch_kexec_kernel_verify_pe_sig(const char *kernel,
> +				    unsigned long kernel_len);
>  #endif
>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 33400ff051a8..0530275b7aa3 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -106,6 +106,23 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  {
>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>  }
> +
> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
> +int arch_kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
> +{
> +	int ret;
> +
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +				      VERIFY_USE_SECONDARY_KEYRING,
> +				      VERIFYING_KEXEC_PE_SIGNATURE);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +					      VERIFY_USE_PLATFORM_KEYRING,
> +					      VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +	return ret;
> +}
> +#endif
>  #endif
>  
>  /*
