Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6033D9444
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhG1RZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:25:59 -0400
Received: from foss.arm.com ([217.140.110.172]:33984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhG1RZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:25:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26C8F6D;
        Wed, 28 Jul 2021 10:25:56 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DFF63F66F;
        Wed, 28 Jul 2021 10:25:53 -0700 (PDT)
Date:   Wed, 28 Jul 2021 18:25:46 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 08/17] firmware: arm_scmi: Add priv parameter to
 scmi_rx_callback
Message-ID: <20210728172546.GL6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-9-cristian.marussi@arm.com>
 <20210728142625.zbx7zbeffwsksjl5@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728142625.zbx7zbeffwsksjl5@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:26:25PM +0100, Sudeep Holla wrote:
> On Mon, Jul 12, 2021 at 03:18:24PM +0100, Cristian Marussi wrote:
> > Add a new opaque void *priv parameter to scmi_rx_callback which can be
> > optionally provided by the transport layer when invoking scmi_rx_callback
> > and that will be passed back to the transport layer in xfer->priv.
> > 
> > This can be used by transports that needs to keep track of their specific
> > data structures together with the valid xfers.
> >

Hi,

> 
> This change looks simple but doesn't make sense on its own. I assume you don't
> want to add all these in the patch making use of priv which makes sense. Not
> sure if the next patch uses it, but I prefer to keep them as close as possible
> if it is not too much of a hassle.
> 

Right, yes I'll move it close to 17/17 which is the actual user of this
at the end.

Thanks,
Cristian

