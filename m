Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909813D93CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhG1RFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:05:23 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56016 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1RFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:22 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:41318)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m8mzc-009twJ-Vr; Wed, 28 Jul 2021 11:05:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42296 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m8mzb-00AVbT-SU; Wed, 28 Jul 2021 11:05:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com,
        syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com,
        syzbot+6cd79f45bb8fa1c9eeae@syzkaller.appspotmail.com,
        syzbot+b6e65bd125a05f803d6b@syzkaller.appspotmail.com
In-Reply-To: <20210728122448.lh2e3nr4txhsmcwt@example.org> (Alexey Gladkov's
        message of "Wed, 28 Jul 2021 14:24:48 +0200")
References: <000000000000efe97f05c74bb995@google.com>
        <20210728025837.1641-1-hdanton@sina.com>
        <20210728122448.lh2e3nr4txhsmcwt@example.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 28 Jul 2021 12:05:08 -0500
Message-ID: <87im0ucqt7.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m8mzb-00AVbT-SU;;;mid=<87im0ucqt7.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX196ZsBb5LCytZ7s0FvmpIS4CCZiP6zUHLA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1914]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 576 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 12 (2.1%), b_tie_ro: 10 (1.7%), parse: 1.21
        (0.2%), extract_message_metadata: 5 (0.9%), get_uri_detail_list: 2.4
        (0.4%), tests_pri_-1000: 4.3 (0.8%), tests_pri_-950: 1.30 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 201 (35.0%), check_bayes:
        200 (34.7%), b_tokenize: 9 (1.5%), b_tok_get_all: 74 (12.9%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 111 (19.2%), b_finish: 0.85
        (0.1%), tests_pri_0: 326 (56.7%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.80 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 12 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1] ucounts: Fix race condition between alloc_ucounts and put_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> On Wed, Jul 28, 2021 at 10:58:37AM +0800, Hillf Danton wrote:
>> On Tue, 27 Jul 2021 17:24:18 +0200 Alexey Gladkov wrote:
>> > +++ b/kernel/ucount.c
>> > @@ -160,6 +160,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
>> >  {
>> >  	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
>> >  	struct ucounts *ucounts, *new;
>> > +	long overflow;
>> >  
>> >  	spin_lock_irq(&ucounts_lock);
>> >  	ucounts = find_ucounts(ns, uid, hashent);
>> > @@ -184,8 +185,12 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
>> >  			return new;
>> >  		}
>> >  	}
>> > +	overflow = atomic_add_negative(1, &ucounts->count);
>> >  	spin_unlock_irq(&ucounts_lock);
>> > -	ucounts = get_ucounts(ucounts);
>> > +	if (overflow) {
>> > +		put_ucounts(ucounts);
>> 
>> Given 		  if (atomic_add_unless(atomic, -1, 1))
>> 			return 0;
>> 
>> put can not help roll back overflow.
>
> In case of overflow, we don't try to rollback overflow. We return an
> error.

Unfortunately I don't see the email with the original comment, but let
me see if I can clarify a little.

The code in get_ucounts explicitly uses atomic_add_negative as a
performance optimization.  Which means just by testing the negative
status of the count it is easy to tell if the count is larger than is
supported.  Where this matters is that atomic_add_negative can be
cheaper than cmpxchg.  Which means it is faster to reserve all of the
negative numbers to catch the case where the counter grows too large,
then to precisely bound the count at a specific cut off.

This particular code path can not use atomic_add_unless(.., -1,...)
get_ucounts may have already hit the limit so it may be a negative value
other than -1.

>> BTW can you specify a bit on the real workloads with the risk of count overflow?

One place where I think it is possible to reach a count of 2^31 is to
set the rlimit for pending signals to unlimited and post a bunch of
realtime signals to a process which simply does not read them.

As pointed out in Alex's link below this code notices when the maximum
count is reached and fails gracefully unlike refcount_t which would leak
memory.

The point is to handle unrealistic workloads gracefully from a reference
counting perspective.  If real workloads start reaching the maximum
count something probably needs to change. (larger counts or changing
what gets counted).

> For example, one user has too many processes in one namespace.
>
> It is necessary to check and handle the possibility of counter overflow
> in this case. Linus described it here:
>
> https://lore.kernel.org/lkml/CAHk-%3dwjYOCgM%2bmKzwTZwkDDg12DdYjFFkmoFKYLim7NFmR9HBg@mail.gmail.com/
>
>> > +		return NULL;
>> > +	}
>> >  	return ucounts;
>> >  }
>> >  
>> > @@ -193,8 +198,7 @@ void put_ucounts(struct ucounts *ucounts)
>> >  {
>> >  	unsigned long flags;
>> >  
>> > -	if (atomic_dec_and_test(&ucounts->count)) {
>> > -		spin_lock_irqsave(&ucounts_lock, flags);
>> > +	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
>> >  		hlist_del_init(&ucounts->node);
>> >  		spin_unlock_irqrestore(&ucounts_lock, flags);
>> >  		kfree(ucounts);
>> > -- 
>> > 2.29.3

Eric

