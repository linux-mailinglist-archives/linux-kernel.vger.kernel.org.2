Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4F3DBB00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhG3Oq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbhG3Oqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:46:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF3C0613CF;
        Fri, 30 Jul 2021 07:46:44 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627656403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWM7g/MHdOxxc/s3DimjSaz1UmZ27Jw8JVxb2NbbEeo=;
        b=GVUTXY706Ds1lW8XaMWrQL7MMlXRhuV3ro5+Molu4QSaLEUHGNa6C6f5nHIJ9sebuUuk3I
        W79Ae+7dysvi+QQFnWRfJPk1EvZkP/l485IRsvyNRMQyY8n63dLo+JfV4EHZFljIEgEtiu
        PaogBzaKvAcrsCs66q8Tm3USbBIBGzGcsL4Kw9m32LXG9Rd2FaJ721Qha8x+bBKB6NRxez
        LIYU74Vi1R3mkOUf31IajvCXF6qSoQSwI7iYTVeY69lw9D1bK8XB6tnoPmoig52x8hoxkD
        jN8or1dvTGSTiEAIygSKi6G4eEcvK54wKx+9sNEJa2X5gV1P4yY8zyuItBo7Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627656403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWM7g/MHdOxxc/s3DimjSaz1UmZ27Jw8JVxb2NbbEeo=;
        b=Ro/iJy1ukVNFCA69rc4b6HtUpnMD9Ba7KvOop10ADSOCJ18BL6GiqM2BxR3MqASSbPA6Dr
        6MJDaVbL8jMUciAA==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     chao.qin@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, mgross@linux.intel.com, paul.mei@intel.com,
        lili.li@intel.com
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msleep in pr_flush()
In-Reply-To: <20210730140143.53wls2g7xf2ktdgv@linutronix.de>
References: <20210719022649.3444072-1-chao.qin@intel.com> <87mtqiuzd4.fsf@jogness.linutronix.de> <20210730140143.53wls2g7xf2ktdgv@linutronix.de>
Date:   Fri, 30 Jul 2021 16:52:42 +0206
Message-ID: <87k0l7svu5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-30, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2021-07-19 17:01:51 [+0206], John Ogness wrote:
>> On 2021-07-19, chao.qin@intel.com wrote:
>> > --- a/kernel/printk/printk.c
>> > +++ b/kernel/printk/printk.c
>> > @@ -3620,7 +3620,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
>> >  	u64 diff;
>> >  	u64 seq;
>> >  
>> > -	may_sleep = (preemptible() && !in_softirq());
>> > +	may_sleep = (preemptible() && !in_softirq()
>> > +			&& (system_state >= SYSTEM_RUNNING));
>
> I don't have more context but scheduling should work starting with
> SYSTEM_SCHEDULING.

I also thought this, but a quick test shows that is not the case. For
example, init/main.c:kernel_init() is called in preemptible context, but
msleep() will hang if called at the beginning of that function.

John Ogness
