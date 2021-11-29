Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3C3460E14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 05:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhK2EmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 23:42:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46412 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhK2EkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 23:40:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AT4aYml118115;
        Sun, 28 Nov 2021 22:36:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638160594;
        bh=uc+McsQyh4vXxa36jTByMhq1Rk8pFaR494tnqxl9MhU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ePYbcrzO7ceJxKPbVR6kg0/SijmM02JHi6HmlYZIvtojBs+YQStyedtyQkHYHdL5P
         cQAlRBJx1mpdRQFTxbKzoWMwrbbE9iKplbEPoK0dsdaaKHu7j8tQOgWTs4XDyRdJVs
         8MrHEwlIPYFZ8MQYT5Bb9ypyy/LiTdVekWi32aL8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AT4aYES100018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 28 Nov 2021 22:36:34 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 28
 Nov 2021 22:36:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 28 Nov 2021 22:36:34 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AT4aXji085863;
        Sun, 28 Nov 2021 22:36:33 -0600
Date:   Sun, 28 Nov 2021 22:36:33 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <kishon@ti.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/4] mtd: nand: omap2: Add support for NAND Controller on
 AM64 SoC
Message-ID: <20211129043633.myxmgp6idbrqvx5p@unlisted>
References: <20211123103609.14063-1-rogerq@kernel.org>
 <20211123103609.14063-5-rogerq@kernel.org>
 <20211124131552.6b9bc506@xps13>
 <e52141a6-96fc-97d6-95d7-3e26276fbac3@kernel.org>
 <20211126104231.7cc43149@xps13>
 <917ac002-9d4b-237d-94f3-bcd05f481f39@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <917ac002-9d4b-237d-94f3-bcd05f481f39@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:10-20211126, Roger Quadros wrote:
[...]

> >>>> +	/* Some SoC's have 32-bit at least, read limitation */
> >>>> +	if (soc_device_match(k3_soc_devices)) {
> >>>> +		dev_info(&pdev->dev, "force 32-bit\n");
> >>>> +		info->force_32bit = true;
> >>>> +	}
> >>>> +  
> >>>
> >>> As suggested above, just adding a capability structure tied to the
> >>> compatible string and retrieved with of_device_get_match_data() should
> >>> be enough and replace this manual tree research.  
> >>
> >> The trouble comes when TI updates the silicon revision to "SR2.0" and that has the issue fixed
> >> but still uses the same compatible. So compatible string by itself is not sufficient to identify
> >> the troubled devices. soc_device_match() was the easiest way to address this.
> > 
> > This is precisely what compatibles are for, I believe we should declare
> > the necessary additional compatibles and fix the device trees that are
> > wrong.
> 
> AFAIK TI SoCs don't have different compatibles for different revisions of the same SoC.
> My understanding is that the SoC is the same so compatible shouldn't change. Just that there were some
> hardware fixes and some quirks may not be needed anymore.
> 
> Nishanth,
> 
> Could you please chime in on why SoC revisions can't use different compatibles?
> 

The permutations of boards (with add-on cards) and SRs become
un-manageable esp when Silicon Revisions(SRs) dont actually get into
production. Instead, what we do suggest are one of two things:
a) The dts in k.org always reflect the latest SR for the chip that is
   going into production. Older SR revisions are supported as overlays on top
   of the dtb.
b) Where possible, use the chip-id framework[1] to dynamically detect
   the variations. This might be easier with newer K3 generation SoCs.


In this instance, an overlay corresponding to older SoC might be
feasible.



[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
