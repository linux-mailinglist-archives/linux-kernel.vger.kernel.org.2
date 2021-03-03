Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2813732BEA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574417AbhCCRdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349198AbhCCN4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:56:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4478C64E87;
        Wed,  3 Mar 2021 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614779754;
        bh=y+3D2ihOR15AlOsH25HAl7Bu9/GoIWNYosMrVHxotiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vjXJ/gK4TyF7Ma53BIHkYMoX6TGx/2Tl4NXVAvJUGnucYHfxa2lakbUl+N+GNta7q
         zz7URZXNhx4wqXUOTm2G8D1K4efC/LXLJR4QLVR86fU610wWYHRsZ2S8jJp1kG7pS9
         MvUxx72S6UXtKu2JcNjimQv5D+gW8g5QY0+WEpLM=
Date:   Wed, 3 Mar 2021 14:55:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     maqiang <maqianga@uniontech.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: lp: remove redundant space
Message-ID: <YD+VaDUQFDBpAWEH@kroah.com>
References: <20210303113938.16867-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303113938.16867-1-maqianga@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 07:39:38PM +0800, maqiang wrote:
> These two lines of code don't meet the kernel coding style,
> so remove the redundant space.
> 
> Signed-off-by: maqiang <maqianga@uniontech.com>

Please use your "full" name that you sign legal documents with.

thanks,

greg k-h
