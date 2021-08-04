Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A453E08F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbhHDTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:48:58 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46084 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhHDTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:48:55 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:38462)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mBMsb-00G5UJ-3o; Wed, 04 Aug 2021 13:48:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43610 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mBMsa-00AESH-1k; Wed, 04 Aug 2021 13:48:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210730062854.3601635-1-svens@linux.ibm.com>
        <YQn+GomdRCoYc/E8@Ryzen-9-3900X.localdomain>
Date:   Wed, 04 Aug 2021 14:47:57 -0500
In-Reply-To: <YQn+GomdRCoYc/E8@Ryzen-9-3900X.localdomain> (Nathan Chancellor's
        message of "Tue, 3 Aug 2021 19:40:26 -0700")
Message-ID: <875ywlat5e.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mBMsa-00AESH-1k;;;mid=<875ywlat5e.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DF2GFSI/LRYKxEBZpK6iMObDDI8QO/9M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords,
        XM_B_SpammyWords2 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4921]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Nathan Chancellor <nathan@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 455 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (2.8%), b_tie_ro: 11 (2.4%), parse: 1.29
        (0.3%), extract_message_metadata: 5 (1.2%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 5.0 (1.1%), tests_pri_-950: 1.79 (0.4%),
        tests_pri_-900: 1.34 (0.3%), tests_pri_-90: 134 (29.5%), check_bayes:
        132 (28.9%), b_tokenize: 9 (2.0%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 3.2 (0.7%), b_tok_touch_all: 107 (23.5%), b_finish: 1.10
        (0.2%), tests_pri_0: 253 (55.7%), check_dkim_signature: 0.76 (0.2%),
        check_dkim_adsp: 3.4 (0.7%), poll_dns_idle: 0.71 (0.2%), tests_pri_10:
        5 (1.1%), tests_pri_500: 24 (5.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] ucounts: add missing data type changes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:

> On Fri, Jul 30, 2021 at 08:28:54AM +0200, Sven Schnelle wrote:
>> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
>> changed the data type of ucounts/ucounts_max to long, but missed to
>> adjust a few other places. This is noticeable on big endian platforms
>> from user space because the /proc/sys/user/max_*_names files all
>> contain 0.
>> 
>> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>
> This patch in -next as commit e43fc41d1f7f ("ucounts: add missing data type
> changes") causes Windows Subsystem for Linux to fail to start:
>
> [error 0x8007010b when launching `wsl.exe -d Arch'] Could not access starting
> directory "\\wsl$\Arch\home\nathan"
>
> Specifically, it is the change to max_user_watches in
> fs/notify/inotify/inotify_user.c, as the below diff gets me back to working.
> Unfortunately, I have no additional information to offer beyond that as WSL's
> init is custom and closed source (as far as I am aware) and there are no real
> debugging utilities.

Could you try this patch and tell us what value is being set?

The only think I can imagine is that someone wants unlimited watches and
sets the value to a ridiculously large value and the interpretation of
that value winds up being different between int and long.

This should allow you to read either dmesg or the kernel's log as it
boots up and see what value is being written.  From there it should
be relatively straight forward to figure out what is going on.

Thank you,
Eric


diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 272f4a272f8c..733c4cfa1f60 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -975,6 +975,14 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 		.min = (int *) table->extra1,
 		.max = (int *) table->extra2,
 	};
+#if 1
+	size_t lenv = *lenp;
+	if (write && (lenv > 0) && (lenv < INT_MAX)) {
+		int len = lenv;
+		printk(KERN_EMERG "intvec: %s <- %*.*s\n",
+			table->procname, len, len, (char *)buffer);
+	}
+#endif
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
 }
