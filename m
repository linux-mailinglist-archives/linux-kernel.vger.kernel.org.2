Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2939484D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE1VYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 17:24:12 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41148 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1VYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 17:24:11 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lmjw9-00Em24-W8; Fri, 28 May 2021 15:22:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lmjw9-00GWJi-5K; Fri, 28 May 2021 15:22:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <legion@kernel.org>
References: <20210526143805.2549649-1-yangyingliang@huawei.com>
Date:   Fri, 28 May 2021 16:22:16 -0500
In-Reply-To: <20210526143805.2549649-1-yangyingliang@huawei.com> (Yang
        Yingliang's message of "Wed, 26 May 2021 22:38:05 +0800")
Message-ID: <m1h7imlfjr.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lmjw9-00GWJi-5K;;;mid=<m1h7imlfjr.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/jTzNAx0dUEzq/BvL0ncWV2+Hn6hLWxh0=
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
        *      [score: 0.4772]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Yang Yingliang <yangyingliang@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 268 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (4.0%), b_tie_ro: 9 (3.5%), parse: 0.82 (0.3%),
         extract_message_metadata: 11 (4.2%), get_uri_detail_list: 0.88 (0.3%),
         tests_pri_-1000: 14 (5.2%), tests_pri_-950: 1.21 (0.5%),
        tests_pri_-900: 0.99 (0.4%), tests_pri_-90: 47 (17.5%), check_bayes:
        46 (17.1%), b_tokenize: 4.6 (1.7%), b_tok_get_all: 4.0 (1.5%),
        b_comp_prob: 1.43 (0.5%), b_tok_touch_all: 33 (12.2%), b_finish: 0.85
        (0.3%), tests_pri_0: 168 (62.7%), check_dkim_signature: 0.67 (0.3%),
        check_dkim_adsp: 1.91 (0.7%), poll_dns_idle: 0.24 (0.1%),
        tests_pri_10: 2.1 (0.8%), tests_pri_500: 9 (3.2%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH -next] cred: add missing return error code when set_cred_ucounts() failed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> writes:

> If set_cred_ucounts() failed, we need return the error code.
>
> Fixes: 905ae01c4ae2 ("Add a reference to ucounts for each cred")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied thanks.
> ---
>  kernel/cred.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cred.c b/kernel/cred.c
> index db7c46bf36e5..e6fd2b3fc31f 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -372,7 +372,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>  		ret = create_user_ns(new);
>  		if (ret < 0)
>  			goto error_put;
> -		if (set_cred_ucounts(new) < 0)
> +		ret = set_cred_ucounts(new);
> +		if (ret < 0)
>  			goto error_put;
>  	}
