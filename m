Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77DF40B8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhINUTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:19:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38938 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbhINUTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:19:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18EKHgKv119046;
        Tue, 14 Sep 2021 15:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631650662;
        bh=sa18CJ4cLCTP9vAmABvziakIoPCH/PszhmZbN0S9cTc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kCjP0xfIxHQoWTSeITYjBlXzm/UFEUn0gLLBpWMVmRqlR5bz6KXcBwoiK+H+h5ADj
         EQAAJdKyHO498zrLrI7OXvdTxm2HVPqTLYZ6x34uPqdjHGJk37w3Hey4BJqCuRrejN
         kmBElOoGTH7AQeEAQKHzwco4y/7XlyUP/kDXyAwk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18EKHgr9077092
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Sep 2021 15:17:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Sep 2021 15:17:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Sep 2021 15:17:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18EKHf7W097900;
        Tue, 14 Sep 2021 15:17:41 -0500
Date:   Tue, 14 Sep 2021 15:17:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH v3 4/5] arm64: dts: ti: iot2050: Prepare for adding
 2nd-generation boards
Message-ID: <20210914201741.mz26sg6yvxqg6guf@diving>
References: <cover.1631216478.git.jan.kiszka@siemens.com>
 <a0b569b9919a1d2c2bc20defeb310561572850da.1631216478.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a0b569b9919a1d2c2bc20defeb310561572850da.1631216478.git.jan.kiszka@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:41-20210909, Jan Kiszka wrote:
[..]
> copy from arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> copy to arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> index ec9617c13cdb..d25e8b26187f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> @@ -4,10 +4,9 @@
>   *
>   * Authors:
>   *   Le Jin <le.jin@siemens.com>
> - *   Jan Kiszka <jan.kiszk@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>

^^ please call that email ID out in the commit message as well.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
