Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2801E401F30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbhIFRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243961AbhIFRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:35:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAEDC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:34:49 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q68so7409502pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RuRsrItRCGT33aYjZwAQREkMqMsFsdvg/GueZb9ps7I=;
        b=vcFjoHW65IWgE3KC0gEzK22XqS4AxNg6lQi0ysKg1IajszNCwpKV5jRUgP+K5p2/lF
         yIjG/v1CjRg03rP4bga02idTRx9kxUfNMn0GEdH8RejhqF8m9khWA+hA9Nok/1SFAtmF
         fAjzB0zG0ie6C3QKig354VkTP3VB91zrZJ7Q6tDEWh04emMTjbp9vqtxHKMXal1tex40
         2waOPSvq9Bf57uhjooWymtOn+txRPFXfpodn+5f4xIjIJLO1qfzY1HGRSG+pdgteE8PJ
         voCeWpWeK95rjJsEFQuPd6cX3GDY+S05HXfmUPZ0lv7uhhSbBrFHRHcNKss+1vchYACX
         IUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RuRsrItRCGT33aYjZwAQREkMqMsFsdvg/GueZb9ps7I=;
        b=r8PkBU99Lq2onnjzhVgDbGGKHHXlWD1o6x0BMQZt0UJHnAXSqElY/Vvf7NP/swMnOG
         XpESNkiRO+t/lPwFpyPXTcx66G6AsazxfegskJJAoetYyqcVY/x2m4A4L7lNws7ryznE
         mIb1nXoN0RLtlMDax8PGSLoZXnixE8NcheeI8Ds7p/SGYredrL9Y/TAxCUS4VevigqW2
         44QiNxI+BkoilQm9iZiNexmSciEVUjEK3DlW0V9X1r8m/1xXgUYMrkaofUdtyifhnP/Q
         L8/bbji3XmjcwIZidZis1+JVvcBcVoH4xpKpjdIaljEcUbUYcvP1sP+ahXSZfQPpiwsG
         6MEA==
X-Gm-Message-State: AOAM531DPFHs87A9BNihGuIyv0/ZowwV1lImEnX/btkRX5wMIVl96tHL
        FsqAMAo6YURCeGOohnF/UXbCCg==
X-Google-Smtp-Source: ABdhPJzJCBpqjPtwkmX3tl1rocoW+R1yAATRVKI1430lo6bJNJOVCc2UIFEo4TSKUc4qhmSW9NGCDQ==
X-Received: by 2002:a63:9752:: with SMTP id d18mr13089145pgo.320.1630949689266;
        Mon, 06 Sep 2021 10:34:49 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v23sm8017125pff.155.2021.09.06.10.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 10:34:48 -0700 (PDT)
Date:   Mon, 6 Sep 2021 11:34:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
Subject: Re: [PATCH 1/2] Documentation: tracing: Documentation for ultrasoc
 SMB drivers
Message-ID: <20210906173446.GD1228692@p14s>
References: <20210719111737.47891-1-liuqi115@huawei.com>
 <20210719111737.47891-2-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719111737.47891-2-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:17:36PM +0800, Qi Liu wrote:
> Ultrasoc trace module is a system level solution for tracing, and SMB
> is the component in trace module to store trace message. This patch
> brings in a documentation for ultrasoc SMB driver and simple introduces
> how to use ultrasoc SMB by sysfs interface and perf interface.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  .../trace/coresight/ultrasoc-trace.rst        | 193 ++++++++++++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100644 Documentation/trace/coresight/ultrasoc-trace.rst
> 
> diff --git a/Documentation/trace/coresight/ultrasoc-trace.rst b/Documentation/trace/coresight/ultrasoc-trace.rst
> new file mode 100644
> index 000000000000..dee133e27bf3
> --- /dev/null
> +++ b/Documentation/trace/coresight/ultrasoc-trace.rst
> @@ -0,0 +1,193 @@
> +=======================================================
> +Siemens Embedded Analytics - HW Assisted Tracing on SoC
> +=======================================================
> +   :Author:   Jonathan Zhou <Jonathan.zhouwen@huawei.com>
> +              Qi Liu <liuqi115@huawei.com>
> +   :Date:     July 8th, 2021
> +
> +Introduction
> +------------
> +
> +This document is concerned with the Siemens Embedded Analytics Framework,
> +using for tracing of multiple type SoC. As this module is developed by
> +Ultrasoc technology, which is acquired by Siemens, we still use "Ultrasoc"
> +to name document and structures.
> +
> +System Memory Buffer is an important component in this Analytics Framework,
> +it provides a way to buffer and store messages in system memory. It provides
> +a capability to store messages received on its input message interface to an
> +area of system memory.
> +
> +A typical Siemens trace system would look like the following diagram:
> +                           @@@@@@@@@@@@@
> +                           @    CPU    @
> +                           @@@@@@@@@@@@@
> +                           #############
> +                           # Coresight #
> +                             #  ETM  #
> +                              #######
> +                                ###
> +                                 #
> +                                 |
> +                                 *
> +                    *******************************
> +                 *** AMBA Advanced Trace Bus (ATB) ***
> +                    ***************^***************
> +                          ===============    |
> +                           === FUNNEL ==<--- |
> +                              =======
> +                                 |
> +                                 *
> +                              @@@@@@@
> +                              @ TRC @
> +                               @@@@@
> +                                @@@
> +                                 @
> +                                 |
> +                                 *
> +    ************************************** *******************
> + ************************ Message BUS ***************************
> +    ******************^************************^****************
> +             |                               |
> +     @@@@@@@@@@@@@@@@@@                      |   @@@@@@@@@@@@
> +     @ Message Engine @                      |   @ JTAG COM @
> +     @@@@@@@@@@@@@@@@@@                      |    @@@@@@@@@@
> +             |                               |---> @@@@@@@@
> +             |                                      @@@@@@
> +          @@@@@@@                                      |
> +          @ SMB @                                     JTAG
> +           @@@@@
> +            @@@
> +             @
> +             |
> +             |
> +             *
> +  ***************************************************************
> + **************************** AMBA AXI  ****************************
> +  *****************************************************************
> +
> +Acronyms
> +---------------------------
> +
> +Acronyms:
> +
> +SMB:         System Memory Buffer
> +TRC:         Trace receiver
> +
> +Framework and implementation
> +------------------------------
> +
> +SMB is implemented as platform device, each SCCL has one SMB device.
> +
> +As TRC receives data from coresight ETM device, SMB can use the following API
> +to register into coresight framework as a sink device:
> +.. c:function:: struct coresight_device *coresight_register(struct coresight_desc *desc);
> +.. c:function:: void coresight_unregister(struct coresight_device *csdev);
> +
> +Then users can get trace data by this path: ETM->funnel->SMB.
> +More information about coresight framework can be found in
> +Documention/trace/coresight/coresight.rst.
> +
> +If everything goes well, the relationship of Embedded Analytics devices will be
> +described under the sysfs::
> +
> +    $# ls /sys/bus/platform/devices/
> +    <HID.smb>:00
> +    $# ls /sys/bus/coresight/devices/
> +    etm0     etm14    etm2     etm25    etm30    etm8       funnel4
> +    etm1     etm15    etm20    etm26    etm31    etm9       funnel5
> +    etm10    etm16    etm21    etm27    etm4     funnel0    funnel6
> +    etm11    etm17    etm22    etm28    etm5     funnel1    funnel7
> +    etm12    etm18    etm23    etm29    etm6     funnel2    sink_smb0
> +    etm13    etm19    etm24    etm3     etm7     funnel3
> +    $# ls -l /sys/bus/coresight/devices/funnel0/connections/
> +    <file details> in:0 -> ../../../../system/cpu/cpu0/ARMHC500:00/etm0
> +    <file details> in:1 -> ../../../../system/cpu/cpu1/ARMHC500:01/etm1
> +    <file details> in:2 -> ../../../../system/cpu/cpu2/ARMHC500:02/etm2
> +    <file details> in:3 -> ../../../../system/cpu/cpu3/ARMHC500:03/etm3
> +    <file details> nr_links
> +    <file details> out:0 -> ../../../HISI0391:00/HISI03A1:00/sink_smb0
> +    $# ls -l /sys/bus/coresight/devices/sink_smb0/connections/
> +    <file details>  in:101 -> ../../../../ARMHC9FE:05/funnel5
> +    <file details>  in:114 -> ../../../../ARMHC9FE:07/funnel7
> +    <file details>  in:121 -> ../../../../ARMHC9FE:03/funnel3
> +    <file details>  in:39 -> ../../../../ARMHC9FE:00/funnel0
> +    <file details>  in:51 -> ../../../../ARMHC9FE:04/funnel4
> +    <file details>  in:61 -> ../../../../ARMHC9FE:06/funnel6
> +    <file details>  in:68 -> ../../../../ARMHC9FE:02/funnel2
> +    <file details>  in:89 -> ../../../../ARMHC9FE:01/funnel1
> +    <file details>  nr_links
> +
> +How to use the Embedded Analytics trace module
> +-----------------------------------------------
> +
> +There are two ways to use the Embedded Analytics trace module:
> +
> +1. interacting directly with the devices using the sysFS interface.
> +2. using the perf cmd line tools.
> +
> +1) Using the sysFS interface:
> +
> +Before trace collection can start, a coresight sink needs to be identified.
> +There is no limit on the amount of sinks (nor sources) that can be enabled at
> +any given moment.  As a generic operation, all device pertaining to the sink
> +class will have an "active" entry in sysfs::
> +
> +    $# ls /sys/bus/coresight/devices/
> +    etm0     etm14    etm2     etm25    etm30    etm8       funnel4
> +    etm1     etm15    etm20    etm26    etm31    etm9       funnel5
> +    etm10    etm16    etm21    etm27    etm4     funnel0    funnel6
> +    etm11    etm17    etm22    etm28    etm5     funnel1    funnel7
> +    etm12    etm18    etm23    etm29    etm6     funnel2    sink_smb0
> +    etm13    etm19    etm24    etm3     etm7     funnel3
> +    $# ls /sys/bus/coresight/devices/sink_smb0
> +    connections  enable_sink  firmware_node  power  subsystem  uevent
> +    $# echo 1 > /sys/bus/coresight/devices/sink_smb0/enable_sink
> +    $# cat /sys/bus/coresight/devices/sink_smb0/enable_sink
> +    1
> +
> +When start trace collection, etm devices corresponding to the enabled sink
> +should be selected::
> +
> +    $# echo 1 > /sys/bus/coresight/devices/etm0/enable_source
> +    $# cat /sys/bus/coresight/devices/etm0/enable_source
> +    1
> +    $# cat /sys/bus/platform/devices/<HID.smb>:00/com_status
> +    com-type            : DOWN-ONLY
> +    service status      : stopped
> +    interrupt status    : 0x00000003
> +    write point         : 0x5437f400   <----- The write pointer is moving
> +
> +Trace collection is stopped the same way::
> +
> +    $# echo 0 > /sys/bus/coresight/devices/etm0/enable_source
> +    $# echo 0 > /sys/bus/coresight/devices/sink_smb0/enable_sink
> +
> +The content of the SMB buffer can be harvested directly from /dev::
> +
> +    $# dd if=/dev/sink_smb0 of=~/cstrace.bin
> +    5233+0 records in
> +    5233+0 records out
> +    2679296 bytes (2.7 MB) copied, 0.0131708 s, 203 MB/s
> +
> +    root:/sys/bus/coresight/devices#
> +
> +The file cstrace.bin can be decompressed using "ptm2human".
> +
> +2) Using perf framework:
> +
> +As SMB device has been registered with coresight framework, perf tool can be
> +used to control Embedded Analytics trace collection, and the method is similar
> +to using perf to do coresight trace collection.
> +
> +The only thing to note is, list of cpus should be correspond to the specified
> +sink device.
> +
> +Example usage of perf::
> +
> +	 $# ./perf list pmu
> +	 cs_etm//                                    [Kernel PMU event]
> +    $# ./perf record -e cs_etm/@sink_smb0/ -C 0 --per-thread sleep 2s
> +    [ perf record: Woken up 2 times to write data ]
> +    [ perf record: Captured and wrote 0.288 MB perf.data ]
> +    $# ./perf report

This IP block works like any other sink device and as such I don't really see a
need for this documentation - especially since it is mostly conveying the same
information already present in coresight.rst.

Thanks,
Mathieu

> -- 
> 2.17.1
> 
