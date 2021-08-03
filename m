Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA753DEA70
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhHCKHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235044AbhHCKGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC5F26103C;
        Tue,  3 Aug 2021 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627985128;
        bh=skncWkvtsrJjdl36847z0ai19FasvHg2VWg+5iNZ0as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DScewpl9OLU+H7kKvdjQaLKiJ9u2xPo61CNhuGvdq8Jme4WK8eV9YL5Ahhxog7+te
         DxgQwqiXInYkFxmitNTfJhGrn64cdy7Ni4DXUJm9qrm8IFiq4q+MRTJjn8mO8TigVG
         GFJ8k3NFim1Lg2kpcfsGp3E2jLVr7XXpZRimTzBZPbTM9JmghNRf99jQXbGwkOY1aC
         BndrfjwL9Wjr0cQ1gfbZQMKzjqPOpWjQYBAKEKvRmWFzypvRR24xSgNpj7AOAo4aaD
         YiQcDncA6RJzMFnoV/gBGyvYCjYaIJhuh2yQQolR8KJF9x5EDKishNli14enQAws+C
         WUDbp8Pwk07eQ==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        moderated for non-subscribers 
        <linux-arm-kernel@lists.infradead.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: move warning about toolchains to archprepare
Date:   Tue,  3 Aug 2021 11:05:19 +0100
Message-Id: <162798335878.1497520.5664687589447099118.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210801053525.105235-1-masahiroy@kernel.org>
References: <20210801053525.105235-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2021 14:35:25 +0900, Masahiro Yamada wrote:
> Commit 987fdfec2410 ("arm64: move --fix-cortex-a53-843419 linker test to
> Kconfig") fixed the false-positive warning in the installation step.
> 
> Yet, there are some cases where this false-positive is shown. For example,
> you can see it when you cross 987fdfec2410 during git-bisect.
> 
>   $ git checkout 987fdfec2410^
>     [ snip ]
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig all
>     [ snip ]
>   $ git checkout v5.13
>     [ snip]
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig all
>     [ snip ]
>   arch/arm64/Makefile:25: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: move warning about toolchains to archprepare
      https://git.kernel.org/arm64/c/64ee84c75b5f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
