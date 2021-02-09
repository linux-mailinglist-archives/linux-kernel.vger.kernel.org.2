Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DCE314E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhBILSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:18:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhBILNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:13:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F31FE64E4B;
        Tue,  9 Feb 2021 11:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612869182;
        bh=6x2uQVtjwUOwoznLE5QMUWQ0+QbCr0WByIxKCkNJemw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y2oErq6zh3CsnyRPdTyRqnl5jO/CVp/bxlFkujnMqxr51nJELeV7hMwVQeXzmNKQY
         M+9hUzAIgoMp8B9muIV0eR0OWEq6VToDcxU3QS52/UavosJ/5IVQTV4BIEVNz3RNeK
         VlDQ45tR+57FaQBdldpyaOIgLquimT5XgYF9Gkgc=
Date:   Tue, 9 Feb 2021 12:13:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: google: make coreboot driver's remove callback
 return void
Message-ID: <YCJuPDwchDsjTO4C@kroah.com>
References: <20210126215339.706021-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126215339.706021-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:53:39PM +0100, Uwe Kleine-König wrote:
> All coreboot drivers return 0 unconditionally in their remove callback.
> Also the device core ignores the return value of the struct
> bus_type::remove(), so make the coreboot remove callback return void
> instead of giving driver authors the illusion they could return an error
> code here.
> 
> All drivers are adapted accordingly.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
> Hello,
> 
> there is no registerd maintainer of this code. I assume so Greg will
> pick this up?!

Now picked up, thanks.

greg k-h
