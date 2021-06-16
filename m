Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAE93A962C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhFPJc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhFPJc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59F67611CA;
        Wed, 16 Jun 2021 09:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623835814;
        bh=nrfbYjfulZoAPaUf06R8qWjrWQRQRK0shPKxqFHChZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xudoE7cLEMoRRo8mEPJY4STJdULAnwguMtuX0NnvGBLS1tcFa+wPRebbUhss7HUbw
         d0XrmG+sDITKRKitnXl2DpdsxQUjL5LzAQQMT0iukeVWr9xsQNmnGZGPPWItIJzMbs
         x5zyIwgdrISLtZXL8+poI0pkDG3M1ZNtmiRRfJpY=
Date:   Wed, 16 Jun 2021 11:30:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Lukasz Halman <lukasz.halman@gmail.com>,
        Johan Hovold <johan@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALSA: usb-audio: Fix rate on Ozone Z90 USB headset
Message-ID: <YMnEo73bQt+mvEXn@kroah.com>
References: <CGME20210616091516epcas2p2111c9b941d0e60fb0a6ae9646fb80d26@epcas2p2.samsung.com>
 <1623834063-108482-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623834063-108482-1-git-send-email-dh10.jung@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 06:01:01PM +0900, Daehwan Jung wrote:
> It mislabels its 96 kHz altsetting and that's why it causes some noise
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  sound/usb/format.c | 2 ++
>  1 file changed, 2 insertions(+)

I am not the sound/usb/ maintainer, so I do not know why you sent this
"To:" me.

Also, can you resend and add a cc: stable to the signed-off-by: area to
let this get backported properly?

thanks,

greg k-h
