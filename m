Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC8B30DD10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhBCOlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:41:15 -0500
Received: from foss.arm.com ([217.140.110.172]:41306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhBCOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:40:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619BF11FB;
        Wed,  3 Feb 2021 06:39:20 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60AA03F73B;
        Wed,  3 Feb 2021 06:39:18 -0800 (PST)
Date:   Wed, 3 Feb 2021 14:39:15 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 29/37] regulator: scmi: port driver to the new
 scmi_voltage_proto_ops interface
Message-ID: <20210203143915.GE8355@e120937-lin>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-30-cristian.marussi@arm.com>
 <20210203132432.GD4880@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203132432.GD4880@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On Wed, Feb 03, 2021 at 01:24:32PM +0000, Mark Brown wrote:
> On Tue, Feb 02, 2021 at 10:15:47PM +0000, Cristian Marussi wrote:
> > Port driver to the new SCMI Voltage interface based on protocol handles
> > and common devm_get_ops().
> 
> I have no cover letter or other context for this, what's the story here?

Sorry I've CCed only the relevant patches to the subsystem maintainers.

The whole story is in the series cover-letter here:

https://lore.kernel.org/linux-arm-kernel/20210202221555.41167-1-cristian.marussi@arm.com/

In summary we wanted to ease both protocols modularization in general and1
the implementation of custom vendor custom protocols and drivers (as
allowed by SCMI spec): to do that I reviewed the internals of SCMI protos
handling to centralize resource accounting (so that I can track who is
using which protocol at any time), and I generalized the interface exposed
to the SCMI drivers so that as an example:

handle->voltage_ops->level_set(handle, ...)

becomes:

/*get access to the proto and ops in probe()*/
vops = handle->devm_get_protocol(handle, SCMI_PROTOCOL_VOLTAGE, &ph);

/* use it */
vops->level_set(ph, ...)

This way the interface is unified for all protocols both standard and
custom and if you develop a new custom proto implementation, and driver,
you'll end-up using it in a similar way:

cops = handle->devm_get_protocol(handle, SCMI_PROTOCOL_CUSTOM, &ph);

cops->custom_method(ph, )

without having to add an endless stream of new custom *_ops structs to
the handle struct.

To attain the above, though, there are also a number of internal changes
in the series that are tightly related to the drivers' interface which I
am changing as an example with this patch, so the series contains a bit
of transient code added and removed along the way around the drivers
changes to maintain bisectability throughout all the series.

Apologies to have not included the cover-letter at first to provide
context.

Thanks

Cristian
