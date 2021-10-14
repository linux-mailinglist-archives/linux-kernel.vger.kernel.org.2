Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58C442D784
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhJNKz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:55:58 -0400
Received: from foss.arm.com ([217.140.110.172]:53068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhJNKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:55:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A004D6E;
        Thu, 14 Oct 2021 03:53:49 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56223F66F;
        Thu, 14 Oct 2021 03:53:48 -0700 (PDT)
Subject: Re: Enable "PMU" counters for Khadas VIM3 in the Google AOSP kernel
To:     Ehsan Aghapour <aghapour.ehsan17@gmail.com>,
        linux-amlogic@lists.infradead.org, mark.rutland@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <CAHjmVnroctx00OycHrbEjU51SntkSi9MkmaR9KZnnHkSvxkBHQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <83c45a95-d13b-0255-4bec-e52b2e7d5dd1@arm.com>
Date:   Thu, 14 Oct 2021 11:53:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHjmVnroctx00OycHrbEjU51SntkSi9MkmaR9KZnnHkSvxkBHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ehsan,

On 2021-10-08 00:11, Ehsan Aghapour wrote:
> Hello All,
> 
> I am working on Google AOSP kernel and require to enable PMU. PMU is
> working well in Khadas kernel for both A53 and A73 cores but it is not
> enabled in Google AOSP kernel 5.4. I try adding arm_pmu definition in
> device tree at /arch/arm64/boot/dts/amlogic/meson-g12b.dtsi as follow:
> arm_pmu {
>                  compatible = "arm,armv8-pmuv3";
>                  clusterb-enabled;
>                  interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
>                          <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
>                  reg = <0x0 0xff634680 0x0 0x4>,
>                          <0x0 0xff6347c0 0x0 0x04>;
>                  cpumasks = <0x3 0x3C>;
>                  /* default 10ms */
>                  relax-timer-ns = <10000000>;
>                  /* default 10000us */
>                  max-wait-cnt = <10000>;
>          };

Note that pretty much none of that is valid per the PMU binding[1].

> However in this case I only see A53 performance counters in DS5
> Streamline and performance counters of A73 cores are zero yet.
> 
> Would you please help me solve the problem? (If device tree need
> change or kernel config to enable pmu counters for both CPUs).

You should have two nodes describing the A53 and A73 PMUs distinctly. If 
the interrupts are SPIs you need the appropriate property describing 
which interrupt belongs to which CPU - see [2] for an example. Note that 
if you really do only have 2 interrupts for 6 CPUs (implying maybe 
they're combined together per cluster?) then unfortunately it's never 
going to work - the upstream PMU driver does not support shared 
interrupts (it used to attempt to, but it's impractically complicated 
and gives poor-quality results at best).

Robin.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/pmu.yaml
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/arm/juno.dts#n209

> This is related kernel log:
> "[    1.965309] hw perfevents: no interrupt-affinity property for
> /arm_pmu, guessing.
> [    1.970821] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7
> counters available
> ...
> [    7.131341] ueventd: LoadWithAliases was unable to load
> of:Narm_pmuT(null)Carm,armv8-pmuv3"
> 
> 
> Best regards,
> Ehsan
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
