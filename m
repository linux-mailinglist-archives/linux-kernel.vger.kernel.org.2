Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A134A617
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCZLF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:05:28 -0400
Received: from foss.arm.com ([217.140.110.172]:55210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhCZLFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:05:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B68B143D;
        Fri, 26 Mar 2021 04:05:00 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378403F7D7;
        Fri, 26 Mar 2021 04:04:58 -0700 (PDT)
Date:   Fri, 26 Mar 2021 11:04:51 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v7 00/38] SCMI vendor protocols and modularization
Message-ID: <20210326110451.GC43717@e120937-lin>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
 <6bf4921a-12ad-a3b5-3dcc-d5463dd36729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf4921a-12ad-a3b5-3dcc-d5463dd36729@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:09:52PM -0700, Florian Fainelli wrote:
> 
> 
> On 3/16/2021 5:48 AM, Cristian Marussi wrote:
> > Hi all,
> > 
> > The current SCMI implementation does not provide an interface to easily
> > develop and include a custom vendor protocol implementation as prescribed
> > by the SCMI standard, also because, there is not currently any custom
> > protocol in the upstream to justify the development of a custom interface
> > and its maintenance.
> > 
> > Moreover the current interface exposes protocol operations to the SCMI
> > driver users attaching per-protocol operations directly to the handle
> > structure, which, in this way, tends to grow indefinitely for each new
> > protocol addition.
> > 
> > Beside this, protocols private data are also exposed via handle *_priv
> > pointers, making such private data accessible also to the SCMI drivers
> > even if neither really needed nor advisable.
> > 
> > This series wants to address this by simplifying the SCMI protocols
> > interface and reducing it, roughly, to these common generic operations:
> > 
> > 	- handle->devm_protocol_get()
> > 	- handle->devm_protocol_put()
> > 	- handle->notify_ops->*
> > 
> > All protocols' private data pointers are removed from handle too and made
> > accessible only to the protocols code through dedicated internal helpers.
> > 
> > The concept of protocol handle is also introduced in the SCMI protocol code
> > to represent a protocol instance initialized against a specific SCMI
> > instance (handle), so that all the new protocol code uses such protocol
> > handles wherever previously SCMI handle was used: this enable tighter
> > control of what is exposed to the protocol code vs the SCMI drivers.
> > 
> > Moreover protocol initialization is moved away from device probe and now
> > happens on demand when the first user shows up (first .protocol_get), while
> > de-initialization is performed once the last user of the protocol, even in
> > terms of registered notifications callback, is gone, with the SCMI core
> > taking care to perform all the needed underlying resource accounting.
> > 
> > This way any new future standard or custom protocol implementation will
> > expose a common unified interface which does not need to be extended
> > endlessly: no need to maintain a custom interface only for vendor protos.
> > SCMI drivers written on top of standard or custom protocols will use this
> > same common interface to access any protocol operations.
> > 
> > All existent upstream SCMI drivers are converted to this new interface.
> > 
> > In order to make this migration painless and to avoid the need of a big
> > un-mergeable jumbo patch touching all over the protocols and drivers (like
> > it was in v2), since v3 the migration process has been heavily split with a
> > bit of transient code added along the way (to preserve bisectability) and
> > finally removed towards the ends of the series.
> > Protocols and SCMI drivers migration to the new interface happens along
> > patches 10->30.
> > 
> > Leveraging this new centralized and common initialization flow we took
> > care also to refactor and simplify protocol-events registration and remove
> > *notify_priv from the handle interface making it accessible only to the
> > notification core.
> > 
> > Patch 37 builds on top of this new interface and introduces a mechanism to
> > define an SCMI protocol as a full blown module (possibly loadable) while
> > leaving the core dealing with proper resource accounting.
> > Standard protocols are still kept as builtins in this series, though.
> > 
> > Finally, patch 38 introduces dynamic SCMI devices creation to avoid having
> > to update the static module device table in the core each time a new driver
> > is added.
> > 
> > The whole SCMI stack can still be built alternatively as a module, with all
> > the standard protocols included in scmi-module.ko in such a case.
> > 
> > On top of this series an example SCMI Custom protocol 0x99 and related
> > SCMI Custom Dummy driver has been built and it is available at [1] as a
> > series of DEBUG patches on top this same series.
> > 
> > The series is currently based on sudeep/for-next/scmi [2] on top of:
> > 
> > commit 908a4f778dc7 ("Merge branch 'ib-iio-scmi-5.12-rc2-take3' of
> > 	 git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into
> > 	 for-next/scmi")
> > 
> > Any feedback welcome.
> 
> You copied me on each round and thanks for doing that, I did not have
> time to go look at each change, but sensors, clocks and cpufreq still
> worked on ARCH_BRCMSTB with both 32-bit and 64-bit kernels, so:
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 
 Great, thanks for taking time to test this !

 And btw, thanks for your initial feedback anyway, it spawned a lot of
 needed rework across this series.

 Thanks

 Cristian
> Thanks!
> -- 
> Florian
