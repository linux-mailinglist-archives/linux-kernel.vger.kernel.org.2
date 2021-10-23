Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5C438268
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhJWIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 04:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhJWIxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 04:53:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8548460EE9;
        Sat, 23 Oct 2021 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634979084;
        bh=ct54VtT4K6JE49+uBccZJPg0Fi+OTpFzKU1ZlZJS4ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbsrjSwS91SrdgYD5BqeVZSiLY2AlYS+SZHBaTnzKfXnPcz2uRX8VQkZ0tdYHvrt/
         pUsQudoVQK6I467c+Ypfl5Q+b08CsyoIEYhDY2LMc9wcRiK2YKJPLLQWqQVJdZMwoj
         T9GXradhzLza5ZZYgDsqYMaviLasUmqxGbm26ExA=
Date:   Sat, 23 Oct 2021 10:51:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] Docs: usb: update struct usb_driver, __init and __exit
Message-ID: <YXPNBAdp+3YO+ZT/@kroah.com>
References: <20211023065916.GA6268@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023065916.GA6268@matrix-ESPRIMO-P710>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 08:59:16AM +0200, Philipp Hortmann wrote:
> update struct usb_driver from usb-skeleton.c.
> remove :c:func: for usb_register and usb_deregister
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

As you are doing two totally different things here in the same patch,
this should be 2 different patches, right?  Please make this a patch
series.

thanks,

greg k-h
