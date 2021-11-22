Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB3B4587B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 02:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhKVBN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 20:13:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhKVBN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 20:13:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4CCF60C4A;
        Mon, 22 Nov 2021 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637543450;
        bh=ZohWFl40liRdlY9xJVmwlgi0WeY3kXR+eJvoZ5ycpbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8Hkr4WSIe21TsTXqyVx7edJ2AjP8uy8Ltft/9ouL/ocpUo8TuikTT1zEurV6iKjB
         gRPIcsQaVX3sgcqADEHWtqVjvOcHnSrFffjfwdvB0CsRcl0fMTSvyGzct2N8wQBgjX
         qPPbBbh3/V5G7cM7/XIdWktusHPM9VWXZLk0lM0MePbURRuObdX3B9fzrSoCIwju9n
         A/GMfZpg+tt2346089DJMNpHAbeLjYhbqLUNYUrLO3FaLRDusHDnKACY7RQQj+H9vh
         2n2pgPlNDUUlGp0N0RR/ttP2RdHPDzMsypDFKymI3pNgrbU/GYme57XDEQmbM9blGV
         GVsPvG+9yXhNg==
Date:   Mon, 22 Nov 2021 09:10:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     festevam@gmail.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v1 0/4] support the Librem 5 front camera
Message-ID: <20211122011044.GT31998@dragon>
References: <20211104132213.470498-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104132213.470498-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:22:09PM +0100, Martin Kepplinger wrote:
> hi Shawn and all whom this concerns,
> 
> 3 weeks ago I sent this as RFC that didn't yield feedback, see below :)
> Here's the same patches as a proper patchset ready to apply.
> 
> The first patch adds a shared "r3.dtsi" and is only refactoring.
> Patch 2 that describes the power supplies on the Librem 5 board as regulators.
> Patch 3 and 4 should be straight forward camera descriptions according to
> the drivers.
> 
> thank you,
>                              martin
> 
> revision history
> ----------------
> RFC v1:
>   https://lore.kernel.org/phone-devel/20211015083506.4182875-1-martin.kepplinger@puri.sm/
>   and more specifically thoughts on patch 2:
>   https://lore.kernel.org/phone-devel/20211015083506.4182875-3-martin.kepplinger@puri.sm/
> 
> 
> Martin Kepplinger (4):
>   arm64: dts: split out a shared imx8mq-librem5-r3.dtsi description
>   arm64: dts: imx8mq-librem5: describe power supply for cameras
>   arm64: dts: imx8mq-librem5: describe the selfie cam
>   arm64: dts: imx8mq-librem5-r3.dtsi: describe selfie cam XSHUTDOWN pin

Applied all, thanks!
