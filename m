Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29136320B3E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBUPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUPC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:02:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52E1E64EDE;
        Sun, 21 Feb 2021 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613919736;
        bh=d4ANynSmNbXObqDDoOwixZII/pFiyoIFifqZb3QHJZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BV9ea2WRL93VHHdd8M4b8HmNPaZy1+rg+pDZAZdqOMg7bSHrdC7QpKLfxCHBi3d+w
         AlokQjkItPU6LenTidaXAe8jDxkUsXPerszhfTEjGRClM+8bgPooQYW9OKjzSiCS27
         EEh2oy7Qnon8J3Rvbp5GbJBHAJgcq/smrvnFlO0w=
Date:   Sun, 21 Feb 2021 16:02:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthik alapati <mail@karthek.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: media/atomisp: don't compile unused code
Message-ID: <YDJ19vSgRjR6edby@kroah.com>
References: <cover.1613915981.git.mail@karthek.com>
 <90eb63796a8f8aca988efb33247ea01f4a860074.1613915981.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90eb63796a8f8aca988efb33247ea01f4a860074.1613915981.git.mail@karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 07:34:57PM +0530, karthik alapati wrote:
> currently the functions defined in ibuf_ctrl_rmgr.c file are only
> used by isys_init.c when CONFIG_VIDEO_ATOMISP_ISP2401 is selected
> so dont't compile it when not needed, also fixes some sparse warnings
> 
> Signed-off-by: karthik alapati <mail@karthek.com>
> ---
>  drivers/staging/media/atomisp/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

This has nothing to do with the previous 2 patches, why did you add it
to this series?

And note, you missed the correct people to send this patch to, so it's
not going to ever get applied :(

thanks,

greg k-h
