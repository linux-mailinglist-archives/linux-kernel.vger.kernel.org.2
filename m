Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51FE3080A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhA1VjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:39:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhA1VjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:39:06 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611869903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIzehXtZGVhpB1yHQMfVfz2P5f3f41/m1wLdY+MrNmM=;
        b=qcvkyvR6VnVEjI1jv4KEwpmNS4636JQ+mwxNTSRMcue7o/s7JMWveSFLNlVCoFFAf8Jtt3
        3xO6lzAoWXwGasRwUSHC+0IP7G4pMAHr+LQECEmllfHBaIvclmf8ahREBDIwKSvrSwqgKQ
        cSfbqdioGnKlAfzMd72R2/toWRRvC1YAX/LfLLIkB2bqrI8AD6DvuR2bYAeqMh3t1WLWGw
        //GDJNSqtfp3VlTKQTUN/YPOCbcQ+EK8ygoJ652qwniJAzWJctkXQYbnLZeIYdcTCOs/9W
        +YiC5FOEoa0Xm7d9CFCNnG9l/OhZmy5PqdHFx5UEurgQLy5W5Ri4EiMROsuzgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611869903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIzehXtZGVhpB1yHQMfVfz2P5f3f41/m1wLdY+MrNmM=;
        b=DkxrxorF8qRUTwTJrxxkNkdnEiqEO8c8IGVntc1RgdF1Sbv4erynjXpMfaDBIXsB5hUzxh
        vUFJ/LiXae9RWGDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
In-Reply-To: <871re5m0a2.fsf@jogness.linutronix.de>
References: <20210122081311.GA12834@xsang-OptiPlex-9020> <YAr7d6A4CkMpgx+g@alley> <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain> <87bldaaxcc.fsf@jogness.linutronix.de> <YBJ2CjN2YntC1o3j@jagdpanzerIV.localdomain> <87czxpmhe1.fsf@jogness.linutronix.de> <YBLPhkHQ8cXFiY1X@alley> <877dnxm5ju.fsf@jogness.linutronix.de> <YBLoGNQNMkFivh34@alley> <871re5m0a2.fsf@jogness.linutronix.de>
Date:   Thu, 28 Jan 2021 22:44:22 +0106
Message-ID: <87v9bglp2p.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28, John Ogness <john.ogness@linutronix.de> wrote:
> [  903.189448][  T356] [  778.825864] [  655.250559] [  531.607066] [  407.120936] tasks-torture:torture_onoff task: online 0 failed: errno -5

So I at least found out what these multi-timestamp messages are (thanks
to reading /dev/kmsg). lkp is directing all its test output to
/dev/kmsg. This is why we see messages like:

  2021-01-28 21:15:15 rmmod rcutorture

The final line of its test is "dmesg | grep torture:". So it is dumping
dmesg output into /dev/kmsg! This causes the timestamp to be included in
the text of the new messages so we later see 2 timestamps. After 2
minutes it has reached the messages it fed into /dev/kmsg and feeds them
in again (thus a 3rd timestamp).

Here is a snippet from /dev/kmsg when it starts feeding dmesg into
/dev/kmsg. If the first number is >= 8, it is coming from userspace.

1,24066,323390711,-;tasks-torture:torture_onoff task: online 0 failed: errno -5
1,24067,323444452,-;tasks-torture:torture_onoff task: online 0 failed: errno -5
1,24068,323461363,-;tasks-torture:torture_onoff task: online 0 failed: errno -5
13,24069,323469754,-;2021-01-28 21:15:15 rmmod rcutorture
12,24070,323469775,-;
1,24071,323481652,-;tasks-torture:torture_onoff task: online 0 failed: errno -5
1,24072,323495879,-;tasks-torture:torture_onoff task: online 0 failed: errno -5
1,24073,323503276,-;tasks-torture:torture_onoff task: online 0 failed: errno -5
1,24074,323510766,-;tasks-torture:torture_onoff task: online 0 failed: errno -5
1,24075,323519658,-;tasks-torture:torture_onoff task: online 0 failed: errno -5
13,24076,323522146,-;[  158.513122] tasks-torture:torture_onoff task: online 0 failed: errno -5
12,24077,323522157,-;
13,24078,323526545,-;[  158.519672] tasks-torture:torture_onoff task: online 0 failed: errno -5
12,24079,323526556,-;
13,24080,323529365,-;[  158.534695] tasks-torture:torture_onoff task: online 0 failed: errno -5
12,24081,323529374,-;
13,24082,323531951,-;[  158.549755] tasks-torture:torture_onoff task: online 0 failed: errno -5
12,24083,323531961,-;

I don't know why it is doing the message text with loglevel 5 (NOTICE)
followed by a blank line with loglevel 4 (WARNING), but they are
definitely coming from userspace.

Anyway, enough with that madness. I now will return my focus to the rcu
stall, and see how printk could be responsible.

John Ogness
