Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1F417909
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbhIXQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:46:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58756 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbhIXQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:46:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:41616)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mToK4-00DD1A-6l; Fri, 24 Sep 2021 10:45:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:48876 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mToK2-00GHdg-8U; Fri, 24 Sep 2021 10:45:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian@brauner.io>
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
        <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
        <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com>
        <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com>
        <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com>
        <CALgW_8WHq051ifcYPta5reoVZ10=fA5Rb1EZuyaievK+OUw99Q@mail.gmail.com>
        <CAJqdLrpxnMThqersqiVsTNr1Y25V8jmDcW_sKWi0ziJXCsi2gw@mail.gmail.com>
        <87y2ab9w8u.fsf@disp2133>
        <00ce7bff-e432-8244-1765-12460817baab@colorfullife.com>
Date:   Fri, 24 Sep 2021 11:45:07 -0500
In-Reply-To: <00ce7bff-e432-8244-1765-12460817baab@colorfullife.com> (Manfred
        Spraul's message of "Thu, 23 Sep 2021 18:36:16 +0200")
Message-ID: <87pmsxorcc.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mToK2-00GHdg-8U;;;mid=<87pmsxorcc.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18aWtGQ0imt7CbQjqrTDEas2KQJw3Y/wn8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_00,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3287]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_00 obfuscated drug references
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Manfred Spraul <manfred@colorfullife.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1321 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.3%), b_tie_ro: 2.4 (0.2%), parse: 0.65
        (0.0%), extract_message_metadata: 8 (0.6%), get_uri_detail_list: 0.68
        (0.1%), tests_pri_-1000: 4.1 (0.3%), tests_pri_-950: 1.04 (0.1%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 86 (6.5%), check_bayes: 85
        (6.4%), b_tokenize: 4.6 (0.4%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        1.51 (0.1%), b_tok_touch_all: 71 (5.4%), b_finish: 0.65 (0.0%),
        tests_pri_0: 1207 (91.4%), check_dkim_signature: 0.36 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.60 (0.0%), tests_pri_10:
        1.74 (0.1%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace was changed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> Hi Eric,
>
> I'd like to restart the discussion, the issue should be fixed.

Agreed.

I am going to come right out and say having read through everything
my suggests were confused and wrong.

Somehow I thought the cleanups I was suggesting world result in
shm_clist only being modified from the task that owns the list.
Which would result in no need to use a per-task list.

Having looked through my suggestions again I was completely wrong.

The only useful bit I have to contribute from that original suggestion
is let's please have smallish patches that change one thing at a time.

That code is sufficiently interesting that it is way too easy to get
lost in big patches.


I am not going to discuss my broken suggestions right now because every
time I look into them I go into a rabbit hole and I don't get anything
productive done on fixing these issues, just something close and
frustrating.  Apologies if I derailed your patch.

Eric
