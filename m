Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB6306060
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhA0P6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:58:40 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35672 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbhA0P4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:56:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10RFsgYK070432;
        Wed, 27 Jan 2021 09:54:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611762882;
        bh=G3P+78on/TWqACdAlhbVu3n0xTxWbsdD8Nbgcyzprxs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=J8oalWYbJx9HMRhdW0atd4N1mbqwsMYDek9eeN5jHC+uILLGMsfANCAGXXw90R4q5
         8uBuwtghIL7CA6CQX0h5RZ9YvIDF8dIEg8dRqOx0JrA+ICR55KqkFRE2F8msQHI72N
         O3aU8e1AN2RJjcoBb0r6T3OeNT6WfXg6U4ijcvWU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10RFsgbe011498
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jan 2021 09:54:42 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 Jan 2021 09:54:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 Jan 2021 09:54:41 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10RFsfVM130156;
        Wed, 27 Jan 2021 09:54:41 -0600
Date:   Wed, 27 Jan 2021 09:54:41 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dts: ti: k3-j7200-main: Add support for zeroth
 instance of GPIO subsystem
Message-ID: <20210127155441.e2oho7m4aeovkafw@absinthe>
References: <20210127150815.16991-1-a-govindraju@ti.com>
 <20210127150815.16991-2-a-govindraju@ti.com>
 <20210127151256.tgbhpngy6fi43edj@create>
 <9308ad5d-48bd-ebd2-2ea3-9775b8c11163@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9308ad5d-48bd-ebd2-2ea3-9775b8c11163@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:56-20210127, Aswath Govindraju wrote:
> Hi Nishanth,
> 
> On 27/01/21 8:42 pm, Nishanth Menon wrote:
> > On 20:38-20210127, Aswath Govindraju wrote:
> >> Add support for the zeroth instance of GPIO subsystem in the main domain.
> >>
> >> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > 
> > 
> > I really dont want to pick up one patch per node instance. It is hard
> > to scale and just creates a lot of noise.
> > 
> 
> As the main goal of the patch series was to add support for higher speed
> modes in MMC, I added only the required ones. If required I will send a
> follow up patch to add the remaining GPIO nodes.


I dont plan on picking this patch up in it's current form. please send a
patch with all the gpio nodes added in as it makes no sense to split
these out.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
