Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37E3C8173
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhGNJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238291AbhGNJZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:25:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82EB061396;
        Wed, 14 Jul 2021 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626254531;
        bh=iWkXEwS6/RcWzpnSyrd1venxnCkUIGN1a2E3Y4jNlIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3KIgw3frS2stjRSJpH4g3zTtpI/eyVJo/VgNbULk5igfTHXNYdtuK1PUw14nIpAJ
         vPUG3SLDi1vdBM6um4ud95MHjbT/Q+Hd3z3SAdcRfsKWtimHNURmI6C/gyDKiJzhbc
         Tx7T9X+VIciaBXyawivAgcTdEsngo0MsuwmWk1NE=
Date:   Wed, 14 Jul 2021 11:22:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, fei1.li@intel.com
Subject: Re: [PATCH] MAINTAINERS: Change ACRN HSM driver maintainer
Message-ID: <YO6sv1zUxljRRcdN@kroah.com>
References: <20210714082614.88560-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714082614.88560-1-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 04:26:14PM +0800, Shuo Liu wrote:
> Shuo steps down, Fei will take over.
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

We need an ack from the person you are assigning this to :)

thanks,

greg k-h
