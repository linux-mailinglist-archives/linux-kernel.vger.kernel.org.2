Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8E4197FC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhI0Pdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:33:47 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:24449 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhI0Pdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:33:42 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4HJ65M3ccLz4p;
        Mon, 27 Sep 2021 17:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1632756600; bh=NjIDyBuZsrAIXiftVniqch5Zog92VtwzLgbabmREaKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=is/5qg9cRXgH8YZYgR5MpffEmFztXijj1YK8Jf52q9bBlq+cCyuW8KXcj0mZZt5CX
         0Ckfh1jaKaXYbFa9uxCyxOGcD188kfEj6mCsXAEgGicxGtKIrclYiqrZzunRiTQsG6
         ZDr4aTLrLWFwV9amsYps6pxTb0HNtuOIbLZ8v/vgEicQ2EdvykwdWepVbSosL7G4xD
         LD0Uei7MEHo93ewUKJzVUzjrKRDhJbl6Ltnll5dR2k2uP5aLGN3qyXPVVn95n5oHDd
         erevnpjePPWhW8JBlCYa6OCU6EXwXwUipRYmMx6AxOY2Ateu5/BJ+qbTkatOwz2S9T
         VlhPF8nVmRbPw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Mon, 27 Sep 2021 17:31:56 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] cb710: avoid NULL pointer subtraction
Message-ID: <YVHj7AMD8KJ76xM5@qmqm.qmqm.pl>
References: <20210927121408.939246-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927121408.939246-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 02:13:57PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-14 complains about an unusual way of converting a pointer to
> an integer:
> 
> drivers/misc/cb710/sgbuf2.c:50:15: error: performing pointer subtraction with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtraction]
>         return ((ptr - NULL) & 3) != 0;
> 
> Replace this with a normal cast to uintptr_t.
> 
> Fixes: 5f5bac8272be ("mmc: Driver for CB710/720 memory card reader (MMC part)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/cb710/sgbuf2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cb710/sgbuf2.c b/drivers/misc/cb710/sgbuf2.c
> index e5a4ed3701eb..a798fad5f03c 100644
> --- a/drivers/misc/cb710/sgbuf2.c
> +++ b/drivers/misc/cb710/sgbuf2.c
> @@ -47,7 +47,7 @@ static inline bool needs_unaligned_copy(const void *ptr)
>  #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	return false;
>  #else
> -	return ((ptr - NULL) & 3) != 0;
> +	return ((uintptr_t)ptr & 3) != 0;
>  #endif
>  }
>  

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqmq.pl>
