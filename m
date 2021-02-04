Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E63C30BB42
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhBBJo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:44:29 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:44810 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhBBJnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:43:07 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l6sCB-0006Z7-K4; Tue, 02 Feb 2021 20:42:04 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Feb 2021 20:42:03 +1100
Date:   Tue, 2 Feb 2021 20:42:03 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
Cc:     "Khurana, Prabhjot" <prabhjot.khurana@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "yumeng18@huawei.com" <yumeng18@huawei.com>
Subject: Re: [PATCH v7 4/7] crypto: add ecc curve and expose them
Message-ID: <20210202094203.GA28856@gondor.apana.org.au>
References: <1611299395-675-1-git-send-email-yumeng18@huawei.com>
 <1611299395-675-5-git-send-email-yumeng18@huawei.com>
 <20210128050354.GA30874@gondor.apana.org.au>
 <CAMj1kXHvY9JveFyhtETALCH=AFGMGVbGGFMNDGc6ZVngEKbyDQ@mail.gmail.com>
 <20210128103908.GA32495@gondor.apana.org.au>
 <c3c3d47edbfd61c338deea5a10a4fb39e2ace68a.camel@linux.intel.com>
 <20210202051346.GB27641@gondor.apana.org.au>
 <f239c77dd510c860254189b65fa297d039041490.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f239c77dd510c860254189b65fa297d039041490.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 09:27:33AM +0000, Alessandrelli, Daniele wrote:
>
> I see. Just to clarify: does the in-kernel user requirement also apply
> to the case when the author of a device driver also provides the
> software implementation for the new algorithms supported by device
> driver / HW?

Yes we need an actual user.  For example, if your algorithm is used
by the Security Subsystem (IMA) that would be sufficient.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
