Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92870457B35
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhKTEd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:33:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:56914 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236997AbhKTEd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:33:56 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1moI1c-0001KW-Kr; Sat, 20 Nov 2021 12:30:52 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1moI1c-0006n1-Ha; Sat, 20 Nov 2021 12:30:52 +0800
Date:   Sat, 20 Nov 2021 12:30:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lei He <helei.sig11@bytedance.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: Re: [PATCH] crypto: testmgr - Fix wrong test case of RSA
Message-ID: <20211120043052.GK25752@gondor.apana.org.au>
References: <20211105122531.73891-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105122531.73891-1-helei.sig11@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 08:25:31PM +0800, Lei He wrote:
> According to the BER encoding rules, integer value should be encoded
> as two's complement, and if the highest bit of a positive integer
> is 1, should add a leading zero-octet.
> 
> The kernel's built-in RSA algorithm cannot recognize negative numbers
> when parsing keys, so it can pass this test case.
> 
> Export the key to file and run the following command to verify the
> fix result:
> 
>   openssl asn1parse -inform DER -in /path/to/key/file
> 
> Signed-off-by: Lei He <helei.sig11@bytedance.com>
> ---
>  crypto/testmgr.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
