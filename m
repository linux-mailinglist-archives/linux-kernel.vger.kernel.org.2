Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D9833AB4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCOFyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:54:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47198 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCOFyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:54:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12F5sTrL045733;
        Mon, 15 Mar 2021 00:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615787669;
        bh=yxTzeyuJ1u64hRuS0S+cMJtTYAD67t7PxhEhg06Gyvk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cR76ZBixRK2EIqS93rWlL2mwXhnuKcgA3lDW4/mkVrm1qY4jVb9wKr70AWDe5+pj4
         UihI0QUXT9rPPmw2VWzqBU+wUy/usjQN05pUa4COAL9MtBVoyBFiXIr2cPFmWkf6Wj
         oUtE8GSRFQv+8v4zZq0Q457Cb2fSsIlyNwRD0dw8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12F5sTWb091893
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Mar 2021 00:54:29 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 15
 Mar 2021 00:54:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 15 Mar 2021 00:54:29 -0500
Received: from [10.250.235.121] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12F5sPZK079162;
        Mon, 15 Mar 2021 00:54:26 -0500
Subject: Re: [PATCH v2 0/2] AM64: Add USB support
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210310112758.1982-1-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b6a4609e-3b62-fd92-bdb7-ce7c0db1a73c@ti.com>
Date:   Mon, 15 Mar 2021 11:24:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310112758.1982-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/21 4:57 pm, Aswath Govindraju wrote:
> The following series of patches, add USB support for AM642 evm.
> 
> USB test logs,
> https://pastebin.ubuntu.com/p/Qrbb7SGv8N/
> 
> Changes since v1:
> - Rebased the patches on top of ti-k3-dts-next
> - Added test logs

Would prefer simple data transfer tests in the log but other than that
for the patches itself

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Aswath Govindraju (2):
>   arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
>   arm64: dts: ti: k3-am642-evm: Add USB support
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
>  2 files changed, 48 insertions(+)
> 
