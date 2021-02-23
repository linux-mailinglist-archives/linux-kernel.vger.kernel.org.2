Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAC322524
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhBWFRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:17:41 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47946 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhBWFRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:17:39 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lEQ48-00ABIl-6P; Mon, 22 Feb 2021 22:16:56 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lEQ47-003en1-Dn; Mon, 22 Feb 2021 22:16:55 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Will Deacon <will@kernel.org>
Cc:     james.morse@arm.com, jmorris@namei.org,
        tyhicks@linux.microsoft.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        kernel-team@android.com
References: <20210219195142.13571-1-pasha.tatashin@soleen.com>
        <161399720788.2051103.17455817952511939013.b4-ty@kernel.org>
Date:   Mon, 22 Feb 2021 23:16:38 -0600
In-Reply-To: <161399720788.2051103.17455817952511939013.b4-ty@kernel.org>
        (Will Deacon's message of "Mon, 22 Feb 2021 14:29:01 +0000")
Message-ID: <m1im6jmki1.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lEQ47-003en1-Dn;;;mid=<m1im6jmki1.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/njm8oIeOFBiruLt6tVNkQHTfo43YCCvM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMGappySubj_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3320]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Will Deacon <will@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 267 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (4.2%), b_tie_ro: 10 (3.6%), parse: 0.99
        (0.4%), extract_message_metadata: 3.6 (1.3%), get_uri_detail_list:
        1.27 (0.5%), tests_pri_-1000: 3.6 (1.4%), tests_pri_-950: 1.25 (0.5%),
        tests_pri_-900: 1.07 (0.4%), tests_pri_-90: 55 (20.6%), check_bayes:
        54 (20.1%), b_tokenize: 5.0 (1.9%), b_tok_get_all: 6 (2.2%),
        b_comp_prob: 1.84 (0.7%), b_tok_touch_all: 38 (14.2%), b_finish: 0.81
        (0.3%), tests_pri_0: 169 (63.4%), check_dkim_signature: 0.45 (0.2%),
        check_dkim_adsp: 3.4 (1.3%), poll_dns_idle: 1.80 (0.7%), tests_pri_10:
        3.2 (1.2%), tests_pri_500: 9 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] kexec: move machine_kexec_post_load() to public interface
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> writes:

> On Fri, 19 Feb 2021 14:51:42 -0500, Pavel Tatashin wrote:
>> machine_kexec_post_load() is called after kexec load is finished. It must
>> declared in public header not in kexec_internal.h
>> 
>> Fixes the following compiler warning:
>> 
>> arch/arm64/kernel/machine_kexec.c:62:5: warning: no previous prototype for
>> function 'machine_kexec_post_load' [-Wmissing-prototypes]
>>    int machine_kexec_post_load(struct kimage *kimage)
>
> Applied to arm64 (for-next/fixes), thanks!
>
> [1/1] kexec: move machine_kexec_post_load() to public interface
>       https://git.kernel.org/arm64/c/2596b6ae412b

As you have already applied this it seems a bit late,
but I will mention that change could legitimately have the following
tag.

Fixes: de68e4daea90 ("kexec: add machine_kexec_post_load()")

So far arm64 is the only implementation of that hook.

Eric
