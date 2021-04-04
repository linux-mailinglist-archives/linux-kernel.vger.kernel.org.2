Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0063537B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhDDJ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 05:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhDDJ4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 05:56:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0F4661380;
        Sun,  4 Apr 2021 09:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617530203;
        bh=73hP+jEaoOThuXHQz9FoAHAQEROgVEtTny858He9dRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nB1qT3VpR+ESVGTlYaK/nDen1ypyZifEgww/pPz7bOL6BN93VuEWJ2b71vUp96J6R
         nO6v6wkgyogp/tgjJhRKJqCUj6FNUL40O3Qz0IBoJtnKcHvGEa21HR0MKgM+GEz7Wt
         /hl36ExET76WwZokZnGpsMhLJfaaSjD0NEADjj4w=
Date:   Sun, 4 Apr 2021 11:56:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging:r8188eu: remove dummy handlers from
 OnAction()
Message-ID: <YGmNWIFSvtOB84Ds@kroah.com>
References: <20210328163323.53163-1-insafonov@gmail.com>
 <20210328163323.53163-2-insafonov@gmail.com>
 <YGcWTOUl8OtAHTT4@kroah.com>
 <8955077a-94b6-9ffb-d2f6-b611845b6cfc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8955077a-94b6-9ffb-d2f6-b611845b6cfc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 12:30:41AM +0300, Ivan Safonov wrote:
> On 4/2/21 4:04 PM, Greg Kroah-Hartman wrote:
> > On Sun, Mar 28, 2021 at 07:33:25PM +0300, Ivan Safonov wrote:
> > > on_action_spct() do nothing, because rtw_get_stainfo() has no side
> > > effects. Other action handlers are trivial.
> > > 
> > > Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> > 
> > Same here, wrong driver name :(
> > 
> 
> Driver name is "r8188eu"...
> 
> $ grep 'r8188eu' drivers/staging/rtl8188eu/include/drv_types.h

Directory name is "rtl8188eu", so something needs to be fixed up here to
remove confusion like this :)

thanks,

greg k-h
