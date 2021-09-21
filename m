Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF079412F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhIUHmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhIUHml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:42:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 961F661156;
        Tue, 21 Sep 2021 07:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632210073;
        bh=idYtU6Is7rkmMuxKhtzxtzM5UOSu1GSJwrtRF9Xslj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGjVDZQk+zYu4zL6GtfvUCyQ8teHoaQ+SM+p/BFN6Ie68qMgZO4tho+Apjqz9MpOQ
         UB1i3MeUDbJdcy19bRS0h77gqqjDlLlTfQsC5j4C+FJr26ddxJqI94OzQ6DtcPfs20
         trLqULRYRUvnqHDLWs12DGzKtKZV4jW/CIPf2StA=
Date:   Tue, 21 Sep 2021 09:41:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <YUmMli6LA/7Ew3hD@kroah.com>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210809145329.24177-1-pali@kernel.org>
 <20210820172238.ekvo42s7oqxkeomt@pali>
 <20210831083510.iiapfla7iy76fs3w@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210831083510.iiapfla7iy76fs3w@pali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 10:35:10AM +0200, Pali Rohár wrote:
> On Friday 20 August 2021 19:22:38 Pali Rohár wrote:
> > On Monday 09 August 2021 16:53:23 Pali Rohár wrote:
> > > This patch series add support for baudrates higher than 230400 on
> > > Marvell Armada 37xx boards.
> > > 
> > > Please review these patches as they touch both Device Tree bindings and
> > > mvebu-uart.c driver.
> > 
> > Stephen, is this patch series OK now? Or is there any other issue?
> 
> PING?

I'm going to drop this series from my queue.  Please resend it as it
seems people who need to review this have ignored it :(

greg k-h
