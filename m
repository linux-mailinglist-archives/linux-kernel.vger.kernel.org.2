Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690F1428173
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhJJNM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhJJNM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:12:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1F6A61076;
        Sun, 10 Oct 2021 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633871428;
        bh=ofLwMdJPr8c/nsbZa56UKm1KuyjPyG9jWpmTcjItIHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlVt5E5hCUuYIzb0anOPd40p3AUJyGYcdEiISlWEgBLmKbO3UmSM8vhIz22loHgnj
         fYGaBiGQC9nK1cLDkpyuwLwd9gTo48LdQ1wcM26g+fEAH7/tzGUCpu9wPqmSKgwltr
         +nGSMitrNMxUeVIrfQLW7Nnhm8suc7dBctswbzDE=
Date:   Sun, 10 Oct 2021 15:10:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Bruce Mitchell <Bruce.Mitchell@ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v4] usb: ehci: handshake CMD_RUN instead of STS_HALT
Message-ID: <YWLmQcw1ON4/BWfV@kroah.com>
References: <20210910073619.26095-1-neal_liu@aspeedtech.com>
 <CACPK8Xf40cfnFFeeAzkdXk6ikbfBhWOOt6U8Oq3iCaxe5v5=_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xf40cfnFFeeAzkdXk6ikbfBhWOOt6U8Oq3iCaxe5v5=_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 01:27:02AM +0000, Joel Stanley wrote:
> Hi Greg,
> 
> On Fri, 10 Sept 2021 at 07:38, Neal Liu <neal_liu@aspeedtech.com> wrote:
> >
> > For Aspeed, HCHalted status depends on not only Run/Stop but also
> > ASS/PSS status.
> > Handshake CMD_RUN on startup instead.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
> > Tested-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Has this one gone in? If not, here's some tags:
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> It also needs to go to stable:
> 
> Cc: stable@vger.kernel.org
> Fixes: 280a9045bb18 ("ehci: fix EHCI host controller initialization sequence")

This is already in my tree, but waiting until 5.16-rc1, sorry.  You can
see it at commit 7f2d73788d90 ("usb: ehci: handshake CMD_RUN instead of
STS_HALT") in linux-next.  I'll try to remember to queue it up in stable
after it hits Linus's tree.

thanks,

greg k-h
