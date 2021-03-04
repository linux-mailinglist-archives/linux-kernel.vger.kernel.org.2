Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF01D32CEBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhCDIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:46:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50690 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhCDIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:46:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1248jJhr016367;
        Thu, 4 Mar 2021 02:45:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614847519;
        bh=I+QMqMp5VoK7+KQ+kqBL4wJ7n8inPaoTdGPsJ+uf6IQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SvIJY3OnU2ATIK/gJlczx05VA3Cehw4UePgKrLZHEDlNYg+PwM434Tz5DLf3DWY+k
         OUjvtq8wW8+0Lm/RxGHW2FGm8Z/0IcX3ZUOa+DtBJtnklOT04aQi9TYRj0jGWtfUjj
         pQOI4X8hoJ5oOQfqRaAGle5GZZx4ly1IcxmExOSQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1248jJ84066456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 02:45:19 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 02:45:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 02:45:19 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1248jGQJ103372;
        Thu, 4 Mar 2021 02:45:16 -0600
Subject: Re: [PATCH 0/4] arm64: dts: ti: am642x: add CPSW3g DT nodes
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>
References: <20210303192114.12292-1-grygorii.strashko@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <72de97eb-81c6-54e6-bbd8-f972226f7a90@ti.com>
Date:   Thu, 4 Mar 2021 14:15:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303192114.12292-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/21 12:51 am, Grygorii Strashko wrote:
> Hi
> 
> This series adds corresponding AM642x CPSW3g nodes required to enable networking
> on TI am642-evm/sk platforms and adds required pinmux/PHY nodes in corresponding
> board files.
> 
> Kernel Boot Log: 
> EVM: https://pastebin.ubuntu.com/p/6Qkbw35Jg3/
> SK: https://pastebin.ubuntu.com/p/Pd3xxP9J9K/

Except for the minor comment. Series

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> 
> 
> Grygorii Strashko (1):
>   arm64: dts: ti: k3-am64-main: add main CPTS entry
> 
> Vignesh Raghavendra (3):
>   arm64: dts: ti: am64-main: Add CPSW DT node
>   arm64: dts: ti: k3-am642-evm: add CPSW3g DT nodes
>   arm64: dts: ti: k3-am642-sk: Add CPSW DT nodes
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 89 +++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am64.dtsi      |  2 +
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 93 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 73 +++++++++++++++++++
>  4 files changed, 257 insertions(+)
> 
