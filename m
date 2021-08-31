Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D843FCD44
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhHaS4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:56:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53208 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhHaS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:56:24 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:45162)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mL8us-008tdj-S0; Tue, 31 Aug 2021 12:55:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39700 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mL8ur-005lKV-1F; Tue, 31 Aug 2021 12:55:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, Cyril Hrubis <chrubis@suse.cz>,
        Kees Cook <keescook@chromium.org>
References: <87bl5d7chn.fsf@disp2133>
Date:   Tue, 31 Aug 2021 13:55:17 -0500
In-Reply-To: <87bl5d7chn.fsf@disp2133> (Eric W. Biederman's message of "Tue,
        31 Aug 2021 12:25:24 -0500")
Message-ID: <87bl5d5tre.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mL8ur-005lKV-1F;;;mid=<87bl5d5tre.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+GGHGwyh8QCfoZcIpDvV/UTNp8oRy3T3o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3493]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1248 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.9%), b_tie_ro: 9 (0.8%), parse: 0.78 (0.1%),
         extract_message_metadata: 11 (0.9%), get_uri_detail_list: 0.79 (0.1%),
         tests_pri_-1000: 14 (1.1%), tests_pri_-950: 1.24 (0.1%),
        tests_pri_-900: 0.99 (0.1%), tests_pri_-90: 62 (5.0%), check_bayes: 61
        (4.9%), b_tokenize: 4.4 (0.4%), b_tok_get_all: 5.0 (0.4%),
        b_comp_prob: 1.50 (0.1%), b_tok_touch_all: 46 (3.7%), b_finish: 0.85
        (0.1%), tests_pri_0: 1131 (90.6%), check_dkim_signature: 0.51 (0.0%),
        check_dkim_adsp: 2.9 (0.2%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        3.5 (0.3%), tests_pri_500: 11 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] exit cleanups for v5.15-rc1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Please pull the exit-cleanups-for-v5.15 branch from the git tree:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.15
>
>   HEAD: d21918e5a94a862ccb297b9f2be38574c865fda0 signal/seccomp: Dump core when there is only one live thread
>

I failed to mention this pull request has a minor conflict with my
previous pull request.  They both want to add a declaration to the same
place in include/linux/sched/signal.h

Eric
