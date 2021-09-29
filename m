Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C171841BFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhI2HOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244486AbhI2HOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:14:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF3936137E;
        Wed, 29 Sep 2021 07:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632899583;
        bh=VI48gGecE8JRkm15ynMz5sFO5LaSB24AzwL9LS1SRIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYy210J4wAdrB2yLJvtCtKejQjQ80diGsETt1cajhixscF5ZqTcXuoShT7USrNfG/
         r1bbBZHJEr3IHLTZBBUHPPRMtqG1AlWqenynvulBGjqbyZ9+3+cIfFZjEiv1MbpuEv
         sfxXH+AASE4cyUtysbT75sWfZRFt15Ik5Ca0jtYo=
Date:   Wed, 29 Sep 2021 09:13:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: get_abi.pl: make undefined search more
 deterministic
Message-ID: <YVQR/WzopuDTTwDq@kroah.com>
References: <YVNOZ3GKcpRxPXzv@kroah.com>
 <5dc55fd42e632a24a48f95212aa6c6bc4b2d11fd.1632865873.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc55fd42e632a24a48f95212aa6c6bc4b2d11fd.1632865873.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:51:32PM +0200, Mauro Carvalho Chehab wrote:
> Sort keys on hashes during undefined search, in order to
> make the script more deterministic.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/get_abi.pl | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
> index 841d889747c0..d32dcd7cca5d 100755
> --- a/scripts/get_abi.pl
> +++ b/scripts/get_abi.pl
> @@ -775,6 +775,8 @@ sub check_undefined_symbols {
>  	my $next_i = 0;
>  	my $start_time = times;
>  
> +	@files = sort @files;
> +
>  	my $last_time = $start_time;
>  
>  	# When either debug or hint is enabled, there's no sense showing
> @@ -909,16 +911,16 @@ sub undefined_symbols {
>  		}
>  	}
>  	# Compile regexes
> -	foreach my $l (keys %leaf) {
> +	foreach my $l (sort keys %leaf) {
>  		my @expr;
> -		foreach my $w(split /\xac/, $leaf{$l}->{what}) {
> +		foreach my $w(sort split /\xac/, $leaf{$l}->{what}) {
>  			push @expr, qr /^$w$/;
>  		}
>  		$leaf{$l}->{expr} = \@expr;
>  	}
>  
>  	# Take links into account
> -	foreach my $link (keys %aliases) {
> +	foreach my $link (sort keys %aliases) {
>  		my $abs_file = $aliases{$link};
>  		graph_add_link($abs_file, $link);
>  	}
> -- 
> 2.31.1
> 

Much better, now we are at a reproducable 10 seconds on my large box.
Thanks for all the work on this, now to go and start adding the missing
documentation :)

greg k-h
