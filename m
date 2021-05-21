Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D2838C69F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhEUMhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhEUMhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:37:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49AD5613DF;
        Fri, 21 May 2021 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621600587;
        bh=dhLso/vIiTF2IWtgiXtmzhZHjHC6OeVr8BkZcImxV+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMOdL2j2wPiZ+kEi1sU9bD0PXTQjgMfpN7BPDycqsEUZ0atQt0ABGg+J1Cjs4tb+Q
         Z0Pyj3wDOcaSEj8UPqSknq6FZ+PifsXd3PEraj3DxKs8qP2tf/a8T/fvFLW064XZsO
         mlVQZ/2alUDvYrFsfYGSRIZnyzJLCXxB4hLEtoQA=
Date:   Fri, 21 May 2021 14:36:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, mihai.carabas@oracle.com,
        andriy.shevchenko@linux.intel.com, pizhenwei@bytedance.com,
        pbonzini@redhat.com, linqiheng@huawei.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] misc/pvpanic: Fix error handling in
 'pvpanic_pci_probe()'
Message-ID: <YKepSQpLUc5V17tz@kroah.com>
References: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 04:36:55PM +0200, Christophe JAILLET wrote:
> There is no error handling path in the probe function.
> Switch to managed resource so that errors in the probe are handled easily
> and simplify the remove function accordingly.
> 
> Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/pvpanic/pvpanic-pci.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

I see two different series for these patches, so I don't know which to
take :(

Please fix up and send a v2 series so that I have a clue...

thanks,

greg k-h
