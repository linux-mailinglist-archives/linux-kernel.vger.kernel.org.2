Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0F308402
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhA2DBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:01:30 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55166 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231165AbhA2DB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:01:29 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l5K0y-0000jx-Cv; Fri, 29 Jan 2021 14:00:05 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Jan 2021 14:00:04 +1100
Date:   Fri, 29 Jan 2021 14:00:04 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Meng Yu <yumeng18@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zaibo Xu <xuzaibo@huawei.com>, wangzhou1@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Khurana, Prabhjot" <prabhjot.khurana@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: Re: [PATCH v7 4/7] crypto: add ecc curve and expose them
Message-ID: <20210129030004.GA3463@gondor.apana.org.au>
References: <1611299395-675-1-git-send-email-yumeng18@huawei.com>
 <1611299395-675-5-git-send-email-yumeng18@huawei.com>
 <20210128050354.GA30874@gondor.apana.org.au>
 <CAMj1kXHvY9JveFyhtETALCH=AFGMGVbGGFMNDGc6ZVngEKbyDQ@mail.gmail.com>
 <ff63fffd-2d65-337f-d802-adcf4352fdc3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff63fffd-2d65-337f-d802-adcf4352fdc3@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 09:49:41PM -0500, Stefan Berger wrote:
>
> In my patch series I initially had registered the akciphers under the names
> ecc-nist-p192 and ecc-nist-p256 but now, in V4, joined them together as
> 'ecdsa'. This may be too generic for a name. Maybe it should be called
> ecsda-nist for the NIST family.

What I'm proposing is specifying the curve in the name as well, i.e.,
ecdsa-nist-p192 instead of just ecdsa or ecdsa-nist.

This simplifies the task of handling hardware that only supports a
subset of curves.

There is a parallel discussion of exactly what curves we should
support in the kernel.  Personally if there is a user in the kernel
for it then I'm happy to see it added.  In your specific case, as
long as your use of the algorithm in x509 is accepted then I don't
have any problems with adding support in the Crypto API.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
