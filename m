Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B6C35C491
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhDLLA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239843AbhDLLAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:00:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C9EC61241;
        Mon, 12 Apr 2021 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618225204;
        bh=jrTLLq4qjpyYrWKjrn65QbFhsZS8WXKdFzH9fVWjqdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ANK3GpXNP3bnczL5TmSXLhkF56yedowok02NvL6G1Uph4GQ/Y4v8APc/xvscbhFZ
         f3U5pZK1SvH1TqrJkFBxGC+h4ARhKxNB2D69UAQ9FU3z4d0G1JLGXFjjW5b2UArKU+
         5udk95e2ClJrK8t0dtyjkUK223TYwsx/m/2luTpQ=
Date:   Mon, 12 Apr 2021 13:00:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 12/12] USB: cdc-acm: add more Maxlinear/Exar models to
 ignore list
Message-ID: <YHQoMmdS+RqyytU4@kroah.com>
References: <20210412095557.1213-1-johan@kernel.org>
 <20210412095557.1213-13-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412095557.1213-13-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:55:57AM +0200, Johan Hovold wrote:
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Now that the xr_serial got support for other models, add their USB IDs
> as well.
> 
> The Maxlinear/Exar USB UARTs can be used in either ACM mode using the
> cdc-acm driver or in "custom driver" mode in which further features such
> as hardware and software flow control, GPIO control and in-band
> line-status reporting are available.
> 
> In ACM mode the device always enables RTS/CTS flow control, something
> which could prevent transmission in case the CTS input isn't wired up
> correctly.
> 
> Ensure that cdc_acm will not bind to these devices if the custom
> USB-serial driver is enabled.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Link: https://lore.kernel.org/r/5155887a764cbc11f8da0217fe08a24a77d120b4.1616571453.git.mchehab+huawei@kernel.org
> [ johan: rewrite commit message, clean up entries ]
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
