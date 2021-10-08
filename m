Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54AF426E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhJHQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhJHQG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:06:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AD8561027;
        Fri,  8 Oct 2021 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633709071;
        bh=KD398jaQvDXHUuNuLLyW0QSjhLdu/GhpQY+K7ndSUhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mBuz/TKs0bb7lggF2tsR8GEVsq5OHRmCuGk7DywHvfvYjbYePF3TTziXgSG9/1Clf
         NRe8x16NSyn+6Gx2NmqQGsTOgj6KnkAkXBD9U+mCOQdC9CMpcTw4NMs37VS3EcBqlT
         FvRmLUK7gyfRua/epdFQQXjWtyFgeK6vRhD79yJlqVBHUD2kHgLcoLOw0ROc4sH8kd
         OBqg4nMBADFtZgUlctmI63joNjAY0VXZ71suciugI8/iZTArlz5UPtZUTsX/7h3mHu
         ziQ1o91J/ZHWn9KZfFyYfoqGozUlhfrnqX6pkcj7rBzNsyi699hTNEmBATgwVXHhuX
         tCKKlem8htmvw==
Date:   Fri, 8 Oct 2021 18:04:27 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: dts: marvell: add Globalscale MOCHAbin
Message-ID: <20211008180427.68be1d3f@thinkpad>
In-Reply-To: <CA+HBbNEDxBDvNZPSWnBYJOUhqdwonBhFwD9P0xhSGccdvQJx3Q@mail.gmail.com>
References: <20211008114343.57920-1-robert.marko@sartura.hr>
        <20211008120855.46zbo2fl5edwf7ja@pali>
        <CA+HBbNGvFtws2GF7RLbznAbXfvjKx4rOJ=eMeuHOJ6s7iANtzw@mail.gmail.com>
        <20211008134347.lskm5pzt73pkf7oc@pali>
        <CA+HBbNEDxBDvNZPSWnBYJOUhqdwonBhFwD9P0xhSGccdvQJx3Q@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 17:52:40 +0200
Robert Marko <robert.marko@sartura.hr> wrote:

> I have to agree, so I did some digging.
> I don't think that the Armada 8k PCI driver actually supports HW level PERST#.
> I then looked at the functional specs and the only thing that looks
> related to PERST#
> is PCIe Software Reset Register which has a SoftWarePERst bit.
> 
> Can you maybe look at it?
> 
> Removed the reset-gpios and set the PERST pinmux to PCIe, and the
> QCA9377 card will
> show up, but I have no idea whether PERST# actually ever gets toggled.

You can check with voltmeter, toggle the bit via mw command in u-boot.
