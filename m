Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2482D35BAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbhDLHPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhDLHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:15:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99707C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:15:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618211708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VdRBl/Hc8oxjJjZID5EuedD1AhqEQU8Ej3s/0QRRD+o=;
        b=vxt9eiKf9KD5fd7yNE8V7UD7/2mPVfPm2pMx9jWYgGHZs4bkmK4JjaJ02HhlWTSo9Bc+bQ
        r8pF0Iv8G6PwwzpWTFH4K+oti01YaVQTA3mvAhwbX59xVgxiWEa1Fi2cNdepho8MxCQil/
        RQEriaasBJ+hoiHUalO3Z6WRs0811+W1G4mkQ2gDw/ZQ4uvLuJsKuzX2votnMVZ30ivrex
        dScEutBKh/2kY9mQEQqhBma1jk87ykjCKg3SH8x6Qy4o5/DG4+ZShvFvupDSkTNKGIu41x
        XQfrHaje9dcBTXE+fApOZ/iYmPCIVfOigjTKa1E2ufQs5fprORi/RgP/QxCmRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618211708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VdRBl/Hc8oxjJjZID5EuedD1AhqEQU8Ej3s/0QRRD+o=;
        b=1R3KZ5gt8SRjTeOEpaZwvADPiBRc+aMtWv1mW6uP7zi+gIy+hfMHZ/PEhp2WWwtnIsmth1
        4QfGkFh6YRZ8WADg==
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
In-Reply-To: <YGe/IwJSNHnuhU2d@otcwcpicx3.sc.intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com> <20210313054910.2503968-3-fenghua.yu@intel.com> <871rca6dbp.fsf@nanos.tec.linutronix.de> <YFUjVwBg133LN+kS@otcwcpicx3.sc.intel.com> <878s6iatdf.fsf@nanos.tec.linutronix.de> <YGe/IwJSNHnuhU2d@otcwcpicx3.sc.intel.com>
Date:   Mon, 12 Apr 2021 09:15:08 +0200
Message-ID: <8735vw2cub.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03 2021 at 01:04, Fenghua Yu wrote:
> On Sat, Mar 20, 2021 at 01:42:52PM +0100, Thomas Gleixner wrote:
>> On Fri, Mar 19 2021 at 22:19, Fenghua Yu wrote:
>> And even with throttling the injection rate further down to 25k per
>> second the impact on the workload is still significant in the 10% range.
>
> Thank you for your insight!
>
> So I can change the ratelimit to system wide and call usleep_range()
> to sleep: 
>                while (!__ratelimit(&global_bld_ratelimit))
>                        usleep_range(1000000 / bld_ratelimit,
>                                     1000000 / bld_ratelimit);
>
> The max bld_ratelimit is 1000,000/s because the max sleeping time is 1
> usec.

Maximum sleep time is 1usec?

> The min bld_ratelimit is 1/s.

Again. This does not make sense at all. 1Mio bus lock events per second
are way beyond the point where the machine does anything else than being
stuck in buslocks.

Aside of that why are you trying to make this throttling in any way
accurate? It does not matter at all, really. Limit reached, put it to
sleep for some time and be done with it. No point in trying to be clever
for no value.

Thanks,

        tglx
