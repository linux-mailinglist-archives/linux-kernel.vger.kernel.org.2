Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC33B8710
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhF3Qaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3Qae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:30:34 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989DC061756;
        Wed, 30 Jun 2021 09:28:05 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7F7E382C0B;
        Wed, 30 Jun 2021 18:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1625070481;
        bh=oHVEsrewW6stMNciWz3pWjRt7Jm6Y/3FuNvd0veTo1I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fzPuMJ6fVndf5oRktVYsHXMiVKB2tIG2p69L8YsBJdDgdYTCSCtlvmgeNP5uinFHP
         rezc0l1CU+jXZoaR+3CbPQaVj1wyTnLDoYLXmfam+Mudn7BaAqTQihSR5jBry9Owux
         mhBR+LSnjiXzG+CVUxgkV0vYCFt0vziUApcTTVOSC8SKrOeCGWt/pbYrtfEwYRET4H
         3e4NXjojQKjaGay7olGPlYGb8r+t/DlY9qvqmkwpT8Iely3WX4TJbO1UnkgdwUl4Y0
         YMhZWPyl9peQAKBp+q0pQnrXoqSFkouZRAUK+1pipgp0BGyDKN73VXYKVVvoFWBgJR
         rV88Sdf23pJUw==
Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
 <CAHCN7xJgqRfg1sHNbcpdEFaLHUwhYxe7_r5SEMDqSaCPFXX7UQ@mail.gmail.com>
 <DB6PR0402MB2760B05081D54D775B8949CA88019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAHCN7xL6Rr41fHaaPwi6OA5Du8x09EHcE-bWyiGpz0pVn74jeQ@mail.gmail.com>
 <c6a00f74-6c34-4208-0b17-7fa15835eb3a@kontron.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <181ac373-7701-361e-6364-6fc74b2d71fe@denx.de>
Date:   Wed, 30 Jun 2021 18:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c6a00f74-6c34-4208-0b17-7fa15835eb3a@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 4:46 PM, Frieder Schrempf wrote:
> On 30.06.21 14:09, Adam Ford wrote:
>> On Wed, Jun 30, 2021 at 4:34 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>>
>>>> Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
>>>>
>>>> On Tue, Jun 29, 2021 at 1:56 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
>>>> wrote:
>>>>>
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> V8:
>>>>> Revert one change in v7, force goto disable_clk for handshake when
>>>>> power on in patch 3 One minor update to use if{} else {}, not if{};
>>>>> if{}; in patch 3 Typo Hankshake->Handshake
>>>>>
>>>> I am using ATF, branch lf_v2.4, from the NXP code aurora repo with U-Boot
>>>> v2021.07-rc5
>>>>
>>>> I applied this patch against linux-next, I applied the pgc patches [1], and the
>>>> suggested power-domains to the otg1 and otg2 nodes.
>>>> I am able to boot the device and use USB, but with this applied, I cannot wake
>>>> from sleep.  If I revert this, the system wakes from sleep again.
>>>
>>> I just tried linux-next without this patch on iMX8MM EVK, suspend/resume
>>> not work. Per my last test, it works before. Not sure what changed in kernel.
>>>
>>> Which kernel are you using, any commit or git repo? I could try on imx8mm
>>> evk and debug the issue you see.
>>
>> I used kernel-next,
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> commit 889bab4c367a0ef58208fd80fafa74bb6e2dca26 (tag: next-20210621)
>>
>> I then applied the GPCv2 patch that Marek sent.  You were CC'd on the
>> e-mail from Marek, but I can forward the patch to you if you can't
>> find it.
>> I tested his patch and I was able to suspend-to-RAM and resume.
>> Once I was comfortable that it worked, I then applied your patch
>> series for the blk-ctl.
>> With the blk-ctl series applied, the suspend-resume stopped working.
> 
> Same here. I tested with linux-next-20210629 and as soon as I add the BLK-CTL driver and devicetree nodes, the resume after suspend causes a lockup each time.

btw do you have etnaviv enabled ?
