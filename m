Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1782134155D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhCSG03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:26:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37806 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhCSG0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:26:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12J6PwdA040352;
        Fri, 19 Mar 2021 01:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616135158;
        bh=sfgae7YEBHArWauIp36inbiUJN+OT1t19yF7Avo2V4U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qoRVVsH+12d7wQiD5kzNcy22NHBJKc0hrm3cZSNgvwHpua/HAYrlKxDIhfBaAoKe4
         R9ioD6d8Z6kcf+wB0ixJx6DP+ifMShLvWgoHwETvSZTrixFP1EpKNnVobAyyGjv+jD
         PgyolRh0zpgUwUZ811gZ/xJP0twjZwtCE79jcl/I=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12J6Pw2q055334
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 01:25:58 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 01:25:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 01:25:58 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12J6PtIr068351;
        Fri, 19 Mar 2021 01:25:55 -0500
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-am642: reserve gpio in mcu
 domain for firmware usage
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210319051950.17549-1-a-govindraju@ti.com>
 <20210319051950.17549-3-a-govindraju@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <3d753b85-dd11-d4c3-5f24-e5c74f87b766@ti.com>
Date:   Fri, 19 Mar 2021 11:55:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319051950.17549-3-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/03/21 10:49 am, Aswath Govindraju wrote:
> The gpio0 subsystem present in MCU domain might be used by firmware and is
> not pinned out in evm/sk. Therefore, reserve it for MCU firmware.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

