Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98B73074CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhA1L2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhA1L12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:27:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75262C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:26:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611833207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6rJRBaXyy5q04HD57q0d3mAKdDTOQkUbore1edzQL8=;
        b=Reajy2jAn+7wUtsKPgLYID8qfMQ+NTFIiaOorsS5LVU7TUoMzizs4FNej/RHVbZldBuU7Y
        bQ0q1Ihumcz5JRwBYKgKP5Omy1jIPoaYJLqU4GRLK8Il315aKTKoxrC8fUUIkPznIxy/Om
        FIqnUZFhSXvfNRAwrI1PteZ9sqhRQpGXu2HRF2aqDdWisWnM01n+ARQRuZ57QMn4Eac5J0
        HY5TPEY55uyCxIwFJjWGX988RnIV8IwvZycncZjTMUt7MY2TKZXhlgXhAApv6SRE3M7XkH
        La481eWXde65cgGitbFfNsGTD/altkGskWTWv7J3SdgTQ05rW5GcTfiR1PFhpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611833207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6rJRBaXyy5q04HD57q0d3mAKdDTOQkUbore1edzQL8=;
        b=yBKzagERw9RookkHaXUHEtEqKfSQlu4fcGHEXn6fbn8DDqvFfx71wP0pe3BwsP0JqJp8yO
        s05eLUd1N9VIt5Cg==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
In-Reply-To: <YBJ2CjN2YntC1o3j@jagdpanzerIV.localdomain>
References: <20210122081311.GA12834@xsang-OptiPlex-9020> <YAr7d6A4CkMpgx+g@alley> <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain> <87bldaaxcc.fsf@jogness.linutronix.de> <YBJ2CjN2YntC1o3j@jagdpanzerIV.localdomain>
Date:   Thu, 28 Jan 2021 12:32:46 +0106
Message-ID: <87czxpmhe1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> # modprobe rcutorture onoff_interval=3 onoff_holdoff=30 torture_type=tasks
>> 
>> (Those are the same modprobe parameters used by the lkp job.)
>> 
>> After about a minute I see:
>> 
>> [   47.268292] tasks-torture: rcu_torture_read_exit: Start of episode
>> [   51.273365] tasks-torture: rcu_torture_read_exit: End of episode
>> [   55.823306] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
>> [   55.824350] tasks-torture:torture_onoff task: online 0 failed: errno -5
>> [   55.830661] tasks-torture:torture_onoff task: online 0 failed: errno -5
>> [   55.848524] tasks-torture:torture_onoff task: online 0 failed: errno -5
>
> Just out of curious, this is seen only with the printk commit in
> question applied?

No. The error messages are not related to the commit. But they are
really the only thing printk'ing when the rcu stall happens. So you
probably do need to see them in order to reproduce this. (Assuming this
is somehow printk related.)

John Ogness

