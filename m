Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F129B3E0613
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhHDQmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhHDQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:42:28 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C4C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:42:15 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mBJy9-007Etz-Jq
        for linux-kernel@vger.kernel.org; Wed, 04 Aug 2021 18:42:13 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8]
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mBJxs-007Esc-7G; Wed, 04 Aug 2021 18:41:56 +0200
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-4-bert@biot.com>
 <20210730144627.GB19569@C02TD0UTHF1T.local>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <d0ff051b-280c-4021-f4ee-7bfda5e356d3@biot.com>
Date:   Wed, 4 Aug 2021 18:41:55 +0200
MIME-Version: 1.0
In-Reply-To: <20210730144627.GB19569@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 4:46 PM, Mark Rutland wrote:
> On Fri, Jul 30, 2021 at 03:45:50PM +0200, Bert Vermeulen wrote:
>> +	timer {
>> +		compatible = "arm,armv8-timer";
> 
> This should be "arm,armv7-timer".
> 
>> +		interrupt-parent = <&gic>;
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> 
> GICv3 doesn't have a cpumask in its PPI description, so the
> GIC_CPU_MASK_SIMPLE() bits should be removed.

Ok, will fix.

>> +		clock-frequency = <25000000>;
> 
> Please have your FW configure CNTFRQ on each CPU; the clock-frequency
> property in the DT is a workaround for broken FW, and it's *vastly*
> preferable for FW to configure this correctly (e.g. as it means VMs
> should "just work").

I've since got hold of the modified U-Boot that runs on my eval board, and 
indeed it doesn't set CNTFRQ. So the kernel does need this, for the moment.

I may get a chance to upstream support for this SoC in U-Boot, but I can't 
control what people are going to ship with their board. Is it ok to leave 
this in?


-- 
Bert Vermeulen
bert@biot.com
