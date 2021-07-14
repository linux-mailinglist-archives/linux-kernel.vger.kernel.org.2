Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028D23C7F44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhGNHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238079AbhGNHY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:24:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1071B61361;
        Wed, 14 Jul 2021 07:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626247326;
        bh=/IPK+PprsaGmsl+F8H0yb7oiy0gnC1KyMVeq9sTlV7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkQ5gG/w0EfArOQ97UL9wThH4DAT5PccX/Ciuyz5DiUvmYVR58TPDkGlpoW8+XAjV
         /XdlxTOhcp1aSNhZ2Qx8qvSFM4M7bxBK2kzghz1ZuaHQWqouhboPaqy+Q1z4OaQJfp
         iqqa7aae5nZ4fSF+5xUlmr13LnZZ7m0x4hww7oyAWJnU7wcTPs9WhhwdFRYDH1Bour
         QyR6XOTTnA8G3NBtJGdJ9qw9YtVGFBKl8Po9g88r+Q6CNgnG4MpJZU93WslT0nEhO3
         +MGzFRG2ab8VM/XrBfoCeFOYhlg9OK1NtY/MmGzl9aCu0RomJlYDeeZkl/0GaorqlU
         1E7B6gYz+p+2w==
Date:   Wed, 14 Jul 2021 15:22:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
 LX2160A UART
Message-ID: <20210714072201.GC4419@dragon>
References: <20210615131605.616-1-thunder.leizhen@huawei.com>
 <20210615131605.616-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615131605.616-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 09:16:05PM +0800, Zhen Lei wrote:
> Mark Kettenis told us that:
> According to the NXP documentation, the LX2160A has a real PL011 UART.
> 
> Therefore, rewrite it to the compatible string of pl011. The property
> "current-speed" specific to "arm,sbsa-uart" is also deleted.
> 
> Suggested-by: Shawn Guo <shawnguo@kernel.org>
> Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied, thanks.
