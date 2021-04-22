Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD7A368104
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhDVNBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVNBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFA0C60551;
        Thu, 22 Apr 2021 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619096469;
        bh=vwM8qjktpmjRExcLhBWGULYZwi2yQlelTHOJbu8uHKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJJTKURRHvpNybNXm8mYkNV9lNU/Ie3yd8NMXDbv2Ylip4ebq59GI4ef67yp4jeUv
         ROEzsi0rtSSSZCX+p6cnNbyuYufTLpL7W8MQgkyuSKoKssHUp1VZzm2PKkh5tNpHmw
         OS+j10Riuz9BhOsObg9w5MmEBmVmdESC+/9vQbV65a4WJ4V2EHkXWjwDVpv71Gxaqw
         h5rFlI2RIuB8UzH553oxViMJVH402b83ELoV4l2hZJ5wcJhduKXtjU9ha856xqbhkU
         zD9/UperjaZ2BmML1YXhVxX414Cbb9e0dtEJWuI4YbM68i/02UMNK9PGmMyh7e0uAO
         Stbli+/wr8Gfw==
Date:   Thu, 22 Apr 2021 14:01:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove HAVE_DEBUG_BUGVERBOSE
Message-ID: <20210422130105.GF1521@willie-the-truck>
References: <20210418215231.563d4b72@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418215231.563d4b72@xhacker>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 09:52:31PM +0800, Jisheng Zhang wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> After commit 9fb7410f955f ("arm64/BUG: Use BRK instruction for generic
> BUG traps"), arm64 has switched to generic BUG implementation, so
> there's no need to select HAVE_DEBUG_BUGVERBOSE.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm64/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
