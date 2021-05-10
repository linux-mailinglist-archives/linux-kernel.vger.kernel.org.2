Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86143378DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhEJM7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348504AbhEJMmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:42:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2814061075;
        Mon, 10 May 2021 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620650459;
        bh=IFUIQLT4ckcRv4nIp14Tw+hshyc6udmW0RapcuUSdmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vq5nD8M+MzlLGt3AMxKIMB6HJH9BBqGtYHj1Ofe+F+OhulRpH1A9rdQzo4NX0q7dx
         bRLBd9LOsyHENVMvbooeoG4n69uar09KSzvEu2uqMNFgmLYFYTvyM0EB3bftKSp8pv
         COcKb8lsyehvR3PdUPiM6g59+a4jPkTaZr/11tSE=
Date:   Mon, 10 May 2021 14:40:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/1] usb: dwc3: pci: Enable usb2-gadget-lpm-disable
 for Intel Merrifield
Message-ID: <YJkp2ZfhB717CmT7@kroah.com>
References: <20210425195452.94143-1-ftoth@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425195452.94143-1-ftoth@exalondelft.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 09:54:52PM +0200, Ferry Toth wrote:
> On Intel Merrifield LPM is causing the host to reset port after a timeout.
> By disabling LPM entirely this is prevented.
> 
> Fixes: 066c09593454 ("usb: dwc3: pci: Enable extcon driver for Intel Merrifield")
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-pci.c | 1 +
>  1 file changed, 1 insertion(+)

What changed from v1?  Always put that below the --- line.

