Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209E7379FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhEKG12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhEKG1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:27:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59CC66128E;
        Tue, 11 May 2021 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620714374;
        bh=UV4fbVgL52REpMq4SBHkMYtTskxfKhM6n65aZENFeQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrC+pPxY9XfYL1SCiO31Uaer3bPCA1aSWeXRv2rQcWmU9FnksNiyM3/qum2/hCQeR
         gz/EzWvr9fKqDq0wOpQZFi7bdKcTGMcfXp2Lm5RlycrkxAW5/Y93qtsrG9rq3uH8du
         anhnxGnoFVozousFuWEiScfvlXxpY8YMfIOFq2yw=
Date:   Tue, 11 May 2021 08:26:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Increase timeout for HC halt
Message-ID: <YJojglZqVE3vaUxX@kroah.com>
References: <20210511002933.1612871-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511002933.1612871-1-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 02:29:33AM +0200, Maximilian Luz wrote:
> On some devices (specifically the SC8180x based Surface Pro X with
> QCOM04A6) HC halt / xhci_halt() times out during boot. Manually binding
> the xhci-hcd driver at some point later does not exhibit this behavior.
> To work around this, double XHCI_MAX_HALT_USEC, which also resolves this
> issue.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  drivers/usb/host/xhci-ext-caps.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Should this go to stable kernels as well?

thanks,

greg k-h
