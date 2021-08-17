Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4173EE3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhHQBgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:36:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53146 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233278AbhHQBgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:36:41 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mFo1M-0005G6-LG; Tue, 17 Aug 2021 09:36:04 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mFo1J-0003gc-UL; Tue, 17 Aug 2021 09:36:01 +0800
Date:   Tue, 17 Aug 2021 09:36:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.14
Message-ID: <20210817013601.GA14148@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708030913.GA32097@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This push contains a fix for a potential boot failure due to
a missing Kconfig dependency for people upgrading with the DRBG
enabled.

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to 5261cdf457ce3635bf18d393a3c1991dcfaf9d02:

  crypto: drbg - select SHA512 (2021-07-16 15:49:31 +0800)

----------------------------------------------------------------
Stephan Mueller (1):
      crypto: drbg - select SHA512

 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
