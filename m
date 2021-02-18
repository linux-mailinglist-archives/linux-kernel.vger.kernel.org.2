Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F7C31E75B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhBRIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhBRHVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:21:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBC7164D9F;
        Thu, 18 Feb 2021 07:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613632232;
        bh=V0ObLKL8xMIPQWZ+Z7mEwookFjTJoIGtHvN+xm7+Rwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCWvovz1y5axANTN4LfJQ8h4mwNxCRNI2xggDWg3Aey16+TaiWX7tCnMcYQfKvN/o
         HfqLvm3frRgElCkITrRVi/1LkZrwaAWW2nOXPHjW1IZ7Hp0G36NuA86sZg9P9CtqKB
         87JPZv3o63E7vCx0wyGKHDmx3bYS9yS8s7LI2JIk=
Date:   Thu, 18 Feb 2021 08:10:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Gopinathan <atulgopinathan@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: cast to (void __user *)
Message-ID: <YC4S5Pxw341zw9DL@kroah.com>
References: <20210218062839.32650-1-atulgopinathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218062839.32650-1-atulgopinathan@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:58:40AM +0530, Atul Gopinathan wrote:
> Resolve the following sparse warning:
> drivers/staging//comedi/comedi_fops.c:2983:41: warning: incorrect type in argument 1 (different address spaces)
> drivers/staging//comedi/comedi_fops.c:2983:41:    expected void [noderef] <asn:1> *uptr
> drivers/staging//comedi/comedi_fops.c:2983:41:    got unsigned int *chanlist
> 
> cmd->chanlist is of type (unsigned int *) as defined in
> "struct comedi_cmd" in file drivers/staging/comedi/comedi.h
> 
> The function "ptr_to_compat()" expects argument of type
> (void __user *) as defined in include/linux/compat.h
> 
> Signed-off-by: Atul Gopinathan <atulgopinathan@gmail.com>
> ---
>  drivers/staging/comedi/comedi_fops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Is this different from your previous patch:
	https://lore.kernel.org/r/20210217165907.9777-1-atulgopinathan@gmail.com

if so, you might need a better subject line here, and for that one, as
they look alike at a quick glance.

Which one goes first?

Can you resend both of these as a patch series with better subjects as a
v2 patch set?

thanks,

greg k-h
