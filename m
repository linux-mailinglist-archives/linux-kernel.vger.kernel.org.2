Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E621E41D7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350055AbhI3Kp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349865AbhI3Kp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:45:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66954610A2;
        Thu, 30 Sep 2021 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632998624;
        bh=y1o++T9LBcKIpcl8lUORUmDeRJWvBztNwma/RriJp7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuAT54/71zVMpvdjV02MrkTLKc+86BnaVA01cioeNA/e135uiLicJXFw3JR7SmKvZ
         DI3fRoUkbtYT3F/31PXQ9s/I5qMztroEQc0FdizvtumA5dKUYvsk3slHnFUVUaOxMA
         PmEZfpRY9uG1W/u6m5KyWSKR4K4c09aPWrcfYkjQ=
Date:   Thu, 30 Sep 2021 12:43:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antti Kervinen <antti.kervinen@intel.com>
Cc:     tklauser@distanz.ch, Jonathan.Cameron@huawei.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        song.bao.hua@hisilicon.com, tiantao6@hisilicon.com,
        yury.norov@gmail.com
Subject: Re: [PATCH] cpumask: Omit terminating null byte in
 cpumap_print_{list,bitmask}_to_buf
Message-ID: <YVWU3f5elbnRctae@kroah.com>
References: <20210916222705.13554-1-tklauser@distanz.ch>
 <20210930103010.2716097-1-antti.kervinen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930103010.2716097-1-antti.kervinen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 01:30:10PM +0300, Antti Kervinen wrote:
> 
> An original function, bitmap_print_to_pagebuf() in lib/bitmap.c,
> returns the number of printed characters, excluding terminating null.
> 
> Commit 1fae5629, a cause of this regression, introduced new functions
> to lib/bitmap.c:
> 
> - bitmap_print_to_buf()
>   (return value doc missing)
> 
> - bitmap_print_bitmask_to_buf()
>   (return value doc not explicit about terminating null, but
>   can be considered misleading)
> 
> - bitmap_print_list_to_buf()
>   (the same as above)
> 
> Unlike the original function, the return value of new functions
> include the terminating null.
> 
> As this behavior is clearly opposite to the original function, and
> functions that print to buffers in general, I would suggest fixing
> this problem by alignign these new functions with the original one:
> excluding the terminating null. And documenting this behavior
> unambiguously.
> 
> The suggested change to cpumask_print_{bitmask,list}_to_buf()
> functions decrements possible errors (like -ENOMEM) returned by
> bitmap_print_to_buf(). This must not happen.

I already pointed you at
	https://lore.kernel.org/r/20210916222705.13554-1-tklauser@distanz.ch
a few hours ago.

Why not test the patch there (and in linux-next) and let us know if it
resolves the issue you see or not.

thanks,

greg k-h
