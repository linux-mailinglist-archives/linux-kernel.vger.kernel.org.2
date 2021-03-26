Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EB234AA18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCZOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhCZOge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:36:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B5A4619F2;
        Fri, 26 Mar 2021 14:36:32 +0000 (UTC)
Date:   Fri, 26 Mar 2021 14:36:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: move --fix-cortex-a53-843419 linker test to
 Kconfig
Message-ID: <20210326143630.GD5126@arm.com>
References: <20210324071128.1723273-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324071128.1723273-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

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

Would you like this patch to go in via the arm64 tree or you will queue
it via the kbuild tree?

Thanks.

-- 
Catalin
