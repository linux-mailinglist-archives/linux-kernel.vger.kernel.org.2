Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A4428BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhJKLSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236149AbhJKLSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:18:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4C2E60EFE;
        Mon, 11 Oct 2021 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633950976;
        bh=BGseFkSI3o7YUdTGuh0dvYWUKKGv2pjwiqfBn9C/EAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kf4vkv0KqFJ0tXgmZ9OSTje8U5pQFFj2XUIQ8qxL/tixJD59y0AOp77Vxv2ajo5Ku
         5eVHHRgbpsNUJSDBHHraZc9IXy4Yu9grlnL6fpM+hiG22t8Pr5gWOL1JMRV9DrQUEc
         bTWIRDHo2ruozRq2GEgXI9lOKamROMPORFvcbczz0IAHX+xaH+zfqF6LNEh2TYj/nx
         oTqkvf4mUhDBKXgFjsvgV3eS5bJqDQ/BIqhLsath/GTBUw2n1QzaXcX/ufgUcAoIpX
         EEOuVhxZUlKCD8K7xNaAGJCzqNWMtPYkgm3EBM9cUQ+MGrqeLeAXNAsi6+IS3DgAjm
         K1LdUQeWGlaOQ==
Date:   Mon, 11 Oct 2021 12:16:11 +0100
From:   Will Deacon <will@kernel.org>
To:     trix@redhat.com
Cc:     peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] locking/ww_mutex: set ret variable on failure
Message-ID: <20211011111610.GD4068@willie-the-truck>
References: <20210927145756.209435-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927145756.209435-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:57:56AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Building with clang 13 produces this error
> test-ww_mutex.c:138:7: error: variable 'ret' is used
>   uninitialized whenever 'if' condition is true
>   [-Werror,-Wsometimes-uninitialized]
>                 if (!ww_mutex_trylock(&mutex, &ctx)) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> On this failure set ret to -EINVAL as is similarly done
> in the function.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  kernel/locking/test-ww_mutex.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Will Deacon <will@kernel.org>

Will
