Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7235739228E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhEZWMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:12:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43212 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhEZWMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:12:34 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lm1jw-00AiDR-L7; Wed, 26 May 2021 16:11:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lm1jv-0002hQ-H0; Wed, 26 May 2021 16:11:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <legion@kernel.org>
References: <20210526143805.2549649-1-yangyingliang@huawei.com>
Date:   Wed, 26 May 2021 17:10:43 -0500
In-Reply-To: <20210526143805.2549649-1-yangyingliang@huawei.com> (Yang
        Yingliang's message of "Wed, 26 May 2021 22:38:05 +0800")
Message-ID: <m1sg29kuxo.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lm1jv-0002hQ-H0;;;mid=<m1sg29kuxo.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/k7+ezPaBxFas8ZXSyR8onGsoWUMRXnZc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4771]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Yang Yingliang <yangyingliang@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 303 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (4.5%), b_tie_ro: 12 (3.9%), parse: 0.97
        (0.3%), extract_message_metadata: 12 (4.1%), get_uri_detail_list: 1.12
        (0.4%), tests_pri_-1000: 4.5 (1.5%), tests_pri_-950: 1.35 (0.4%),
        tests_pri_-900: 1.10 (0.4%), tests_pri_-90: 69 (22.9%), check_bayes:
        67 (22.2%), b_tokenize: 4.0 (1.3%), b_tok_get_all: 6 (2.1%),
        b_comp_prob: 1.63 (0.5%), b_tok_touch_all: 51 (16.8%), b_finish: 1.30
        (0.4%), tests_pri_0: 186 (61.3%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 2.6 (0.9%), poll_dns_idle: 1.15 (0.4%), tests_pri_10:
        2.4 (0.8%), tests_pri_500: 8 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] cred: add missing return error code when set_cred_ucounts() failed
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> writes:

> If set_cred_ucounts() failed, we need return the error code.

Alex how does this look to you?

This is showing up now as I have finally dropped the code in linux-next
and other people are looking at it.

At a quick fix looks correct to me.

> Fixes: 905ae01c4ae2 ("Add a reference to ucounts for each cred")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
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
