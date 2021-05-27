Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5618D392C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhE0LMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232891AbhE0LL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F1F561028;
        Thu, 27 May 2021 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622113825;
        bh=M3DIHT756xXhbeiWHhuicNBdTbcwyCz9skDBLtVxm5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rw9eANvjxWl1Odcz8PbgicIBK5gDbzfhfAPerFRKhTAgwHAkJfk9WMGaBQWoO39eb
         PG+CUcrmGQAxWWSe2TG+7BvH0yhVfxhH8Gy28ug2ajgBweAbRIYsH8IHoKytprQw+e
         OtwbAE9hT7mNWWnyjcOTYohFFGh9mpJD0xj5vB+E=
Date:   Thu, 27 May 2021 13:10:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
Subject: Re: [PATCH] powerpc/udbg_hvc: retry putc on -EAGAIN
Message-ID: <YK9+HyS3zE09iUSe@kroah.com>
References: <20210514214422.3019105-1-nathanl@linux.ibm.com>
 <YKer6KPaHDgaWS8k@kroah.com>
 <87mtsliuzm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtsliuzm.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 08:51:09PM +1000, Michael Ellerman wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> > On Fri, May 14, 2021 at 04:44:22PM -0500, Nathan Lynch wrote:
> >> hvterm_raw_put_chars() calls hvc_put_chars(), which may return -EAGAIN
> >> when the underlying hcall returns a "busy" status, but udbg_hvc_putc()
> >> doesn't handle this. When using xmon on a PowerVM guest, this can
> >> result in incomplete or garbled output when printing relatively large
> >> amounts of data quickly, such as when dumping the kernel log buffer.
> >> 
> >> Call again on -EAGAIN.
> >> 
> >> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> >> ---
> >>  drivers/tty/hvc/hvc_vio.c | 2 +-
> >
> > Subject line does not match up with this file name.
> >
> > Don't you want "tty" and "hvc" in there somewhere?
> 
> It's a powerpc only driver, but I guess the subject should still be
> "tty: hvc: ..." to match convention.
> 
> I was planning to take this via the powerpc tree, but I can drop it if
> you'd rather take it.

No problem, feel free to take it yourself!

greg k-h
