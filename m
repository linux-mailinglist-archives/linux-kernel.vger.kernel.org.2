Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD7C388977
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbhESIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236249AbhESIdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:33:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF3561355;
        Wed, 19 May 2021 08:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621413106;
        bh=44k6xIJijGFNay+2T/qkyD1nvLUD1zJTY/C3KnNuYV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrZ5gfn2PuBpGluKGxj5sZDRstijAVsuNrF8lkX9IKlLwweZWBahhkdjXVYA7YKfc
         HZQ+OzKUX19SnvrdniBX39lL2V8wHTxz5PNqbmLkqH3DIpT8rotB+VhROyMb2QJ/z/
         whCzX6CFumrpba7fIfIN7Vky/wmnp+jWsA/+oRMo=
Date:   Wed, 19 May 2021 10:31:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hriday Hegde <hridayhegde1999@gmail.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 'const' keyword
Message-ID: <YKTM8KmXI8bXUSqp@kroah.com>
References: <20210519081958.7223-1-hridayhegde1999@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519081958.7223-1-hridayhegde1999@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:19:58AM -0700, Hriday Hegde wrote:
> Fixing following warnings found by checkpatch.pl
> WARNING: struct file_operations should normally be const
> 380: FILE: drivers/staging/android/ashmem.c:380:
> +	static struct file_operations vmfile_fops;
> 
> Signed-off-by: Hriday Hegde <hridayhegde1999@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 8ee4320a5dc6..8ff2794b08e3 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> -- 
> 2.25.1
> 
> 

Any reason why you didn't build your change before submitting this
patch?

thanks,

greg k-h
