Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D356D3107FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBEJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhBEJc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:32:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5013864F4A;
        Fri,  5 Feb 2021 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612517527;
        bh=jgQzZhuJanUyFvcQr/pf0vZbG+herQxEJyaMFM6t8H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoOAO7Nhlr9nQ6q72H/0ZYP45xoHs91spyqIrqoJx6yr8RMyyZkym3Sy8guJI5k2D
         aU30TY9u/yc5Gmn9LJBIq4ygboX1AWUiL4CvTeSjYCz9HSbJj7sONQa30xbVEjqPHS
         chcauDLHwRzWhIeICuBFxV+Zjn6J0Rv39D0rwShg=
Date:   Fri, 5 Feb 2021 10:32:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mayank Suman <mayanksuman@live.com>
Cc:     sfr@canb.auug.org.au, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] staging: fbtft replaced udelay with usleep_range
Message-ID: <YB0QlMk4Gae1IGjd@kroah.com>
References: <PS1PR04MB29341C7117657B1F312444FBD6B29@PS1PR04MB2934.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR04MB29341C7117657B1F312444FBD6B29@PS1PR04MB2934.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:41:13PM +0530, Mayank Suman wrote:
> According to Documentation/timers/timers-howto.rst, usleep_range is
> preffered over udelay for >=10us delay.
> 
> Signed-off-by: Mayank Suman <mayanksuman@live.com>

ALWAYS test build your patches before sending them out to the world for
review.  You don't want to make maintainers grumpy by breaking the tree
with changes that can not compile, right?  :)

thanks,

greg k-h
