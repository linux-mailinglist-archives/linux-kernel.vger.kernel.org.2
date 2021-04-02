Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736A535284A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhDBJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:11:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59552 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234651AbhDBJLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:11:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSFpg-0002j2-Bi; Fri, 02 Apr 2021 20:11:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 20:11:12 +1100
Date:   Fri, 2 Apr 2021 20:11:12 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, luto@kernel.org, jannh@google.com,
        ardb@kernel.org
Subject: Re: [PATCH RESEND] random: remove dead code left over from blocking
 pool
Message-ID: <20210402091112.GA24604@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322051400.266903-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Remove some dead code that was left over following commit 90ea1c6436d2
> ("random: remove the blocking pool").
> 
> Cc: linux-crypto@vger.kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> drivers/char/random.c         | 17 ++-----
> include/trace/events/random.h | 83 -----------------------------------
> 2 files changed, 3 insertions(+), 97 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
