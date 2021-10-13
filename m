Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5794842C005
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhJMMb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhJMMbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:31:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEC68610C8;
        Wed, 13 Oct 2021 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634128188;
        bh=h3WziEftLqB6CU7avBQ1X6oRlDM1FEjW0Zbtli9UK00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yAjnkJJSL62mMS+MVSO+UOwK+/98XNAUaVp0cGPpaMHa09m+LKqV632jgKZvnBNTQ
         vMcs4PJGgG1Uajm2OzT9aevBp5wYOjR5WRpkL3jQn9KUk/h+oyPa+QhJnIFfPFNx3y
         oc0/tyqbqnz5mxpxCajUoj5tlar+1MAOuBGfHjR8=
Date:   Wed, 13 Oct 2021 14:29:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] staging: r8188eu: use kzalloc instead of kmalloc and
 memset
Message-ID: <YWbROYHPtt42qC4c@kroah.com>
References: <20211013070149.349-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013070149.349-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:01:28AM -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/staging/r8188eu/os_dep/ioctl_linux.c:422:10-17:
> WARNING: kzalloc should be used for pwep, instead of kmalloc/memset
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Someone just sent this same patch before you did, sorry:
	https://lore.kernel.org/r/20211012024624.GA1062447@embeddedor

