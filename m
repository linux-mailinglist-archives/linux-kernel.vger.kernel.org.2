Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9140ADBC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhINMdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232412AbhINMdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:33:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A848F60F9F;
        Tue, 14 Sep 2021 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631622721;
        bh=B9PIk/9PrcrqkK5QK8g/tEn1XLqHBAB4niXngidyYhI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lbEYWFzwfmuEvcZB9lU1qV7mYFyETzdgkC7Lj/bPUxS6BBZqm/h+z64mxJ/DP6/an
         Q763v9jDJwiA0k3BUTUSXth3eaiEzvURSV6nJcbcFLZJJivVDoJf9ah7iBxroTO6oG
         /3K2vgUYuTG49kbXe8LJS8KRCzj7Ow9D17Y0P5A20TYOTwWHJ2N+CZNGSblx1IYXZt
         PfY8cGcqFbmW+CefHNllhp2OJgWYyZUpTZ90xkSiXgznYaQ9Tz4AOAWtczxxXjLdVg
         6ZXIY7YJ0eFIlZ/piic/oK+hNfNhfsZANA7v87Tm2aXWLwfUfHNhUsYfcUNLr6WBfj
         S/bbrbFcWJrMg==
Subject: Re: [PATCH v2 0/2] ARM: dts: keystone-k2*-evm: Fix mdio and dss node
 status
To:     ssantosh@kernel.org
Cc:     nm@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210824105858.19496-1-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <37067735-73a2-7840-e467-e13aab19fcd0@kernel.org>
Date:   Tue, 14 Sep 2021 15:31:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824105858.19496-1-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh

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

Could you please queue these trivial fixes for 5.15? Thanks

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

cheers,
-roger
