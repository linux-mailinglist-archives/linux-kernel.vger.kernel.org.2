Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96E459BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhKWFzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhKWFzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:55:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0C1660174;
        Tue, 23 Nov 2021 05:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637646726;
        bh=16r6J8ycJjRHxKmkqPJvCenPNAYddQKOVSL71EK6Rm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PexDVdjXkD0NTnnv4NY+Rpfx1ny3WXQZZFvS3dKyRKhUNiYhectW2eotKKCqg3qeR
         MmSTH85ZDd0pIwDuIx2RzZKe3wnuGTUIRDNi5MWvnK/NoWZ30xc+i2jhf7/+3J9e2F
         xOwbHpFdUhck77jWS8s2bCcmxd0V/eKlJnBi9IM4CCfExPl3yOxi/o9+dBWMGEYXe9
         nRCzRRKdgIsFzXUb9dhCKV5JViSd6CvfOeE5+tknF0L9AIwOJqUaicjHC0aq0bP05x
         MPWEGDNJrGsWmapixnP7p4eW6ZZZxuUbb5sTPk2om1pb4DxNv8B35J2WVgkYX+NuDd
         hlrExXc+uqhYA==
Date:   Tue, 23 Nov 2021 11:22:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] phy: socionext: Introduce some features for
 UniPhier SoCs
Message-ID: <YZyBgtbgKW3w6lqG@matsya>
References: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-10-21, 19:38, Kunihiko Hayashi wrote:
> This series includes the patches to add the following features:
> - Add basic support for new UniPhier NX1 SoC to USB3 and PCIe PHY.
>   NX1 SoC also has the same kinds of controls as the other UniPhier SoCs.
> - Add a PHY parameters to PCIe PHY
> - Add dual-phy support for the SoCs that has two phys to PCIe PHY
> - Add basic support for Pro4 SoC to ACHI PHY

Applied, thanks

-- 
~Vinod
