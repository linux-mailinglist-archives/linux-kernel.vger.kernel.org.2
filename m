Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2942AD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhJLTvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhJLTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:51:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CDFC061570;
        Tue, 12 Oct 2021 12:49:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CB9D72D3;
        Tue, 12 Oct 2021 19:49:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CB9D72D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634068174; bh=J+VU/Z23eHXA/EXm5a9vouyZ4Lxsf+8UqKzwH+KayRs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tfgrx9pFnAIoXBvayFLyFIS+/tKl/s1NQ8jmQjVM4bXSUcnk+dDsRnMxVhH//Tjaz
         1cKBCYPFxHBhaEgjFovqMVpHaKXleyOqv77+5Ou5WxDmaA2F/5WpoZUgUYDD3RoBMg
         ArrQUh/7D5OLcUrBVAyGAbK7r0knf4UTs+G2+9y5JybLYTWWb41Ly2fhHWN+B30E5K
         lDH9eSOxjghTIQZwYKzUs57yXPNxq8h8iPxiHBZZfdAoQhZdamEf49nYX8C22xNaKU
         6pKWiUr1LztKBPg/11/9HGtN+l/PGeFdZlkRctYPgvYB1rIKLc5iHinazbk5kM0MTW
         sRpbylLod2C+A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arjan@linux.intel.com
Subject: Re: [PATCH] docs: update file link location
In-Reply-To: <20211003220706.7784-1-tomm.merciai@gmail.com>
References: <20211003220706.7784-1-tomm.merciai@gmail.com>
Date:   Tue, 12 Oct 2021 13:49:34 -0600
Message-ID: <87ee8quipd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tommaso Merciai <tomm.merciai@gmail.com> writes:

[CC += Arjan just in case]

> Fix web error: this site can't be reached
>
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  Documentation/process/submitting-drivers.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/submitting-drivers.rst b/Documentation/process/submitting-drivers.rst
> index 3861887e0ca5..8413b693d10d 100644
> --- a/Documentation/process/submitting-drivers.rst
> +++ b/Documentation/process/submitting-drivers.rst
> @@ -185,7 +185,7 @@ Linux USB project:
>  	http://www.linux-usb.org/
>  
>  How to NOT write kernel driver by Arjan van de Ven:
> -	http://www.fenrus.org/how-to-not-write-a-device-driver-paper.pdf
> +	https://landley.net/kdocs/ols/2002/ols2002-pages-545-555.pdf

This is an OK change, I guess...a working link is better than a broken
one.  That said, I do have to wonder whether this link needs to be
preserved at all.  That paper was good advice 19 years ago, but I'm not
sure it has much to tell people in 2021; the days of having to tell
developers to think about SMP systems are past.

I'll apply this for now, though.

Thanks,

jon
