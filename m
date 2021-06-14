Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F83A6908
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhFNOeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:34:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36586 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhFNOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:34:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15EEWGdh072894;
        Mon, 14 Jun 2021 09:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623681136;
        bh=ZEXIB+2o/eHdHCXWPzEHpwRRAGGY1kDKN8HNXWJr+X4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CF11oIwv+EVuQETi1V8iui0pTkL/w39goQU+sfkG41mqMvtVWfe/6o2+iDtNXRzZh
         39PtVt8VwQvDqKQuEeWIBv+tLBsTGaCRAbw1IzRFvIduARGtlVKLIGb0VPndbeScyB
         lrkyt6SooPOmfU6awDNMiZAZzWnICvFAFYdf7u3w=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15EEWGQf046965
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jun 2021 09:32:16 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 14
 Jun 2021 09:32:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 14 Jun 2021 09:32:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15EEWGhc111699;
        Mon, 14 Jun 2021 09:32:16 -0500
Date:   Mon, 14 Jun 2021 09:32:15 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64-main: Update the location of
 ATF in SRAM and increase its max size
Message-ID: <20210614143215.4dzkwux4bijn47hs@cylinder>
References: <20210607133806.18158-1-a-govindraju@ti.com>
 <162343800075.7434.10921347563461214925.b4-ty@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <162343800075.7434.10921347563461214925.b4-ty@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:00-20210611, Nishanth Menon wrote:
> On Mon, 7 Jun 2021 19:08:06 +0530, Aswath Govindraju wrote:
> > Due to a limitation for USB DFU boot mode, SPL load address has to be less
> > than  or equal to 0x70001000. So, load address of SPL and ATF have been
> > moved to 0x70000000 and 0x701a0000 respectively.
> > 
> > Also, the maximum size of ATF has been increased to 0x1c000 [1].
> > 
> > Therefore, update ATF's location and maximum size accordingly in the device
> > tree file.
> > 
> > [...]
> 
> Hi Aswath Govindraju,
> 
> I have applied the following to branch ti-k3-dts-next on [1].
> Thank you!
> 
> [1/1] arm64: dts: ti: k3-am64-main: Update the location of ATF in SRAM and increase its max size
>       commit: d05c19bd3f588445eb6769fb71f2e5e02b7a959e
> 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent up the chain during
> the next merge window (or sooner if it is a relevant bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git


Based on discussion in [1], I have dropped this patch from my queue.


[1] https://lore.kernel.org/linux-arm-kernel/20210614142849.ogi4emuqgxg3m7ls@constrict/T/#t
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
