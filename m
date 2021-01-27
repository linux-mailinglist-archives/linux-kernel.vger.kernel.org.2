Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1DC3067F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhA0Xbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhA0XbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:31:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FD8C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:29:09 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611790146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ovKlPzpKCMynzgFtEXCUWBxt30oNgDe6PQkZXpXltUA=;
        b=C/tBOjYGSKvMIq4ciJOkKiAxjDcyNQ+81R7SWA7tWAwRiKX0TGdmh/WVQiihEScPSNcXc+
        C1cYSr9oAAGuTDX9K4VQtWoSwIAYYJABGO7IBcHFL+a0aTQjJ5uMgvlnfHZSQ1zcRsJKvG
        X7a1IOxKQpM/exo1QP/N/AHDhot8ROujrqwyA1AdTMEiOaSQMEDXiyJ8GTGyqkpyvD/PwO
        xV/36kZfOPBaQmXNecESa69z2ovJB4aZ5grm60n5uY5sbVeOeXu4r5NCjHWV4rwNv6qmLJ
        TspgAK3key6s8A8KsWqzFdq/ix8f1nB9gQf8LYciO3aT8UD4Pvq9BDIvBq4h4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611790146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ovKlPzpKCMynzgFtEXCUWBxt30oNgDe6PQkZXpXltUA=;
        b=JJFCLAa8lWBu1muEWqTMVrgiMNXfffjAYOQnL5m1DE3P0ielD0T3ncr+RZTA83IQXkZc2D
        hF046Xs3itYu1ICA==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
In-Reply-To: <87bldaaxcc.fsf@jogness.linutronix.de>
References: <20210122081311.GA12834@xsang-OptiPlex-9020> <YAr7d6A4CkMpgx+g@alley> <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain> <87bldaaxcc.fsf@jogness.linutronix.de>
Date:   Thu, 28 Jan 2021 00:35:06 +0106
Message-ID: <878s8eari5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-27, John Ogness <john.ogness@linutronix.de> wrote:
> I was finally able to trigger this by using my workstation

Well, I don't know how reliably I can trigger this. I think my time will
be better spent getting lkp to trigger, since that shows to be reliable.

It took me an hour to trigger this one and I have the feeling I got
lucky with it.

[ 1854.183816] INFO: rcu_tasks detected stalls on tasks:
[ 1854.184502] 0000000036ce200f: .. nvcsw: 0/0 holdout: 1 idle_cpu: -1/1
[ 1854.185234] task:dd              state:R  running task     stack:    0 pid:19891 ppid:   668 flags:0x00000000
[ 1854.185273] Call Trace:
[ 1854.185275]  __schedule+0xfa9/0x1056
[ 1854.185283]  ? firmware_map_remove+0x172/0x172
[ 1854.185300]  ? ksys_write+0x147/0x180
[ 1854.185304]  schedule+0x170/0x1e3
[ 1854.185307]  exit_to_user_mode_prepare+0x27/0xac
[ 1854.185312]  syscall_exit_to_user_mode+0x41/0x4f
[ 1854.185316]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1854.185321] RIP: 0033:0x7f99bf52fc00
[ 1854.185324] RSP: 002b:00007ffd75722bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 1854.185328] RAX: 0000000000000001 RBX: 00007f99bfa1b690 RCX: 00007f99bf52fc00
[ 1854.185331] RDX: 0000000000000001 RSI: 0000560056ce3010 RDI: 0000000000000001
[ 1854.185335] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[ 1854.185338] R10: 00007ffd757229c0 R11: 0000000000000246 R12: 0000560056ce3010
[ 1854.185341] R13: 0000000000000001 R14: 0000560056ce3010 R15: 0000560056ce3010

To generate syscalls and interrupts, "dd" was doing:

    dd if=/dev/zero bs=1 count=100000000 | nc 10.0.2.2 12345

I'm not even sure how to go about debugging this. The only printk load I
can really see are the:

    "tasks-torture:torture_onoff task: online 0 failed: errno -5"

error messages. But they are only occurring at a rate of 40-50 per
second. They are coming from the pr_alert() in kernel/torture.c:174, so
it should still be hitting spinlocks (either from the console driver or
@console_owner_lock).

I will re-focus on reproducing this with lkp.

John Ogness
