Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3653ECFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhHPILB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234503AbhHPIK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:10:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5289661AFC;
        Mon, 16 Aug 2021 08:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629101425;
        bh=Q2rTcpbGoDYXSqrTZIPCkTl7PTdnF+8YLs/LK9+nyP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vbLiHjOnN9GRqjt1sBayuoYp17GjUWH0LWpDcs0O6gjxcUem0XscP6MkHhBEwDR0E
         gHAu1iRxWM2cr1odd8cu1kcvwzQYnxLIb5o1w/lDMpa/pagztWSE+JZP8rVRMCqPfY
         4VW1C5xcHpnblD+NUA3Uure/Tv5qo/gcPCjDRn/M=
Date:   Mon, 16 Aug 2021 10:10:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     dan.carpenter@oracle.com, yangyingliang@huawei.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove the dependency on ipx.h
Message-ID: <YRodb5XKDC7NF/pQ@kroah.com>
References: <20210816075406.938-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816075406.938-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:54:06PM +0800, Cai Huoqing wrote:
> commit <47595e32869f> ("<MAINTAINERS: Mark some staging directories>")
> indicated the ipx network layer as obsolete in Jan 2018,
> updated in the MAINTAINERS file
> 
> now, after being exposed for 3 years to refactoring,
> so to remove the dependency on ipx.h
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 24 ++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

See:
	https://lore.kernel.org/r/20210816073450.668993-2-gregkh@linuxfoundation.org

for a different approach to this.

thanks,

greg k-h

