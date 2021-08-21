Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBF3F3B68
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhHUQVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232965AbhHUQVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96B35611ED;
        Sat, 21 Aug 2021 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629562837;
        bh=pYPwEe20z34MLrKXGR5xy7lPN1wTiOxN0d+4VLAtJnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6Gn/Kd/0eQCY1LCOiAIWSJ8d9FjcY1OsbXV8Idq1WgImsrmFU/yfATuc4SXnBg3L
         4A7+OEozbrhthsIGc3Tf21x5C5OGl488Ivs9GuKdJtsGpmo72FovFsmkPx5wQtSjmY
         xSNzb/Ew04ovTZvn/zgMi060J2c3HU5v6e0tBkac=
Date:   Sat, 21 Aug 2021 18:20:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] staging: r8188eu: fix sparse warnings
Message-ID: <YSEn0RaIwMLywhkF@kroah.com>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629562355.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 09:48:27PM +0530, Aakash Hemadri wrote:
> Hi,
> 	This patch series fixes some sparse warnings in rtw_br_ext.c
> 
> Thanks,
> Aakash Hemadri
> 
> Aakash Hemadri (5):
>   staging: r8188eu: restricted __be16 degrades to int
>   staging: r8188eu: cast to restricted __be32
>   staging: r8188eu: incorrect type in csum_ipv6_magic
>   staging: r8188eu: restricted __be16 degrades to int
>   staging: r8188eu: incorrect type in assignment
> 
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 093991aaadf0fbb34184fa37a46e7a157da3f386
> -- 
> 2.32.0
> 
> 

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
