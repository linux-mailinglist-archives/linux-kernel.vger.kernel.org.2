Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D043433DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhJSSEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhJSSET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:04:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB5F96108E;
        Tue, 19 Oct 2021 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634666526;
        bh=Mt5jIqaeETd1bbNuX1hs19s9ku7FcDJOjgZHjseuqtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRoTljZWPSMMyEYLFUwcSPBe/c2hoYfWVKolXhheHSBmslBn1LKfagG1veJgi6Ori
         YlGgk1/+KrSWko6KsnXIygged5K2GgdVPb9/n++6qogq2JX/MQLJH2TUjESB9oqNzf
         z/c+R1ey4aP9xsO9v37w+icAQlnc7M63lVT5ku8QX/d8BNgN0ryBpWRo42HpHZi+r8
         sSN2CKC6514tWzdSFUunIpoOXiSa34vFmf3lzQ81WbHHvJGKPNIWtDvI9fosCC0npC
         ZWzVNPS5pwl9mUSZhGS8bG7kVq30dlOvzf0rCPFbVumKlPRaK2ZWW6gUk7frf3TtpZ
         w215v0HLcMyNQ==
Date:   Tue, 19 Oct 2021 23:32:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, kishon@ti.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip: remove usb-phy fallback
 string for rk3066a/rk3188
Message-ID: <YW8IGnRAjjIA4wFW@matsya>
References: <20210828111218.10026-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828111218.10026-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-21, 13:12, Johan Jonker wrote:
> With the conversion of rockchip-usb-phy.yaml a long time used fallback
> string for rk3066a/rk3188 was added. The linux driver doesn't do much with
> the GRF phy address range, however the u-boot driver rockchip_usb2_phy.c
> does. The bits in GRF_UOC0_CON2 for rk3066a/rk3188 and rk3288 for example
> don't match. Remove the usb-phy fallback string for rk3066a/rk3188
> to prevent possible strange side effects.

Applied, thanks

-- 
~Vinod
