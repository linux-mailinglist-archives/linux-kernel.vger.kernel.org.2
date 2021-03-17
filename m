Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0914E33F8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhCQTRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:17:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43844 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhCQTRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:17:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12HJGs3k064784;
        Wed, 17 Mar 2021 14:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616008614;
        bh=jsQOfjpbp04TY9yBBdvk2lKx8Ml6EzBPMf8jcmIoMB0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AmtY9LpjjSXq0uKTCALyhbZsba/N8boopjZHFx4s04VIXbJ4KnmXwFxArKoTj1qwJ
         VgyTU+wvQyVhuEh1Uno4Ex90Hs3HRjnXELi6K1WC/gTDDtv5m5bgR/bnLMIKvmNtNg
         0GLdtrcyONvOqxC52duJr4Z4pVwqO0v8pOmtp0EU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12HJGsUi109410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Mar 2021 14:16:54 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 17
 Mar 2021 14:16:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 17 Mar 2021 14:16:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12HJGske042673;
        Wed, 17 Mar 2021 14:16:54 -0500
Date:   Wed, 17 Mar 2021 14:16:54 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] AM64: Add USB support
Message-ID: <20210317191654.qwrrgwqpjx4kkmh7@supper>
References: <20210317043007.18272-1-a-govindraju@ti.com>
 <33c7b945-5a3b-649b-ebaf-26465e480edc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33c7b945-5a3b-649b-ebaf-26465e480edc@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:22-20210317, Kishon Vijay Abraham I wrote:
> Aswath and Nishanth,
> 
> On 17/03/21 10:00 am, Aswath Govindraju wrote:
> > The following series of patches, add USB support for AM642 evm.
> > 
> > USB test logs,
> > https://pastebin.ubuntu.com/p/YSQRBWGmzd/
> 
> Vinod has provided stable tag [1]
> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
> tags/ti-serdes-for-5.13
> 
> This should unblock us from up-streaming SK along with this.
> 

Awesome. Thanks Vinod and Kishon for helping co-ordinate this.

Ashwath,

Please highlight this detail as part SK USB3 addendum series and I can
pick it up as part of pulling that series in. our window is starting to
narrow, so lets respin asap.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
