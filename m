Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ABA411612
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhITNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:49:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35758 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbhITNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:49:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:58100)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mSJds-003Ax2-H1; Mon, 20 Sep 2021 07:47:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:40164 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mSJdr-00F2oS-Ir; Mon, 20 Sep 2021 07:47:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Clapinski <mclapinski@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de
References: <20210918145337.3369-1-manfred@colorfullife.com>
Date:   Mon, 20 Sep 2021 08:46:57 -0500
In-Reply-To: <20210918145337.3369-1-manfred@colorfullife.com> (Manfred
        Spraul's message of "Sat, 18 Sep 2021 16:53:37 +0200")
Message-ID: <87ilyv4awe.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mSJdr-00F2oS-Ir;;;mid=<87ilyv4awe.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Yhyg2VMGs/z48zFTbGq79vNJIwrzD/fU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4911]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Manfred Spraul <manfred@colorfullife.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 345 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (3.1%), b_tie_ro: 9 (2.7%), parse: 0.87 (0.3%),
         extract_message_metadata: 14 (4.1%), get_uri_detail_list: 1.18 (0.3%),
         tests_pri_-1000: 15 (4.4%), tests_pri_-950: 1.28 (0.4%),
        tests_pri_-900: 0.99 (0.3%), tests_pri_-90: 51 (14.9%), check_bayes:
        50 (14.5%), b_tokenize: 6 (1.7%), b_tok_get_all: 5 (1.5%),
        b_comp_prob: 1.86 (0.5%), b_tok_touch_all: 34 (9.9%), b_finish: 0.82
        (0.2%), tests_pri_0: 239 (69.1%), check_dkim_signature: 0.56 (0.2%),
        check_dkim_adsp: 7 (2.1%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ipc/ipc_sysctl.c: Remove fallback for !CONFIG_PROC_SYSCTL
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> Compilation of ipc/ipc_sysctl.c is controlled by
> obj-$(CONFIG_SYSVIPC_SYSCTL)
> [see ipc/Makefile]
>
> And CONFIG_SYSVIPC_SYSCTL depends on SYSCTL
> [see init/Kconfig]
>
> An SYSCTL is selected by PROC_SYSCTL.
> [see fs/proc/Kconfig]
>
> Thus: #ifndef CONFIG_PROC_SYSCTL in ipc/ipc_sysctl.c is impossible, the
> fallback can be removed.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric


> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>  ipc/ipc_sysctl.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 345e4d673e61..f101c171753f 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -23,7 +23,6 @@ static void *get_ipc(struct ctl_table *table)
>  	return which;
>  }
>  
> -#ifdef CONFIG_PROC_SYSCTL
>  static int proc_ipc_dointvec(struct ctl_table *table, int write,
>  		void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -118,18 +117,6 @@ static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
>  }
>  #endif
>  
> -#else
> -#define proc_ipc_doulongvec_minmax NULL
> -#define proc_ipc_dointvec	   NULL
> -#define proc_ipc_dointvec_minmax   NULL
> -#define proc_ipc_dointvec_minmax_orphans   NULL
> -#define proc_ipc_auto_msgmni	   NULL
> -#define proc_ipc_sem_dointvec	   NULL
> -#ifdef CONFIG_CHECKPOINT_RESTORE
> -#define proc_ipc_dointvec_minmax_checkpoint_restore	NULL
> -#endif	/* CONFIG_CHECKPOINT_RESTORE */
> -#endif
> -
>  int ipc_mni = IPCMNI;
>  int ipc_mni_shift = IPCMNI_SHIFT;
>  int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
