Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB13369EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhDXGCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 02:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhDXGCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 02:02:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA65361476;
        Sat, 24 Apr 2021 06:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619244093;
        bh=6XGCDXGcaoQ+hVBK/IbHul30nrRd138xcaNBNc7ZO9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzCUkt6gL4PZngkYY/CxCyfrXD08JEN5HSLIzrUpzRBkKDMU+iDBsZO096UcK+dzf
         oqFtfec72JDtWmI+QMomzhFE2Wb62/snFzN5IGKo0xBKzF2cEGLEopTP1EgqopDZW2
         HJBzlDoCyXzxlHKeOIj/rkiUfmhRYzVZONsAtQbk=
Date:   Sat, 24 Apr 2021 08:01:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [RFC PATCH] usb: gadget: Drop unnecessary NULL checks after
 container_of
Message-ID: <YIO0OB4rFZcc5/1A@kroah.com>
References: <20210423150626.138188-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423150626.138188-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 08:06:26AM -0700, Guenter Roeck wrote:
> The parameters passed to allow_link and drop_link functions are never NULL.
> That means the result of container_of() on those parameters is also
> never NULL, even if the reference into the structure points to the first
> element of the structure. Remove the subsequent NULL checks.
> 
> The changes in this patch were made automatically using the following
> Coccinelle script.
> 
> @@
> type t;
> identifier v;
> statement s;
> @@
> 
> <+...
> (
>   t v = container_of(...);
> |
>   v = container_of(...);
> )
>   ...
>   when != v
> - if (\( !v \| v == NULL \) ) s
> ...+>
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> After the recent discussion about a patch which tried to add a check
> against NULL after container_of(), I realized that there are a number
> of such checks in the kernel.
> 
> Now the big question: Are patches like this acceptable, or do they count
> as noise ?

Yes they are acceptable, and no, they are not noise.

I will be glad to take this after -rc1 is out, thanks.

thanks,

greg k-h
