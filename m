Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016863E149A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbhHEMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhHEMUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:20:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64B2E61131;
        Thu,  5 Aug 2021 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628166016;
        bh=hltNOYGNq9IKaszUFsVAUaSkYIfIAlRCI0OZn9UjbPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ng5EwiERXnof1DEYvU2hmUZ0O245fpm2i1omaHOWCQTfKFo5/N2+oUKJzqq6yO1gQ
         /AJJ3OuLPv8uZnauzfKJdk5PmMUv5+tXnUSdZh9OCxxJTf700R4l/yY0HITtmj+X5f
         0UyeVKkZ9J8YSKfypse8EfcpyYZ/1jx7/g+5APZ4=
Date:   Thu, 5 Aug 2021 14:20:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ipack: tpci200: fix many double free issues in
 tpci200_pci_probe
Message-ID: <YQvXfQ4A04cy5MEA@kroah.com>
References: <20210721111137.1523229-1-mudongliangabcd@gmail.com>
 <20210721111137.1523229-2-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721111137.1523229-2-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 07:11:31PM +0800, Dongliang Mu wrote:
> The function tpci200_register called by tpci200_install and
> tpci200_unregister called by tpci200_uninstall are in pair. However,
> tpci200_unregister has some cleanup operations not in the
> tpci200_register. So the error handling code of tpci200_pci_probe has
> many different double free issues.
> 
> Fix this problem by moving those cleanup operations out of
> tpci200_unregister, into tpci200_pci_remove and reverting
> the previous commit 9272e5d0028d
> 
> Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/ipack/carriers/tpci200.c | 35 ++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 18 deletions(-)

This needs to be applied to the tree now, and should not depend on your
patch 1/3 here as it is a bugfix.  Please redo this series and send 2,
one to be merged for 5.14-final and to go to the stable kernels, and a
separate "clean up things" series that can wait until 5.15-rc1.

thanks,

greg k-h
