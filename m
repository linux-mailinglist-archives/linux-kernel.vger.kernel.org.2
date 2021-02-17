Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA4431DD53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhBQQ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234193AbhBQQ2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:28:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F06664DFF;
        Wed, 17 Feb 2021 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613579242;
        bh=48uDl0cK0TcRMhfYwNZd76eaGCNym7qStjlm6Y7QXUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QqS/LrquQEMaM4nTE53Kk8otC9u21gFaxqJITH/nSi+v+enHLlG986bZwBtnlkSUV
         HaT3Ag+fVD9dziO6hqWHbg5xwkJRyJKgo6cU5MTXuMkK3st8fByRFwRm+pXhSQzRgb
         dJ1hwG+QIfDmnsepmOrArDgNgDEN7z2Rm6ydWJ+9pJMZzbRINn/qCge10PfLgKBfkr
         /v0t1qZ4AfDvUSA2SQ9u0B4jdLDlkI36HufliVWGqWFpLHrT26r0uyN8zIuOw+sf5+
         OYA4uQEzgBX+NmFv7bqR/yZ65vMo92gFnnf0vx1D3oRCPz7nI8Rsfcs1UvOOPjxGAA
         qzpC6k2aWAO/A==
Date:   Wed, 17 Feb 2021 17:27:18 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
Message-ID: <20210217172718.6fdf412e@kernel.org>
In-Reply-To: <YC1CuWnLQju7wMl2@lunn.ch>
References: <20210217153038.1068170-1-rsalvaterra@gmail.com>
        <YC1CuWnLQju7wMl2@lunn.ch>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 17:22:17 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Feb 17, 2021 at 03:30:38PM +0000, Rui Salvaterra wrote:
> > Hardware buffer management has never worked on the Turris Omnia, as the
> > required MBus window hadn't been reserved. Fix thusly.  
> 
> Hi Rui
> 
> I don't know all the details for the MBus Windows...
> 
> Can this be set once in armada-385.dtsi ?
> 
> Did you check the other dts files. Do any others have the same
> problem?
> 
>     Andrew

armada-38x.dtsi defines only
  ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
for internal-regs.

It probably depends on how the mbus driver works.
If the mbus driver maps every window defined in ranges, regardless
whether they are used, then we do not want to put all windows in .dtsi
file.

Marek
