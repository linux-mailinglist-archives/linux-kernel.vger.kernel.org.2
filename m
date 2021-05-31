Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154F039570F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhEaIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEaIgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:36:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ADA0611EE;
        Mon, 31 May 2021 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622450111;
        bh=h0daNFOBtnGVuD3sxjbRsyFpXcSCgAHAlgQieU7xUJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvUQtc6pLUtBmEvufELqzhlrgnGIYM0LZ9NeOR6Czd4DMs3h6KkluBBX+Rxly2iZN
         RrViLjY9vEJ9FQshDWkCHB2sS+rzhRPxLUHHPyQlT8H7lbOiXf3wSivLSm3DVKsbEy
         svShKts5m1oPpFmf4Vwk5HtdDzlEQ+WsHbeANY3CopHE1qOWcikv6Y8wojzmWHirNS
         xGgKSRUpeTwrFLe/mH8vB3zfjmmI9BwDwyA3P0Ecq3+7nddHLj6ZhbsgI7R+VocyGv
         xO+uswSheQeCtnZ3/gYpJpgdvKo0Rqw2Nz2XnGhRaSmXTD0wxuQE7PJjuQASUza9Rt
         24vSMwzEogvxw==
Date:   Mon, 31 May 2021 14:05:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, kishon@ti.com,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] dt-bindings: phy: rename phy nodename in
 phy-rockchip-inno-usb2.yaml
Message-ID: <YLSfvDeKrB0b66Ol@vkoul-mobl.Dlink>
References: <20210518165658.12764-1-jbx6244@gmail.com>
 <20210518165658.12764-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518165658.12764-3-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-21, 18:56, Johan Jonker wrote:
> The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
> in phy-provider.yaml has required "#phy-cells" for phy nodes.
> The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
> Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
> notifications. Remove unneeded "#phy-cells" from parent node.
> Also sort example.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
> phy/phy-provider.yaml

This fails to apply for me, needs rebase..

-- 
~Vinod
