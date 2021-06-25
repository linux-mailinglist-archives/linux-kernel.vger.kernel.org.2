Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3934A3B3ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 04:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhFYCQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:16:45 -0400
Received: from m.b4.vu ([203.16.231.148]:53408 "EHLO m.b4.vu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232917AbhFYCQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:16:43 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2021 22:16:43 EDT
Received: by m.b4.vu (Postfix, from userid 1000)
        id 4094561E5F02; Fri, 25 Jun 2021 11:37:48 +0930 (ACST)
Date:   Fri, 25 Jun 2021 11:37:48 +0930
From:   "Geoffrey D. Bennett" <g@b4.vu>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ALSA: usb-audio: scarlett2: Fix for loop increment in
 scarlett2_usb_get_config
Message-ID: <20210625020748.GA21766@m.b4.vu>
References: <20210624212048.1356136-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624212048.1356136-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 02:20:48PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> sound/usb/mixer_scarlett_gen2.c:1189:32: warning: expression result
> unused [-Wunused-value]
>                         for (i = 0; i < count; i++, (u16 *)buf++)
>                                                     ^      ~~~~~
> 1 warning generated.
> 
> It appears the intention was to cast the void pointer to a u16 pointer
> so that the data could be iterated through like an array of u16 values.
> However, the cast happens after the increment because a cast is an
> rvalue, whereas the post-increment operator only works on lvalues, so
> the loop does not iterate as expected.
> 
> Replace the post-increment shorthand with the full expression so the
> cast can be added in the right place and the look works as expected.

look -> loop

> Fixes: ac34df733d2d ("ALSA: usb-audio: scarlett2: Update get_config to do endian conversion")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1408
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  sound/usb/mixer_scarlett_gen2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
> index fcba682cd422..c20c7f1ddc50 100644
> --- a/sound/usb/mixer_scarlett_gen2.c
> +++ b/sound/usb/mixer_scarlett_gen2.c
> @@ -1186,7 +1186,7 @@ static int scarlett2_usb_get_config(
>  		if (err < 0)
>  			return err;
>  		if (size == 2)
> -			for (i = 0; i < count; i++, (u16 *)buf++)
> +			for (i = 0; i < count; i++, buf = (u16 *)buf + 1)
>  				*(u16 *)buf = le16_to_cpu(*(__le16 *)buf);
>  		return 0;
>  	}

Thanks Nathan!

FYI: although incorrect, this caused no bug as there is not yet any
case where count > 1.

Acked-by: Geoffrey D. Bennett <g@b4.vu>
