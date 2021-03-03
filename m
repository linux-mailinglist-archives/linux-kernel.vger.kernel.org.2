Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89C32BF75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835501AbhCCSDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382128AbhCCPWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:22:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC4D964EE6;
        Wed,  3 Mar 2021 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614784149;
        bh=kuSlFyqS0esHp6a9WfeHEtn7CGyzwnqKO7imFdyzNGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnU/BRK1bn9yIFBSrdz+SxcaRejYSiommzyqQjTxS/gEUJb2zQwJSnEB6/8NPVSN1
         ZLYI4M2yFVY00TTjTdg8aw4E5VuiM7QRhCmmxn43RSl4VJTNDKuX6Pzwyuw599D/yy
         4evYEdxZ8RoNOXYnjOEP2+q42CGNfu6l8l/YdUhs=
Date:   Wed, 3 Mar 2021 16:09:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        taehyun cho <taehyun.cho@samsung.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Message-ID: <YD+mkse29UwwYbFB@kroah.com>
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com>
 <20210303103839.it7grj3vtrdmngbd@kozik-lap>
 <YD+XkFAfoKpSsea3@kroah.com>
 <cf330a12-82b9-3d6a-eeeb-28630e0a5f2b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf330a12-82b9-3d6a-eeeb-28630e0a5f2b@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 06:56:38AM -0800, Guenter Roeck wrote:
> On 3/3/21 6:05 AM, Greg Kroah-Hartman wrote:
> [ ... ]
> >> Anyway, that's the convention or consensus so far for entire SoC. If we
> >> want to change it - sure, but let's make it for everyone, not for just
> >> this one USB driver.
> > 
> > Great, let's change it for everyone, I don't see a need for ARCH_*
> > symbols except for people who want to make it simpler for their one
> > board type.  And for that, use a defconfig.
> > 
> 
> I don't think that will work in practice. Many ARCH_ symbols for various
> architectures contradict with each other. Almost all watchdog drivers
> only _build_ for specific platforms/architectures.

Great, that's horrible to hear, so much for a "generic arm64 kernel
binary" which I _thought_ was the goal.

ugh, you would have thought we would have learned our lesson with
arm32...

greg k-h
