Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2673E4165
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhHIIK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:10:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233588AbhHIIK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:10:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FD8B6105A;
        Mon,  9 Aug 2021 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628496639;
        bh=/d6xkvPLH1Toz4dcO58TgPpbVKD4jmYI6JghBDyGdyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g63MYKvq73ZCk5irzCvPl5WwQscHjyzoNXRo+mt1yM/U+PV2VtnphyZmIbFstxNmC
         cykfwZcRkzD1He3OEmxzrpozsN+LOl5b2DAVw5TerUC5ekOyg3gjhzAMqiWpds6R+b
         qzPBRtuBTZDA+dO1v4fcjDTs+lKQO2/y4hijGrWQi4EJnk5ZD9/XAvEhT0HNo5fyMQ
         I6f0+f1+C2c9N57OH6xnvkk+rZYfDxs9DtYbDcTVNRcDqHhXrWuKgmJoqxXj8/m0zQ
         dDqqF2SBaKK51wMZWFnkESrtqYX4yDnDHSOPBJB6hIEqVjRvA3XIsEqDc9Guj8Q0d6
         09g1CwjwaTODQ==
Date:   Mon, 9 Aug 2021 16:10:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] get_maintainer: add email addresses from dts files
Message-ID: <20210809081033.GQ30984@dragon>
References: <20210809080204.8381-1-shawnguo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809080204.8381-1-shawnguo@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, Aug 09, 2021 at 04:02:04PM +0800, Shawn Guo wrote:
> MAINTAINER file will get bloated quickly if individual section entry
> is created for each .dts/.dtsi file.  Add the email address from dts
> files to get_maintainer output for saving unnecessary patching on
> MAINTAINER file.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

My understanding is that you will be the one picking this up.
Otherwise, please let me know whom I should send this to.  Thanks!

Shawn

> ---
>  scripts/get_maintainer.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 2075db0c08b8..15aa8f947f4b 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -436,7 +436,7 @@ sub maintainers_in_file {
>  
>      return if ($file =~ m@\bMAINTAINERS$@);
>  
> -    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
> +    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
>  	open(my $f, '<', $file)
>  	    or die "$P: Can't open $file: $!\n";
>  	my $text = do { local($/) ; <$f> };
> -- 
> 2.17.1
> 
