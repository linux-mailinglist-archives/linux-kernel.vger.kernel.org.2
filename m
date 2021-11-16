Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B38452EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhKPKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233869AbhKPKOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:14:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E57A26187F;
        Tue, 16 Nov 2021 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637057512;
        bh=PfADZY/p3JqYuaRUK9dg8fuh6I4K/kUrlJWAr+qv9Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzoIyIpbNKLj45yhnUIxQT2nm1rj7G63vFjn/W1rcuCXPXR91ceS3WOOdM2blZVe5
         EeQ2+WUsSad0OOiNb7h43HaxImiPfbDX1soAaTueFchYf4N2dQ6xz5Gp6G8qatxVrY
         KMSPYlMQnwLQ698UZx9Ju9Ggd/3fM7yMHsJHaotWUu931jsyxYIeQTFV9L9Cf1BEL8
         xvOF/tSk2ske5ompc4AqcP7k70MmAreeKGYiY9t2Er6ZbLtZlJgExFINM//M4EcrbM
         l/I1pJy7aXzY8QhIDbN6vhZnmz4NgyqVMSAcGuJlgzKFN2KZ/BWlqBNCgaf0W4BPBw
         9+f+BdqmT+txQ==
Date:   Tue, 16 Nov 2021 10:11:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com,
        james.hsu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mark.rutland@arm.com
Subject: Re: [PATCH] arm64: update compiler option for PAC
Message-ID: <20211116101147.GB9851@willie-the-truck>
References: <20211115031810.29701-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115031810.29701-1-Kuan-Ying.Lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:18:08AM +0800, Kuan-Ying Lee wrote:
> We pass -mbranch-protection=pac-ret+leaf to support PAC
> when we use GCC 9 or later.
> 
> Before GCC 9, we pass -msign-return-address=all to support
> PAC.
> 
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
>  Documentation/arm64/pointer-authentication.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arm64/pointer-authentication.rst b/Documentation/arm64/pointer-authentication.rst
> index f127666ea3a8..055d08b0d42d 100644
> --- a/Documentation/arm64/pointer-authentication.rst
> +++ b/Documentation/arm64/pointer-authentication.rst
> @@ -54,8 +54,10 @@ virtual address size configured by the kernel. For example, with a
>  virtual address size of 48, the PAC is 7 bits wide.
>  
>  Recent versions of GCC can compile code with APIAKey-based return
> -address protection when passed the -msign-return-address option. This
> -uses instructions in the HINT space (unless -march=armv8.3-a or higher
> +address protection when passed compiler option as following.
> +Pass -msign-return-address when we use GCC 7, 8.
> +Pass -mbranch-protection when we use GCC 9 or later.
> +This uses instructions in the HINT space (unless -march=armv8.3-a or higher
>  is also passed), and such code can run on systems without the pointer
>  authentication extension.

I think I'd be more inclined to delete this paragraph altogether. It doesn't
really document anything to do with the kernel, and trying to document the
behaviour of "recent" versions of GCC is futile.

Will
