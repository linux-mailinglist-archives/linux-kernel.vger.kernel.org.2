Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2963E8B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhHKHlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235491AbhHKHlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:41:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A150760230;
        Wed, 11 Aug 2021 07:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628667656;
        bh=V/N3eN/dw5gSqAyCkP+gCTFP8cNeUSG7Vnrmvybg9YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2nEEGo6qq4f/vChJviFvNJGOXUdcy2sE4Et/9BG/ML35x1TGhgsfEw5gTXUiWdINt
         ttGxCioO0qIIw83UY6v5FTymJIdfLouK9VD6KUJOg7OXzijRvWbuAMD6gVR+6EMjhW
         4RQjquwm8YCOTFlMaKWo+P7hjklKwna7KOYnrSFk=
Date:   Wed, 11 Aug 2021 09:40:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] staging: r8188eu: remove lines from Makefile that
 silence build warnings
Message-ID: <YRN/BYRayELQnM+2@kroah.com>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
 <20210810235047.177883-9-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810235047.177883-9-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:50:47AM +0100, Phillip Potter wrote:
> Remove the several lines from the Makefile that append EXTRA_CFLAGS options
> to silence build warnings about unused variables, unused functions and such
> like. This will enable cleanup of missed warnings, and easier spotting
> of future such problems.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/Makefile | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
> index 152d6325b4d9..7f6658f931d1 100644
> --- a/drivers/staging/r8188eu/Makefile
> +++ b/drivers/staging/r8188eu/Makefile
> @@ -2,15 +2,6 @@ SHELL := /bin/bash
>  EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
>  EXTRA_CFLAGS += -O1
>  
> -EXTRA_CFLAGS += -Wno-unused-variable
> -EXTRA_CFLAGS += -Wno-unused-value
> -EXTRA_CFLAGS += -Wno-unused-label
> -EXTRA_CFLAGS += -Wno-unused-parameter
> -EXTRA_CFLAGS += -Wno-unused-function
> -EXTRA_CFLAGS += -Wno-unused
> -
> -EXTRA_CFLAGS += -Wno-uninitialized
> -

Ah, that is why I didn't see any warnings!  Thanks for these changes,
will go queue them up now.

greg k-h
