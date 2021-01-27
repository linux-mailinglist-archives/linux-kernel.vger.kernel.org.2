Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B363061DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhA0RWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235781AbhA0RUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C9E664DA6;
        Wed, 27 Jan 2021 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611768012;
        bh=gvWTdwbsA34w2oiAnKEtvNOQz9SrYrz47V3JVa47zt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sq18ImHitmfm+0oG1JCHOEk1u1hPbC/AFqugtl7jxN0s9nNtrpj3oUQkiL9RV5Duk
         aotj9inX7f09ZteNIc/gFFcaDv0eOEVIiyTcDAW6q68vC6+J2RsNrEn9QvwvLrt7Xr
         ojo62GTzgBPV/W/JW8O545dylqANrRJuxGE0OqWgZ2hhiEZix3ZpkhIOLn/hS5hLrD
         aEf2MyhjyBe+LDZLe1jXAGP9+BpY0Ww/4x2ub4SN5U7IPfYlzHIC53fONMX6huq3mB
         fuVapvfWciJ6TG19yuHmbKKIVGSQ6lWEcl4f+XYf1JScqDwQ7A6LbLfvoowwa6pGfV
         ZtRecHX+ClRkg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4oUR-0002M7-5H; Wed, 27 Jan 2021 18:20:23 +0100
Date:   Wed, 27 Jan 2021 18:20:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Xu Wang <vulab@iscas.ac.cn>,
        Liu Shixin <liushixin2@huawei.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/12] usb: misc: appledisplay: update to use the
 usb_control_msg_{send|recv}() API
Message-ID: <YBGg132/qWaPgjsI@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-2-anant.thazhemadam@gmail.com>
 <YBFxkSlWPQRMuaGo@hovoldconsulting.com>
 <f82c8fae-251f-12e9-6e43-28824a5ff3e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82c8fae-251f-12e9-6e43-28824a5ff3e5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 08:12:21PM +0530, Anant Thazhemadam wrote:
> 
> On 27/01/21 7:28 pm, Johan Hovold wrote:
> > On Wed, Jan 27, 2021 at 12:03:52AM +0530, Anant Thazhemadam wrote:
> >> The newer usb_control_msg_{send|recv}() API are an improvement on the
> >> existing usb_control_msg() as it ensures that a short read/write is treated
> > As I mentioned in my comments on v2, a short write has always been
> > treated as an error so you shouldn't imply that it wasn't here (and in
> > the other commit messages).
> 
> The newer API ensures that a short send/recv is an error, as they
> either complete the complete translation, or return an error, and
> remove the need for explicit return value checking that was previously
> expected to detect the short read/write (which wasn't present in a lot
> of places).

But my point is that this claim isn't factually correct; there has never
been a need to check for short *writes* (even if a few drivers have such
redundant checks).

> That's what I was trying to say. But if the commit message isn't
> representative of that, I'll try and modify it.

Just drop the bit about "short writes".

> Does this sound like a better commit message?
> 
> "The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg().

Even this is disputable; in some situations the usb_control_msg() is
still preferred as I hope my comments have shown.

Perhaps they are better described as "convenience wrappers" or similar
as the real gain from using these helpers is to replace a pattern like:

	f(data, ...) {
		buf = malloc(data);
		usb_control_msg(..., buf, ...);
		memcpy(data, buf, ...);
		kfree(buf);
	}

for when data is on the stack *and* you do not expect variable-length IN
transfers.

But as soon as a driver is able to reuse a single buffer for multiple
transfers or the data buffer is already DMA-able, usb_control_msg() may
still be a better choice.

> The new API ensures either the full translation is completed,
> or an error is returned. This ensures that all short send/recv are detected as

recv only

> errors even if there is no explicit return value checking performed.
> 
> The new API also allows us to use data off the stack, and don't require raw usb
> pipes to be created in the calling functions."

Johan
