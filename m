Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8D455B58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbhKRMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:18:41 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55826 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344576AbhKRMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:18:03 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AICF275098294;
        Thu, 18 Nov 2021 21:15:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 18 Nov 2021 21:15:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AICF1F3098286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Nov 2021 21:15:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
Date:   Thu, 18 Nov 2021 21:14:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] vt: Fix sleeping functions called from atomic context
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <df266c83-88df-4d1a-5c7e-ea0214f3de3b@i-love.sakura.ne.jp>
 <77983591.hkYTjcaLry@localhost.localdomain>
 <1825634.Qa45DEmgBM@localhost.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <1825634.Qa45DEmgBM@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/18 18:38, Fabio M. De Francesco wrote:
>> Actually, we don't care of start_tty(). It's not in the path that triggers sleeping in atomic bug.
>> According to Syzbot report and to my ftrace analysis it's __start_tty() that is called by 
>> n_tty_ioctl_helper(), and it is this function that acquires a spinlock and disables interrupts. 
>>
>> I must admit that I've never used git-blame and I'm not sure to understand what you did here :(

I just dumped the source code as of before these commits.

> 
> I've had a chance to look both at commit c545b66c6922 and f9e053dcfc02. They are so strictly 
> related (same code. same author, same date) that I'm not anymore sure of which is to blame.
> 
> However, at this moment I'm scarcely interested in figuring out which one actually is responsible 
> for this issue.

Commit f9e053dcfc02b0ad ("tty: Serialize tty flow control changes with flow_lock") is responsible,
for that commit says

  Split out unlocked __start_tty()/__stop_tty() flavors for use by
  ioctl(TCXONC) in follow-on patch.

and syzbot is hitting n_tty_ioctl_helper(tty, TCXONC, TCOON) path.

>>> Well, how to fix? Introduce a new flag for indicating "starting" state (like drivers/block/loop.c uses Lo_* state) ?
>>
>> I think this is not the correct fix, but I might very well be wrong...
> 
> I've read (again) the code that you mentioned. I've changed my mind about it.
> Now I think that a flag like that could be useful if there are no other means to
> lock __start_tty() and __stop_tty() critical sections.

If ->flow.lock were held from only schedulable context, replacing this spinlock with
a mutex would be possible. But stop_tty() says "may be called from any context" which
means that we can't use a mutex...

Making do_con_write() no-op when called with IRQs disabled would be the minimal change
that can silence the syzbot. But this does not fix the regression for drivers/tty/n_hdlc.c
introduced by f9e053dcfc02b0ad.

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	struct vt_notifier_param param;
 	bool rescan;
 
-	if (in_interrupt())
+	if (in_interrupt() || irqs_disabled())
 		return count;
 
 	console_lock();
@@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vc_data *vc;
 
-	if (in_interrupt())	/* from flush_to_ldisc */
+	if (in_interrupt() || irqs_disabled())	/* from flush_to_ldisc */
 		return;
 
 	/* if we race with con_close(), vt may be null */

According to scripts/get_maintainer.pl , Greg and Jiri are maintainers for the n_hdlc driver.
Greg and Jiri, what do you think? Is sacrificing ability to write to consoles when
n_hdlc_send_frames() is called from __start_tty() path considered tolerable? (Maybe
OK for now and stable kernels, for nobody was reporting this problem suggests that
nobody depends on this ability.)

But if we must fix the regression for drivers/tty/n_hdlc.c , we need to use something
like https://lkml.kernel.org/r/7d851c88-f657-dfd8-34ab-4891ac6388dc@i-love.sakura.ne.jp
in order to achieve what f9e053dcfc02b0ad meant. That is, extend tty->stopped in order
to be able to represent "started state (currently indicated by tty->stopped == false)",
"stopped state (currently indicated by tty->stopped == true)" and "changing state
(currently impossible due to bool)", but this approach might need to touch many locations,
and I worry that touching many locations introduces some oversight bugs.

