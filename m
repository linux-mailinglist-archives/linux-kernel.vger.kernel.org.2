Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E150356FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353415AbhDGPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232221AbhDGPPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:15:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E26E61262;
        Wed,  7 Apr 2021 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617808544;
        bh=ILkNXIt2AR6usEDfkpNuhK5euzJc8sahoo/4wGXrSms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4rEWM3O4lEYD1k+pCLeFgfyhxQAYTvXhL9GK20RG4dj8i+xd5ErvuFhtjhad30yW
         sBr2T5Yc86BEpPFAS043MyCqHejacdzQ3rG7F6XI65qr+x1JhjYnyRx4JPmfvUuChb
         GWf7sZ0LnElI0yXBHztvixlHhcIh3SOYeOGCrZc4=
Date:   Wed, 7 Apr 2021 17:15:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barney Goette <barneygoette@gmail.com>
Cc:     "arve@android.com" <arve@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: Re: [PATCH] Staging: android: ashmem: Fixed a const coding styleissue
Message-ID: <YG3MnqfgDutxAF6p@kroah.com>
References: <20210407143502.3414-1-barneygoette@gmail.com>
 <YG3GLQA1O3b0w0RY@kroah.com>
 <606dcaee.1c69fb81.df22.7ca0@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <606dcaee.1c69fb81.df22.7ca0@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:08:31AM -0500, Barney Goette wrote:
> Sorry. 
> 
> I was following the Kernel First Patch tutorial and I didn’t quite
> understand how to build a driver that was for Android while on a
> desktop.

Where you build the kernel does not matter, how do you think Android
kernels get built?  Not on the device itself :)

Please be more careful, you can not break the build for obvious reasons.

thanks,

greg k-h
