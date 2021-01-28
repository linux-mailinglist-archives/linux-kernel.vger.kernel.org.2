Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26A6307F22
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhA1UF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:05:59 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59830 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhA1UCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:02:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l5DUC-009GeF-Mv; Thu, 28 Jan 2021 13:01:48 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l5DUB-00Cis1-GO; Thu, 28 Jan 2021 13:01:48 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, tyhicks@linux.microsoft.com,
        pmladek@suse.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210126204125.313820-1-pasha.tatashin@soleen.com>
        <20210126204125.313820-2-pasha.tatashin@soleen.com>
Date:   Thu, 28 Jan 2021 14:00:28 -0600
In-Reply-To: <20210126204125.313820-2-pasha.tatashin@soleen.com> (Pavel
        Tatashin's message of "Tue, 26 Jan 2021 15:41:25 -0500")
Message-ID: <87lfcczvab.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l5DUB-00Cis1-GO;;;mid=<87lfcczvab.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194r404La2QKiPvYCt3+fRZW3Di1W4x6TY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_PhishingBody,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubLong,XM_B_Phish66 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Pavel Tatashin <pasha.tatashin@soleen.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 608 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.7%), b_tie_ro: 9 (1.5%), parse: 1.28 (0.2%),
         extract_message_metadata: 29 (4.8%), get_uri_detail_list: 2.6 (0.4%),
        tests_pri_-1000: 26 (4.3%), tests_pri_-950: 1.66 (0.3%),
        tests_pri_-900: 1.35 (0.2%), tests_pri_-90: 63 (10.4%), check_bayes:
        61 (10.0%), b_tokenize: 8 (1.3%), b_tok_get_all: 8 (1.3%),
        b_comp_prob: 2.0 (0.3%), b_tok_touch_all: 40 (6.5%), b_finish: 0.92
        (0.2%), tests_pri_0: 447 (73.4%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 6 (0.9%), poll_dns_idle: 3.7 (0.6%), tests_pri_10:
        3.6 (0.6%), tests_pri_500: 20 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/1] kexec: dump kmessage before machine_kexec
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Tatashin <pasha.tatashin@soleen.com> writes:

> kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> machine_restart(), machine_halt(), machine_power_off(), the only one that
> is missing is  machine_kexec().
>
> The dmesg output that it contains can be used to study the shutdown
> performance of both kernel and systemd during kexec reboot.
>
> Here is example of dmesg data collected after kexec:

As long was we keep kmsg_dump out of the crash_kexec path where
it completely breaks kexec on panic this seems a reasonable thing to do.
On the ordinary kernel_kexec path everything is expected to be working.

Is kmsg_dump expected to work after all of the device drivers
are shut down?  Otherwise this placement of kmsg_dump is too late.

Eric

> root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
> ...
> <6>[   70.914592] psci: CPU3 killed (polled 0 ms)
> <5>[   70.915705] CPU4: shutdown
> <6>[   70.916643] psci: CPU4 killed (polled 4 ms)
> <5>[   70.917715] CPU5: shutdown
> <6>[   70.918725] psci: CPU5 killed (polled 0 ms)
> <5>[   70.919704] CPU6: shutdown
> <6>[   70.920726] psci: CPU6 killed (polled 4 ms)
> <5>[   70.921642] CPU7: shutdown
> <6>[   70.922650] psci: CPU7 killed (polled 0 ms)
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 4f8efc278aa7..e253c8b59145 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/compiler.h>
>  #include <linux/hugetlb.h>
>  #include <linux/objtool.h>
> +#include <linux/kmsg_dump.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -1180,6 +1181,7 @@ int kernel_kexec(void)
>  		machine_shutdown();
>  	}
>  
> +	kmsg_dump(KMSG_DUMP_SHUTDOWN);
>  	machine_kexec(kexec_image);
>  
>  #ifdef CONFIG_KEXEC_JUMP
