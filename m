Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D1031F77B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhBSKmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhBSKlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:41:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8207464EAF;
        Fri, 19 Feb 2021 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613731259;
        bh=eVO2HD34oqjPxE4D8k4YzK7H3mbnN08+5UHMMbGmNkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeE0V6mQ4HY0+J8qY39MMjuC/hFrku7azSwseFci48NNxZWxDxXAWpLHjh7jBh73F
         LrBpfvsu8egXYahoLDHqEBNzdNbVf4IMfP3ENwzuWYpHXPvvIz/iDW+suJvqNz0Iuz
         jE/vHBvI7HktVdK3fxYW69jfiU7IPRcyHrkCoH0s=
Date:   Fri, 19 Feb 2021 11:40:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amrit Khera <amritkhera98@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: Fix const keyword style issue in
 ashmem.c
Message-ID: <YC+Vt0qJbkCLPZfo@kroah.com>
References: <20210219101338.2670-1-amritkhera98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219101338.2670-1-amritkhera98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:43:39PM +0530, Amrit Khera wrote:
> This change fixes a checkpatch warning for "struct file_operations should normally be const".
> 
> Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
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

Always test-build your patches before sending them out, otherwise you
are wasting reviewer's time, right?

:(
