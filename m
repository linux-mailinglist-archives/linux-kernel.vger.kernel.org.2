Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAFE45A4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbhKWONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:13:52 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50322 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbhKWONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:13:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1ANEAOfG113384;
        Tue, 23 Nov 2021 08:10:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637676624;
        bh=qv1wGUQW2WZVJpfqaD6uoCEXNFoMFEymMrqfwcPcxr8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=x2QeTftA9aQ/DKruRcqgjfESEhmmoDOLHbbeOHLnkp3/YtY6pEVeXVxuMB3HkfPNe
         5SvOPJG74ynvcQMFxN4gbgJxD98c4rKNti4sFPKIRIpu3RAeG1Oou59aR5JCeVitiM
         Z7RCFc93tvAFMvzbdhubJ03JXAfAetI14pbw05xo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1ANEAOQH113058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 08:10:24 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 23
 Nov 2021 08:10:24 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 23 Nov 2021 08:10:24 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1ANEAOfg082069;
        Tue, 23 Nov 2021 08:10:24 -0600
Date:   Tue, 23 Nov 2021 08:10:24 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <kishon@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Message-ID: <20211123141024.hv3eruvegkahjeou@nuclear>
References: <20211123103908.14220-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211123103908.14220-1-rogerq@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:39-20211123, Roger Quadros wrote:
> Hi Nishanth,
> 
> This series adds GPMC and ELM controller nodes.
> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>   arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
>   arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> -- 
> 2.17.1
> 

Don't we need to disable the nodes in the board dts files, since these
are only on optional daughter cards for evm?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
