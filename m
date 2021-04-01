Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7935C350E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 06:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhDAEgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 00:36:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33168 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDAEgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 00:36:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lRp4N-00AFhJ-Tx; Wed, 31 Mar 2021 22:36:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lRp4K-007N3W-EJ; Wed, 31 Mar 2021 22:36:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Josh Hunt <johunt@akamai.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210401033156.7262-1-johunt@akamai.com>
Date:   Wed, 31 Mar 2021 23:36:28 -0500
In-Reply-To: <20210401033156.7262-1-johunt@akamai.com> (Josh Hunt's message of
        "Wed, 31 Mar 2021 23:31:56 -0400")
Message-ID: <m15z16r583.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lRp4K-007N3W-EJ;;;mid=<m15z16r583.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/B65/rNB3ftoATqolMFHoRXiQZiFhOC5w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Josh Hunt <johunt@akamai.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2466 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (0.5%), b_tie_ro: 10 (0.4%), parse: 1.03
        (0.0%), extract_message_metadata: 14 (0.5%), get_uri_detail_list: 1.40
        (0.1%), tests_pri_-1000: 31 (1.2%), tests_pri_-950: 1.22 (0.0%),
        tests_pri_-900: 0.97 (0.0%), tests_pri_-90: 2201 (89.3%), check_bayes:
        2199 (89.2%), b_tokenize: 6 (0.2%), b_tok_get_all: 6 (0.2%),
        b_comp_prob: 1.77 (0.1%), b_tok_touch_all: 2182 (88.5%), b_finish:
        1.13 (0.0%), tests_pri_0: 192 (7.8%), check_dkim_signature: 0.53
        (0.0%), check_dkim_adsp: 2.7 (0.1%), poll_dns_idle: 0.56 (0.0%),
        tests_pri_10: 2.3 (0.1%), tests_pri_500: 8 (0.3%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] psi: allow unprivileged users with CAP_SYS_RESOURCE to write psi files
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Hunt <johunt@akamai.com> writes:

> Currently only root can write files under /proc/pressure. Relax this to
> allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
> able to write to these files.

The test for CAP_SYS_RESOURCE really needs to be in open rather
than in write.

Otherwise a suid root executable could have stdout redirected
into these files.

Eric


> Signed-off-by: Josh Hunt <johunt@akamai.com>
> ---
>  kernel/sched/psi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index b1b00e9bd7ed..98ff7baf1ba8 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1270,6 +1270,9 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
>  	if (!nbytes)
>  		return -EINVAL;
>  
> +	if (!capable(CAP_SYS_RESOURCE))
> +		return -EPERM;
> +
>  	buf_size = min(nbytes, sizeof(buf));
>  	if (copy_from_user(buf, user_buf, buf_size))
>  		return -EFAULT;
> @@ -1353,9 +1356,9 @@ static int __init psi_proc_init(void)
>  {
>  	if (psi_enable) {
>  		proc_mkdir("pressure", NULL);
> -		proc_create("pressure/io", 0, NULL, &psi_io_proc_ops);
> -		proc_create("pressure/memory", 0, NULL, &psi_memory_proc_ops);
> -		proc_create("pressure/cpu", 0, NULL, &psi_cpu_proc_ops);
> +		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
> +		proc_create("pressure/memory", 0666, NULL, &psi_memory_proc_ops);
> +		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
>  	}
>  	return 0;
>  }
