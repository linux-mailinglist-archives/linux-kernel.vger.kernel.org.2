Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69D436B016
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhDZI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhDZI7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:59:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 176FB60FEE;
        Mon, 26 Apr 2021 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619427521;
        bh=dGqN4lwNdcHBEwE1VHJZImPQnsWd/13B9Bs/6EaeKQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeuRlvapCCWYmIvRgL62e0f7V6q3+ahoVw0at875tvVt9XGXgWVG7Q4x/o0SJgHeU
         kU8h2qe8YTwgr7Zq8Gprli+Wgb5rIZ0hkfj9Ea9MKkFRUs7LMUWrOn4HspkCDPFMc3
         KFLLju55uGTC3d6OsNPWJc4CdwxOT4m6d0HQ0YDyLHVGMRplHmDMpFlDvlSKp57P/y
         lkchv2v+wOfnbQeLWYeEHcR6NIc1m5sfAy1UE7HrSDQ+8+R4cj1Ty7MLvSMd9fxbLt
         bac6AqeozVm3YQfZwdCUDbaDtNOhB1jR2OhEQachuSPZyibpFYVcfn1nHHMrrsfEbr
         VmanR2Tw/7W9A==
Date:   Mon, 26 Apr 2021 09:58:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [PATCH 3/4] crypto: arm64: generate *.S by Perl at build time
 instead of shipping them
Message-ID: <20210426085836.GA5802@willie-the-truck>
References: <20210425175734.1310191-1-masahiroy@kernel.org>
 <20210425175734.1310191-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425175734.1310191-3-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Ard]

On Mon, Apr 26, 2021 at 02:57:33AM +0900, Masahiro Yamada wrote:
> Generate *.S by Perl like arch/{mips,x86}/crypto/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/arm64/crypto/Makefile                |    9 +-
>  arch/arm64/crypto/poly1305-core.S_shipped |  835 ---------
>  arch/arm64/crypto/sha256-core.S_shipped   | 2069 ---------------------
>  arch/arm64/crypto/sha512-core.S_shipped   | 1093 -----------
>  4 files changed, 3 insertions(+), 4003 deletions(-)
>  delete mode 100644 arch/arm64/crypto/poly1305-core.S_shipped
>  delete mode 100644 arch/arm64/crypto/sha256-core.S_shipped
>  delete mode 100644 arch/arm64/crypto/sha512-core.S_shipped

What's the advantage of removing the _shipped files? We included them
originally so that we didn't require perl for the kernel build -- is that no
longer an issue?

I guess I'm just missing the justification for the change.

Cheers,

Will
