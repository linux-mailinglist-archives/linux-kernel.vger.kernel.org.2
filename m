Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E8B383CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEQTDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:03:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54466 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhEQTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:03:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621278117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myO/l3NohTIBqCwn70OccdFIJ7sZQFhlXIgthsPu/L4=;
        b=N3liIZthIKutLGGyusxXejqWA+5qAOCqWMDKcgP6DTA0JOSh2fAAXEG8OVAGYuzP6GfvtT
        xx3HwT9USYkIXlZVwYjtsT15ppknP1Y6cq3I1zo8Q/pyB7JPhGS9VyGBzmVpDbPZWdtRhF
        tViPzvku91idw4s+gwuraEh5oNs+cx2+S5lE/UsmTW9uMS9tDBxS3+KslzdlHbj1xK+fOl
        GYOMBo+ItWuf6u/CCasCJVQozz1jaCmpNAlBT6qG+DF70lVccV5zWVEljwXfN+AVcWND12
        EvUiJzBz54NLcB0Ead0zOG3gqHLXA4CrI3CXFqz4PN+fYzYbHqwO1507yIXC2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621278117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myO/l3NohTIBqCwn70OccdFIJ7sZQFhlXIgthsPu/L4=;
        b=AKMx0cwBhb1RoX+rGBgVMjUS2FRTTRgY5MiTJ3nUyE0yiXkJG+zmWt8xtpZZ9V4fINLZ4q
        Egh+D0xpufts6ZDA==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 0/4] x86/bus_lock: Set rate limit for bus lock
In-Reply-To: <YKK5/fgD4w+TVinx@otcwcpicx3.sc.intel.com>
References: <20210419214958.4035512-1-fenghua.yu@intel.com> <YKK5/fgD4w+TVinx@otcwcpicx3.sc.intel.com>
Date:   Mon, 17 May 2021 21:01:57 +0200
Message-ID: <877djxfal6.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17 2021 at 18:46, Fenghua Yu wrote:
> Hi, Dear X86 maintainers,
>
> On Mon, Apr 19, 2021 at 09:49:54PM +0000, Fenghua Yu wrote:
>> Bus lock warn and fatal handling is in tip. This series sets system
>> wide bus lock rate limit to throttle malicious code.
>> 
>> This series is applied on top of tip master branch.
>> 
>> Change Log:
>> -Set system wide rate limit instead of per-user rate limit (Thomas).
>> -Thomas suggested to split the previous bus lock into warn and fatal
>> patch set and this rate limit patch set:
>> https://lore.kernel.org/lkml/871rca6dbp.fsf@nanos.tec.linutronix.de/
>
> Any comment on this series?
>
> The series can be applied to 5.13-rc cleanly without any change.

It's on my todo list already.
