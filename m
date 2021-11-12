Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9259B44E4D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhKLKvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:51:17 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:56674 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhKLKvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:51:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mlU6W-00076q-2H; Fri, 12 Nov 2021 18:48:20 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mlU6R-0003fz-LQ; Fri, 12 Nov 2021 18:48:15 +0800
Date:   Fri, 12 Nov 2021 18:48:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.16
Message-ID: <20211112104815.GA14105@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029041408.GA3192@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This push fixes a boot crash regression.

The following changes since commit 39ef08517082a424b5b65c3dbaa6c0fa9d3303b9:

  crypto: testmgr - fix wrong key length for pkcs1pad (2021-10-29 21:04:04 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to beaaaa37c664e9afdf2913aee19185d8e3793b50:

  crypto: api - Fix boot-up crash when crypto manager is disabled (2021-11-09 13:45:48 +0800)

----------------------------------------------------------------
Herbert Xu (1):
      crypto: api - Fix boot-up crash when crypto manager is disabled

 crypto/algapi.c | 2 ++
 1 file changed, 2 insertions(+)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
