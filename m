Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2657331C849
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPJpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:45:15 -0500
Received: from foss.arm.com ([217.140.110.172]:59236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBPJpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:45:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF9B1FB;
        Tue, 16 Feb 2021 01:44:22 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E2B03F694;
        Tue, 16 Feb 2021 01:44:20 -0800 (PST)
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210212202628.GC2692426@xps15>
 <9ca3b9da-dded-1206-e048-835590b2265e@arm.com>
 <CAJ9a7ViX6UUO66WX7M8hixg7dRdx7XPZNpfr3zwTaT=GBbWJSg@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7b20f8b3-4efa-530f-b058-1aae13e4e43e@arm.com>
Date:   Tue, 16 Feb 2021 15:14:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7ViX6UUO66WX7M8hixg7dRdx7XPZNpfr3zwTaT=GBbWJSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On 2/16/21 2:30 PM, Mike Leach wrote:
> Hi Anshuman,
> 
> There have been plenty of detailed comments so I will restrict mine to
> a few general issues:-
> 
> 1) Currently there appears to be no sysfs support (I cannot see the
> MODE_SYSFS constants running alongside the MODE_PERF ones present in
> the other sink drivers). This is present on all other coresight
> devices, and must be provided for this device. It is useful for
> testing, and there are users out there who will have scripts to use
> it. It is not essential it makes it into this set, but should be a
> follow up set.

Sure, will try and add it in a follow up series.

> 
> 2) Using FILL mode for TRBE means that the trace will by definition be
> lossy. Fill mode will halt collection without cleanly stopping and
> flushing the source. This will result in the sink missing the last of
> the data from the source as it stops. Even if taking the exception
> moves into a prohibited region there is still the possibility the last
> trace operations will not be seen. Further it is possible that the
> last few bytes of trace will be an incomplete packet, and indeed the
> start of the next buffer could contain incomplete packets too.

Just wondering why TRBE and ETE would not sync with each other in order
for the ETE to possibly resend all the lost trace data, when the TRBE
runs out of buffer and wrappers around ? Is this ETE/TRBE behavior same
for all implementations in the FILL mode ? Just wondering.

> 
> This operation differs from the other sinks which will only halt after
> the sources have stopped and the path has been flushed. This ensures
> that the latest trace is complete. The weakness with the older sinks
> is the lack of interrupt meaning buffers were frequently wrapped so
> that only the latest trace is available.

Right.

> 
> By using TRBE WRAP mode, with a watermark as described in the TRBE
> spec, using the interrupts it is possible to approach lossless trace
> in a way that is not possible with earlier ETR/ETB. This is somethin
Using TRBTRG_EL1 as the above mentioned watermark ?

> that has been requested by partners since trace became available in
> linux systems. (There is still a possibility of loss due to filling
> the buffer completely and overflowing the watermark, but that can be
> flagged).
> 
> While FILL mode trace is a good start, and suitable for some scenarios
> - WRAP mode needs implementing as well.

I would like to understand this mechanism more. Besides how the perf
interface suppose to choose between FILL and WRAP mode ? via a new
event attribute ?

> 
> 3) Padding: To be clear, it is not safe for the decoder to run off the
> end of one buffer, into the padding area and continue decoding, or
> continue through the padding into the next buffer. However I believe
> the buffer start / stop points are demarked by the aux_output_start /
> aux_output_end calls?

Yes.

> 
> With upcoming perf decode updates this should enable the decoder to
> correctly be started and stopped on the buffer boundaries. The padding
> is there primarily to ensure that the decoder does not synchronize
> with the data stream until a genuine sync point is found.

Right.

> 
> 4) TRBE needs to be a loadable module like the rest of coresight.

Even though the driver has all the module constructs, the Kconfig was
missing a tristate value, which is being fixed for the next version.

- Anshuman
