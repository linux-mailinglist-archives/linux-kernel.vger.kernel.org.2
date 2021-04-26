Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3436B6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhDZQVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234565AbhDZQVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:21:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C34B661158;
        Mon, 26 Apr 2021 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619454069;
        bh=kJmUU6T85xolm+/E7OL4SM7JetG7DSZ+/OVpna1AJJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yxisSGVa1awm4wpy7UGcJMTLnBUUgLQyjRaZTOD1twcj023BrtQpNIjI/MJa+ltvI
         0PD20fZKYYK54+EPEIUD+tltezGzPA3kI0T7TuVXi5lFvm8ev2EzHZzEW+w25rq3e0
         4TUKNYYrfDt6PGl2kJ7LPidsW/BV1dEMYOBCDC1o=
Date:   Mon, 26 Apr 2021 18:21:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     siglesias@igalia.com, jens.taprogge@taprogge.org,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging:ipack/carriers/tpci200: Fix a double free in
 tpci200_pci_probe
Message-ID: <YIbocgzOz+rAcuit@kroah.com>
References: <20210426153547.9058-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426153547.9058-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 08:35:47AM -0700, Lv Yunlong wrote:
> In the out_err_bus_register error branch of tpci200_pci_probe,
> tpci200->info->cfg_regs is freed by tpci200_uninstall()->
> tpci200_unregister()->pci_iounmap(..,tpci200->info->cfg_regs)
> in the first time.
> 
> But later, iounmap() is called to free tpci200->info->cfg_regs
> again.
> 
> My patch sets tpci200->info->cfg_regs to NULL after tpci200_uninstall()
> to avoid the double free.
> 
> Fixes: cea2f7cdff2af ("Staging: ipack/bridges/tpci200: Use the TPCI200 in big endian mode")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/ipack/carriers/tpci200.c | 5 ++++-

This is not a staging driver, why does your subject line say that?

thanks,

greg k-h
