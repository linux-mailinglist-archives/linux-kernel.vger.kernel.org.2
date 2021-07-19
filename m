Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC24E3CD3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhGSK4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:56:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232156AbhGSK43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:56:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD9236D;
        Mon, 19 Jul 2021 04:37:07 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C6C63F73D;
        Mon, 19 Jul 2021 04:37:04 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:36:57 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 00/17] Introduce SCMI transport based on VirtIO
Message-ID: <20210719113657.GI49078@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <314d75d6-ae5c-6aaf-b796-a424c195aee4@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314d75d6-ae5c-6aaf-b796-a424c195aee4@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 06:35:38PM +0200, Peter Hilber wrote:
> On 12.07.21 16:18, Cristian Marussi wrote:
> > Hi all,
> > 
> 
> Hi Cristian,
> 
> thanks for your update. Please find some additional comments in this reply
> and the following.
> 
> Best regards,
> 
> Peter

Hi Peter,

thanks for the feedback.

> 
> > While reworking this series starting from the work done up to V3 by
> > OpenSynergy, I am keeping the original autorship and list distribution
> > unchanged.
> > 
> > The main aim of this rework, as said, is to simplify where possible the
> > SCMI VirtIO support added in V3 by adding at first some new general
> > mechanisms in the SCMI Transport layer.
> > 
> > Indeed, after some initial small fixes, patches 05/06/07/08 add such new
> > additional mechanisms to the SCMI core to ease implementation of more
> > complex transports like virtio, while also addressing a few general issues
> > already potentially affecting existing transports.
> > 
> > In terms of rework I dropped original V3 patches 05/06/07/08/12 as no more
> > needed, and modified where needed the remaining original patches to take
> > advantage of the above mentioned new SCMI transport features.
> > 
> > DT bindings patch has been ported on top of freshly YAML converted arm,scmi
> > bindings.
> > 
> > Moreover, since V5 I dropped support for polling mode from the virtio-scmi
> > transport, since it is an optional general mechanism provided by the core
> > to allow transports lacking a completion IRQ to work and it seemed a
> > needless addition/complication in the context of virtio transport.
> > 
> 
> Just for correctness, in my understanding polling is not completely optional
> ATM. Polling would be required by scmi_cpufreq_fast_switch(). But that
> requirement might be irrelevant for now.
> 

Cpufreq core can use .fast_switch (scmi_cpufreq_fast_switch) op only if 
policy->fast_switch_enabled is true which in turn reported as true by
the SCMI cpufreq driver iff SCMI FastChannels are supported by Perf
implementation server side, but the SCMI Device VirtIO spec (5.17)
explicitly does NOT support SCMI FastChannels as of now.

Anyway, even though we should support in the future SCMI FastChannels on
VirtIO SCMI transport, fastchannels are by defintion per-protocol/per-command/
per-domain-id specific, based on sharedMem or MMIO, unidirectional and do not
even allow for a response from the platform (SCMIV3.0 4.1.1 5.3) so polling
won't be a thing anyway unless I'm missing something.

BUT you made a good point in fact anyway, because the generic perf->freq_set/get
API CAN be indeed invoked in polling mode, and, even though we do not use them
in polling as of now (if not in the FastChannel scenario above) this could be a
potential problem in general if when the underlying transport do not support poll
the core just drop any poll_completion=true messages.

So, while I still think it is not sensible to enable poll mode in SCMI Virtio,
because would be a sort of faked polling and increases complexity, I'm now
considering the fact that maybe the right behaviour of the SCMI core in such a
scenario would be to warn the user as it does now AND then fallback to use
non-polling, probably better if such a behavior is made condtional on some
transport config desc flag that allow such fallback behavior.

Any thought ?

> > Additionally, in V5 I could also simplify a bit the virtio transport
> > probing sequence starting from the observation that, by the VirtIO spec,
> > in fact, only one single SCMI VirtIO device can possibly exist on a system.
> > 
> 
> I wouldn't say that the virtio spec restricts the # of virtio-scmi devices
> to one. But I do think the one device limitation in the kernel is
> acceptable.
> 

Indeed it is not that VirtIO spec explicitly forbids multiple devices,
but the fact that SCMI devices are not identifiable from VirtIO layer
(if not by vendor mmaybe) nor from DT config (as of now) leads to the fact
that only one single device can be possibly used; if you define multiple
MMIO devices (or multiple PCI are discovered) there is now way to tell which
is which and, say, assign those to distinct channels per different protocols.

Having said that, this upcoming series by Viresh, may be useful in the
future:

https://lore.kernel.org/lkml/aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org/

since it would add the capability to 'link' an SCMI device user (SCMI
virtio transport instance or specific channel) to a specific virtio-mmio
node. Once this is in, I could try to multi SCMI VirtIO device support, but not
within this series probably.


Thanks,
Cristian

