Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E13B5CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhF1LCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:02:01 -0400
Received: from phobos.denx.de ([85.214.62.61]:51970 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhF1LB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:01:59 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F18FA82DA2;
        Mon, 28 Jun 2021 12:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1624877973;
        bh=/uSwIhUTGzgWud23+aNg1TbxMnbf4cZss/WEmETMEjk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=x/vH1wVtGgHw+yvzhphYwEHnlVO5UOyO9VVWdjw6WXS5MjtoaIjT5EZZcYgEIRod4
         ynJMaTJHC4Gx3F5FJhvJSPTBK15iV9wiODNuoGRDjbAbnliz5inXIdwXgRU/eWciTF
         MLawKS6d+wtLoqTyouuSAiCsF9WrNxYjFMwU/aPQ25DSkNlufyl+LDSiz1V0+nLIJS
         //mkv8ZCZgZx/9WjF021RhUhAKYjOVYYTQ+r2tdzaCmlEGwhBsoJ4P2zEbiae4U5uJ
         FcYa+pdSUE47JCm4mZXKMXMK0mDTtjsxHW8Mi1P99BymubE1Hh+a1zgSynqj9nyeSk
         5hVWfLoPBP2Bg==
Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
To:     Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20210612133134.2738-1-peng.fan@oss.nxp.com>
 <20210612133134.2738-5-peng.fan@oss.nxp.com>
 <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <2c39672b-780a-8e33-038e-0856e32ede7a@denx.de>
Date:   Mon, 28 Jun 2021 12:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 8:07 PM, Adam Ford wrote:
> On Sat, Jun 12, 2021 at 7:58 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
>> that support in this driver.
>>
>> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Maybe my TF-A is too old, but I am not able to wake the device from
> suspend-to-ram with this series.  I used the device tree from [1] to
> enable both the GPCv2 and the blk-ctl stuff.
> 
> [1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210604111005.6804-1-peng.fan@oss.nxp.com/
> 
> I based both off Shawn's for-next branch.

I also ran into issues with this, although it could also be related to 
GPCv2. On MX8MM , the system sometimes hangs when bringing up the GPCv2 
power domain 6 (VPUMIX). It seems that the GPCv2 driver sets 
GPC_PU_PGC_SW_PUP_REQ register to 0x100 to bring up the VPUMIX and the 
bit never self-clears. After that, it seems the entire GPC locks up. 
Have you ever seen that kind of behavior ?
