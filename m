Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D874088FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhIMK3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbhIMK3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:29:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6606C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 03:28:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631528895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ykiHoHYVr6MJVC+BEHigFkaiSxAMhCFyD3MDWk5rE4U=;
        b=JgKV1g3IXnqPySAvgrpnErDESL3iApKD2MNRliSUBzndzNYR1eP7/AUuTfZ27HNfo67x74
        JXHUg5nnOkp4ASkQ283KizT0taFgtB+gsaK5GJ8x21S5SbnPjlPGCTbNOzSzSQ5TkR4w/q
        JjgXhja44gBgQJMlGZPKZvkg+tR5dBDL1y+eGr7vVdH300MPsfDi0rmC5EnGbMs3Ah3Jfl
        AGJtSvIL2NiOy1Zg1pwTjZAnwXuOLTEa4wM0AAZfSEzaXYh3/gIiydWODOaO9/Kq7Exxxj
        Q8/lylZpbXEFeA38b69xqhP+0odWNNxJABw0n8YQDeCZOEGPe8OTf8+R0GpXYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631528895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ykiHoHYVr6MJVC+BEHigFkaiSxAMhCFyD3MDWk5rE4U=;
        b=eDY130rAPGpOnJ4rMjUdsrDGIBrRed/uA2ttbJZZn+166Z+N64s3MtM6X5Tvhy5KmAospS
        pKmW9xwEeKCy4QAA==
To:     Hillf Danton <hdanton@sina.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
In-Reply-To: <20210831074532.2255-1-hdanton@sina.com>
References: <000000000000eaacf005ca975d1a@google.com>
 <20210831074532.2255-1-hdanton@sina.com>
Date:   Mon, 13 Sep 2021 12:28:14 +0200
Message-ID: <87mtogg475.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31 2021 at 15:45, Hillf Danton wrote:
> On Mon, 30 Aug 2021 12:58:58 +0200 Dmitry Vyukov wrote:
>>>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
>>>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
>>>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>>>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
>>>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
>>>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
>
> Add debug info only to help kasan catch the timer running longer than 2 ticks.
>
> Is it anything in the right direction, tglx?

Not really. As Dmitry pointed out this seems to be related to
mac80211_hwsim and if you look at the above stacktrace then how is
adding something to the timer wheel helpful?

Thanks,

        tglx
