Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51123BD8F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhGFOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:52:59 -0400
Received: from foss.arm.com ([217.140.110.172]:44122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231509AbhGFOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:52:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49AE611D4;
        Tue,  6 Jul 2021 07:18:51 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 219E73F73B;
        Tue,  6 Jul 2021 07:18:48 -0700 (PDT)
Date:   Tue, 6 Jul 2021 15:18:41 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v5 08/15] firmware: arm_scmi: Introduce optional support
 for delegated xfers
Message-ID: <20210706141841.GG17807@e120937-lin>
References: <20210705144914.35094-1-cristian.marussi@arm.com>
 <20210705144914.35094-9-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705144914.35094-9-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 03:49:07PM +0100, Cristian Marussi wrote:
> Some SCMI transports allow for more parallelism while handling SCMI
> messages and as a result may have more complex inner workings than shared
> memory based transports and they could need to maintain additional
> transport-specific state information and data about the ongoing transfers.
> Using the current SCMI core transport layer interface, additional effort
> would be needed to keep such states and data in sync with the SCMI core.
> 
> Allow an SCMI transport to optionally declare to be using delegated xfers
> so that it can use a few SCMI core helper functions to query the core early
> on in the RX path for any valid existing in-flight transfers matching a
> specific message header or, alternatively, to transparently obtain a brand
> new dedicated xfer to handle a notification message.
> 
> In both cases the obtained xfer can be uniquely mapped to a specific xfer,
> assured to be valid, through the means of the message header sequence
> number acting as key.
> 
> In this way such a transport can save its own transport specific envelope
> into a private reference associated with the xfer before calling into the
> core scmi_rx_callback() in the usual way.
> 
> The scmi_rx_callback() does not need to be modified to carry additional
> transport-specific ancillary data related to such message envelopes since
> an unique natural association is established between the xfer and the
> related message header.
> 
> Existing transports that do not need anything of the above will continue
> to work as before without any change.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Hi,

as an afterthough (sigh...) on this patch of mine, I think that now, after
all the support introduced earlier within this same series into the SCMI
core (monotonic tokens and concurrency/out-of-order handling of responses),
the additional complexity of this patch could NOT be needed anymore and I
am actually experimenting dropping this patch as a whole and further
simplifying the virtio transport rx logic, with the only caveat of
having to modify scmi_rx_callback() prototype to allow for a new
priv parameter to be optionally provided by the transport, thing that I
avoided till now but it does not seem worth anymore.

I'll post a new V6 on 5.14-rc1 with this patch reworked once fully
tested and ruled out any unexpected surprise.

Sorry for the noise.

Thanks,
Cristian
