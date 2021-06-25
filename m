Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4053B3C81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhFYGMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:12:16 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39718 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFYGMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:12:15 -0400
Received: by mail-wr1-f47.google.com with SMTP id b3so9268513wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 23:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxZJNH/ldnqJ3IT7+jiuzqAO/ABMSxBK7lr/weQ/9tY=;
        b=N9DIlmkP8/VtLcQ3bGGM53o644G4W3JiffolOTKJZtDB1HkJ1rBvnwGkDN0Ry2n7iP
         6vGELeZgAa+UkJvjjlUNDndEdLPMfS2c8uiJq/xE/4lm2DirYtiefGWlDtWRLjKc3F9A
         IAilGfaP8Jm1ISRSFFPQw9T3VN46YRgx3LoathtFMQnNnDeUQ92LcUNIVXCSHqpsB0sk
         rmct9hAni7SBUo5Ls88J31odJM1qQjt/gbMwCR9bBJbn0vOipd3hZgPKQ+o+buBkxj1m
         7wExl1sjZu7aP3y05EeGVTLKshkn+bcSYSJX1y0mIhf5IxNe0KO0V/0VKgSUIX7+YR8M
         zsuQ==
X-Gm-Message-State: AOAM532/5cRK9DRfzTN9eorj9EfX70Ifve65dNroADya/5r+yiIawWML
        4/S0d/Ur1GkPRbCXPOMmXUE=
X-Google-Smtp-Source: ABdhPJzhD1ART1YBSqcC0L6yYmWIJUEGZMAPGlMWljMNEK/lm7JmStund9dhjWz8I3fweQjgfISjVw==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr8604923wrv.423.1624601394637;
        Thu, 24 Jun 2021 23:09:54 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y13sm4974387wmj.18.2021.06.24.23.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 23:09:54 -0700 (PDT)
Subject: Re: [PATCH v4] tty: Fix out-of-bound vmalloc access in imageblit
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
References: <20210624202725.20415-1-igormtorrente@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <6d3d27d2-36e2-d95b-98e4-df08dedc34e2@kernel.org>
Date:   Fri, 25 Jun 2021 08:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624202725.20415-1-igormtorrente@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 06. 21, 22:27, Igor Matheus Andrade Torrente wrote:
> This issue happens when a userspace program does an ioctl
> FBIOPUT_VSCREENINFO passing the fb_var_screeninfo struct
> containing only the fields xres, yres, and bits_per_pixel
> with values.
> 
> If this struct is the same as the previous ioctl, the
> vc_resize() detects it and doesn't call the resize_screen(),
> leaving the fb_var_screeninfo incomplete. And this leads to
> the updatescrollmode() calculates a wrong value to
> fbcon_display->vrows, which makes the real_y() return a
> wrong value of y, and that value, eventually, causes
> the imageblit to access an out-of-bound address value.
> 
> To solve this issue I made the resize_screen() be called
> even if the screen does not need any resizing, so it will
> "fix and fill" the fb_var_screeninfo independently.
> 
> Reported-and-tested-by: syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
>   drivers/tty/vt/vt.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fa1548d4f94b..e342f5c905bc 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1220,7 +1220,22 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>   	new_screen_size = new_row_size * new_rows;
>   
>   	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
> -		return 0;
> +		/* This function is being called here to cover the case

This was already commented on v3:
<quote>
  Please do not use networking style comments, use normal ones:
                 /*
                  * This function...
</quote>

> +		 * where the userspace calls the FBIOPUT_VSCREENINFO twice,
> +		 * passing the same fb_var_screeninfo containing the fields:
> +		 * yres/xres equal to a number non-multiple of vc_font.height
> +		 * and yres_virtual/xres_virtual equal to number lesser than the
> +		 * vc_font.height and yres/xres.
> +		 * In the second call, the struct fb_var_screeninfo isn't
> +		 * being modified by the underlying driver because of the
> +		 * if above, and this causes the fbcon_display->vrows to become
> +		 * negative and it eventually leads to out-of-bound
> +		 * access by the imageblit function.
> +		 * To give the correct values to the struct and to not have
> +		 * to deal with possible errors from the code below, we call
> +		 * the resize_screen here as well.
> +		 */
> +		return resize_screen(vc, new_cols, new_rows, user);

I suppose you need to add { } after the if given how its body grew.

With what all console drivers have you tested this with?

>   
>   	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
>   		return -EINVAL;
> 


-- 
js
suse labs
