Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E164E37A088
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhEKHRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhEKHRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:17:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED56060FD9;
        Tue, 11 May 2021 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620717394;
        bh=zT07xd2iNPYwbWJc/3A+9gxG9yAD6m7tjmgNbpWYgG4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=s6b/Yp+kzwecHIHnLUJX2L4yHXPlUNC/wMUvJ3cMj0m4pW1NI3AqSFnEH/fsMYslC
         BHNldPBYYS569eHwiVq5aPiUIH3yOxsHdHjgFuiUxID9o9VIKP072ZvSLDz2Z8GcX8
         JJrmApHm52rnja3H7AEFuplwASf74lu0DW5y7857wG1ExiRuZKSXNP/ACU5DRdCeJL
         nQzOwqXkUtG0FS0QEtcbetpIksDUYFwXX/9zJHF47nsY/KjjUI45s2g2jRrSjtYxMR
         9Pe4LZeDNTQs2juWZBXwHIe7EsAN8us2aZGx4BX7AgruZzlr5nbCgSMEt1eIIuPNIU
         oZbe8p2srTWHw==
Subject: Re: [PATCH 0/4] ARM: dts: keystone: k2g: Update dts node for yaml
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210510144312.986-1-nm@ti.com>
From:   Tero Kristo <kristo@kernel.org>
Message-ID: <5e8b7521-5957-1702-0e3a-e2df360d66b7@kernel.org>
Date:   Tue, 11 May 2021 10:16:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510144312.986-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 17:43, Nishanth Menon wrote:
> Hi,
> 
> Series of patches to cleanup the dts for k2g to sync the dts
> with yaml fixups (information provided per patch)
> 
> 
> Basic tests performed on k2g-evm. Series has been based on v5.13-rc1 -
> will be good to get it in the 5.13 window if possible.
> 
> Nishanth Menon (4):
>    ARM: dts: keystone: k2g: Rename message-manager node
>    ARM: dts: keystone: k2g: Rename the TI-SCI node
>    ARM: dts: keystone: k2g: Rename the TI-SCI clocks node name
>    ARM: dts: keystone: k2g-evm: Move audio oscillator assigned clock to
>      mcasp
> 
>   arch/arm/boot/dts/keystone-k2g-evm.dts | 11 +++--------
>   arch/arm/boot/dts/keystone-k2g.dtsi    |  6 +++---
>   2 files changed, 6 insertions(+), 11 deletions(-)
> 

For the whole series:

Reviewed-by: Tero Kristo <kristo@kernel.org>
