Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40187398E6C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhFBPV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232284AbhFBPUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E26C61246;
        Wed,  2 Jun 2021 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622647141;
        bh=PZsB06x+NpT1ViJV6G6NQaYYnRZjPyiFIouzYvlLxjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNKqPnVjyzL6cTsrSlGEvTMzkcZ/q4VLLFIXOOprEKdyqPlrIwuzLTGgNvmVRJubT
         60MDGV61ArOGWEbyhUi07+G3pVdihsZCBF62G1F9zXDkEBRU6HaxfAOjZrX7iyxyaK
         kLsdNbfIFWshrpWPvgi0KOOBL32DG2AQthP1A/XQ=
Date:   Wed, 2 Jun 2021 17:18:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     sh4nnu <manikishanghantasala@gmail.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: fix coding-style issues in r8192U_hw.h
Message-ID: <YLehYmLYBMmI8MOk@kroah.com>
References: <20210602151038.53794-1-manikishanghantasala@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602151038.53794-1-manikishanghantasala@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 08:40:33PM +0530, sh4nnu wrote:
> staging: rtl8192u: r8192U_hw.h: Clear the coding-style issue
> 
> "Macros with complex values should be enclosed in parantheses"
> by enclosing values in parantheses.
> Modified spacing around "|" and removed a space before tab.
> 
> Signed-off-by: sh4nnu <manikishanghantasala@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_hw.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
> index 8d3a592f1c35..aabe03721d99 100644
> --- a/drivers/staging/rtl8192u/r8192U_hw.h
> +++ b/drivers/staging/rtl8192u/r8192U_hw.h
> @@ -88,7 +88,7 @@ enum _RTL8192Usb_HW {
>  #define RX_FIFO_THRESHOLD_MASK (BIT(13) | BIT(14) | BIT(15))
>  #define RX_FIFO_THRESHOLD_SHIFT 13
>  #define RX_FIFO_THRESHOLD_NONE 7
> -#define MAX_RX_DMA_MASK 	(BIT(8) | BIT(9) | BIT(10))
> +#define MAX_RX_DMA_MASK		(BIT(8) | BIT(9) | BIT(10))
>  #define RCR_MXDMA_OFFSET	8
>  #define RCR_FIFO_OFFSET		13
>  #define RCR_ONLYERLPKT		BIT(31)			// Early Receiving based on Packet Size.
> @@ -221,13 +221,13 @@ enum _RTL8192Usb_HW {
>  #define	RATR_MCS14		0x04000000
>  #define	RATR_MCS15		0x08000000
>  // ALL CCK Rate
> -#define RATE_ALL_CCK		RATR_1M|RATR_2M|RATR_55M|RATR_11M
> -#define RATE_ALL_OFDM_AG	RATR_6M|RATR_9M|RATR_12M|RATR_18M|RATR_24M\
> -							|RATR_36M|RATR_48M|RATR_54M
> -#define RATE_ALL_OFDM_1SS	RATR_MCS0|RATR_MCS1|RATR_MCS2|RATR_MCS3 | \
> -							RATR_MCS4|RATR_MCS5|RATR_MCS6|RATR_MCS7
> -#define RATE_ALL_OFDM_2SS	RATR_MCS8|RATR_MCS9	|RATR_MCS10|RATR_MCS11| \
> -							RATR_MCS12|RATR_MCS13|RATR_MCS14|RATR_MCS15
> +#define RATE_ALL_CCK		(RATR_1M | RATR_2M | RATR_55M | RATR_11M)
> +#define RATE_ALL_OFDM_AG	(RATR_6M | RATR_9M | RATR_12M | RATR_18M |\
> +				 RATR_24M | RATR_36M | RATR_48M | RATR_54M)
> +#define RATE_ALL_OFDM_1SS	(RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
> +				 RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | RATR_MCS7)
> +#define RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\
> +				 RATR_MCS12 | RATR_MCS13 | RATR_MCS14 | RATR_MCS15)
>  
>  	EPROM_CMD		= 0xfe58,
>  #define Cmd9346CR_9356SEL	BIT(4)
> -- 
> 2.25.1
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
