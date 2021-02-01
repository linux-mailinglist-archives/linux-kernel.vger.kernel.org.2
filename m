Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC230A45C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhBAJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231748AbhBAJ1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:27:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35AA464EA3;
        Mon,  1 Feb 2021 09:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612171630;
        bh=GDOdGwLBUdhE8w9rNn6b3HIerVpuSs4Cl3TDcqidl3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkZqEMSlVqaFJjuTPNL7XJDwlW9k4XUpiTXryVXW9sYWskM9a7RyLQsOo3/8xTKI6
         4RZJQ5O+8Agj58X2tTpQP/ymjqDBWESOwjp+8LuIO6YY8iqzQU32RpxrTaDF87zqf3
         ihIVB2zGpwYksRW4g/Z9P8RQ3iR9WWIKUWGEwJSXWfg7Vx01fws/f3AYDcbUV6s78M
         5lmkrcdArUpy8Ll9gzG4oaqpFJlqACnu+uje7PZwHRJxyW7v4oIr58o6BFEZLPbvBM
         DNoIgzgqBQh2b7/ZpZ2PckFGNGAtBLYScG/yzpmlWNLWyrMtP7reH/osD8sqdZkR0+
         c7ZKKz8FygUqA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l6VUP-00059u-8v; Mon, 01 Feb 2021 10:27:22 +0100
Date:   Mon, 1 Feb 2021 10:27:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>
Subject: Re: [PATCH] init: clean up early_param_on_off() macro
Message-ID: <YBfJeQC1jUeD2fdp@hovoldconsulting.com>
References: <20210201041532.4025025-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201041532.4025025-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 01:15:32PM +0900, Masahiro Yamada wrote:
> Use early_param() to define early_param_on_off().
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  include/linux/init.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index e668832ef66a..ae2c2aace0d0 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -277,14 +277,14 @@ struct obs_kernel_param {
>  		var = 1;						\
>  		return 0;						\
>  	}								\
> -	__setup_param(str_on, parse_##var##_on, parse_##var##_on, 1);	\
> +	early_param(str_on, parse_##var##_on);				\
>  									\
>  	static int __init parse_##var##_off(char *arg)			\
>  	{								\
>  		var = 0;						\
>  		return 0;						\
>  	}								\
> -	__setup_param(str_off, parse_##var##_off, parse_##var##_off, 1)
> +	early_param(str_off, parse_##var##_off)
>  
>  /* Relies on boot_command_line being set */
>  void __init parse_early_param(void);

Looks good:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
