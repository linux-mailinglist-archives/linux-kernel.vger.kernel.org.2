Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544B6347E23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhCXQrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236580AbhCXQqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:46:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF00461A06;
        Wed, 24 Mar 2021 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616604397;
        bh=TJLFQhZC1jWNLtoUFrsnvOFF9CPnFj5MhXj3QGGfWbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tAusyE0oX598MDBWGwhjFz6BcqpxV6JGn/vcKpGwhQ23eCnDdavKKK1Y0fMbT6QCg
         7GxRdL4adPvyiPtYugdxxzOjn/UZFeV5Ke/UravJ72HKyx+fRUQsL5MFDw6ZRt7v7/
         hr5IKVXyLprWjsRMrKMfO3Bj1Qhg75nVp/1Dyo4n60XxEpsQQOS2lbUkZMPex6meFZ
         gwMjkkWp37emMTq0EeSIgBdX5RdUjzuejLmOL2M4fBb1s/yt2FlyLZ+MRhDhdwAGeM
         KfzA85z11j0pt8mkuLlEuBlXMD46oMoFXv/Es/1qh0jN2glKavYWHtr+mSm4cZJnLE
         QcTnky6aXuv/g==
Date:   Wed, 24 Mar 2021 16:46:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: move --fix-cortex-a53-843419 linker test to
 Kconfig
Message-ID: <20210324164631.GA13030@willie-the-truck>
References: <20210324071128.1723273-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324071128.1723273-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 04:11:28PM +0900, Masahiro Yamada wrote:
> $(call ld-option, --fix-cortex-a53-843419) in arch/arm64/Makefile is
> evaluated every time even for Make targets that do not need the linker,
> such as "make ARCH=arm64 install".
> 
> Recently, the Kbuild tree queued up a patch to avoid needless
> compiler/linker flag evaluation. I beleive it is a good improvement
> itself, but causing a false-positive warning for arm64 installation
> in linux-next. (Thanks to Nathan for the report)
> 
> Kconfig can test the linker capability just once, and store it in the
> .config file. The build and installation steps that follow do not need
> to test the liniker over again.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> I was not sure what the preferred CONFIG option name is.
> Please suggest a one if you have a better idea.
> 
> 
>  arch/arm64/Kconfig  | 3 +++
>  arch/arm64/Makefile | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
