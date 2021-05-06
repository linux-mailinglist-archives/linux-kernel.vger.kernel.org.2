Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492CA3759B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbhEFRwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:52:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51364 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhEFRwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:52:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lei9W-00F7tC-IE; Thu, 06 May 2021 11:51:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lei9U-0005UH-6d; Thu, 06 May 2021 11:51:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
References: <20210506132827.3198497-1-elver@google.com>
        <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
        <CAKXUXMx4dOSb8xub+JtOR8HBrLi_WtGL+L_+3c-rdQQc3XEPLw@mail.gmail.com>
        <CANpmjNMsbyG7T2+BW2+QEtHnnznOVJQvydddOP+VLQZK8nTG2w@mail.gmail.com>
Date:   Thu, 06 May 2021 12:51:05 -0500
In-Reply-To: <CANpmjNMsbyG7T2+BW2+QEtHnnznOVJQvydddOP+VLQZK8nTG2w@mail.gmail.com>
        (Marco Elver's message of "Thu, 6 May 2021 18:11:40 +0200")
Message-ID: <m1eeej3g52.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lei9U-0005UH-6d;;;mid=<m1eeej3g52.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HFsb2I83TqoqIA50p576He+UTyT2n7UU=
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
        *      [score: 0.4966]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1354 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.2 (0.2%), b_tie_ro: 2.2 (0.2%), parse: 1.11
        (0.1%), extract_message_metadata: 19 (1.4%), get_uri_detail_list: 4.6
        (0.3%), tests_pri_-1000: 16 (1.2%), tests_pri_-950: 0.99 (0.1%),
        tests_pri_-900: 0.84 (0.1%), tests_pri_-90: 97 (7.2%), check_bayes: 96
        (7.1%), b_tokenize: 8 (0.6%), b_tok_get_all: 9 (0.7%), b_comp_prob:
        2.3 (0.2%), b_tok_touch_all: 73 (5.4%), b_finish: 0.77 (0.1%),
        tests_pri_0: 322 (23.8%), check_dkim_signature: 0.41 (0.0%),
        check_dkim_adsp: 2.2 (0.2%), poll_dns_idle: 874 (64.6%), tests_pri_10:
        1.69 (0.1%), tests_pri_500: 888 (65.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] checkpatch: warn about direct use of send_sig_info and force_sig_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Thu, 6 May 2021 at 18:02, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>> On Thu, May 6, 2021 at 5:02 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>> > On Thu, May 6, 2021 at 6:59 PM Marco Elver <elver@google.com> wrote:
>> > >
>> > > Setting up siginfo and using send_sig_info() and force_sig_info()
>> > > directly is discouraged. Instead, new code wanting to generate signals
>> > > should use the appropriate helper specific to the signal.
>> > >
>> > > Eric mentioned that he'd like to make these static at some point, but
>> > > until that can happen, let's try to avoid introducing new users of them.
>> > >
>> > > Cc: Eric W. Biederman <ebiederm@xmission.com>
>> > > Signed-off-by: Marco Elver <elver@google.com>
>> > > ---
>> > > Eric,
>> > >
>> > > While siginfo doesn't need changing often, when it does, it's quite the
>> > > adventure. We now have the various static asserts. The other thing is
>> > > usage of {send,force}_sig_info.
>> > >
>> > > I think the best option right now is to teach checkpatch.pl about it
>> > > until they become static.
>> > >
>> > > Fyi, I noticed one such new user here:
>> > > https://lkml.kernel.org/r/20210421024826.13529-1-wangjunqiang@iscas.ac.cn
>> > >
>> > > Thanks,
>> > > -- Marco
>> > > ---
>> > >  scripts/checkpatch.pl | 6 ++++++
>> > >  1 file changed, 6 insertions(+)
>> > >
>> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> > > index ccb412a74725..3a86aafc3bcd 100755
>> > > --- a/scripts/checkpatch.pl
>> > > +++ b/scripts/checkpatch.pl
>> > > @@ -7153,6 +7153,12 @@ sub process {
>> > >                              "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
>> > >                 }
>> > >
>> > > +# check for direct use of send_sig_info(), force_sig_info()
>> > > +               if ($line =~ /\b((force|send)_sig_info)\(/) {
>> >
>> > I think this might be a little better as:
>> > if ($line =~ /\b((?:force|send)_sig_info)\(/) {
>> >
>> > Otherwise it's good as it is.
>> > Tested-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
>> >
>>
>> Dwaipayan, do you want to also document this new rule on the
>> checkpatch documentation?
>> Marco, maybe you can assist us here with some pointer (lore.kernel.org
>> link) to the original discussion you had.
>
> It started somewhere here:
> https://lkml.kernel.org/r/m17dkjttpj.fsf@fess.ebiederm.org
>
> Eric has the full history here -- if I missed something, hopefully
> he'll nack or ack.

The practical problem is that siginfo_t is a complicated union.

Having fixed many many cases of this there is a very high probability in
making a mistake in filling siginfo_t.  Perhaps 1 in 10 times someone
fills out a siginfo_t manually.  So helpers that take just the
information that is intended to be in the structure as parameters and
fill in that information explicitly are a tremendous help, and let
developers when calling them focus on their actual development.

This all a very slow moving process and we don't have many call sites
for any kind of exception generating signals happen quickly.   Maybe one
or two a year.

I don't mind a checkpatch warning.  But making force_sig_info and
send_sig_info static is probably the better long term approach so people
simply don't have a problematic interface to call.

I will add that the ongoing addtion of SIGTRAP TRAP_PERF is currently
misusing si_errnno in Linus's tree.  We are reviewing and double
checking the fixes now.  Which is pretty much where this conversation
started this time around.

Eric
