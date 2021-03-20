Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1C342D34
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 15:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCTN6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhCTN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 09:58:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB746C061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 06:57:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616248673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x8H1V0k5OhUS+mggqNUK8EoniqcnTOxt5Y0BbnyP9xc=;
        b=OtC8iVX//o6rJAj66uF5yAMN9C5Y4ukS6APBRhHYx5AbyT1xtY7lNf6KuLlMSF4bf5/mQV
        rzTn1SiHfZTUkQnP5oI5CM+bQeExJVAq8FJNuTztF0vQAsykHA4c8xSgGZyRFo9S8SZNlk
        9VQ0+4NTqlMz6f473a3cxhPp3qzEN1D847XCi04ZcIrlb9o1Wa63FdxcRNtvPlq/LXVSnX
        Hqbh1gpyFnVtbeLVHbyVsxeMFeJgiNQxaiISlIxR5V04dh7uLdyxUb50P89HXZm6Z8xhIF
        GcXE6EztASwelAVw4SaaZCm5tkTpV+kY5H6pGWZcEObb0GI1Y6W2mn2XmlnkZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616248673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x8H1V0k5OhUS+mggqNUK8EoniqcnTOxt5Y0BbnyP9xc=;
        b=jRq+MduKkeR6CUHYIJWryCG9VcOKdX+pxWM6eeIdkZwBljiDYWN40LtEfODNAvutVDwl1Z
        2mEYwnUOWwk/XSBQ==
To:     "Luck\, Tony" <tony.luck@intel.com>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Li\, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
In-Reply-To: <87k0q2bpu1.fsf@nanos.tec.linutronix.de>
References: <20210313054910.2503968-1-fenghua.yu@intel.com> <20210313054910.2503968-3-fenghua.yu@intel.com> <871rca6dbp.fsf@nanos.tec.linutronix.de> <d98d86f9f5824573b2441089e0c2ae91@intel.com> <87k0q2bpu1.fsf@nanos.tec.linutronix.de>
Date:   Sat, 20 Mar 2021 14:57:52 +0100
Message-ID: <874kh6apwf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20 2021 at 02:01, Thomas Gleixner wrote:

> On Fri, Mar 19 2021 at 21:50, Tony Luck wrote:
>>>  What is the justifucation for making this rate limit per UID and not
>>>  per task, per process or systemwide?
>>
>> The concern is that a malicious user is running a workload that loops
>> obtaining the buslock. This brings the whole system to its knees.
>>
>> Limiting per task doesn't help. The user can just fork(2) a whole bunch
>> of tasks for a distributed buslock attack..
>
> Fair enough.
>
>> Systemwide might be an interesting alternative. Downside would be accidental
>> rate limit of non-malicious tasks that happen to grab a bus lock periodically
>> but in the same window with other buslocks from other users.
>>
>> Do you think that a risk worth taking to make the code simpler?
>
> I'd consider it low risk, but I just looked for the usage of the
> existing ratelimit in struct user and the related commit. Nw it's dawns
> on me where you are coming from.

So after getting real numbers myself, I have more thoughts on
this. Setting a reasonable per user limit might be hard when you want to
protect e.g. against an orchestrated effort by several users
(containers...). If each of them stays under the limit which is easy
enough to figure out then you still end up with significant accumulated
damage.

So systemwide might not be the worst option after all.

The question is how wide spread are bus locks in existing applications?
I haven't found any on a dozen machines with random variants of
workloads so far according to perf ... -e sq_misc.split_lock.

What's the actual scenario in the real world where a buslock access
might be legitimate?

And what's the advice, recommendation for a system administrator how to
analyze the situation and what kind of parameter to set?

I tried to get answers from Documentation/x86/buslock.rst, but ....

Thanks,

        tglx


