Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37EB376A22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhEGSpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 14:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGSpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 14:45:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8280AC061574;
        Fri,  7 May 2021 11:44:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620413042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7rJ0dlFmG2nBfHC2MLUNYWbqEOUVFlJXYjrKpA8y4U=;
        b=ERXnZvWfiwqAMqFp6VAA1kNnf+uuuYuSr+8nEiIcCK13DKl8wnHmpA6HzRHMCMvJCWvVyZ
        WjOCCNlSx4bMEpEXx3i+KyNMKMtSsDPmbrSGutRNcOkCmNASVxTl778jtVA1PxWywvkcVs
        8236SBDHXrN/2jNOEnZV6aC5g7MWZAM15NZyw1JbdLGs7egeG6AkjfBLVL+2ZqUcmj753g
        3/PRmdZIMKygWfTg9nyriqKSGkm6OOq7eURrtQ3wx6+FwgDu+mBWAY9Q66++tFOIBZMSgp
        S4NgF1Oyxg5UM36Ce9/rExtoFsFQtHbUoD92frrrsgBQBWAmDQO2vpzUHpMvSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620413042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7rJ0dlFmG2nBfHC2MLUNYWbqEOUVFlJXYjrKpA8y4U=;
        b=+3YcQRLt0Hifq5eZj4aSejW5/SSBEi1Gr3EAqhWloe7lXnBWPI8zsit6up03b/va7agqdI
        02kHDiNiezLmd4Dg==
To:     Dave Hansen <dave.hansen@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Len Brown <lenb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-abi@vger.kernel.org,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <5d3d513b-77d6-e2e2-779e-ff3ea33deba3@intel.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com> <87bl9s8kfb.fsf@oldenburg.str.redhat.com> <5d3d513b-77d6-e2e2-779e-ff3ea33deba3@intel.com>
Date:   Fri, 07 May 2021 20:44:02 +0200
Message-ID: <87o8dmmljh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03 2021 at 06:43, Dave Hansen wrote:
> On 5/2/21 10:18 PM, Florian Weimer wrote:
>>> 5. If the feature is enabled in XCR0, the user happily uses it.
>>>
>>>     For AMX, Linux implements "transparent first use"
>>>     so that it doesn't have to allocate 8KB context switch
>>>     buffers for tasks that don't actually use AMX.
>>>     It does this by arming XFD for all tasks, and taking a #NM
>>>     to allocate a context switch buffer only for those tasks
>>>     that actually execute AMX instructions.
>> What happens if the kernel cannot allocate that additional context
>> switch buffer?
>
> Well, it's vmalloc()'d and currently smaller that the kernel stack,
> which is also vmalloc()'d.  While it can theoretically fail, if it
> happens you have bigger problems on your hands.

Such a buffer allocation might also exceed a per process/cgroup
limitation. Anything else which is accounted happens in syscall context
which then returns an error on which the application can react.

So what's the consequence when the allocation fails? Kill it right away
from #NM? Kill it on the first signal? Do nothing and see what happens?

Thanks,

        tglx


