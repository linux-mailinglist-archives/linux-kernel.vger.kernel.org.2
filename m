Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB235F0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhDNJmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhDNJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:41:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC7EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:41:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618393289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4/RHxsfohskTtOw0aS3OJVyodBBIJyJEVripy2Vc2k=;
        b=Xi/8vu3k7TfI91QEGRmY+fGcKdPHvqUVfgBi8X4PQLU+RmqA96BKAN8zED/usdls8Mhyop
        SeieeMWhRV4igMWpz2arMUBK5ms9SLPxS8PFhs16ZSca5ea1uDU1zLXWHa9EAoE9KrI+mi
        e/UGwI9UOMtUpYl7isMGvSidBcc5yt54K9BZHjgAC8oUaW/dbCRAIGOxDT9vKr+H2r1B1P
        kMQcUrX059XAhyJN5zbN2LtLMCkpUeL6g5JhS5slms14uVmdvLXwGKjpSLmCm8ZQlzxS13
        ScM+oRk6bzdOIk+moht4TnvRNCK8cNCvvDDBw7K4GTy062PwR1bYEyj9TMNV4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618393289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4/RHxsfohskTtOw0aS3OJVyodBBIJyJEVripy2Vc2k=;
        b=R8EienE+8n7C5nXqMeTQ2Mlh0sWjF9TDZZ7uVMilOuVYu6i33kOPD7unTcVWQlQqGpoeIy
        eFxuijItjo9zJbBQ==
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
In-Reply-To: <YHYr/cK+8BGXNILt@otcwcpicx3.sc.intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com> <20210313054910.2503968-3-fenghua.yu@intel.com> <871rca6dbp.fsf@nanos.tec.linutronix.de> <YFUjVwBg133LN+kS@otcwcpicx3.sc.intel.com> <878s6iatdf.fsf@nanos.tec.linutronix.de> <YGe/IwJSNHnuhU2d@otcwcpicx3.sc.intel.com> <8735vw2cub.ffs@nanos.tec.linutronix.de> <YHYr/cK+8BGXNILt@otcwcpicx3.sc.intel.com>
Date:   Wed, 14 Apr 2021 11:41:28 +0200
Message-ID: <875z0pxkxj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua,

On Tue, Apr 13 2021 at 23:40, Fenghua Yu wrote:
> On Mon, Apr 12, 2021 at 09:15:08AM +0200, Thomas Gleixner wrote:
>> Aside of that why are you trying to make this throttling in any way
>> accurate? It does not matter at all, really. Limit reached, put it to
>> sleep for some time and be done with it. No point in trying to be clever
>> for no value.
>
> Is it OK to set bld_ratelimit between 1 and 1,000 bus locks/sec for
> bld_ratelimit?
>
> Can I do the throttling like this?
>
>                /* Enforce no more than bld_ratelimit bus locks/sec. */
>                while (!__ratelimit(&global_bld_ratelimit))
>                        msleep(10);
>
> On one machine, if bld_ratelimit=1,000, that's about 5msec for a busy
> bus lock loop, i.e. bus is locked for about 5msec and then the process
> sleeps for 10msec and thus won't generate any bus lock.
> "dd" command running on other cores doesn't have noticeable degradation
> with bld_ratelimit=1,000.

Something like this makes sense. Add some rationale for the upper limit
you finally end up with so sysadmins can make informed decisions.

Thanks,

        tglx
