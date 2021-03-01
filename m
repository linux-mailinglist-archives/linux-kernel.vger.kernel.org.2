Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208B23277AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhCAGhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:37:24 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:44070 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhCAGhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:37:15 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lGcA8-0007L9-FF; Mon, 01 Mar 2021 17:36:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 01 Mar 2021 17:36:12 +1100
Date:   Mon, 1 Mar 2021 17:36:12 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] crypto: sa2ul - Hide pointer and fix
 -Wpointer-to-int-cast in dev_dbg()
Message-ID: <20210301063612.GA28172@gondor.apana.org.au>
References: <20200826162954.28636-1-krzk@kernel.org>
 <20200904082804.GB1214@gondor.apana.org.au>
 <CAJKOXPfktQY_T0UpsZaGv-gUpyWmfrWVbB1yENEBtcJkZv2WKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPfktQY_T0UpsZaGv-gUpyWmfrWVbB1yENEBtcJkZv2WKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 05:37:49PM +0100, Krzysztof Kozlowski wrote:
>
> I think this patch was lost, although you replied that the entire set
> is applied.
> 
> Can you pick it up?

I think it was not applicable because the following had already
been applied:

commit ea066b7a3ddf1e4e5ae749495f0adf12766188b4
Author: YueHaibing <yuehaibing@huawei.com>
Date:   Tue Aug 18 22:00:01 2020 +0800

    crypto: sa2ul - Fix pointer-to-int-cast warning

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
