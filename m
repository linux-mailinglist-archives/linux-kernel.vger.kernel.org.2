Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F6459BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhKWFvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:51:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhKWFvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:51:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E28E60174;
        Tue, 23 Nov 2021 05:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637646484;
        bh=s5g41jYrdtxlXA66zVRRQhw+GXrmib0rXuZHEcHaZWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIDUW0ytL9AgGAD0JVqJu/WnY8a+CxtN/MO5tEZdwN65QEuvwdYUmq+Ute2eSv9oo
         guOQtGiMEUutwnOA140LRGGcbdtuPrEyeSbTg4lZfDlCDGjUnHfAb2OxCINfYZwfva
         1aD+GyVwOWBoBmgGNYBcoGHWFNHazz6AFKVVxOaHuPId5K1GdZjjbXsjEQVYUaxWuY
         tgS1vqaN9IGMc+qS9yqsGML2ixVs6uZBHwOwVvgF7sozq0aRo+g7BlKtAfm4cDhRBT
         1awQZcMEPMTj1eF4op3CX8QIUDO2oTtp8S55+oNkGXMefXqhwpEp/4/X6l/6hvmx57
         zwtBiUlt7e44Q==
Date:   Tue, 23 Nov 2021 11:17:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        kishon@ti.com
Subject: Re: [PATCH v3 0/2] phy: Add support for the HDMI TX PHY on
 Meson8/8b/8m2
Message-ID: <YZyAj/Co1e0SLU4+@matsya>
References: <20211020195107.1564533-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020195107.1564533-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-21, 21:51, Martin Blumenstingl wrote:
> Amlogic Meson8/8b/8m2 SoCs embed a HDMI TX PHY. Unfortunately there is
> no (public) documentation for this hardware. The best thing we have is
> the 3.10 vendor kernel, which unfortunately doesn't document most
> register bits (only a few are named there, the rest is all magic
> numbers).
> It is possible that this is a TranSwitch HDMI TX PHY based core, but
> this is pure speculation.
> 
> Adding a driver for the HDMI TX PHY gets us one step closer to video
> output on these older SoCs.

Applied, thanks

-- 
~Vinod
