Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECF338001
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhCKWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:02:05 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33700 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCKWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:01:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BM1hNR059014;
        Thu, 11 Mar 2021 16:01:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615500103;
        bh=iqbjIDn5aoYZVoETPq9RaOxNijO0u9nemjY4dLhYicU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qK1Ao0ijpNI7irJRx4xNGzff20F6MFZVoaxqcAttYJxoSHJ0ywaFZ7fw5rrEbrCzE
         3fqn6cRS56UpiigpvkliaRECcc0kvuTpkcEOXfFea5SxyLh4okkmwq+KnEE7VlSnvc
         TC+4vi5xo1jQUIttuBiq2ICpE9CVfUjNCAAASnF8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BM1hJW010586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 16:01:43 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 16:01:09 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 16:01:09 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BM19rE087587;
        Thu, 11 Mar 2021 16:01:09 -0600
Date:   Thu, 11 Mar 2021 16:01:09 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andre Przywara <andre.przywara@arm.com>, Rob H <robh@kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
Message-ID: <20210311215914.pgpz2yymmfqlainl@episode>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
 <20201118151259.kpag44djji4ssiup@eldest>
 <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
 <20210126000108.GA1267192@robh.at.kernel.org>
 <20210126163839.57491132@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210126163839.57491132@slackpad.fritz.box>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andre, Rob,
On 16:38-20210126, Andre Przywara wrote:
> > Now that I look back at the dtc change, I'm now confused why this 
> > check got applied. Both David and I wanted changes in regards to 
> > #address-cells. Either a separate check or part of interrupt-map checks. 
> > And the interrupt-map check never got applied. Andre?
> 
> Yeah, I somewhat dropped the ball on this, after some iterations and a
> partial merge. Will put it on my list to revive this.


I was hoping we made some steps, but I did see [1] as well and it is
possible that I am missing some discussion, but it is starting to get
W=2 builds warnings noisy enough to start interfering with discovering
real problems as we keep adding new stuff in.. Just wondering...


[1] https://lore.kernel.org/linux-devicetree/CAL_Jsq++DyiKG9smQGx9FAPDJnVrezcXNb0Y5uh-5_2GBzTQpQ@mail.gmail.com/
[2] https://pastebin.ubuntu.com/p/ns6hPCBxVM/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
