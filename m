Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5A6330578
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 01:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhCHAz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 19:55:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233429AbhCHAzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 19:55:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5266564F29;
        Mon,  8 Mar 2021 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615164947;
        bh=VXwKpdNyK5hS53TXuxq83aT8f8NgvBrnqunXhv8/Pl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WU5WoDgyQHfowQ0JBDmh4aT+JmSazIt5xI9Q3/5hYdwdZ5YAyRXyfykUaAP0IrLFB
         K4WoNmVPgf5QFFpbAxLmGh0AHrljm3CyZwwHn6mTKI7N7yZ/n22pzaNi6QknzjP7Ne
         Wslm2qEx1esSEGdIMakpOShXRzCMjQnO46hfVn5mqQqnDKptAaytITaLrsnGYTgcO4
         MlgP+QR/mlGHBZlrJFKApLkfbpOGmbr3aN3Xc2T6NhhHYpfTlUOv/DuwcbsDQO5VN1
         jOYquHupQz00Yb8xjasyi+0PqZ3L+/eOEU4BAyE56kEgVQqCdbq2PzubVgG1KzJNPx
         YOx8+GlOP7iwQ==
Date:   Mon, 8 Mar 2021 08:55:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 0/5] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
Message-ID: <20210308005541.GO543@dragon>
References: <20210225192404.262453-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225192404.262453-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:53:59AM +0530, Jagan Teki wrote:
> Jagan Teki (5):
>   dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
>   arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SoM
>   arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
>   dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
>   arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit

Applied all, thanks.
