Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DA73A3788
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFJXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhFJXCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE0B6613E1;
        Thu, 10 Jun 2021 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623366048;
        bh=0JBPBRnwjMclTlgWuSDhjEf5Q89skZtWG7GkA9KzUOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHhjoSA6nP+kIztHgQ3HQ3dqO2ILsNgGtSmfMfWa8LqBII1Yyi6bpJCk2j/3vW+oM
         gtby8hX3ZLdoMas+nsTkjijhVAE1bhSbmSw+9Uvg9FP6kYpdDUWVZiSUHtNIXXZGEy
         at+JNLk6zJ0xOkDXOMvPsxr/RLktx/x39B9hwQqa62eeLuYU3FVziva7ES2r7c1NWB
         Re6/RlgYNkeKM+2QOQ8T+AYYtNd1gVLVrBzxsBhW+13bQcJ/baJt4KjAnVRUFugpUR
         D5zbzxtT6kP3AclSnancb03DrLOpdRbG5YTdu1DohP9xxbHZ50ybS0wu4ulEJGXGFx
         65GO2Yu23EW6Q==
Date:   Thu, 10 Jun 2021 16:00:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: remove CRYPTOA_U32 and related functions
Message-ID: <YMKZnrwYQVF7ttYw@gmail.com>
References: <20210605053902.2017295-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605053902.2017295-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 01:39:02PM +0800, Liu Shixin wrote:
> According to the advice of Eric and Herbert, type CRYPTOA_U32
> has been unused for over a decade, so remove the code related to
> CRYPTOA_U32.
> 
> After removing CRYPTOA_U32, the type of the variable attrs can be
> changed from union to struct.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  crypto/algapi.c         | 18 ------------------
>  crypto/algboss.c        | 32 +++++++-------------------------
>  include/crypto/algapi.h |  1 -
>  include/linux/crypto.h  |  5 -----
>  4 files changed, 7 insertions(+), 49 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

One nit below:

> +		param->attrs[i].attr.rta_len =
> +			sizeof(param->attrs[i]);

These two lines can be joined into one.

- Eric
