Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52F33FA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhCQVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhCQVky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:40:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2274BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:40:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616017245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7PVxEzHYsLnxah0gzyCFe+cmVyIcqo7hj3sN52SqI8=;
        b=mnfv0jBJCAeP+jnSUwUPpWjfObnSDQ+Zos2AbJlvZQtN7cRHuVDa4bw2MGU5H+59d4t2bg
        MfNbeeXumAFbVUWp1sl+cnf65myyTfNs+Xo3TYCd85YRnC+eyPrD1B2p2j7/WKo2iHEp3w
        YKpfoJw35N68zj/09e0mxTX1MFOej7rxD8VNWYYqgGOfIiQzMFKEFJLoT1c36HHta9Dwpo
        he8ot9kuX5impJGd33F1l86Qysk6An/ENxy0pMppnIQFRsP7Etji1JczVNdJFCa41cCXv5
        3bld9IfwWtQdKFO415TPGLzdL7uUn8zhw2xxH68eiJ7lmgamyofl4aCDefOsfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616017245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7PVxEzHYsLnxah0gzyCFe+cmVyIcqo7hj3sN52SqI8=;
        b=FNKY+DSFvE8DNiUI1m3W+pDCmP7e9bIF6djOMLaqrSU9L5lbCPuDmi5V44QHdV3vUwBFTS
        snpZsx2qvSZKq9DQ==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] x86/apic: Do not make an exception for PIC_CASCADE_IR when marking legacy irqs in irq_matrix
In-Reply-To: <87blbhxyvk.fsf@nanos.tec.linutronix.de>
References: <20210219113101.967508-1-vkuznets@redhat.com> <20210219113101.967508-2-vkuznets@redhat.com> <87im5py1ty.fsf@nanos.tec.linutronix.de> <87blbhxyvk.fsf@nanos.tec.linutronix.de>
Date:   Wed, 17 Mar 2021 22:40:45 +0100
Message-ID: <878s6lxxuq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 22:18, Thomas Gleixner wrote:

> On Wed, Mar 17 2021 at 21:14, Thomas Gleixner wrote:
>> On Fri, Feb 19 2021 at 12:31, Vitaly Kuznetsov wrote:
>> Even without looking at the machine I can tell you what's going on. MP
>> config or ACPI has a pin assigned to IRQ 2 which I've not seen before.
>> The code there is ignoring IRQ 2 because that's how the original code
>> worked as well as it is reserved for the PIC_CASCADE_IRQ which should
>> never fire and we actually want to catch an spurious interrupt on it.
>>
>> So depending on the overall configuration of that system and the
>> resulting delivery modes this might be ok, but I'm really nervous about
>> doing this wholesale as it might break old machines.
>>
>> Out of paranoia I'd rather ignore that IO/APIC pin completely if it
>> claims to be IRQ2. I assume there is no device connected to it at all,
>> right?
>
> Seems at some point we lost the 'ignore cascade IRQ' logic in
> IO/APIC. There is still a comment to that effect.
>
> Let me do some archaeology.

af174783b925 ("x86: I/O APIC: Never configure IRQ2")

has a very nice explanation why.

Back then the logic was quite different. All legacy PIC interrupts
(0-15) were bound to the legacy vectors at boot and never moved away.

There was a check in the back then setup routing which prevented the
IOAPIC routing of IRQ2 which got lost at some point. Haven't figured out
yet where this might be. Still digging in those ancient horrors.

Thanks,

        tglx

