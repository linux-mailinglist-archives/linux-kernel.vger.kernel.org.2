Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6652A3189CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBKLrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhBKLVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:21:33 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24998C061574;
        Thu, 11 Feb 2021 03:20:52 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DbvM65VlQz1ryX5;
        Thu, 11 Feb 2021 12:20:50 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DbvM64CgGz1qqkj;
        Thu, 11 Feb 2021 12:20:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id B7gAg38INMBf; Thu, 11 Feb 2021 12:20:48 +0100 (CET)
X-Auth-Info: bZBan9mJO87T5FEmIs2zk/GYzHwW6N2f41a4gNFU4sA=
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 11 Feb 2021 12:20:48 +0100 (CET)
Subject: Re: [PATCH] pinctrl: imx: imx8mm: fix pad offset of SD1_DATA0 pin
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Claudius Heine <ch@denx.de>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210211095413.1043102-1-ch@denx.de>
 <03ac353d-e7a1-5235-a787-21014d0c7607@kontron.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <675ce5b7-1854-e168-55e4-1db90adce0a1@denx.de>
Date:   Thu, 11 Feb 2021 12:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <03ac353d-e7a1-5235-a787-21014d0c7607@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 11:17 AM, Frieder Schrempf wrote:
> On 11.02.21 10:54, Claudius Heine wrote:
>> There is a 0 missing in the pad register offset. This patch adds it.
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
> 
> I think this should rather be prefixed by "arm64: dts: imx8mm:" as this 
> is no change in the pinctrl driver, but only in the devicetree.
> 
> And I guess this deserves a "Fixes" and "Cc: stable" tag, so:
> 
> Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for 
> imx8mm")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Indeed.

But since this isn't the first such fix, I wonder whether it wouldn't be 
a good idea to regenerate those pinctrl tables and see whether there are 
any other such issues in them. I wonder, is there some sort of register 
and bit list in machine-parseable form for the MX8M ?
