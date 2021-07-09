Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66D3C1F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 09:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGIGvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 02:51:33 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51208 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhGIGvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 02:51:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1m1kJc-0008TB-GX; Fri, 09 Jul 2021 14:48:48 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1m1kJa-0001ZD-Jk; Fri, 09 Jul 2021 14:48:46 +0800
Date:   Fri, 9 Jul 2021 14:48:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <james.morris@microsoft.com>
Subject: Re: how to request crypto_alloc_shash for GMAC
Message-ID: <20210709064846.GB5907@gondor.apana.org.au>
References: <CAH2r5muOdHbLDQr_p15U0572qF+6MjPK+32JYAf4LUKPuvkLGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muOdHbLDQr_p15U0572qF+6MjPK+32JYAf4LUKPuvkLGA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 12:48:00AM -0500, Steve French wrote:
>
> Presumably due to https://www.ietf.org/rfc/rfc4543.txt it is already
> supported in the kernel ... but what is the name that it is exposed as
> in the kernel crypto libraries?

We don't have standalone gmac in the kernel, it only exists as
part of the AEAD algorithm gcm.  You're more than welcome to add
it of course.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
