Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44B380B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhENOPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:15:12 -0400
Received: from one.firstfloor.org ([193.170.194.197]:52810 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhENOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:15:10 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 6380586BFB; Fri, 14 May 2021 16:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1621001637;
        bh=kVEuB9YOBrzCWwh0pYjc4iCKCAUcFiuB9NNxctx6o3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2sw07cKJvz+uedyfA3vExCJyJKukYUMrTPMlzki1d9b46m9mXHi04XyINRrLZyAo
         MPrlUrdToEFBDUHzXT40ZDytY+1bhBfUBNdKWNNOGLtNEVIrVJflMg94pMzj8Kvjkg
         iWo++C7TDyX68W95QYT6H9f7/4MG2Kco1LVMWr98=
Date:   Fri, 14 May 2021 07:13:57 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] poly1305: Make prototypes match
Message-ID: <20210514141355.3rvfysiluo3udfga@two.firstfloor.org>
References: <20210425211325.3157769-1-ak@linux.intel.com>
 <20210514104813.wvdvviyoyo6pqbhw@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514104813.wvdvviyoyo6pqbhw@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 06:48:13PM +0800, Herbert Xu wrote:
> On Sun, Apr 25, 2021 at 02:13:25PM -0700, Andi Kleen wrote:
> > From: Andi Kleen <andi@firstfloor.org>
> > 
> > gcc 11 complains when arrays in prototypes do not match the function.
> > Fix this here.
> > 
> > Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Andi Kleen <andi@firstfloor.org>
> > ---
> >  include/crypto/internal/poly1305.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Just noticed that this wasn't cc'ed to linux-crypto.  Andi, could
> you please resend with a cc to the list?

I thought it was already fixed by Arnd? I think I collided with him.

-Andi
