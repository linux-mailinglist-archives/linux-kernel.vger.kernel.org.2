Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAB430AFB6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBASpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhBASpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:45:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E5C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:44:39 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id my11so361582pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NNdaRjT986B8fPbGTKHOrn/Rn+XWK1ZtiU5+GpD431A=;
        b=bJ5NDcUKTTtU9aCAqttulIMBCg/Qg76G9jeclExVrB3hjfsKXcet8vfaMdomw0TUzj
         sexS9YkXhF7FNme9roTkgDUaYIqrf9zkwTBtWR3l1QqmvFtULrCkzc0BRt6prXPZYeRP
         cY8Vvk0dBsr1tR7yU+DZJDEb7X3DZnxgx+izcgYr1QXIPMKDaGHju+stvflwHJk4nNIl
         zeSG25cEWPRB5hUZP1/0xBdazRrkZoF/j1GsBMbJPaJVS2ZLym8oCkpEoPIYk69JpBFT
         AC56jR8cGdzmAkbFrbft9MnKA29U3cvHZ32ON1aw7K3lYIU0j6sydryBIOexI6qynhDD
         cIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NNdaRjT986B8fPbGTKHOrn/Rn+XWK1ZtiU5+GpD431A=;
        b=FgZjGTBvnr110fF8sjh/ehrvrI4qmO7UWMBGoG5J6Ka/8p7+YlgCcSw61K9cghgcjO
         x0IDIhAd8GMeKxYiUiqBBctujS+YD6ZfN6+opYAcwrfmbD8Zfvll6oXFB3GuykehSR7O
         GY40mQaCY8Evyhh7u16VHcSn5NX/eNQkMmP/A21Ik2kX3aMSIBEMgwUUivzJ1a2H/nNP
         mk6FGHtPu4gE7EUg/+mtLAkl4MLg+zJEvQnV96jBDJe36AokMmXqKBmrJsXPzTW2kDOE
         /rbM/ZJfgGWVl0TBiPEeZlHAl34JScw0e4KkVfpIpxxQ7+1tRX0YSgXl5xh1pPIVw1zD
         zirg==
X-Gm-Message-State: AOAM533C5w/3dtmhqnUbQMnW+CbDITbEicAAmyLorJD+Diuulv3ynpxI
        71oZTjZUrdEYaeReG5MjaHNrtw==
X-Google-Smtp-Source: ABdhPJzNimvM7td0QkfIpLZ+pax5m61tpLRx6XPuPpr61Ej4hdV4oNHAgxgCXLwm1AzURs5J6P/l6g==
X-Received: by 2002:a17:902:7783:b029:df:fa69:3a34 with SMTP id o3-20020a1709027783b02900dffa693a34mr18826752pll.21.1612205078792;
        Mon, 01 Feb 2021 10:44:38 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g10sm21392597pgn.0.2021.02.01.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:44:38 -0800 (PST)
Date:   Mon, 1 Feb 2021 11:44:36 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 00/14] arm64: coresight: Enable ETE and TRBE
Message-ID: <20210201184436.GA1475392@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:24PM +0530, Anshuman Khandual wrote:
> This series enables future IP trace features Embedded Trace Extension (ETE)
> and Trace Buffer Extension (TRBE). This series depends on the ETM system
> register instruction support series [0] which is available here [1]. This
> series which applies on [1] is avaialble here [2] for quick access.
> 
> ETE is the PE (CPU) trace unit for CPUs, implementing future architecture
> extensions. ETE overlaps with the ETMv4 architecture, with additions to
> support the newer architecture features and some restrictions on the
> supported features w.r.t ETMv4. The ETE support is added by extending the
> ETMv4 driver to recognise the ETE and handle the features as exposed by the
> TRCIDRx registers. ETE only supports system instructions access from the
> host CPU. The ETE could be integrated with a TRBE (see below), or with the
> legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same firmware
> description as the ETMs and requires a node per instance. 
> 
> Trace Buffer Extensions (TRBE) implements a per CPU trace buffer, which is
> accessible via the system registers and can be combined with the ETE to
> provide a 1x1 configuration of source & sink. TRBE is being represented
> here as a CoreSight sink. Primary reason is that the ETE source could work
> with other traditional CoreSight sink devices. As TRBE captures the trace
> data which is produced by ETE, it cannot work alone.
> 
> TRBE representation here have some distinct deviations from a traditional
> CoreSight sink device. Coresight path between ETE and TRBE are not built
> during boot looking at respective DT or ACPI entries.
> 
> Unlike traditional sinks, TRBE can generate interrupts to signal including
> many other things, buffer got filled. The interrupt is a PPI and should be
> communicated from the platform. DT or ACPI entry representing TRBE should
> have the PPI number for a given platform. During perf session, the TRBE IRQ
> handler should capture trace for perf auxiliary buffer before restarting it
> back. System registers being used here to configure ETE and TRBE could be
> referred in the link below.
> 
> https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers.

This set is giving me several checkpatch.pl warnings...  Those about complex
macros and DT bindings are fine but everything else should have been addressed
by now.  Since this is your first patchset I will carry on but I expect future
submissions to be clean. 

> 
> Question:
> 
> - Should we implement sysfs based trace sessions for TRBE ?
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20210110224850.1880240-1-suzuki.poulose@arm.com/
> [1] https://gitlab.arm.com/linux-arm/linux-skp/-/tree/coresight/etm/sysreg-v7
> [2] https://gitlab.arm.com/linux-arm/linux-anshuman/-/tree/coresight/ete_trbe_v3
> 
> Changes in V3:
> 
> - Rebased on coresight/next
> - Changed DT bindings for ETE
> - Included additional patches for arm64 nvhe, perf aux buffer flags etc
> - TRBE changes have been captured in the respective patches
> 
> Changes in V2:
> 
> https://lore.kernel.org/linux-arm-kernel/1610511498-4058-1-git-send-email-anshuman.khandual@arm.com/
> 
> - Converted both ETE and TRBE DT bindings into Yaml
> - TRBE changes have been captured in the respective patches
>  
> Changes in V1:
> 
> https://lore.kernel.org/linux-arm-kernel/1608717823-18387-1-git-send-email-anshuman.khandual@arm.com/
> 
> - There are not much ETE changes from Suzuki apart from splitting of the ETE DTS patch
> - TRBE changes have been captured in the respective patches
> 
> Changes in RFC:
> 
> https://lore.kernel.org/linux-arm-kernel/1605012309-24812-1-git-send-email-anshuman.khandual@arm.com/
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Linu Cherian <lcherian@marvell.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (3):
>   coresight: core: Add support for dedicated percpu sinks
>   arm64: Add TRBE definitions
>   coresight: sink: Add TRBE driver
> 
> Suzuki K Poulose (11):
>   coresight: etm-perf: Allow an event to use different sinks
>   coresight: Do not scan for graph if none is present
>   coresight: etm4x: Add support for PE OS lock
>   coresight: ete: Add support for ETE sysreg access
>   coresight: ete: Add support for ETE tracing
>   dts: bindings: Document device tree bindings for ETE
>   coresight: etm-perf: Handle stale output handles
>   arm64: nvhe: Allow TRBE access at EL1
>   dts: bindings: Document device tree bindings for Arm TRBE
>   perf: aux: Add flags for the buffer format
>   coresight: etm-perf: Add support for trace buffer format
> 
>  Documentation/devicetree/bindings/arm/ete.yaml     |   74 ++
>  Documentation/devicetree/bindings/arm/trbe.yaml    |   49 +
>  Documentation/trace/coresight/coresight-trbe.rst   |   39 +
>  arch/arm64/include/asm/el2_setup.h                 |   19 +
>  arch/arm64/include/asm/kvm_arm.h                   |    2 +
>  arch/arm64/include/asm/sysreg.h                    |   51 +
>  drivers/hwtracing/coresight/Kconfig                |   21 +-
>  drivers/hwtracing/coresight/Makefile               |    1 +
>  drivers/hwtracing/coresight/coresight-core.c       |   16 +-
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |   93 +-
>  drivers/hwtracing/coresight/coresight-etm4x-core.c |  138 ++-
>  .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   19 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h      |   81 +-
>  drivers/hwtracing/coresight/coresight-platform.c   |    6 +
>  drivers/hwtracing/coresight/coresight-trbe.c       | 1025 ++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-trbe.h       |  160 +++
>  include/linux/coresight.h                          |   12 +
>  include/uapi/linux/perf_event.h                    |   13 +-
>  18 files changed, 1759 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
> 
> -- 
> 2.7.4
> 
