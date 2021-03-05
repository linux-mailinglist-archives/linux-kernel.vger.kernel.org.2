Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCA32F48A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 21:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCEUTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 15:19:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52542 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCEUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:18:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 125KIcMv071433;
        Fri, 5 Mar 2021 14:18:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614975518;
        bh=Lr6e2h+c4yZuZf/JIJqYZJVomrIWaQe3tnb72Z+F05w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UjT2AKCEF1QEIfvKKRO0ZO4nYub7BFjw1ZaSjD8gzVvqSGgq3bCZSaRCMjYPMjrqE
         KgiXr12q34aD1oxuzXKWi9R1qv5anOtK0n+u8Sgbh3gaS2w/JYywg5DEEUj2C3nsFS
         wp1ZEcKEYKBhBz4d5JgPJ10kc1wPbqht++loI1bM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 125KIcaX030908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Mar 2021 14:18:38 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Mar
 2021 14:18:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Mar 2021 14:18:37 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 125KIbW8032082;
        Fri, 5 Mar 2021 14:18:37 -0600
Date:   Fri, 5 Mar 2021 14:18:37 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jan Kiszka <jan.kiszka@siemens.com>, Le Jin <le.jin@siemens.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add Siemens vendor prefix
Message-ID: <20210305201837.okhrvl2gnywpjfvt@luckily>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <4726d7ad39d40916a02b5e79fc17e15934e97f5d.1613071976.git.jan.kiszka@siemens.com>
 <20210305193336.GA520824@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210305193336.GA520824@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:33-20210305, Rob Herring wrote:
> On Thu, 11 Feb 2021 20:32:53 +0100, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Add prefix for Siemens AG.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Rob, as the vendor prefix maintainer, do you see a problem if I carry
this patch on my tree for -next?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
