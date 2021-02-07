Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6EB3124B4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBGOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGOfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:35:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64B7764E42;
        Sun,  7 Feb 2021 14:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612708503;
        bh=3oAePvp7BtjsZE5pGFHqzeOfislh9iQnGI/HKJOc+Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrYvmFzVRVgfpGW9Pgc47Zn3ZqU6prI1sq6jhYlMFGfimmperFwI+D1ZuW0IyzjpC
         QVEumeTmmBwDIXCXwlnkm4NH/p6cBS1+ELiGEiHnM/Z6l9kmuUxx3auTMlh6HVRBC2
         0SkiiiTdmRGZDG6p2j/FhCdExFCcQRgLJgxYYAzQ=
Date:   Sun, 7 Feb 2021 15:35:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mahak Gupta <gmahak1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        rcy@google.com, benchan@chromium.org, toddpoynor@google.com,
        rspringer@google.com
Subject: Re: [PATCH] staging: gasket: fix indentation and lines ending with
 open parenthesis
Message-ID: <YB/6lL/kljg/isrH@kroah.com>
References: <20210207140928.11029-1-gmahak1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207140928.11029-1-gmahak1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 07:39:28PM +0530, Mahak Gupta wrote:
> This patch fixes warnings of 'checkpatch.pl'. According to
> Linux coding guidelines, code should be aligned properly to
> match with open parenthesis and lines should not end with
> open parenthesis.
> 
> Signed-off-by: Mahak Gupta <gmahak1@gmail.com>
> ---
>  drivers/staging/gasket/gasket_ioctl.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
> index e3047d36d8db..a966231bad42 100644
> --- a/drivers/staging/gasket/gasket_ioctl.c
> +++ b/drivers/staging/gasket/gasket_ioctl.c
> @@ -40,7 +40,7 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
>  
>  /* Read the size of the page table. */
>  static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
> -	struct gasket_page_table_ioctl __user *argp)
> +				       struct gasket_page_table_ioctl __user *argp)
>  {
>  	int ret = 0;
>  	struct gasket_page_table_ioctl ibuf;
> @@ -51,8 +51,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
>  	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
>  		return -EFAULT;
>  
> -	ibuf.size = gasket_page_table_num_entries(
> -		gasket_dev->page_table[ibuf.page_table_index]);
> +	ibuf.size = gasket_page_table_num_entries(gasket_dev->page_table[ibuf.page_table_index]);
>  
>  	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
>  					   ibuf.host_address,
> @@ -66,7 +65,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
>  
>  /* Read the size of the simple page table. */
>  static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
> -	struct gasket_page_table_ioctl __user *argp)
> +					      struct gasket_page_table_ioctl __user *argp)
>  {
>  	int ret = 0;
>  	struct gasket_page_table_ioctl ibuf;
> @@ -92,7 +91,7 @@ static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
>  
>  /* Set the boundary between the simple and extended page tables. */
>  static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
> -	struct gasket_page_table_ioctl __user *argp)
> +				       struct gasket_page_table_ioctl __user *argp)
>  {
>  	int ret;
>  	struct gasket_page_table_ioctl ibuf;
> @@ -107,8 +106,8 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
>  
>  	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
>  		return -EFAULT;
> -	max_page_table_size = gasket_page_table_max_size(
> -		gasket_dev->page_table[ibuf.page_table_index]);
> +	max_page_table_size = gasket_page_table_max_size
> +		(gasket_dev->page_table[ibuf.page_table_index]);
>  
>  	if (ibuf.size > max_page_table_size) {
>  		dev_dbg(gasket_dev->dev,
> @@ -119,8 +118,7 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
>  
>  	mutex_lock(&gasket_dev->mutex);
>  
> -	ret = gasket_page_table_partition(
> -		gasket_dev->page_table[ibuf.page_table_index], ibuf.size);
> +	ret = gasket_page_table_partition(gasket_dev->page_table[ibuf.page_table_index], ibuf.size);
>  	mutex_unlock(&gasket_dev->mutex);
>  
>  	return ret;
> @@ -183,7 +181,7 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
>   * corresponding memory.
>   */
>  static int gasket_config_coherent_allocator(struct gasket_dev *gasket_dev,
> -	struct gasket_coherent_alloc_config_ioctl __user *argp)
> +					    struct gasket_coherent_alloc_config_ioctl __user *argp)
>  {
>  	int ret;
>  	struct gasket_coherent_alloc_config_ioctl ibuf;
> -- 
> 2.17.1
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
