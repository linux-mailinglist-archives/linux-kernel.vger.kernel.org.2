Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35AE44F741
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 09:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhKNIki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 03:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhKNIkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 03:40:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD90060E8B;
        Sun, 14 Nov 2021 08:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636879052;
        bh=TgzoCPwmF9eCJlP283+PFkAjEuCZ6XjtsKW6oY9wVwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWT3DM1BQ79UoPxsUTFjq2tpM/KgpWcRsC2PUBW3+0yVdMzbu9rNmchl1FjYthFNu
         lBkghc+cMjZOglav9YXoTGDvo5WyoQ5YS9PSub78fCAgvY6LCI/usdI36GsO1O+2cN
         gUnFWWjX3TZ1Sol7acBiWToJpphuZwLa0pvZ+adY=
Date:   Sun, 14 Nov 2021 09:37:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: fix camelcase in wCurrentRate
Message-ID: <YZDKyAf3c3kI0Lyo@kroah.com>
References: <20211114082029.GA118847@t470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114082029.GA118847@t470p>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 09:20:29AM +0100, Alberto Merciai wrote:
> Replace camelcase word variable "wCurrentRate" into linux kernel coding
> style equivalent "current_rate".
> 
> References:
> https://www.kernel.org/doc/html/latest/process/coding-style.html
> https://www.cse.iitk.ac.in/users/dsrkg/cs245/html/Guide.htm
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
>  drivers/staging/vt6655/device.h      |   2 +-
>  drivers/staging/vt6655/device_main.c |  12 +--
>  drivers/staging/vt6655/rxtx.c        | 134 +++++++++++++--------------
>  3 files changed, 74 insertions(+), 74 deletions(-)


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
