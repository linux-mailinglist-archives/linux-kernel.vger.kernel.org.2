Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB853237F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhBXHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232343AbhBXHbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:31:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E69E64ECB;
        Wed, 24 Feb 2021 07:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614151838;
        bh=6KWcfVE7ehtOI43lndv+QRd+lKd96Y/+ShOkch0BvBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZHdrLqNH9uYP4vwZ06tHXixoDEsOIIeNQG4EdVvL7nVAYr01/NALZADmr5WLBX66
         l/CUvVBaVrpsn08NRUIVUuwwsveAAi8h5jwjMVegQNhbR8i5Q+R8cJiwkJuFQJXMVP
         7HC8e6PCqBmVISCDhgKqnWm+eaXrYAY4YLFxEu1w=
Date:   Wed, 24 Feb 2021 08:30:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     chakravarthi Kulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ethan Edwards <ethancarteredwards@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: comedi: Fixed side effects from macro
 definition.
Message-ID: <YDYAm4GeMD/M4gic@kroah.com>
References: <20210217142008.29699-1-chakravarthikulkarni2021@gmail.com>
 <3c1ddf91-da6c-5620-61e7-1ec453b2aa93@mev.co.uk>
 <CAEwrQWZEXYJDsTDiOAZLOr5jLXXyuZamwqRMquCyBdYPa8anow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEwrQWZEXYJDsTDiOAZLOr5jLXXyuZamwqRMquCyBdYPa8anow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Feb 24, 2021 at 12:47:26PM +0530, chakravarthi Kulkarni wrote:
> Hi,
> 
> I tested it will unit test cases it looks fine.
> int x = 10;
> NI_USUAL_PFI_SELECT(x++)
> 
> will not have side effects as it is taken care using local variable in
> macro.

You ignored what Ian said about why this change was not ok :(

It's long deleted from my review queue, sorry.

greg k-h
