Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4A43521A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhJTR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhJTR7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:59:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA5DD61260;
        Wed, 20 Oct 2021 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634752628;
        bh=XQzcmxRtmpTtwLEmhDRGGu/vVrNymCgV6elsUAeO/hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmF2wRMGxunC7sIHQ8p6+oKzruLFtHoFBaGOdwUhByocaotRmDd0N5yoS0djAgeKI
         dC/3bVbwpUDK5yTIBfJJcJxLRi8eGiQf5Pt26S6HTySFd+7zAhNxvyaf+5JcljSqo7
         NqSP49J8YZyleU0ti2UzQThHKJAnSbN7mJRqwjUL59v89qaaSrVCXTQ5RN5WPuHRSI
         zsWmm8hOBgoDTuaku/wWJNjr9ELEkt6u8V6fTAF/fBdZ+zlsqFA4BqegvkPiB+Z0DF
         /THJ7MWz1X5tuZswLxtGt1T14R0iN2fe9lELzOOldYWy4wPHvgDPXTQjibx3BsdiU1
         SCbjqLoLtAdQQ==
Date:   Wed, 20 Oct 2021 23:27:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mparab@cadence.com, lokeshvutla@ti.com, a-govindraju@ti.com
Subject: Re: [PATCH v2 0/4] PHY: Add support to output derived and received
 reference clock from Torrent
Message-ID: <YXBYcOeydTf4xj4H@matsya>
References: <20210922123735.21927-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922123735.21927-1-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-21, 14:37, Swapnil Jakhade wrote:
> This patch series updates reference clock driver implementation for Torrent
> by adding support to output derived as well as received reference clock.
> When reference clock driver is enabled, either derived or received refclk
> is output on cmn_refclk_p/m.
> 
> In derived reference clock mode, cmn_refclk_p/m outputs the refclk derived
> from internal PLLs while when received refclk is selected to output on
> cmn_refclk_p/m, this is the internal reference clock driven on the
> pma_cmn_refclk_int.

Applied, thanks

-- 
~Vinod
