Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1AC3562D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 07:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348536AbhDGFFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 01:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244465AbhDGFF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:05:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 552F9610E5;
        Wed,  7 Apr 2021 05:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617771919;
        bh=yG9sVV2XkTvpYthUJOLIYdqgQ1z2rajhnaemIOf45eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPvzvVSy71KM4xUwqP39Gqh4X+ftx3L0i4IOphPe//PnfzGhbJ07NLSmVInzLChT1
         4zfdfdeXFL6YL2YmgI3YsaLXcia2D6RIpQcFO+hyCcSeW5k6JWKfNE8Oyq2wYeNrGX
         7mRmePqTgGvnncG6upTN+imXJRZk8H+pGrZaw7C8=
Date:   Wed, 7 Apr 2021 07:05:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zuo Qi Lin <zuoqilin1@163.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] fs/debugfs: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <YG09jTh5QGLLqtKP@kroah.com>
References: <20210402121141.82-1-zuoqilin1@163.com>
 <YGcMgENjMSla4BO3@kroah.com>
 <20210407102206.00005d9a.zuoqilin1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407102206.00005d9a.zuoqilin1@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:22:06AM +0800, Zuo Qi Lin wrote:
> On Fri, 2 Apr 2021 14:22:24 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Apr 02, 2021 at 08:11:41PM +0800, zuoqilin1@163.com wrote:
> > > From: zuoqilin <zuoqilin@yulong.com>  
> > 
> > Please use your full/real name.
> > 
> > thanks,
> > 
> > greg k-h
> 
> -----------------------------------------------------------
> Hi 
> 
> My name is Zuo Qilin.

Great!  Then use that above :)

Also that name does not match your "From: " name in your email, here
either, so please just get them all the same when sending a patch.

thanks,

greg k-h
