Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51A13330F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhCIVbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:31:04 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:40198 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhCIVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:30:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lJjwI-002YEr-EK; Tue, 09 Mar 2021 14:30:50 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lJjwH-00FGKw-E3; Tue, 09 Mar 2021 14:30:50 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Palash Oswal <oswalpalash@gmail.com>, akpm@linux-foundation.org,
        dave@stgolabs.net, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rppt@linux.vnet.ibm.com, sds@tycho.nsa.gov,
        syzkaller-bugs@googlegroups.com
References: <CAGyP=7dpTbbj39uO37YrNMg9h4Nzmkszc3MoZg9n8ALir_A52g@mail.gmail.com>
        <YEZcVKbPzfMVK2aK@zeniv-ca.linux.org.uk>
        <CAGyP=7fHhyrTP-u0tqCy5ZHzZN0v_0dAoj6dCHnFuBbqtfnBmQ@mail.gmail.com>
        <YEeFYMcdPVNrKRJT@zeniv-ca.linux.org.uk>
Date:   Tue, 09 Mar 2021 15:30:52 -0600
In-Reply-To: <YEeFYMcdPVNrKRJT@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Tue, 9 Mar 2021 14:25:36 +0000")
Message-ID: <m1y2ewxbeb.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lJjwH-00FGKw-E3;;;mid=<m1y2ewxbeb.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+HjtweDKY1K86sC4DDB32cQP+KXJFBrcI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2994]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 500 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 8 (1.7%), parse: 0.94 (0.2%),
         extract_message_metadata: 10 (2.0%), get_uri_detail_list: 0.92 (0.2%),
         tests_pri_-1000: 8 (1.6%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 110 (22.0%), check_bayes:
        107 (21.5%), b_tokenize: 5 (1.0%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 1.80 (0.4%), b_tok_touch_all: 90 (18.1%), b_finish: 0.98
        (0.2%), tests_pri_0: 348 (69.5%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.67 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: kernel panic: Attempted to kill init!
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Tue, Mar 09, 2021 at 11:29:14AM +0530, Palash Oswal wrote:
>
>> I observe the following result(notice the segfault in systemd):
>> root@sandbox:~# ./repro
>> [    9.457767] got to 221
>> [    9.457791] got to 183
>> [    9.459144] got to 201
>> [    9.459471] got to 208
>> [    9.459773] got to 210
>> [    9.462602] got to 270
>> [    9.488551] systemd[1]: segfault at 7ffe59fd7fb8 ip
>> 000055be8f20b466 sp 00007ffe59fd7fc0 error 6 in
>> systemd[55be8f15f000+ed000]
>> [    9.490723] Code: 00 00 00 00 41 57 41 56 41 55 41 54 55 53 89 fd
>> 48 81 ec 48 01 00 00 64 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00
>> 00 31 c0 <e8> f5 bf f7 ff 83 f8 01 0f 84 b7 00 00 00 48 8d 9c 240
>> [    9.492637] Kernel panic - not syncing: Attempted to kill init!
>> exitcode=0x0000000b
>
> Lovely.  So something in that sequence of syscalls manages to trigger
> segfault in unrelated process.  What happens if you put it to sleep
> right after open_by_handle_at() (e.g. by read(2) from fd 0, etc.)?

There is the creation of at least one file.  I wonder if inotify or
another notification mechanism is being triggered in systemd, and
systemd handling the notification badly and falling over.

Eric

