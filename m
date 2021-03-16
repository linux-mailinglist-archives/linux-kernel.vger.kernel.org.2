Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE3633D357
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhCPLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:48:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47682 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCPLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:47:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12GBllOi053827;
        Tue, 16 Mar 2021 06:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615895267;
        bh=RB8BKbHVGkC5iM/+Lrr0DiKLGzcqrEAK7Ue8ROz4oNM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yBFrAf/6N0JzUvvM2ATrD1JLBR6azEgE5hzoRZOMycEhelweNz0Ooipk9zFsRYEdF
         Wzg0VIiI33M0MfNpv6Ru1CJO+VjiMICxvC//8kmT/8SH/CUuEmTiVO311QTu3k4PWt
         0aU+VXU+SSFTcyB9gaPFeqE12fS2G46z1vXvHIQo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12GBllK9039354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 06:47:47 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 06:47:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 06:47:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12GBll1Y011372;
        Tue, 16 Mar 2021 06:47:47 -0500
Date:   Tue, 16 Mar 2021 06:47:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add ADC nodes
Message-ID: <20210316114747.pi4ts4zmgqmlszpr@appetizer>
References: <20210309130708.12391-1-vigneshr@ti.com>
 <106b78af-1606-a4aa-2b11-e4e3c5592bed@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <106b78af-1606-a4aa-2b11-e4e3c5592bed@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:05-20210311, Lokesh Vutla wrote:
> 
> 
> On 09/03/21 6:37 pm, Vignesh Raghavendra wrote:
> > AM64 SoC has a single ADC IP with 8 channels. Add DT node for the same.
> > 
> > Default usecase is to control ADC from non Linux core on the system on
> > AM642 GP EVM, therefore mark the node as reserved in k3-am642-evm.dts
> > file. ADC lines are not pinned out on AM642 SK board, therefore disable
> > the node in k3-am642-sk.dts file.
> > 
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>


Looks like the patch wont apply anymore after all the cpsw nodes got in.
could you rebase and repost?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
