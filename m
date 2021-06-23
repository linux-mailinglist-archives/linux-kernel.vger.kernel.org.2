Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5A3B11D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 04:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFWCob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 22:44:31 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:50714 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWCoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 22:44:30 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BEE9E72C8B4;
        Wed, 23 Jun 2021 05:42:12 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B27227CF72A; Wed, 23 Jun 2021 05:42:12 +0300 (MSK)
Date:   Wed, 23 Jun 2021 05:42:12 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] userfaultfd: fix UFFDIO_CONTINUE ioctl request
 definition
Message-ID: <20210623024212.GA17269@altlinux.org>
References: <20210601143432.1002481-1-glebfm@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601143432.1002481-1-glebfm@altlinux.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 01, 2021 at 05:34:32PM +0300, Gleb Fotengauer-Malinovskiy wrote:
> This ioctl request reads from uffdio_continue structure which justifies
> _IOC_READ flag.
> See NOTEs in include/uapi/asm-generic/ioctl.h for more information.

These ioctl flag usage rules seem to be a perpetual source of mistakes.
I suggest a slightly different wording of the commit message which is
hopefully a bit easier to follow:

"This ioctl request reads from uffdio_continue structure written by
userspace which justifies _IOC_WRITE flag.  It also writes back to that
structure which justifies _IOC_READ flag.

See NOTEs in include/uapi/asm-generic/ioctl.h for more information."
 
Please make sure this patch is merged before v5.13 is released, otherwise
the UAPI bug would have to stay for backwards ABI compatibility.

> Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
>  include/uapi/linux/userfaultfd.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> v2 fix commit message
> 
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index bafbeb1a2624..650480f41f1d 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -80,8 +80,8 @@
>  				      struct uffdio_zeropage)
>  #define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
>  				      struct uffdio_writeprotect)
> -#define UFFDIO_CONTINUE		_IOR(UFFDIO, _UFFDIO_CONTINUE,	\
> -				     struct uffdio_continue)
> +#define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
> +				      struct uffdio_continue)
>  
>  /* read() structure */
>  struct uffd_msg {

Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>


-- 
ldv
