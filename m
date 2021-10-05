Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D00342300C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhJESdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:33:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49786 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJESdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:33:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 195IVHNu121097;
        Tue, 5 Oct 2021 13:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633458677;
        bh=WR7f8Krasvfot852Hz+xWJQu23dBi0fQnvs1vHZffPk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=r7XAyPRQfOvzrfAyjDTHt1LiHG1Gw6CcYZeSokRqNBUg+x3l1iMEoE18Dl1/MgZiR
         B7N4l44WF3CwZp/cSiiHPAIrl/pA8edn9sDSyKOcyO/6MP9wdbwh6WZhNz7V8dg5Rt
         9+NFW+x57Fagwp8LSr/FYW4w6iuqke/V7arn6NLE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 195IVHWC002177
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Oct 2021 13:31:17 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Oct 2021 13:31:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Oct 2021 13:31:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 195IVHHF062004;
        Tue, 5 Oct 2021 13:31:17 -0500
Date:   Tue, 5 Oct 2021 13:31:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>, Sinthu Raja <sinthu.raja@ti.com>,
        Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH V2 2/4] dt-bindings: arm: ti: am642/am654: Allow for SoC
 only compatibles
Message-ID: <20211005183117.fndcsfjdfhjmidib@lantern>
References: <20210925201430.11678-1-nm@ti.com>
 <20210925201430.11678-3-nm@ti.com>
 <YVs/v7g8wwLq/ujb@robh.at.kernel.org>
 <20211004185920.26iyyq3xz7vjam5i@gentile>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211004185920.26iyyq3xz7vjam5i@gentile>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:59-20211004, Nishanth Menon wrote:
> On 12:54-20211004, Rob Herring wrote:
> > On Sat, Sep 25, 2021 at 03:14:28PM -0500, Nishanth Menon wrote:
> > > Maintain consistency in K3 SoCs by allowing AM654 and AM642 platforms
> > > just state SoC compatibles without specific board specific compatibles
> > > aligned with what we have done for J721E/J7200 platforms as well.
> > 
> > This is the wrong direction IMO. Why do you want this other than 
> > alignment?
> 
> Many downstream boards tend not to have an specific compatible at least
> during initial phase and I would like folks to start using checks to
> make sure that the easy to catch issues via match against bindings are
> already handled.
> 
> I am curious as to why you think this is wrong - because we permit an
> alternative option that allows the board files to be less specific?


Thinking again, I get the rationale. We are attempting to be specific,
and this patch reverses the direction. Agreed. Will drop applying this
patch. Also, for future SoCs, will insist on being specific compatible.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
