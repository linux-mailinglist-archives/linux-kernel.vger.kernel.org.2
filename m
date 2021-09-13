Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229C409F95
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhIMWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhIMWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:21:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:20:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631571603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lu0+SbfjHiOcgPZXbw0IysSWeG75SaeBouN1PbDBmZI=;
        b=hp/7iXGX7n44dTdyvpJTD0IRHoHq9a0+44UxrvH7sj7uEc2jcTE/sD6W0Born2ch6r7j47
        FRI6TDz373Dh9wuxQj+1o91yGkz29g7gU3+9zEh4wYppwTnU7j0MMS50rmlo3RQaWX6yKS
        lnNRuYyou1nlTflakQKHgiirstJKBCX86Cung2232Q8OSQl0pqY2dbO09LZMRHB5Go6FD2
        JyLjvKTYkX2IOUOBePxsvCUiTVgDPHldpCYVXPPeI7p0hwGfeC2+1kaJ1PR+8XaNZbTmsa
        o+/toszLUWIU8X8FWkgIXcdRmuwY2DfQ9AEvqC44rHJeK0J2jJ5Srd5GCPTtCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631571603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lu0+SbfjHiOcgPZXbw0IysSWeG75SaeBouN1PbDBmZI=;
        b=tZec57HziKkqsYs+DDwwW/G25gb73z0LPjbB1zxfZg0e57L+3/rV8t3vA1CzHBLx41dMOI
        xDfcyYUDC+ffcnBw==
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
In-Reply-To: <20210913175428-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com> <875yv4f99j.ffs@tglx>
 <20210913175428-mutt-send-email-mst@kernel.org>
Date:   Tue, 14 Sep 2021 00:20:02 +0200
Message-ID: <87y280dsod.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2021 at 18:01, Michael S. Tsirkin wrote:
> On Mon, Sep 13, 2021 at 11:36:24PM +0200, Thomas Gleixner wrote:
>> >From the interrupt perspective the sequence:
>> 
>>         disable_irq();
>>         vp_dev->intx_soft_enabled = true;
>>         enable_irq();
>> 
>> is perfectly fine as well. Any interrupt arriving during the disabled
>> section will be reraised on enable_irq() in hardware because it's a
>> level interrupt. Any resulting failure is either a hardware or a
>> hypervisor bug.
>
> yes but it's a shared interrupt. what happens if multiple callers do
> this in parallel?

Nothing as each caller is serialized vs. itself and its own interrupt
handler it cares about.

Thanks,

        tglx
