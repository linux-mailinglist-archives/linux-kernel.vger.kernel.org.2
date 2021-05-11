Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7837A08F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhEKHTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKHTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:19:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A63A761490;
        Tue, 11 May 2021 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620717482;
        bh=iUBzwik+HNOaeBx/D60TsC6sHb73jnd99L9cq9FNIWM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EcTIJ2nxS40ixHvUs+UOq0AsMCQnIap3UlceMyY00rOgoflFeko5ElzzOkcuf84hr
         O5v+mrc2qtYTTbx1m1deDNixR89DjXrdn3ejio4wngL5nhVcmTFNojcM3u13B3mKci
         5pJlZ2TK2GFRb2kodFXCI4N4IlWcOUbNy+bg1FOoRz2xXyhKVKyJn0FWibZWLOjml0
         mGgZkj7lQtldZsz3ER3i4eUUIgYcaN9Wt/OpeobIAlaXsV4I0J1HDSdKlIXHDkNjUX
         PWYIRKNvYOgKXPue0cFsz9wVxLI4oGuA9dPRNjTT5qw8R8AA/HMXppcQA6AiHc9Dkl
         TgYLZXmgSUzFA==
Subject: Re: [PATCH 0/4] arm64: dts: ti: k3-*: Fixup nodes to exposed to be
 non-compliant with yaml
To:     Nishanth Menon <nm@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210510145033.7426-1-nm@ti.com>
From:   Tero Kristo <kristo@kernel.org>
Message-ID: <6e3f0226-108d-bc29-5b49-cbbe9e6aa103@kernel.org>
Date:   Tue, 11 May 2021 10:17:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510145033.7426-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 17:50, Nishanth Menon wrote:
> Hi,
> 
> Series of minor fixups for v5.13-rc1 for compliance exposed by yaml
> conversion in the series:
> https://lore.kernel.org/linux-arm-kernel/20210503190824.GA2192378@robh.at.kernel.org/#t
> 
> Minimal testing performed on k3 platforms.
> 
> If possible, will be good to get in 5.13 window.
> 
> Nishanth Menon (4):
>    arm64: dts: ti: k3-*: Rename the TI-SCI clocks node name
>    arm64: dts: ti: k3-am65-wakeup: Add debug region to TI-SCI node
>    arm64: dts: ti: k3-am65-wakeup: Drop un-necessary properties from dmsc
>      node
>    arm64: dts: ti: k3-*: Rename the TI-SCI node
> 
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi        |  4 ++--
>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 10 +++++-----
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  4 ++--
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  4 ++--
>   4 files changed, 11 insertions(+), 11 deletions(-)
> 

For the whole series:

Reviewed-by: Tero Kristo <kristo@kernel.org>
