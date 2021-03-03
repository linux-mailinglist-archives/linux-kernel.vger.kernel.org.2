Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A7B32C075
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578691AbhCCSRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhCCQJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:09:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 563A264ED7;
        Wed,  3 Mar 2021 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614787739;
        bh=oLEMq+FKXQy4SVc1LwzFfB9gKXgRmMlJaTjBzUFQP+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UnikIBCXiim0R4HJziT75V1F8nppUbRj3q+OrkLYA/NTyaweTDY+8tXeQDONo+IiQ
         kLA4hbqX8DFJiApfUGeaTk2/E+FHgtc/ieEdQgRJK5FrXl3gVkMNd8pV28ZTu3RJle
         UWUyjf4ErPsURpCRh9nMmkle3Ry3Ujs9iLjAowH0=
Date:   Wed, 3 Mar 2021 17:08:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: require write permissions for locking and badblock
 ioctls
Message-ID: <YD+0mAPTMN8AwNBx@kroah.com>
References: <20210303155735.25887-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303155735.25887-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 04:57:35PM +0100, Michael Walle wrote:
> MEMLOCK, MEMUNLOCK and OTPLOCK modify protection bits. Thus require
> write permission. Depending on the hardware MEMLOCK might even be
> write-once, e.g. for SPI-NOR flashes with their WP# tied to GND. OTPLOCK
> is always write-once.
> 
> MEMSETBADBLOCK modifies the bad block table.
> 
> Fixes: f7e6b19bc764 ("mtd: properly check all write ioctls for permissions")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/mtdchar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks for auditing the rest of these from my original patch.  If this
is ok with userspace tools, it's fine with me, but I don't even have
this hardware to test with :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
