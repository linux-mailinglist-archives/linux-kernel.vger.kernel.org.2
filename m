Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4119C332B55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCIP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:59:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52362 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhCIP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:58:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129Fwpau025678;
        Tue, 9 Mar 2021 09:58:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615305531;
        bh=BV8/rpExm5BWu2SNJlrTfVmgWccLMXLmXBTkkOWPwlk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=h06LAQaoPzpZ2xkw2njAFEO5CJuiOyNvFKL9G+X6Nn4FakzOcSSymzihJ6qy4EU1r
         C7JnWkXTtcO43x9HQOgUersjmg3yhHZaiV3FA9etirIwicxTbw6L7bU0Yr5qmcJxnq
         svUpy5BCeLXjxXYkzs4gsrZXbXHx0Hca7sj5q/Y0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129FwpWh045054
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 09:58:51 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 09:58:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 09:58:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129FwoUG106375;
        Tue, 9 Mar 2021 09:58:50 -0600
Date:   Tue, 9 Mar 2021 09:58:50 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] AM64: Add support for GPIO
Message-ID: <20210309155850.auyuxkrv5p3gkxcd@speed>
References: <20210304112924.12470-1-a-govindraju@ti.com>
 <20210309144333.6ko6olztldslj3fo@paralegal>
 <9ba5e86d-7a60-a35b-0fb4-ddc3052eecee@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ba5e86d-7a60-a35b-0fb4-ddc3052eecee@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:20-20210309, Aswath Govindraju wrote:
> Hi Nishanth,
> 
> On 09/03/21 8:13 pm, Nishanth Menon wrote:
> > On 16:59-20210304, Aswath Govindraju wrote:
> >> The following series of patches adds support for gpio on AM642 evm/sk.
> >>
> >> Changes since v1:
> >> - Added DT for gpio subsystem present in MCU domain
> >> - reserved the mcu gpio for firmware usage
> >>
> >> This series of patches depend on,
> >> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
> >> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439153
> >>
> >>
> >> Aswath Govindraju (2):
> >>   arm64: dts: ti: k3-am64: Add GPIO DT nodes
> >>   arm64: dts: ti: k3-am642: reserve gpio in mcu domain for firmware
> >>     usage
> >>
> >>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 45 ++++++++++++++++++++++++
> >>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 27 ++++++++++++++
> >>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  5 +++
> >>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  5 +++
> >>  4 files changed, 82 insertions(+)
> >>
> >> -- 
> >> 2.17.1
> >>
> > 
> > 
> > Based on your offline comment:
> > -----
> > 
> > On going through the bootlogs before posting for I found the following
> > errors,
> > 
> > [    1.091117] davinci_gpio 601000.gpio: IRQ index 2 not found
> > [    1.101522] davinci_gpio 601000.gpio: error -ENXIO: IRQ not populated
> > 
> > Some issues in allocating interrupts in case of main_gpio1. I
> > accumulated the gpio with interrupt numbers. I'll try to debug the
> > reason behind it and update you with its status. (bootlogs of ti-sdk,
> > also have this error).
> > 
> > -----
> > 
> > I am going to drop this off my queue, please update if the fixup is some
> > system configuration error or repost with fix.
> > 
> 
> This is expected to be a fixup in the system configuration and not a bug
> in the patch series. So, can you please have these patches in your queue
> ? I'll soon post the test results indicating the functioning of GPIOs.


Thanks for clarifying. I will wait till the test results are posted.
Thanks in advance for digging into this and detailed testing.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
