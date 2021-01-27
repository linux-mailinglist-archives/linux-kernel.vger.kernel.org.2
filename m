Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEF3060ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhA0QXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbhA0QWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:22:35 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DE2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:21:50 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i25so2691541oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIMsOth/CNpqJDbBf0Jp68HsUWmj5aTlTiQ/jITKbjA=;
        b=jzTCyeyJA1Kx3z4AYr1gOPM/imqSCvNe1WAoJc1zYzMhAY3T5DuIYaPS9J5fWF5YRf
         HqmCctRohfbOaSPBaH/rPfnxTL+iCZofwUXTl92aYUGSLFdjm/BEcbTpyoKVVLYJNj+N
         wkUysaJApfGBv9Veg+we+8haV171Oys2nqetP7UmUuP7GPSKjxdQDbyqM+NFPq2eED2c
         nbwqoG9WL8OeFbjmR7GsutG39m9IMVRu3AbRoQ8+Upg+dbVjZfirVSn9OZI99dj9aica
         iqfz7HKr9yJffTD78Vc+MCRISwv+r3ZyzHqOPqoNbCJpNjdJFAinEqZ7P4ekbowUkWR2
         EMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIMsOth/CNpqJDbBf0Jp68HsUWmj5aTlTiQ/jITKbjA=;
        b=r0FXA1x9nc81YZWnPeafTmXug8naotdbJmj3iUthmpEeuCpIolxJmGeLM9EWUe4hij
         T5r1zpEI7JL3v2MryO1F9s0ggR0lM+HrJs3TbnWyo+SB7llgA8QPULxNqUQ1vNbuKULP
         Y7E1KQXAFEa39+y4q4vOWxDwTLwS6+X3XqwfAFSi6ZzbyjmCxeu/hLEIB4RHGSs/S9BN
         iJrK9pMaqtMx9w2ilF2qxr3oWzJJ7cki9++L7Qyr6/v8P6LVf/1jW56J9W+wHiXPFVTW
         qv7HppJdVwZNpJDe6hnlQ8TYrbPqFD99hSiuEB3mPG8A0wxv4TpESI0Rd83ObWemEMQ1
         RR/Q==
X-Gm-Message-State: AOAM531lBPVAFKTXntaTSq7TpzOCRjZrXDKe2WVUmXWREIdBubs7yXc8
        CP7jOQA/zIQDr4N90mbFB2/kx7lHbwVjE/K2vKCpHw==
X-Google-Smtp-Source: ABdhPJwizoED4YYnXfw2WhdYH9Di6DU+JIowjUughpLE8nBjzr6e3dK5ni+7zEusddUy2PphROoB1ULn0Y7f9PKewA8=
X-Received: by 2002:aca:b4d5:: with SMTP id d204mr3593832oif.165.1611764509753;
 Wed, 27 Jan 2021 08:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20210112192018.34994-1-cristian.marussi@arm.com>
In-Reply-To: <20210112192018.34994-1-cristian.marussi@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 Jan 2021 17:21:15 +0100
Message-ID: <CAKfTPtD5EwmDQJvx2yhG3cd6hKh-qJYW15DpW5cdPkgUc2tFfA@mail.gmail.com>
Subject: Re: [PATCH v5 0/36] SCMI vendor protocols and modularization
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, james.quinlan@broadcom.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,


On Tue, 12 Jan 2021 at 20:20, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> Hi all,
>
> The current SCMI implementation does not provide an interface to easily
> develop and include a custom vendor protocol implementation as prescribed
> by the SCMI standard, also because, there is not currently any custom
> protocol in the upstream to justify the development of a custom interface
> and its maintenance.
>
> Moreover the current interface exposes protocol operations to the SCMI
> driver users attaching per-protocol operations directly to the handle
> structure, which, in this way, tends to grow indefinitely for each new
> protocol addition.
>
> Beside this, protocols private data are also exposed via handle *_priv
> pointers, making such private data accessible also to the SCMI drivers
> even if neither really needed nor advisable.
>
> This series wants to address this by simplifying the SCMI protocols
> interface and reducing it, roughly, to these common generic operations:
>
>         - handle->devm_get_protocol()
>         -  handle->devm_put_protocol()
>         - handle->notify_ops()
>
> All protocols' private data pointers are removed from handle too and made
> accessible only to the protocols code through dedicated internal helpers.
>
> The concept of protocol handle is also introduced in the SCMI protocol code
> to represent a protocol instance initialized against a specific SCMI
> instance (handle), so that all the new protocol code uses such protocol
> handles wherever previously SCMI handle was used: this enable tigther
> control of what is exposed to the protocol code vs the SCMI drivers.
>
> Moreover protocol initialization is moved away from device probe and now
> happens on demand when the first user shows up (first .get_protocol), while
> de-initialization is performed once the last user of the protocol, even in
> terms of registered notifications callback, is gone, with the SCMI core
> taking care to perform all the needed underlying resource accounting.
>
> This way any new future standard or custom protocol implementation will
> expose a common unified interface which does not need to be extended
> endlessly: no need to maintain a custom interface only for vendor protos.
> SCMI drivers written on top of standard or custom protocols will use this
> same common interface to access any protocol operations.
>
> All existent upstream SCMI drivers are converted to this new interface.
>
> In order to make this migration painless and to avoid the need of a big
> un-mergeable jumbo patch touching all over the protocols and drivers (like
> it was in v2), since v3 the migration process has been heavily split with a
> bit of transient code added along the way (to preserve bisectability) and
> finally removed towards the ends of the series.
> Protocols and SCMI drivers migration to the new interface happens along
> patches 10->29.
>
> Note that even in v5 all the related SCMI drivers maintainers are still NOT
> CC'ed given I am still sort of gather consensus about the interface itself.
>
> Leveraging this new centralized and common initialization flow we took
> care also to refactor and simplify protocol-events registration and remove
> *notify_priv from the handle interface making it accessible only to the
> notification core.
>
> Patch 35 builds on top of this new interface and introduces a mechanism to
> define an SCMI protocol as a full blown module (possibly loadable) while
> leaving the core dealing with proper resource accounting.
> Standard protocols are still kept as builtins in this series, though.
>
> Finally, patch 36 introduces dynamic SCMI devices creation to avoid having
> to update the static module device table in the core each time a new driver
> is added.
>
> The whole SCMI stack can still be built alternatively as a module, with all
> the standard protocols included in scmi-module.ko in such a case.
>
> On top of this series an example SCMI Custom protocol 0x99 and related
> SCMI Custom Dummy driver has been built and it is available at [1] as a
> series of DEBUG patches on top this same series.
>
> The series is currently based on for-next/scmi [2] on top of:
>
> commit 6054d97ab512 ("MAINTAINERS: Update ARM SCMI entry")
>
> Any feedback welcome.

I have tested your patchset on my setup which includes:

- scmi performance protocol
- scmi power domain protocol
- scmi clock protocol
- scmi sensor protocol
- scmi notification
- registration of a custom scmi module (still under dev)
- 2 scmi channels

And everything worked fine. So FWIW,

Tested-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Thanks,
>
> Cristian
>
> ---
> v4 --> v5
> - using standard kernel list instead of ad-hoc lists in 36/36
> - renamed devm_get/put_ops to devm_get/put_protocol
> - dropped RFC patch on non devres get/put_ops
>
> v3 --> v4
> - rebased on sudeep/for-next/scmi v5.11-rc1
> - added a few comments more
>
> v2 --> v3
> - added dynamic SCMI devices creation (getting rid of static device table)
> - heavy split of protocols and drivers migrations to the new interface
> - rebased on top of next-20201201 so migrating also:
>   + SCMIv3.0 Voltage Domain protocol & SCMI Regulator
>   + SCMIv3.0 Sensor Extensions
>
> v1 --> v2
> - rebased on for-next/scmi v5.10-rc1
> - introduced protocol handles
> - added devres managed devm_ variant for protocols operations
> - made all scmi_protocol refs const
> - introduced IDR to handle protocols instead of static array
> - refactored code around fast path
>
> [1]:https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_modules_ext_V5/
> [2]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
>
>
> Cristian Marussi (36):
>   firmware: arm_scmi: review protocol registration interface
>   firmware: arm_scmi: introduce protocol handle definitions
>   firmware: arm_scmi: introduce devres get/put protocols operations
>   firmware: arm_scmi: make notifications aware of protocols users
>   firmware: arm_scmi: introduce new devres notification ops
>   firmware: arm_scmi: refactor events registration
>   firmware: arm_scmi: convert events registration to protocol handles
>   firmware: arm_scmi: add new protocol handle core xfer ops
>   firmware: arm_scmi: add helper to access revision area memory
>   firmware: arm_scmi: port Base protocol to new interface
>   firmware: arm_scmi: port Perf protocol to new protocols interface
>   cpufreq: scmi: port driver to the new scmi_perf_proto_ops interface
>   firmware: arm_scmi: remove legacy scmi_perf_ops protocol interface
>   firmware: arm_scmi: port Power protocol to new protocols interface
>   firmware: arm_scmi: port GenPD driver to the new scmi_power_proto_ops
>     interface
>   firmware: arm_scmi: remove legacy scmi_power_ops protocol interface
>   firmware: arm_scmi: port Clock protocol to new protocols interface
>   clk: scmi: port driver to the new scmi_clk_proto_ops interface
>   firmware: arm_scmi: remove legacy scmi_clk_ops protocol interface
>   firmware: arm_scmi: port Reset protocol to new protocols interface
>   reset: reset-scmi: port driver to the new scmi_reset_proto_ops
>     interface
>   firmware: arm_scmi: remove legacy scmi_reset_ops protocol interface
>   firmware: arm_scmi: port Sensor protocol to new protocols interface
>   hwmon: (scmi) port driver to the new scmi_sensor_proto_ops interface
>   firmware: arm_scmi: remove legacy scmi_sensor_ops protocol interface
>   firmware: arm_scmi: port SystemPower protocol to new protocols
>     interface
>   firmware: arm_scmi: port Voltage protocol to new protocols interface
>   regulator: scmi: port driver to the new scmi_voltage_proto_ops
>     interface
>   firmware: arm_scmi: remove legacy scmi_voltage_ops protocol interface
>   firmware: arm_scmi: make references to handle const
>   firmware: arm_scmi: cleanup legacy protocol init code
>   firmware: arm_scmi: cleanup unused core xfer wrappers
>   firmware: arm_scmi: cleanup events registration transient code
>   firmware: arm_scmi: make notify_priv really private
>   firmware: arm_scmi: add protocol modularization support
>   firmware: arm_scmi: add dynamic scmi devices creation
>
>  drivers/clk/clk-scmi.c                     |  27 +-
>  drivers/cpufreq/scmi-cpufreq.c             |  37 +-
>  drivers/firmware/arm_scmi/base.c           | 140 ++--
>  drivers/firmware/arm_scmi/bus.c            | 100 ++-
>  drivers/firmware/arm_scmi/clock.c          | 129 ++--
>  drivers/firmware/arm_scmi/common.h         | 117 +++-
>  drivers/firmware/arm_scmi/driver.c         | 759 +++++++++++++++++++--
>  drivers/firmware/arm_scmi/notify.c         | 297 ++++++--
>  drivers/firmware/arm_scmi/notify.h         |  38 +-
>  drivers/firmware/arm_scmi/perf.c           | 262 +++----
>  drivers/firmware/arm_scmi/power.c          | 134 ++--
>  drivers/firmware/arm_scmi/reset.c          | 146 ++--
>  drivers/firmware/arm_scmi/scmi_pm_domain.c |  26 +-
>  drivers/firmware/arm_scmi/sensors.c        | 230 ++++---
>  drivers/firmware/arm_scmi/system.c         |  61 +-
>  drivers/firmware/arm_scmi/voltage.c        | 122 ++--
>  drivers/hwmon/scmi-hwmon.c                 |  24 +-
>  drivers/regulator/scmi-regulator.c         |  40 +-
>  drivers/reset/reset-scmi.c                 |  33 +-
>  include/linux/scmi_protocol.h              | 183 ++---
>  20 files changed, 1996 insertions(+), 909 deletions(-)
>
> --
> 2.17.1
>
