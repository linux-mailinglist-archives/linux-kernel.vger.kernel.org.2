Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5584F30EC10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 06:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBDFce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 00:32:34 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51568 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhBDFcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:32:32 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7XEj-0001uB-En; Thu, 04 Feb 2021 16:31:26 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Feb 2021 16:31:25 +1100
Date:   Thu, 4 Feb 2021 16:31:25 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     "Khurana, Prabhjot" <prabhjot.khurana@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "yumeng18@huawei.com" <yumeng18@huawei.com>
Subject: Re: [PATCH v7 4/7] crypto: add ecc curve and expose them
Message-ID: <20210204053125.GA7229@gondor.apana.org.au>
References: <1611299395-675-1-git-send-email-yumeng18@huawei.com>
 <1611299395-675-5-git-send-email-yumeng18@huawei.com>
 <20210128050354.GA30874@gondor.apana.org.au>
 <CAMj1kXHvY9JveFyhtETALCH=AFGMGVbGGFMNDGc6ZVngEKbyDQ@mail.gmail.com>
 <20210128103908.GA32495@gondor.apana.org.au>
 <c3c3d47edbfd61c338deea5a10a4fb39e2ace68a.camel@linux.intel.com>
 <20210202051346.GB27641@gondor.apana.org.au>
 <f239c77dd510c860254189b65fa297d039041490.camel@intel.com>
 <20210202094203.GA28856@gondor.apana.org.au>
 <172b57990e5c0cf9c9c3b638df37fe03efdc7ddb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172b57990e5c0cf9c9c3b638df37fe03efdc7ddb.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:35:26PM +0000, Alessandrelli, Daniele wrote:
>
> Unrelated question: I have my Keem Bay OCS ECC patchset [1] almost
> ready for re-submission. Should I go ahead or should I wait for the
> final decision about using 'ecdh-nist-pXXX' in place of 'ecdh'?

If we agree on going down this route, then the first step is to
convert the existing ecdh generic algorithm and its users to this
scheme to ensure no regressions.

After that then you can add your driver.

PS I just noticed that we already have one driver implementing
ecdh, atmel so it too would need to be converted before we take
on any new drivers for ecdh.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
