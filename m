Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88536351ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhDASDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:03:01 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36320 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbhDARsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:48:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lS1QF-00BMjZ-Mk; Thu, 01 Apr 2021 11:47:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lS1QE-00063A-Tr; Thu, 01 Apr 2021 11:47:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Hunt <johunt@akamai.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20210401033156.7262-1-johunt@akamai.com>
        <m15z16r583.fsf@fess.ebiederm.org> <202104010039.A134EC56@keescook>
Date:   Thu, 01 Apr 2021 12:47:54 -0500
In-Reply-To: <202104010039.A134EC56@keescook> (Kees Cook's message of "Thu, 1
        Apr 2021 00:50:57 -0700")
Message-ID: <m1v995q4l1.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lS1QE-00063A-Tr;;;mid=<m1v995q4l1.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+9kKaosOHZQa/CHlshDAMlvxbI/RV1V68=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 302 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (1.5%), b_tie_ro: 3.0 (1.0%), parse: 1.01
        (0.3%), extract_message_metadata: 14 (4.7%), get_uri_detail_list: 1.60
        (0.5%), tests_pri_-1000: 32 (10.5%), tests_pri_-950: 1.18 (0.4%),
        tests_pri_-900: 0.81 (0.3%), tests_pri_-90: 69 (22.7%), check_bayes:
        66 (22.0%), b_tokenize: 4.1 (1.4%), b_tok_get_all: 5 (1.8%),
        b_comp_prob: 1.31 (0.4%), b_tok_touch_all: 53 (17.5%), b_finish: 0.75
        (0.2%), tests_pri_0: 170 (56.3%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.1 (0.7%), poll_dns_idle: 0.48 (0.2%), tests_pri_10:
        1.78 (0.6%), tests_pri_500: 5 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] psi: allow unprivileged users with CAP_SYS_RESOURCE to write psi files
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Mar 31, 2021 at 11:36:28PM -0500, Eric W. Biederman wrote:
>> Josh Hunt <johunt@akamai.com> writes:
>> 
>> > Currently only root can write files under /proc/pressure. Relax this to
>> > allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
>> > able to write to these files.
>> 
>> The test for CAP_SYS_RESOURCE really needs to be in open rather
>> than in write.
>> 
>> Otherwise a suid root executable could have stdout redirected
>> into these files.
>
> Right. Or check against f_cred. (See uses of kallsyms_show_value())
> https://www.kernel.org/doc/html/latest/security/credentials.html#open-file-credentials

We really want to limit checking against f_cred to those cases where we
break userspace by checking in open.  AKA the cases where we made the
mistake of putting the permission check in the wrong place and now can't
fix it.

Since this change is change the permissions that open uses already I
don't see any reason we can't perform a proper check in open.

Eric
