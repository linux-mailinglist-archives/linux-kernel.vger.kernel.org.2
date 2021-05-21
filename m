Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFFD38C9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhEUPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:18:30 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40018 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhEUPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:18:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lk6tY-009KEL-Ry; Fri, 21 May 2021 09:17:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lk6tX-00ATj1-Is; Fri, 21 May 2021 09:17:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, serge@hallyn.com, dwalsh@redhat.com,
        christian.brauner@ubuntu.com
References: <20210510130011.1441834-1-gscrivan@redhat.com>
Date:   Fri, 21 May 2021 10:16:43 -0500
In-Reply-To: <20210510130011.1441834-1-gscrivan@redhat.com> (Giuseppe
        Scrivano's message of "Mon, 10 May 2021 15:00:08 +0200")
Message-ID: <m1o8d4xgkk.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lk6tX-00ATj1-Is;;;mid=<m1o8d4xgkk.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19X8ggA/aTj4cVjjFgZ0y+UV091oOEgFb0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4900]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Giuseppe Scrivano <gscrivan@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 695 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.5%), b_tie_ro: 9 (1.2%), parse: 0.98 (0.1%),
         extract_message_metadata: 3.8 (0.5%), get_uri_detail_list: 1.50
        (0.2%), tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.27 (0.2%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 102 (14.7%), check_bayes:
        99 (14.3%), b_tokenize: 11 (1.6%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 4.1 (0.6%), b_tok_touch_all: 60 (8.7%), b_finish: 12
        (1.8%), tests_pri_0: 530 (76.3%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 3.7 (0.5%), poll_dns_idle: 1.09 (0.2%), tests_pri_10:
        4.3 (0.6%), tests_pri_500: 27 (3.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/3] new mode 'shadow' for /proc/PID/setgroups
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Scrivano <gscrivan@redhat.com> writes:

> This series is based on some old patches I've been playing with some
> years ago, but they were never sent to lkml as I was not sure about
> their complexity/usefulness ratio.  It was recently reported by
> another user that these patches are still useful[1] so I am submitting
> the last version and see what other folks think about this feature.
>
> Since the fix for CVE-2014-8989 in order to set a gids mapping for a
> user namespace when the user namespace owner doesn't have CAP_SETGID
> in its parent, it is necessary to first disable setgroups(2) through
> /proc/PID/setgroups.
>
> Setting up a user namespace with multiple IDs mapped into is usually
> done through the privileged helpers newuidmap/newgidmap.
> Since these helpers run either as setuid or with CAP_SET[U,G]ID file
> capabilities, it is not necessary to disable setgroups(2) in the
> created user namespace.  The user running in the user namespace can
> use setgroups(2) and drop the additional groups that it had initially.
>
> This is still an issue on systems where negative groups ACLs, i.e. the
> group permissions are more restrictive than the entry for the other
> categories, are used.  With such configuration, allowing setgroups(2)
> would cause the same security vulnerability described by
> CVE-2014-8989.

Do you have any experience or any documentation about systems that are
using groups to deny access?

There are some deployments somewhere, but last I looked they were rare
enough that the intersection between systems using groups to deny access
and systems deploying containers could reasonably be assumed to be the
empty set?

Before we seriously consider merging a change like this I believe we
need some references to actual deployed systems.  As adding a feature
that is designed around a premise of a security model that people
are not using will likely lead to poor testing, poor review and
not enough feedback to get the rough edges off.


I suspect systems need to preserve some set of groups released from
the restriction of needing to preserve negative groups could result
in a very different result.

Eric
