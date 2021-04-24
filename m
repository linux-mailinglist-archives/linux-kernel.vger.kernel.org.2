Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A847F36A368
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 00:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhDXWIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 18:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhDXWIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 18:08:43 -0400
Received: from perceval.ideasonboard.com (unknown [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE75BC061574;
        Sat, 24 Apr 2021 15:08:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D393AE9;
        Sun, 25 Apr 2021 00:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1619302068;
        bh=BjhgVKeI9yTNn8YuXQucQOXP2zoxErBFMZNX8p4BcVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgCwT6PGpgwUDRAH3o8xjsKUmQ7KTiYh68Ib1KH5df6CZWixyPHqheTubBfnZ1MjL
         sANFoL5wjuxIjWe/0xyI+y1wAHLReQRTmRnpi6rqZUZrtUSGX6Mc37XxcPJX4+X/TC
         2BRnMw7T20JH18tnj2vWKt8G/8uoOGACDeSsQm7w=
Date:   Sun, 25 Apr 2021 01:07:42 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] usb: gadget: Drop unnecessary NULL checks after
 container_of
Message-ID: <YISWrhfxH0hHLkfl@pendragon.ideasonboard.com>
References: <20210423150626.138188-1-linux@roeck-us.net>
 <87v98ckt2w.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v98ckt2w.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Sat, Apr 24, 2021 at 11:03:19AM +0300, Felipe Balbi wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> > The parameters passed to allow_link and drop_link functions are never NULL.
> > That means the result of container_of() on those parameters is also
> > never NULL, even if the reference into the structure points to the first
> > element of the structure. Remove the subsequent NULL checks.
> >
> > The changes in this patch were made automatically using the following
> > Coccinelle script.
> >
> > @@
> > type t;
> > identifier v;
> > statement s;
> > @@
> >
> > <+...
> > (
> >   t v = container_of(...);
> > |
> >   v = container_of(...);
> > )
> >   ...
> >   when != v
> > - if (\( !v \| v == NULL \) ) s
> > ...+>
> >
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > After the recent discussion about a patch which tried to add a check
> > against NULL after container_of(), I realized that there are a number
> > of such checks in the kernel.
> >
> > Now the big question: Are patches like this acceptable, or do they count
> > as noise ?
> 
> Not noise in my book :-)
> 
> Acked-by: Felipe Balbi <balbi@kernel.org>

Likewise,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

And thank you for the patch.

-- 
Regards,

Laurent Pinchart
