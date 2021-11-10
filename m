Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15B44BBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhKJGoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhKJGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:44:42 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D83AC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:41:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s136so1389026pgs.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X+raHKJL6enqjpVO3WOSRlHEUFN6UzdJla5lXrtTVSE=;
        b=MgoL8dbP7nNFgIBfTL/wKTFw7Bg/9pvSNUUh7ZJye3MbgY7yZQ/2Ef7HsXmnxUKGz0
         7jQdjqigWbA6tw5rGv2SFTDe1621xlSlEciyvLlMXwWbu4kC3PV9VoSDEvQqKQYOg3NC
         iDn4+JAvs9akHzGXF8QWDk39ItJmBkl8kuJaU1+LeKLiD7c3Xqz3U1PA6/72KOtHlNSm
         WbQgR3ToQ6YE7+baC8L5y/XnTgvYV7uSaSTtFChXwnHx3V1fWnFsvfB98wkijUF07gg2
         0HUtQ15HMlcCfF7aDho7ji02D8xaGgfysXmBMHr2hT7BTXtoehoQGIu8dYw3+3IlVUQ7
         xl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+raHKJL6enqjpVO3WOSRlHEUFN6UzdJla5lXrtTVSE=;
        b=OUPHDS+d+GrONSHg07peLUVNXOZdh0pY5X01ifuMjg2ObPWefV1ZmokrnQrUt5uxJw
         bzEiFOQEl3nxSOGwiLjlh6xr8XutCa6K0xcuXKp165RYcVJAldvpH+c9yh9BqU0K3j1k
         y9ZejKa7faLcQ0tzLrW6eSHD5i73rh6Qb1+q7t6zVOB6/B59XyYkyaJbEU9mTBIRAqTZ
         p0oR8OYyypPWVgJVnoOER1N0aHvkEsinkNU7rh0pV6yzAn93Z8nuf6pYg//nq7q3F47y
         G0p9RAcT3mXG/L2ROcVfTdc2YpQ5l/szWelfkbsC10hzjsKvX2zhR+iBf69zSZ+Wpd4t
         CgvA==
X-Gm-Message-State: AOAM5314AV+I4d9+aKoYVyEYn3A9+KwEWbg1/aZBXdEftK6WbE4/TZQ+
        6g0jAt8lSYblxQSBWtWPPiY=
X-Google-Smtp-Source: ABdhPJx/vlTvM6XhGqhYU9aoajIRIQlqWSgLGFvCx7M+fUw9Q0uSp1XH7HBv4NeY69WiPMJ/A+9Qqg==
X-Received: by 2002:a05:6a00:888:b0:44c:c00e:189c with SMTP id q8-20020a056a00088800b0044cc00e189cmr96349765pfj.79.1636526515086;
        Tue, 09 Nov 2021 22:41:55 -0800 (PST)
Received: from google.com ([2620:15c:202:201:b345:ee3a:151d:b1d1])
        by smtp.gmail.com with ESMTPSA id c21sm23757427pfl.15.2021.11.09.22.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 22:41:54 -0800 (PST)
Date:   Tue, 9 Nov 2021 22:41:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com
Subject: Re: [PATCH v14] tty: Fix the keyboard led light display problem
Message-ID: <YYtpr/bP0HqBsmbW@google.com>
References: <20211108055139.7202-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108055139.7202-1-changlianzhi@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lianzhi,

On Mon, Nov 08, 2021 at 01:51:39PM +0800, lianzhi chang wrote:
> Switching from the desktop environment to the tty environment,
> the state of the keyboard led lights and the state of the keyboard
> lock are inconsistent. This is because the attribute kb->kbdmode
> of the tty bound in the desktop environment (Xorg) is set to
> VC_OFF, which causes the ledstate and kb->ledflagstate

We know that Xorg sets kbdmode mode to VC_OFF, but it does not mean that
you can say for sure that it is Xorg instance that controls a VT simply
by observing kb->kbdmode. There may be something else entirely. That is
why you want drivers/tty/vt/keyboard.c to reset LEDs and leave it to
whoever is controlling VT to set them to something else if it is
desired.

> values of the bound tty to always be 0, which causes the switch
> from the desktop When to the tty environment, the LED light
> status is inconsistent with the keyboard lock status.
> In order to ensure that the keyboard LED lights are displayed
> normally during the VT switching process, when the VT is
> switched, the current VT LED configuration is forced to be issued.
> 
> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> Suggested-by: dmitry.torokhov <dmitry.torokhov@gmail.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  v13:
>  The kbd_bh function no longer handles the "kb->kbdmode == VC_OFF"
>  scene, but puts this process in vt_set_leds_compute_shiftstate
>  together. Because the current circumvention is that other ttys
>  switch to the Xorg-bound tty scene, so this Better.
>  v14:
>  Sorry, I forgot to verify the format, it is good now.
>  
>  drivers/tty/vt/keyboard.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..91e1c5d92029 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -153,6 +153,7 @@ static int shift_state = 0;
>  
>  static unsigned int ledstate = -1U;			/* undefined */
>  static unsigned char ledioctl;
> +static bool vt_switch;
>  
>  /*
>   * Notifier list for console keyboard events
> @@ -412,9 +413,20 @@ static void do_compute_shiftstate(void)
>  /* We still have to export this method to vt.c */
>  void vt_set_leds_compute_shiftstate(void)
>  {
> +	struct kbd_struct *kb;
>  	unsigned long flags;
>  
> -	set_leds();
> +	/* Xorg will bind a tty, the kb->kbdmode of this tty will be set to
> +	 * VC_OFF, and this tty will no longer set the keyboard light. If
> +	 * there is no such restriction, when switching from other tty to
> +	 * Xorg-bound tty, the tty will set the keyboard light, which is
> +	 * unreasonable
> +	 */
> +	kb = kbd_table + fg_console;
> +	if (kb->kbdmode != VC_OFF) {
> +		vt_switch = true;
> +		set_leds();
> +	}
>  
>  	spin_lock_irqsave(&kbd_event_lock, flags);
>  	do_compute_shiftstate();
> @@ -1255,6 +1267,11 @@ static void kbd_bh(struct tasklet_struct *unused)
>  	leds |= (unsigned int)kbd->lockstate << 8;
>  	spin_unlock_irqrestore(&led_lock, flags);
>  
> +	if (vt_switch) {
> +		ledstate = ~leds;
> +		vt_switch = false;
> +	}
> +
>  	if (leds != ledstate) {
>  		kbd_propagate_led_state(ledstate, leds);
>  		ledstate = leds;
> -- 
> 2.20.1
> 
> 
> 

Thanks.

-- 
Dmitry
