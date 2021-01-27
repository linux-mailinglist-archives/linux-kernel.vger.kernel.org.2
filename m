Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A243067DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhA0X0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:26:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59520 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhA0XYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:24:22 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611789819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dqL5P/tp7Bu87XBE/lq9hDjs4DqDS6GB3IF5aK6fTUs=;
        b=sWImd51V43lQizcuq4iSSb0Y5XzA+eeXb9ODhcGv3ox9gCCwP+UwM4Mwe4YylmkMwXNl9U
        fUMGvj8Iyk7Ej6woS0Cf5ZlsmqJ17/AUTf3VexpR6YPTE/8I7tijEFuCPaYWYzZ9smwTpq
        4zhNZ8DffjNwzaWJyDYHdStquVqA4bb+CBVQn1zDX3p2fmVZn6ZK53LGMkmNCam9va/Pr3
        AaUUmW9LZLN7xUdFJokBe6C5dI4utwMV1ifixlt6kxqfOSDIyI8pyrG1eKGNu998Dfoea/
        iwqEhdTWKb955M0y3BP7nku8XctvdtVu9uTPbthNWkBzsjUSDLPHdZ795w4aDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611789819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dqL5P/tp7Bu87XBE/lq9hDjs4DqDS6GB3IF5aK6fTUs=;
        b=87nlFkmZhChpJu0ZBjE5GnhnVbZxlo3NJcLOWMrSJV5w4ExtgUX3yqN0MXmscACTFurV7T
        FqKJDl58pUPuU9CQ==
To:     "Yu\, Fenghua" <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luck\, Tony" <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Li\, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v4 1/4] x86/cpufeatures: Enumerate #DB for bus lock detection
In-Reply-To: <adf4082ffef7410c961cfe76acc93606@intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com> <20201124205245.4164633-2-fenghua.yu@intel.com> <87wnvydqxi.fsf@nanos.tec.linutronix.de> <adf4082ffef7410c961cfe76acc93606@intel.com>
Date:   Thu, 28 Jan 2021 00:23:37 +0100
Message-ID: <87k0rydkw6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua,

On Wed, Jan 27 2021 at 22:39, Fenghua Yu wrote:
>> On Wed, Jan 27, 2021 2:16 PM, Thomas Gleixner wrote:
>> On Tue, Nov 24 2020 at 20:52, Fenghua Yu wrote:
>> 
>> > A bus lock is acquired though either split locked access to writeback
>> > (WB) memory or any locked access to non-WB memory. This is typically
>> > >1000 cycles slower than an atomic operation within a cache line. It
>> > also disrupts performance on other cores.
>> >
>> > Some CPUs have ability to notify the kernel by an #DB trap after a
>> > user instruction acquires a bus lock and is executed. This allows the
>> > kernel to enforce user application throttling or mitigations.
>> 
>> That's nice, but how does that interact with a data breakpoint on the same
>> location?
>
> If both data breakpoint and bus lock happen on the same location, the bus lock
> is handled first and then the data breakpoint is handled in the same exception:
>
> 1. If warn on bus lock, a rate limited warning is printed for the bus lock and then
>     a SIGTRAP is sent to the user process.
> 2. If fatal on bus lock, a SIGBUS is sent to the user process for the bus lock and a
>     SIGTRAP is also sent to the user process. I think the SIGBUS will be delivered first
>     to the process and then SIGTRAP will be delivered to the process.
> 3. If ratelimit on bus lock, first the tasks in the user sleep for specified time, then
>     SIGTRAP is sent to the user process.
>
> Is the interaction OK?

The ordering is a software choice and fine with me as long as the
hardware actually delivers both.

All of this information needs to be in the changelog of the relevant
patches.

Thanks,

        tglx

