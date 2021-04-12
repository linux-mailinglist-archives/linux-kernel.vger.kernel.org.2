Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE95A35C349
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbhDLKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244866AbhDLKBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1BC0611AD;
        Mon, 12 Apr 2021 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618221643;
        bh=oEF9mbnEEuaF1uVd7dfYALcUg0tUYr9MY7WTmXTncQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcvZauxF0ZP353i48NdHx0ILLHsMjn1VJwBLaFNTc58okTQurhNa/tvYLAzqV1HUn
         himXZ/LYjimxCbBaEHYvuXad5TSrRYnrb7SF0amZcxOSBI46bR21whPHkyFPOIFFQp
         mUrJyiYmKqG46t/L7pwQZF+cLfARH7ElKBcMrfkI0ClVQ4x84noVgKl08dFSBtmabn
         282w2FMbc1as+Q0gCPYRqkyiQf8/XFNvbVNKZ+ni+b8gYyVtvm8CVCn1AWHlwuVVoZ
         hLZWOzyDANpt9NbwmRQvk9MUNXkTW1AerCWCiNlf4cjmTsKYo4v8eS6ugu3iBRMljc
         OnsOGlc3NrULA==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVtMz-0001NY-3n; Mon, 12 Apr 2021 12:00:37 +0200
Date:   Mon, 12 Apr 2021 12:00:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pho Tran <photranvan0712@gmail.com>, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] USB: serial: cp210x: provide gpio valid mask
Message-ID: <YHQaRb7bOYc+H8Fh@hovoldconsulting.com>
References: <20210409155216.31867-1-johan@kernel.org>
 <CAHp75Vds=yXk3yYMh1yyDb0o_YyVTh3-6iKh8rYKwYHORebdkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vds=yXk3yYMh1yyDb0o_YyVTh3-6iKh8rYKwYHORebdkQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:23:11PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 9, 2021 at 6:52 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > Use the new GPIO valid-mask feature to inform gpiolib which pins are
> > available for use instead of handling that in a request callback.
> >
> > This also allows user space to figure out which pins are available
> > through the chardev interface without having to request each pin in
> > turn.
> 
> Thanks! I like the series.
> Independently on reaction on my comments:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for reviewing. Now applied.

Johan
