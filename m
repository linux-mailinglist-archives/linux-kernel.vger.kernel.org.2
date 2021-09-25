Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24D5418085
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 10:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbhIYItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 04:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243259AbhIYItE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 04:49:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25FBB6108B;
        Sat, 25 Sep 2021 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632559650;
        bh=jljm/gq2Uo3CFBJYUG9QFQdu6pwhLsRTik+sAfGux90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpEehK1WCcq92jJYny4m2TX1ZNFMIm+qW3leSOGo+gF6pwjuOyi96HeqEVoNQkkm6
         sMHj0fU3UcixtGiDhLpPqFDJ4hGiS7u4FUvoN1yF1cJHS0xnJ/Raz5wL2e1MGtWcAG
         bv1ADhAzR4K70vm7CZV91znkQ0C8nSaGPDUq4dZ4=
Date:   Sat, 25 Sep 2021 10:47:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: vt6655: replace camel case
 b_short_slot_time instead of bShortSlotTime.
Message-ID: <YU7iHvNQPI81WvsM@kroah.com>
References: <20210925074531.10446-1-tomm.merciai@gmail.com>
 <20210925074531.10446-2-tomm.merciai@gmail.com>
 <YU7XBPzQAq2s7d4L@kroah.com>
 <20210925084134.GA4727@tom-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925084134.GA4727@tom-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:41:34AM +0200, Tommaso Merciai wrote:
> On Sat, Sep 25, 2021 at 10:00:04AM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Sep 25, 2021 at 09:45:22AM +0200, Tommaso Merciai wrote:
> > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > 
> > I can not take patches without any changelog text at all, sorry.
> > 
> > My bot pointed you at the instructions for how to write a good
> > changelog, please read that before resubmitting.
> > 
> > thanks,
> > 
> > greg k-h
>   
>   Hi,
>   Thanks for your time. Sorry but I'm trying to check what I'm missing
>   "Versioning one patch revision" as suggested by Gustavo A. R. Silva.
> 
>   https://kernelnewbies.org/Outreachyfirstpatch
> 
>   I put Changes since vN after git format-patch "---". Maybe I'm missing
>   other stuff?

You are missing other stuff :)

Notably the actual text that goes in the git changelog that explains
what this patch is doing and why it is needed.  Again, please read the
link that my bot pointed you at.

thanks,

greg k-h
