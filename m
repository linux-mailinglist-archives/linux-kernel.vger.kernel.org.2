Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5034420E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhCVMiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhCVMdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:33:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE3FC0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:33:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h13so19100113eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bFXSCk7jXzi1oDqUKnupFbkdc1ED5SojZj7S5YlWylo=;
        b=Nb6vq2/ii4Uu5XEatx9s0w0vyMHBFNdJ9XkyhRXQRTYCa2DlOgNpuMLBtGI32mU4LR
         mM7dCOyOsSQiBYx78D9Tou6WPJCLVJK2++P19JKJpLnY6jpQoN++z2bIdKzEKPwiTfB8
         flKUIx/jPAbEh+WGHPcfHxffQaeLfuKX6yZiKFKqfDTbAz9SFCQqpEeOUdO2QyBtYKaB
         Oaywbong+u/EvIZ1Ewmyy2wctKFSPqSSpRnb2lmoQ1pHGjZFL4kuL558WSZeqj9KAhZv
         uvC/l92Hw9hGqb+CsWq5oYBUh8+QoyxagBJkBo5OWb8T+4+67ScVqWdqIvHbdZ1sM5Rt
         FeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bFXSCk7jXzi1oDqUKnupFbkdc1ED5SojZj7S5YlWylo=;
        b=srq91BlvifjWL/dUc0sopV/0NZTiqXJ6G12z+14Dhxkgajm/kAoq0WyHm/O3B414Ar
         x/yS6vluVQsOPM6uSxvlkjW0DhIQhuIVKRgeDY2u0Hk2rPvnRiRIUbkFx/lcjZpPHVxY
         Vipfher3fB78P+eA9PLDZSNzl2x8OQxSnI00b6bUePbT30zGMdokzpfwoIQiwfXF8wmw
         wIAxiTLGuGknVTtD680cTjbBNKfhJC8d401VPuTqQbKbhre+0WJ9oWRiPlQTEi69ZoEX
         2iaRFxp61T4ZnyUj91WOR6neXsZulsbbSX+un++Xz1L3JCIELKi8nRtakfFeB7lbbdDW
         K0dg==
X-Gm-Message-State: AOAM532KrxhqmIMFX9iEMDSQrGtHkhJY+okz9Z3IS17B0VDtQtqy3ndV
        DU35uOL4PL/9TxJfyPORlwmNTGm1S3QlslsQ
X-Google-Smtp-Source: ABdhPJxjAmo2ovKlm60IvoJxky+iKUF6BuDJdKXWp1pzrvgmxzgCNEarFOfUlp+DzNDRON+cPs/jug==
X-Received: by 2002:a50:fc94:: with SMTP id f20mr25432235edq.370.1616416409440;
        Mon, 22 Mar 2021 05:33:29 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id q10sm11247181eds.67.2021.03.22.05.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 05:33:29 -0700 (PDT)
Subject: Re: [PATCH 03/13] PCI: xilinx: Convert to MSI domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-4-maz@kernel.org>
 <20210322122315.GB11469@e121166-lin.cambridge.arm.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <a9fee2d4-5810-7a16-78bc-4b192e1123dc@monstr.eu>
Date:   Mon, 22 Mar 2021 13:33:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322122315.GB11469@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/21 1:23 PM, Lorenzo Pieralisi wrote:
> On Thu, Feb 25, 2021 at 03:10:13PM +0000, Marc Zyngier wrote:
>> In anticipation of the removal of the msi_controller structure, convert
>> the ancient xilinx host controller driver to MSI domains.
>>
>> We end-up with the usual two domain structure, the top one being a
>> generic PCI/MSI domain, the bottom one being xilinx-specific and handling
>> the actual HW interrupt allocation.
>>
>> This allows us to fix some of the most appaling MSI programming, where
>> the message programmed in the device is the virtual IRQ number instead
>> of the allocated vector number. The allocator is also made safe with
>> a mutex. This should allow support for MultiMSI, but I decided not to
>> even try, since I cannot test it.
>>
>> Also take the opportunity to get rid of the cargo-culted memory allocation
>> for the MSI capture address. *ANY* sufficiently aligned address should
>> be good enough, so use the physical address of the xilinx_pcie_host
>> structure instead.
> 
> I'd agree with Bjorn that the MSI doorbell change is better split into
> a separate patch, I can do it myself at merge if you agree.

Thank you for doing it.

Thanks,
Michal
