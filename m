Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9186843E703
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhJ1RSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJ1RSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:18:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7778C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:16:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so4895098plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TqmeLxlzXbiualUO4WNdgNCgh3Eor1LVQ5uIKOBG9Oc=;
        b=zYuXns86gDGe/h8uIxOmgnFZ8iBvMBsxsyb1GEJMUQQ8nJGjkUQE9aiHsvk8JbA+MV
         RRxsb/c1sBD+zQXr3iNkZgaq/2+9wkQlxM2Xq6jUbOgdSEdOhDrbXvM+B2HT+AbTKc1R
         ILmDKweziR2qx2Lx+MqAAMiuEOSGA8bh9QOlG8Op/6rZOXic680EUtq6VGU+TrUk5jAF
         /ERzQKXVhyB2+bsSbCwn+Wv8VCBYQjfGTVunCI8oDxYqHgxWnlJUaL+LYNfjKAaqsu+f
         WXRnzx3tVlRrnJGLJFSEeKhppU2LnjAmn9r6AlbRiZQy0Cj5wwT04HcMxbXLyLGsnrGV
         Z1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqmeLxlzXbiualUO4WNdgNCgh3Eor1LVQ5uIKOBG9Oc=;
        b=HIzm77r5pO0R0FySWUO0WqUsRsSO/U5mMj5cdeaYZ+trn2Q1uxeozWRIYkZqJ3Um4e
         PnYcrTYYRRcrdJBJmUjCZGLWbPnCyh9rX/ieBP/kszo4AdtLHRg1OZjnd9ejAK+cMauH
         bj5Ollz1TEA7Bxl8sCaK6jEGwWIJphjVpntBTIXRizYtGvIncmBzGkUFvoCQGoRe7JYU
         DVkLUPo54n0xkbAhEPKaQSq/quWoaZI0MqFtF1ECz4DQTYn9CIkHwevCeE3+LK18y8Vo
         CZx0G+8c4Y6qtWifeFp9xJkalPmn2otu9jEJbMTSJCaJce8wwRejiwolaF2Zhe6EWxkn
         o0Zw==
X-Gm-Message-State: AOAM530uZL+z9nFWuhdDF4qlRKW5uNMyXhalWthfGHDV41YvQnZ3Y5nU
        nIa4kl+/wnByfGjpOdhrZ/0lLg==
X-Google-Smtp-Source: ABdhPJzwnyT/npArBzp3+6fuNXF727BSlJIUrUWACp/RE8IPwUvzCS2KhWWQ0HKoiBkkOWzE3Q+d2w==
X-Received: by 2002:a17:90a:9a8e:: with SMTP id e14mr5016496pjp.231.1635441378138;
        Thu, 28 Oct 2021 10:16:18 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j5sm2567415pfc.0.2021.10.28.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 10:16:17 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:16:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 00/10] Add support for TPDM and TPDA
Message-ID: <20211028171615.GB4045120@p14s>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have started to review this set.  It is substantial in size and as such will
take me several days, most likely weeks.  

Did you run checkpatch before sending this set out?  If so, any reason why there
are still errors?

Thanks,
Mathieu

On Thu, Oct 21, 2021 at 03:38:46PM +0800, Tao Zhang wrote:
> This series adds support for the trace performance monitoring and
> diagnostics hardware (TPDM and TPDA). It is composed of two major
> elements.
> a) Changes for original coresight framework to support for TPDM and TPDA.
> b) Add driver code for TPDM and TPDA.
> 
> Introduction of changes for original coresight framework
> a) Support TPDM as new coresight source.
> Since only STM and ETM are supported as coresight source originally.
> TPDM is a newly added coresight source. We need to change
> the original way of saving coresight path to support more types source
> for coresight driver.
> The following patch is to add support more coresight sources.
> coresight: add support to enable more coresight paths
> 
> b) To support multi-port input and multi-port output for funnels
> In some cases, different TPDM hardware will be connected to the same
> funnel, but eventually they need to be linked to different TPDAs or
> funnels. This requires funnel to support multi-port input and multi-port
> output, and can specify which input port corresponds to which output port.
> Use property ?label? in the funnel?s configuration to point out from
> which input port to which output port.
> The following patch is to support multi-port input and multi-port output
> for funnels.
> coresight: funnel: add support for multiple output ports
> 
> Introduction of TPDM and TPDA
> TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
> short serves as data collection component for various dataset types
> specified in the QPMDA(Qualcomm performance monitoring and diagnostics
> architecture) spec. The primary use case of the TPDM is to collect data
> from different data sources and send it to a TPDA for packetization,
> timestamping and funneling.
> The following patch is to add driver for TPDM.
> Coresight: Add driver to support Coresight device TPDM
> Coresight: Enable BC and GPR for TPDM driver
> Coresight: Add interface for TPDM BC subunit
> Coresight: Enable and add interface for TPDM TC subunit
> Coresight: Enable DSB subunit for TPDM
> Coresight: Enable CMB subunit for TPDM
> 
> TPDA - The trace performance monitoring and diagnostics aggregator or
> TPDA in short serves as an arbitration and packetization engine for the
> performance monitoring and diagnostics network as specified in the QPMDA
> (Qualcomm performance monitoring and diagnostics architecture)
> specification. The primary use case of the TPDA is to provide
> packetization, funneling and timestamping of Monitor data as specified
> in the QPMDA specification.
> The following patch is to add driver for TPDA.
> coresight: Add driver to support Coresight device TPDA
> 
> The last patch of this series is a device tree modification, which add
> the TPDM and TPDA configuration to device tree for validating.
> ARM: dts: msm: Add TPDA and TPDM configuration to device
> 
> Once this series patches are applied properly, the tpdm and tpda nodes
> should be observed at the coresight path /sys/bus/coresight/devices
> e.g.
> /sys/bus/coresight/devices # ls -l | grep tpd
> tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
> tpdm0 -> ../../../devices/platform/soc@0/6844000.lpass.tpdm/tpdm0
> 
> We can use the commands are similar to the below to validate TPDMs.
> Enable coresight sink first.
> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> The test data will be collected in the coresight sink which is enabled.
> 
> This series applies to coresight/next
> https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git?h=next
> 
> Tao Zhang (10):
>   coresight: add support to enable more coresight paths
>   coresight: funnel: add support for multiple output ports
>   Coresight: Add driver to support Coresight device TPDM
>   Coresight: Enable BC and GPR for TPDM driver
>   Coresight: Add interface for TPDM BC subunit
>   Coresight: Enable and add interface for TPDM TC subunit
>   Coresight: Enable DSB subunit for TPDM
>   Coresight: Enable CMB subunit for TPDM
>   coresight: Add driver to support Coresight device TPDA
>   ARM: dts: msm: Add TPDA and TPDM support to DTS for RB5
> 
>  .../bindings/arm/coresight-tpda.yaml          |  169 +
>  .../bindings/arm/coresight-tpdm.yaml          |   86 +
>  MAINTAINERS                                   |    6 +
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  439 ++
>  drivers/hwtracing/coresight/Kconfig           |   18 +
>  drivers/hwtracing/coresight/Makefile          |    2 +
>  drivers/hwtracing/coresight/coresight-core.c  |  175 +-
>  .../hwtracing/coresight/coresight-platform.c  |    8 +
>  drivers/hwtracing/coresight/coresight-tpda.c  |  828 ++++
>  drivers/hwtracing/coresight/coresight-tpdm.c  | 4253 +++++++++++++++++
>  include/linux/coresight.h                     |    2 +
>  11 files changed, 5928 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>  create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
> 
> -- 
> 2.17.1
> 
