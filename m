Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350023F5CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhHXLGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236471AbhHXLGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:06:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27EEE61371;
        Tue, 24 Aug 2021 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629803116;
        bh=Wn9y68nsnD1iwKPhsS9XKANDPvq3iwni4Zmc1ibzZMk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WyhPh3uHZw8gHE1jFIFQVvhYCwcDClpf+FKaMqkI55YNhj/T7ZZF+9i4i8LJQHzAK
         yTkDrxZcOPFfhstIZW/KJylahC2SgAuYPvdiTSVASc+a18qgbub5JLe5KuDkr/F93G
         VPfsy+9NLoRe6ZtJ8mYfnOrl/Tlf+QgfAtK4Q+HN13gEs6IjaU7aJsqM5xaDVD6XdE
         tisGz5gBlp3bvX9XuOEjG2VQxZoer95z/MmwLNIrcR5p42wwfBDDKyg5+lfzHO4oe4
         jZLRQPo00jzvn0Oqc/eAmdSTnLK3Zlxa0GYbeXV36m27Bea6g0jyQjramxSZ7RbECo
         0Qd/pSg0Fft6w==
Subject: Re: [PATCH v2 0/2] ARM: dts: keystone-k2*-evm: Fix mdio and dss node
 status
To:     ssantosh@kernel.org
Cc:     nm@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210824105858.19496-1-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <6e5a4ef9-3611-25b4-9f79-5776f708dafa@kernel.org>
Date:   Tue, 24 Aug 2021 14:05:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824105858.19496-1-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/08/2021 13:58, Roger Quadros wrote:
> Hi Santosh,
> 
> This series fixes mdio and dss status nodes from "ok" to "okay"
> 
> As per Device Tree Specification [1], the status parameter of nodes can
> be "okay", "disabled", etc. "ok" is not a valid parameter.
> 
> U-boot Driver Model does not recognize status="ok" either and treats
> the node as disabled.
> 
> [1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>   ARM: dts: keystone-k2*-evm: Fix mdio node status to "okay"
>   ARM: dts: keystone-k2g-evm: Fix dss node status to "okay"
> 
>  arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
>  arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Changes in this version:
- updated commit message to point to DT spec instead of schema.
