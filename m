Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902D839333C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhE0QMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:12:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45486 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbhE0QMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:12:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lmIaq-0042u2-QA; Thu, 27 May 2021 10:10:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lmIaq-0006bf-3q; Thu, 27 May 2021 10:10:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20210526143805.2549649-1-yangyingliang@huawei.com>
        <m1sg29kuxo.fsf@fess.ebiederm.org>
        <20210527085613.7nnnh3ocwedvcntz@example.org>
Date:   Thu, 27 May 2021 11:10:27 -0500
In-Reply-To: <20210527085613.7nnnh3ocwedvcntz@example.org> (Alexey Gladkov's
        message of "Thu, 27 May 2021 10:56:13 +0200")
Message-ID: <m1mtsgkvik.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lmIaq-0006bf-3q;;;mid=<m1mtsgkvik.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19rdhmrMM1q8jhEbqc0V31SytS0QxGsnJY=
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
        *      [score: 0.4362]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 368 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (4.0%), b_tie_ro: 12 (3.4%), parse: 1.06
        (0.3%), extract_message_metadata: 13 (3.6%), get_uri_detail_list: 1.47
        (0.4%), tests_pri_-1000: 4.9 (1.3%), tests_pri_-950: 1.39 (0.4%),
        tests_pri_-900: 1.17 (0.3%), tests_pri_-90: 100 (27.2%), check_bayes:
        97 (26.4%), b_tokenize: 4.9 (1.3%), b_tok_get_all: 7 (1.9%),
        b_comp_prob: 2.1 (0.6%), b_tok_touch_all: 78 (21.1%), b_finish: 1.55
        (0.4%), tests_pri_0: 207 (56.1%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 3.9 (1.1%), poll_dns_idle: 2.1 (0.6%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 19 (5.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] cred: add missing return error code when set_cred_ucounts() failed
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> On Wed, May 26, 2021 at 05:10:43PM -0500, Eric W. Biederman wrote:
>> Yang Yingliang <yangyingliang@huawei.com> writes:
>> 
>> > If set_cred_ucounts() failed, we need return the error code.
>> 
>> Alex how does this look to you?
>> 
>> This is showing up now as I have finally dropped the code in linux-next
>> and other people are looking at it.
>> 
>> At a quick fix looks correct to me.
>
> Yes, this is the right fix. I miss it.


Can I have your Acked-by or Reviewed-by.
Thank you.

>> > Fixes: 905ae01c4ae2 ("Add a reference to ucounts for each cred")
>> > Reported-by: Hulk Robot <hulkci@huawei.com>
>> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> > ---
>> >  kernel/cred.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/cred.c b/kernel/cred.c
>> > index db7c46bf36e5..e6fd2b3fc31f 100644
>> > --- a/kernel/cred.c
>> > +++ b/kernel/cred.c
>> > @@ -372,7 +372,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>> >  		ret = create_user_ns(new);
>> >  		if (ret < 0)
>> >  			goto error_put;
>> > -		if (set_cred_ucounts(new) < 0)
>> > +		ret = set_cred_ucounts(new);
>> > +		if (ret < 0)
>> >  			goto error_put;
>> >  	}
>> 

Eric
