Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80842ABD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhJLS1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:27:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58896 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhJLS1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:27:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19CIOmlx112024;
        Tue, 12 Oct 2021 13:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634063088;
        bh=N8ljt3/BRUcAh5ZZnY7/+EAddTqC56LKEo+230v3DP8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dvtybZxnEXfOAPFzHahAi4h+49ZWfumNFXU4FfgWU5/ya8OHh0FAXqWq6Lj7ZRaLI
         aOTWQQ/ceuCKExKgIwxJQQmr9FEGvixLl94Gf52P3H9g3ezlKTjAo2BboszUhznQC1
         paqLjAiobQemQDLEA5THjNKbPMeaWHtDcbwh0TYA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19CIOmDr054576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Oct 2021 13:24:48 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Oct 2021 13:24:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Oct 2021 13:24:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19CIOk0D038630;
        Tue, 12 Oct 2021 13:24:47 -0500
Date:   Tue, 12 Oct 2021 23:54:46 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Sven Eckelmann <sven@narfation.org>
CC:     <openwrt-devel@lists.openwrt.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Adrian Schmutzler <dev@schmutzler.it>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-mtd@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: nvmem: Defining cells on mtd created by mtdparts
Message-ID: <20211012182444.qrn3lzp7vukklwlx@ti.com>
References: <18728084.NGlc0Rocea@sven-desktop>
 <14722734.oMan5NXi5u@sven-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14722734.oMan5NXi5u@sven-desktop>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On 11/10/21 09:06AM, Sven Eckelmann wrote:
> On Sunday, 10 October 2021 14:53:13 CEST Sven Eckelmann wrote:
> [...]
> > Since there are most likely more devices out there which use mtdparts, I would 
> > guess that there might already be a strategy out there which can be used to 
> > define the nvmem-provider for mtdparts defined partitions. At least I saw that 
> > Bartosz Golaszewski added all the mtd devices automatically as nvmem provider 
> > in c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem 
> > API"). So there might also be something for nvmem-cells to find the correct 
> > mtd instead of relying on the fixed-partitions registration + of_node (which 
> > doesn't exist because it comes from mtdparts and not devicetree).

I have been wanting to fix this problem for a while but just never got 
around to it. I was thinking about either extending the mtdparts syntax 
to maybe add nvmem cell information in there or adding a separate 
cmdline argument that complements mtdparts with nvmem cell info. Dunno 
if either of these would work well though...

> 
> Ansuel Smith just proposed in OpenWrt [1] a workaround. It basically adds a 
> minimal fixed-partitions parser to the mtd cmdlinepart parser (responsible for 
> the mtdparts=) that tries to find the matching (size + offset) fixed-partition 
> from the devicetree. The code in mtd_device_parse_register
> (add_mtd_partitions -> add_mtd_device -> mtd_nvmem_add) will then 
> automatically take care of the rest.

I don't quite see how this helps. You say that some devices don't have a 
device tree at all so how would you even match the fixed partition? And 
this of course doesn't solve the problem where you might want nvmem 
cells with a partition layout that is different from the one in device 
tree.

I unfortunately don't really have any answers for this at this point, 
but maybe I can figure something out in the future...

> 
> Kind regards,
> 	Sven
> 
> [1] https://github.com/openwrt/openwrt/pull/4664#issuecomment-939567963



> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
