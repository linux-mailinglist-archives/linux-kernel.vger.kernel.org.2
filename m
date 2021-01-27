Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFA306394
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhA0SvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhA0SvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:51:23 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09988C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:50:43 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id d13so2956297ioy.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DT74Y/YxNa6qvJoCjRxEFuN2KxASxhtwBpilJW7hZK8=;
        b=v14GIQVZmOgU3EmuqK1xx/pCOyLSvNTBNAYXD8wPg7ScUpBs7kvwkPgJVBzQskk1JN
         nIMbl89IogEF4vWdhfLBGdNqnuQfTpEb3Z0E2NSeTQt+JQtT/R5hFgwm3iK8LTgk1cA2
         H1J1mz2IOO0UlNkSUZdbfHg4Ix+RzWnWQaSejC9qmt4mgizHYMhtP2qGyEREdSuNm55T
         NPOMdaMtMTsuMvYRm/AtlpZHmMoAOp2JbjUS9o0zL/bYOZQiVn8sJ8fOhuIST7b1Uq2w
         SiwF+YoU3+dwKp10Usqpi2v2oVktECIjSI5yQR0eqKSywVYTGpM4K7PGw5wQxVBTOyo7
         RIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DT74Y/YxNa6qvJoCjRxEFuN2KxASxhtwBpilJW7hZK8=;
        b=AIVwVOsL1lJKkS8r79Znf2H/OoBXoUTIXks3+Wxw6ujwuMDkfk9uouQA1uXbpvox3e
         OIlpoXEUui+PiAD3xcZuNmeRe5cqlsChkvcu2PD3RjyImI8ypQGRWtLyRwPcexhGb7HC
         42If2Q4Y6Ass2c2A3T7S1F7SfqIoWamwyvi2jQ5ZuDVdcG2snEWgXKQJ+V54Z13Z9sjH
         uANnee4CTs1u9ZvuWHpKypq3J+sEdKRe2z3uZieEE8gqfZMIeDJRJyTKG6Ch5cHFcKS7
         TT7oiPFJghifAvJ4I27YinMr2D82ALRr0APcynAtQ4spT5jlrzk6qrjKCx9MoNE7K38I
         pTJw==
X-Gm-Message-State: AOAM530lfYwqkJWFHI88L1h77kCHy/jKv886xO1hJN35RW6xWK1fw27N
        iCHAv1KchKYuO8qMD4zG40eExdBWbrhKEaBBYCyudg==
X-Google-Smtp-Source: ABdhPJw4uZBBKef3iSwdUVq50S8ekKvH6lHDo75wUWOScydKPJ4uPsTFbyArDl2aN6/auM16s7ngieQsfheqiMFaBrI=
X-Received: by 2002:a05:6638:35a3:: with SMTP id v35mr10288590jal.36.1611773442334;
 Wed, 27 Jan 2021 10:50:42 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 27 Jan 2021 11:50:31 -0700
Message-ID: <CANLsYkw9qruSxoaJJ1Liu_oJeXOKMYk5LszEe0=-t1+piPdofw@mail.gmail.com>
Subject: Re: [PATCH V3 00/14] arm64: coresight: Enable ETE and TRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

I will start looking at your work later this week or early next week.

Mathieu

On Wed, 27 Jan 2021 at 01:55, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
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
