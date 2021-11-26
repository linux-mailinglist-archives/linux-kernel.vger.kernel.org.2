Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E753445F132
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354543AbhKZQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:03:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54764 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354283AbhKZQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:01:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5335F622C5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45238C9305D;
        Fri, 26 Nov 2021 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637942282;
        bh=gZuFeWhX8aYEFfgCgLdFOTAhyoodpTyiMfQWqdN3cQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRJy9/Hoet1/gB0LF/fhIt456dLDbwEylz22ivHMV6ddVnjFlMHQN7jsuQOstHPX5
         UJn+lUvppNHJczwVR1yhq+LZiXJDOPcVKBiT38elMa/eDJfBMTnHNQc5XALyLEg7eb
         u6QjT5SRYdqIW3pl/rgFR9fkH2M9ObRo420oZ1Qg=
Date:   Fri, 26 Nov 2021 16:58:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhaoyu Liu <zackary.liu.pro@gmail.com>
Cc:     masahiroy@kernel.org, ripxorip@gmail.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/tags: merge "TAGS" and "tags" in case
Message-ID: <YaEECIyT3LT7JQzQ@kroah.com>
References: <20211103153522.GA23842@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103153522.GA23842@pc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:35:29PM +0800, Zhaoyu Liu wrote:
> merge "TAGS" and "tags" for the code more concise
> 
> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
> ---
>  scripts/tags.sh | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 16d475b3e203..a9181dd0fee2 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -315,15 +315,11 @@ case "$1" in
>  		dogtags
>  		;;
>  
> -	"tags")
> -		rm -f tags
> -		xtags ctags
> -		remove_structs=y
> -		;;
> -
> -	"TAGS")
> -		rm -f TAGS
> -		xtags etags
> +	"TAGS" | "tags")
> +		rm -f $1
> +		xtags $([ $1 = "tags" ]	\
> +			&& echo ctags		\
> +			|| echo etags)
>  		remove_structs=y
>  		;;

Ick, that's much harder to read and understand.

What is wrong with the existing code?  It's obvious and makes sense, it
is not duplicating any lines here except the one "remove_structs=y"
which is fine.

I'm not going to take this, sorry.

greg k-h
