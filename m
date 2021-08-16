Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D963EDB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhHPQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhHPQud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BF1D60BD3;
        Mon, 16 Aug 2021 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629132601;
        bh=BZy1S4i5I1xaSTwWwzPJ/uVjtG2fkjv77WBJRVxkhw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uN00RyHMAL1nyXwlVIPxwaAQakKr0lXKT67a/DJnjpGoXoIReaiV0lcaMIsP1MDi
         Vs67xZFv9rHx2uWnv0ktjkJNTN8ypYD6KSHx2yquqavRZVSSe22EDaFiN3B79L7fAG
         2qIf7iG3pteBn7TRLG17OB/k99TpXRLTs1+9QOCw=
Date:   Mon, 16 Aug 2021 18:49:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: r8188eu: Remove unused code
Message-ID: <YRqXNyX+fY9qKh3Q@kroah.com>
References: <20210816160617.11949-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816160617.11949-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 06:06:14PM +0200, Fabio M. De Francesco wrote:
> Remove unused code from the r8188eu driver.
> 
> Fabio M. De Francesco (3):
>   staging: r8188eu: Remove unused nat25_handle_frame()
>   staging: r8188eu: Remove all code depending on the NAT25_LOOKUP method
>   staging: r8188eu: Remove no more used variable and function
> 
>  drivers/staging/r8188eu/core/rtw_br_ext.c    | 263 +------------------
>  drivers/staging/r8188eu/include/recv_osdep.h |   1 -
>  drivers/staging/r8188eu/include/rtw_br_ext.h |   1 -
>  3 files changed, 1 insertion(+), 264 deletions(-)

Patch 2/3 did not apply, can you please rebase and resend the remaining
2 patches against my latest tree?

thanks,

greg k-h
