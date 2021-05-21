Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCF338C6CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhEUMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234312AbhEUMtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:49:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B2A2613CC;
        Fri, 21 May 2021 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621601258;
        bh=ENTtycla6YwFTERpKa9JcOnfx4HXvBKAO7BqN7/IJVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+cYJi7ka1r4587j8Le1eVmc3OfKYDJ7sZ2wxGfmOkdmoH4W0/09mF253SE4LijO/
         bcs0onyPuINzEJSSpKWCKxdOBz873WimMdKpbMocHj1qVggOj8KEnvCRDqQbYH67eW
         W63Kl7geq1iKXj8JN4mg3h7DhIkc0IpfeTAZLwGI=
Date:   Fri, 21 May 2021 14:47:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH] powerpc/udbg_hvc: retry putc on -EAGAIN
Message-ID: <YKer6KPaHDgaWS8k@kroah.com>
References: <20210514214422.3019105-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514214422.3019105-1-nathanl@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 04:44:22PM -0500, Nathan Lynch wrote:
> hvterm_raw_put_chars() calls hvc_put_chars(), which may return -EAGAIN
> when the underlying hcall returns a "busy" status, but udbg_hvc_putc()
> doesn't handle this. When using xmon on a PowerVM guest, this can
> result in incomplete or garbled output when printing relatively large
> amounts of data quickly, such as when dumping the kernel log buffer.
> 
> Call again on -EAGAIN.
> 
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  drivers/tty/hvc/hvc_vio.c | 2 +-

Subject line does not match up with this file name.

Don't you want "tty" and "hvc" in there somewhere?

thanks,

greg k-h
