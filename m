Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855BA3EA3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhHLLhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:37:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52736 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236931AbhHLLhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:37:08 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mE90q-0003Ll-4h; Thu, 12 Aug 2021 19:36:40 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mE90p-0000Aj-SA; Thu, 12 Aug 2021 19:36:39 +0800
Date:   Thu, 12 Aug 2021 19:36:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hongbo Li <herbert.tencent@gmail.com>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        herberthbli@tencent.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/mpi: use kcalloc in mpi_resize
Message-ID: <20210812113639.GD561@gondor.apana.org.au>
References: <1628153612-14419-1-git-send-email-herbert.tencent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628153612-14419-1-git-send-email-herbert.tencent@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 04:53:32PM +0800, Hongbo Li wrote:
> From: Hongbo Li <herberthbli@tencent.com>
> 
> We should set the additional space to 0 in mpi_resize().
> So use kcalloc() instead of kmalloc_array().
> 
> In lib/mpi/ec.c:
> /****************
>  * Resize the array of A to NLIMBS. the additional space is cleared
>  * (set to 0) [done by m_realloc()]
>  */
> int mpi_resize(MPI a, unsigned nlimbs)
> 
> Like the comment of kernel's mpi_resize() said, the additional space
> need to be set to 0, but when a->d is not NULL, it does not set.
> 
> The kernel's mpi lib is from libgcrypt, the mpi resize in libgcrypt
> is _gcry_mpi_resize() which set the additional space to 0.
> 
> This bug may cause mpi api which use mpi_resize() get wrong result
> under the condition of using the additional space without initiation.
> If this condition is not met, the bug would not be triggered.
> Currently in kernel, rsa, sm2 and dh use mpi lib, and they works well,
> so the bug is not triggered in these cases.
> 
> add_points_edwards() use the additional space directly, so it will
> get a wrong result.
> 
> Fixes: cdec9cb5167a ("crypto: GnuPG based MPI lib - source files (part 1)")
> Signed-off-by: Hongbo Li <herberthbli@tencent.com>
> ---
>  lib/mpi/mpiutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
