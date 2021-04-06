Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56835561F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhDFOLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhDFOLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:11:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05ADC613A7;
        Tue,  6 Apr 2021 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617718293;
        bh=wq4U+4ecsCCR/Rbtqkka4myOOcVmx4VEjHscpWZCLPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+mea4rvGOW13dfwSFP/PbmTlYrG0QRLtZfbmryo9FUxkj2TRNcuQkA6gHgmZGWEY
         CMa/JCjYkWRj0QLL2QE7qJ6aPs5bPhlQa3/BkkavQcwgXPLE2ca4IHNoFBoYcAR1S4
         WaeclgvYzwY+u85DZhrQF26NsbEkw2LhGh/OP2zQ=
Date:   Tue, 6 Apr 2021 16:11:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: hal: Remove
 camelcase in Hal8723BReg.h
Message-ID: <YGxsExq2fcQvrN99@kroah.com>
References: <20210406130556.1417-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406130556.1417-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 03:05:56PM +0200, Fabio M. De Francesco wrote:
> Remove camelcase in some symbols defined in Hal8723BReg.h. These symbols
> are not used anywhere else, therefore this patch does not break the driver.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

If this is "v2", you need to put below the --- line what changed from
v1.

Please fix up and send a v3.

thanks,

greg k-h
