Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BE32F8F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 09:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCFIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 03:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhCFIU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 03:20:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA45564FE4;
        Sat,  6 Mar 2021 08:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615018856;
        bh=V+apSkenj7wVNfvNTT/reRzRO7BIURwxpVzitvx2RuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkEt9F0qplk/H2xjRMgtaqKwa69fb2iYjAEeYNF0F7Q0F3/KK0/oVEm7Z5rCekMI5
         hbBPgUaqq4jAn+HbHIphTac6jzv6hDufnElIrLygTgBl5JDj7jQkS5vJDLH5dn0ODW
         cIihiBS0ByovsR1lQpsGJVuKzdLcXMhNyKlNwlH0=
Date:   Sat, 6 Mar 2021 09:20:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nabil5352 <nabil.ibn.mahmud@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: android: ashmem: fixed a struct without const
Message-ID: <YEM7ZcT4QzZ0uCaC@kroah.com>
References: <20210306063817.674041-1-nabil.ibn.mahmud@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306063817.674041-1-nabil.ibn.mahmud@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 12:38:17PM +0600, nabil5352 wrote:
> Fixed a struct without const
> 
> Signed-off-by: nabil5352 <nabil.ibn.mahmud@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index d66a64e42273..7854fd410efa 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -376,7 +376,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  

It's a bit rude to submit patches that you have not at the very least,
tried to build before sending it out to us, right?

Please always do so.

greg k-h
