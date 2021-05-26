Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8AD391ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhEZOyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:54:55 -0400
Received: from foss.arm.com ([217.140.110.172]:46092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235068AbhEZOyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:54:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB9D1516;
        Wed, 26 May 2021 07:53:22 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8F1F3F73D;
        Wed, 26 May 2021 07:53:20 -0700 (PDT)
Date:   Wed, 26 May 2021 15:53:17 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 4/4] firmware: arm_scmi: Introduce delegated xfers support
Message-ID: <20210526145317.GQ28060@e120937-lin>
References: <20210524231503.34924-1-cristian.marussi@arm.com>
 <20210524231503.34924-5-cristian.marussi@arm.com>
 <659c2f2c-e236-1a70-44be-c5f6871868e7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659c2f2c-e236-1a70-44be-c5f6871868e7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 07:20:45PM -0700, Florian Fainelli wrote:
> 
> 
> On 5/24/2021 4:15 PM, Cristian Marussi wrote:
> > Introduce optional support for delegated xfers allocation.
> > 
> > An SCMI transport can optionally declare to support delegated xfers and
> > then use a few helper functions exposed by the core SCMI transport layer to
> > query the core for existing in-flight transfers matching a provided message
> > header or alternatively and transparently obtain a brand new xfer to handle
> > a freshly received notification message.
> > In both cases the obtained xfer is uniquely mapped into a specific xfer
> > through the means of the message header acting as key.
> > 
> > In this way such a transport can properly store its own transport specific
> > payload into the xfer uniquely associated to the message header before
> > even calling into the core scmi_rx_callback() in the usual way, so that
> > the transport specific message envelope structures can be freed early
> > and there is no more need to keep track of their status till the core
> > fully processes the xfer to completion or times out.
> > 
> > The scmi_rx_callbak() does not need to be modified to carry additional
> > transport-specific ancillary data related to such message envelopes since
> > an unique natural association is established between the xfer and the
> > related message header.
> > 
> > Existing transports that do not need anything of the above will continue
> > to work as before without any change.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> It would be better to see this in the context of its planned user, but
> that looked reasonable enough.

I agree, definitely better to see this in the context of usage.

Such virtio-scmi rework is still in progress indeed, but working in my
local testing so far.

The reworked V4 virtio-scmi series is still to be refined and posted,
and this transitional code lives now at:

https://gitlab.arm.com/linux-arm/linux-cm/-/tree/scmi_virtio_trans_V4_rework

and in particular this is the patch that changes virtio-scmi transport to
use the new delegated xfers. (hopefully simplfying it)

https://gitlab.arm.com/linux-arm/linux-cm/-/commit/0b524f89ea6cfcf6204a5eaa8cf9030118805b2f

...but, as said, it is highly work in progress so you may just want to
wait for final V4 virtio-scmi rework posted and do not bother this noise
of mine :D

In any case thanks a lot for the feedback so far.

Cristian

> -- 
> Florian

