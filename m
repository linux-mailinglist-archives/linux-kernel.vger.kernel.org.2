Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B2438858
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJXKmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 06:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJXKmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 06:42:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F96C60EBB;
        Sun, 24 Oct 2021 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635071987;
        bh=nM4NcQ2/PXqy3PYO8xrxGrwh807/icH9Jiv7TUp67N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fb+T6h99X5RdvBp9eX9RM6YatKBFBO8W0ietSyYce1tdVNbzpf/mByARDEWYoHGUp
         U7GRpTpIAj1piJeYoCZo7VVeLaQOMZwZLFfEoaZe9blu5dIXZxlgaTvjBCg2HMP/X3
         Gs3gi/TWtv6F0E7Aaa9iwWRA40dS7pfHApIr1eTem3Fk1SfXk1OYjIS2BHkqSDeh3H
         0l1bUsE/B/A+pFK6gmRnu02EOz/OM2ZbfwevVcieFH8I5EJz5+FNawfE1KDn5LMj8U
         QTLWR6k+AofarrmpCNfV7Ju29tK56wJ1G4IKeXYhF3q6yVdemMY01AYbtIdQY0lWig
         XlGYAAOLcjtIQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1meauX-0005ll-Td; Sun, 24 Oct 2021 12:39:29 +0200
Date:   Sun, 24 Oct 2021 12:39:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jim Christian Haukvik <jchaukvik@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/params.c: Refactor dash2underscore
Message-ID: <YXU34dVDXKCXSkZm@hovoldconsulting.com>
References: <20211023180451.59033-1-jchaukvik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023180451.59033-1-jchaukvik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 08:04:51PM +0200, Jim Christian Haukvik wrote:
> This patch refactors the dash2underscore function
> to use the ternary operator.
> 
> Signed-off-by: Jim Christian Haukvik <jchaukvik@gmail.com>
> ---
>  kernel/params.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 8299bd764e42..865a76fec79a 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -76,9 +76,7 @@ static void maybe_kfree_parameter(void *param)
>  
>  static char dash2underscore(char c)
>  {
> -	if (c == '-')
> -		return '_';
> -	return c;
> +	return (c == '-') ? '_' : c;
>  }

This is not an improvement. You're just making the code harder to read
for no good reason (the ternary operator tends to do so).

Johan
