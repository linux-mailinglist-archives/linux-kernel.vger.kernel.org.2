Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4029430965
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbhJQNno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242392AbhJQNnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:43:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B07C360462;
        Sun, 17 Oct 2021 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634478093;
        bh=XSF3t2/FRwE0noUF0lBUj1BR17pTGpHeG1T2Wt392AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZat772RvJvcwiXJt3FVvxbbeynTvqoGjRdLZFlG6brE6AUbkwb4ZDMy99O8Pu8Y8
         y07LoaMe/dTnRLHny0tuvL5pR9J2CkN+wH0Jlg4Oov8Gh9N11720NLrKCoVRhVM06B
         q9zTFTAO8U6Vxyja7ZvaFDpyRVUh0/MK+icyapLE=
Date:   Sun, 17 Oct 2021 15:41:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sebastian Luchetti <luchetti.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: ms.c: Remove two udelay calls and use
 usleep_range instead
Message-ID: <YWwoCuBIBc/xTPIu@kroah.com>
References: <YWwWoB3+4HQTD4/t@Mononoke>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWwWoB3+4HQTD4/t@Mononoke>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 02:27:12PM +0200, Sebastian Luchetti wrote:
> This patch fixes the issue:
> CHECK: usleep_range is preferred over udelay; see
> Documentation/timers/timers-howto.txt
> in two occurrences.
> 
> Signed-off-by: Sebastian Luchetti <luchetti.linux@gmail.com>
> ---
>  drivers/staging/rts5208/ms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
> index 2a6fab5c117a..7292c8f013fd 100644
> --- a/drivers/staging/rts5208/ms.c
> +++ b/drivers/staging/rts5208/ms.c
> @@ -3236,7 +3236,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
>  			return STATUS_FAIL;
>  		}
>  
> -		udelay(30);
> +		usleep_range(27, 32);

These are very odd choices of a number, where did they come from?

And as the other thread on this mailing list a few hours ago describes,
for this same type of change, you need to test this with the actual
hardware to know if this works properly or not.  Have you done so?

thanks,

greg k-h
