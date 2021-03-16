Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F633D3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCPMWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:22:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56788 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCPMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:21:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12GCLho6120641;
        Tue, 16 Mar 2021 07:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615897303;
        bh=6XL5ZOrYfi/rYwChu/eVjSbdtk43zT/iZTKZhZl9A3c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=L48hoEgGZjnf7pW93+fLuTFzgzTpMycg1PT2KGCmk61sa6jXbXyWlOHJpt0d/ZJkO
         QiFNmt58UvzdAWiQubS9CSaPXXliOmJjlMJOiFB64lZDpDzSlS8l50NgZ4jFfHE+hQ
         ZITLnOujujiHdJCJFkjE1W/CyZoXR6W2zi7dChGU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12GCLheT002341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 07:21:43 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 07:21:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 07:21:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12GCLhJv069995;
        Tue, 16 Mar 2021 07:21:43 -0500
Date:   Tue, 16 Mar 2021 07:21:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] AM64: Add USB support
Message-ID: <20210316122142.y6l2g4whsl45cexj@raven>
References: <20210310112758.1982-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210310112758.1982-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:57-20210310, Aswath Govindraju wrote:
> The following series of patches, add USB support for AM642 evm.
> 
> USB test logs,
> https://pastebin.ubuntu.com/p/Qrbb7SGv8N/
> 
> Changes since v1:
> - Rebased the patches on top of ti-k3-dts-next
> - Added test logs
> 
> Aswath Govindraju (2):
>   arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
>   arm64: dts: ti: k3-am642-evm: Add USB support
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> -- 
> 2.17.1
> 

	I see:
	/workdir/arch/arm64/boot/dts/ti/k3-am642-evm.dt.yaml: cdns-usb@f900000: compatible: 'oneOf' conditional failed, one must be fixed:

I assume there is a reason for this? Can you capture that in the commit
message?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
