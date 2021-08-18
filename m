Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5067A3F0169
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhHRKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhHRKPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:15:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 304766103A;
        Wed, 18 Aug 2021 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629281667;
        bh=tSa4UfX6taJAkSS7owvbJwaNxPRi5jLQkSw4pv2Xy+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrFwm41e7xZps5Og0gBIZtz4nZ96QNsMb1ezizhS0MztMhekopHyvliFdnCL8xM91
         jwS6eEQPe8TUyktbA7+RI8JmsDXuZVKq8k7Cl4/WODTiWTygpl2RLIryWcrVscdHN/
         /RR+HPwodnTmF0/GIcOrknsey2gDP4zf6F/X2fJKYXmFOn1oVqWGELwOZlmAncrsAn
         mVJ3argszSchO5Zfd4mqLyimxv5nC8yYH69LujWgorAsW6vIMG8GUNECXhbVb9rHDI
         daEa1mFHloHEL7vhg8CqXP+7RmkfKRd7tSvtt9CWh4HK1uoqO9GGef87gE+seSkGmO
         uVhTOcvcDbyEA==
Date:   Wed, 18 Aug 2021 15:44:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     laurent.pinchart@ideasonboard.com, kishon@ti.com,
        michal.simek@xilinx.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, sgoud@xilinx.com
Subject: Re: [PATCH] phy: xilinx: zynqmp: skip PHY initialization and PLL
 lock for USB
Message-ID: <YRzdfsnntGf9ebU/@matsya>
References: <20210818084311.2643986-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818084311.2643986-1-piyush.mehta@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-21, 14:13, Piyush Mehta wrote:
> PHY initialization for USB is required on linux boot or when
> gt lane is changed from the current one and it is applicable
> on PLL lock too.

Applied, thanks

-- 
~Vinod
