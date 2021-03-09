Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EEA332AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhCIPjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:39:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47152 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhCIPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:39:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129FctWI017748;
        Tue, 9 Mar 2021 09:38:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615304335;
        bh=G0ExlFHKtBAp5VXjCHg03TV5G46LeEwSAT/3Tybj83g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tiq+y+SWp0WYku+jiq84sw18IgzMD+QaREBsuCnA1ZV4yce7cTPcm15Hh1f7r6MIM
         QZ7Bbd02YCBvOuD3eTiHxwfC+gqNAdK6+3jsTS1QpNEGZWa8kN0hC1GnvQqJIywzR2
         uhBiLd5j9vRD8SNU38ox+tDKi+keNN6LgU8/YP3I=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129FcsaA004738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 09:38:54 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 09:38:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 09:38:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129Fcsdp016578;
        Tue, 9 Mar 2021 09:38:54 -0600
Date:   Tue, 9 Mar 2021 09:38:54 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Le Jin <le.jin@siemens.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: ti: Add support for Siemens IOT2050
 boards
Message-ID: <20210309153854.mk4fm2acttt5wufi@clanking>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <0c64b6ad43e7a691c1547524da4a9fd33e61c70c.1613071976.git.jan.kiszka@siemens.com>
 <95e4231c-6bee-ba64-412f-87d257df61c4@ti.com>
 <0561ad0d-7297-35ad-a3a9-49dc9a6bacd3@siemens.com>
 <aecad46d-bce6-5caf-254e-e6385ce8f44b@siemens.com>
 <20210309151019.kbay4ragt6ctyhmx@remote>
 <58952252-1770-a226-828b-dd58fd466ae8@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58952252-1770-a226-828b-dd58fd466ae8@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:22-20210309, Jan Kiszka wrote:
> On 09.03.21 16:10, Nishanth Menon wrote:
> > On 09:38-20210309, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Add support for two Siemens SIMATIC IOT2050 variants, Basic and
> >> Advanced. They are based on the TI AM6528 GP and AM6548 SOCs HS, thus
> >> differ in their number of cores and availability of security features.
> >> Furthermore the Advanced version comes with more RAM, an eMMC and a few
> >> internal differences.
> >>
> >> Based on original version by Le Jin.
> >>
> >> Link: https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
> >> Link: https://github.com/siemens/meta-iot2050
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> >> ---
> > 
> > Jan,
> > 
> > I am not sure if
> > https://lore.kernel.org/linux-arm-kernel/20210304160712.8452-2-s-anna@ti.com/
> > is going to impact your platform. I am planning on picking that series up today.
> > might be good to test against tomorrow's next - running through my basic
> > tests right now before committing to the ICSS-G nodes being picked up.
> > 
> > If you could repost after testing against tomorrow's next, it will
> > probably be better.
> 
> Thanks, I was already on CC. That series does not affect the board
> features as configured in this patch. However, we are eagerly awaiting
> ISCCG and then PRU Ethernet support in upstream as this is used on our
> boards, with both SR1.0 and (upcoming) SR2.0.

Cool, thanks.

> 
> However, I can update [1] with that series and retest our staging
> integration. But as you can see from the topmost commit, it is
> constantly shaking as upstreaming goes on.

Yep, hopefully things should settle down soon-ish, I hope. Thanks for
the link.

> 
> Jan
> 
> [1] https://github.com/siemens/linux/commits/jan/iot2050
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
