Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF53437979
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhJVPDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:03:41 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40412 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhJVPDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:03:39 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:46816)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdw2r-003aFJ-0J; Fri, 22 Oct 2021 09:01:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:34440 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdw2p-00Ev8j-A8; Fri, 22 Oct 2021 09:01:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Antoine Martin <antoine@nagafix.co.uk>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <877de6e589.fsf@disp2133>
        <CAHk-=wjAj+wgHXqkcGuQR9xo3C2G569TB2i5PmFLyK6BAkr2_w@mail.gmail.com>
Date:   Fri, 22 Oct 2021 09:59:57 -0500
In-Reply-To: <CAHk-=wjAj+wgHXqkcGuQR9xo3C2G569TB2i5PmFLyK6BAkr2_w@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 21 Oct 2021 17:35:08 -1000")
Message-ID: <87fsst6r6a.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdw2p-00Ev8j-A8;;;mid=<87fsst6r6a.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+trmELuUB54LDvZVfvhFlo7HQc4mnbrD4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4950]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1056 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 17 (1.7%), b_tie_ro: 16 (1.5%), parse: 0.82
        (0.1%), extract_message_metadata: 22 (2.1%), get_uri_detail_list: 0.94
        (0.1%), tests_pri_-1000: 33 (3.1%), tests_pri_-950: 1.52 (0.1%),
        tests_pri_-900: 1.24 (0.1%), tests_pri_-90: 330 (31.2%), check_bayes:
        311 (29.4%), b_tokenize: 6 (0.5%), b_tok_get_all: 104 (9.9%),
        b_comp_prob: 2.3 (0.2%), b_tok_touch_all: 193 (18.3%), b_finish: 1.20
        (0.1%), tests_pri_0: 636 (60.2%), check_dkim_signature: 0.66 (0.1%),
        check_dkim_adsp: 3.2 (0.3%), poll_dns_idle: 1.16 (0.1%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 9 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] ucount fixes for v5.15
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Oct 21, 2021 at 6:04 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>>  kernel/cred.c                | 9 ++++-----
>>  security/keys/process_keys.c | 8 ++++++++
>>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> That's not remotely the right diffstat.
>
> What's going on?

Sigh.  I sent the diffstat from when I sent the additional patches
out for review instead of the diffstat for the entire branch I was
asking you to pull.

I really should have named things differently on my end when I sent
the additional changes out for review.

The correct diffstat should have been.

 include/linux/user_namespace.h |  2 ++
 kernel/cred.c                  |  9 ++++----
 kernel/signal.c                | 25 ++++++---------------
 kernel/ucount.c                | 49 ++++++++++++++++++++++++++++++++++++++++++
 security/keys/process_keys.c   |  8 +++++++
 5 files changed, 69 insertions(+), 24 deletions(-)


> The shortlog was correct, and I pulled the branch, because everything
> else looked ok, but that diffstat in the pull request was some
> complete fantasy.
>
> If I were to guess, I think the diffstat may be everything _but_ that
> first ("ucounts: Fix signal ucount refcounting") fix. I just don't see
> how/why you'd get that as part of the pull request.

You are exactly right.

My apologies for the confusion.
Eric
