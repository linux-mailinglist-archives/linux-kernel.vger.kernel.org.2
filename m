Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E610C33717D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhCKLgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:36:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52118 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhCKLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:36:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BBZwrK013092;
        Thu, 11 Mar 2021 05:35:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615462558;
        bh=ALsd/Ut/JY9yIh0a/At+DHay+1j+Ihvb5bUsWP+GodM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zPan4+rBQM/6QvxZun7AanJJawRN6CdWK5W1hmOJsKCKlBoDhkkk9373ggb2Y4DP2
         08II5gAf+rnPWyh7f/L11HGdLpYAOQz4KJr9DfWFYUzorrmVErzrj4vyQa3f4ll6LE
         ZfeUGegjD3YKPqXAVBzCrGdFaTgJ8i7jnhOv3FZs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BBZvs6024142
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 05:35:58 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 05:35:57 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 05:35:57 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BBZsHY103876;
        Thu, 11 Mar 2021 05:35:55 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add ADC nodes
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210309130708.12391-1-vigneshr@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <106b78af-1606-a4aa-2b11-e4e3c5592bed@ti.com>
Date:   Thu, 11 Mar 2021 17:05:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309130708.12391-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/21 6:37 pm, Vignesh Raghavendra wrote:
> AM64 SoC has a single ADC IP with 8 channels. Add DT node for the same.
> 
> Default usecase is to control ADC from non Linux core on the system on
> AM642 GP EVM, therefore mark the node as reserved in k3-am642-evm.dts
> file. ADC lines are not pinned out on AM642 SK board, therefore disable
> the node in k3-am642-sk.dts file.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

