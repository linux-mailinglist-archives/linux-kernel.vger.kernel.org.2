Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525A13F85DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbhHZKwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234296AbhHZKwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:52:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACE336108F;
        Thu, 26 Aug 2021 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629975117;
        bh=bYzoqaGaeVIa6hmFFr9DEiYpG3DMEBTslADS8rFb29A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZgaZoo6T6k6aZeGZpa25W8XHEpScpqKI8XBJxs/eTnbvxvt5b4tU1Pwr8OkX1lQY
         xOwCRgQv+Fwz2T3F3O7Z7VUNkY4JS9I8/82R53RIXb3UTDOZI3n/g/E88+zWj5RyNL
         HbWAq7yP9Iw7SEiGbku3KSxGESoK8GeOzu/z3rr4=
Date:   Thu, 26 Aug 2021 12:51:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Provide a TODO file for this driver
Message-ID: <YSdySbNSHYGsXz1r@kroah.com>
References: <20210826014959.26857-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826014959.26857-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 03:49:59AM +0200, Fabio M. De Francesco wrote:
> Provide a TODO file that lists the tasks that should be carried out in
> order to move this driver off drivers/staging.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Thanks to Phillip Potter <phil@philpotter.co.uk> for for providing the first draft.
> 
>  drivers/staging/r8188eu/TODO | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 drivers/staging/r8188eu/TODO
> 
> diff --git a/drivers/staging/r8188eu/TODO b/drivers/staging/r8188eu/TODO
> new file mode 100644
> index 000000000000..4bccca69abac
> --- /dev/null
> +++ b/drivers/staging/r8188eu/TODO
> @@ -0,0 +1,16 @@
> +To-do list:
> +
> +* Correct the coding style according to Linux guidelines; please read the document
> +at https://www.kernel.org/doc/html/latest/process/coding-style.html.

Indent and properly wrap your lines at the right width please.

> +* Remove unnecessary debugging/printing macros; for those that are still needed
> +use the proper kernel API (pr_debug(), dev_dbg(), netdev_dbg()).
> +* Remove dead code such as unusued functions, variables, fields, etc..
> +* Use in-kernel API and remove unnecessary wrappers where possible.
> +* Remove the HAL layer and migrate its functionality into the relevant parts of
> +the driver.
> +* Switch to use LIB80211 (This work is currently in development by Larry Finger).
> +* Switch to use MAC80211 (This work is currently in development by Larry Finger).

No need to say "is being done by XXX" anywhere, as that stops people
from helping out on this instantly.

> +Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> +Larry Finger <Larry.Finger@lwfinger.net>, Phillip Potter <phil@philpotter.co.uk>
> +and CC linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org.

As the MAINTAINERS file lists this properly, no need for this paragraph.
That can also be removed from any remaining TODO files that have it in
it that also have correct MAINTAINERS entries.

thanks,

greg k-h
