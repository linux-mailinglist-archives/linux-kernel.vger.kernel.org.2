Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA93329DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhCIPLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:11:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38668 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhCIPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:11:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129FAJ6S004410;
        Tue, 9 Mar 2021 09:10:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615302619;
        bh=pARYfzVWJ+R5NmwtmFJMmgifXA+woU8wgY6HMNSiu7U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Y0SzlcILL+rYnwxpUCWryWtGDRjaZYnD2m4/3ghuBkKLOVrLc3tAOBGZM82v70+NG
         Ws8UcU9bNFzu+WdAtMYNowYfb1fmiRzN2UTkTo/AMF6Q8xHsf6eQhyALhIg4oXP5Tt
         3kIz4XIVjC0f6zkUCIZ9ruVrYBEXoeF0IBPokILs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129FAJuh078771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 09:10:19 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 09:10:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Mar 2021 09:10:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129FAJKX002768;
        Tue, 9 Mar 2021 09:10:19 -0600
Date:   Tue, 9 Mar 2021 09:10:19 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Le Jin <le.jin@siemens.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: ti: Add support for Siemens IOT2050
 boards
Message-ID: <20210309151019.kbay4ragt6ctyhmx@remote>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <0c64b6ad43e7a691c1547524da4a9fd33e61c70c.1613071976.git.jan.kiszka@siemens.com>
 <95e4231c-6bee-ba64-412f-87d257df61c4@ti.com>
 <0561ad0d-7297-35ad-a3a9-49dc9a6bacd3@siemens.com>
 <aecad46d-bce6-5caf-254e-e6385ce8f44b@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aecad46d-bce6-5caf-254e-e6385ce8f44b@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:38-20210309, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Add support for two Siemens SIMATIC IOT2050 variants, Basic and
> Advanced. They are based on the TI AM6528 GP and AM6548 SOCs HS, thus
> differ in their number of cores and availability of security features.
> Furthermore the Advanced version comes with more RAM, an eMMC and a few
> internal differences.
> 
> Based on original version by Le Jin.
> 
> Link: https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
> Link: https://github.com/siemens/meta-iot2050
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---

Jan,

I am not sure if
https://lore.kernel.org/linux-arm-kernel/20210304160712.8452-2-s-anna@ti.com/
is going to impact your platform. I am planning on picking that series up today.
might be good to test against tomorrow's next - running through my basic
tests right now before committing to the ICSS-G nodes being picked up.

If you could repost after testing against tomorrow's next, it will
probably be better.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
