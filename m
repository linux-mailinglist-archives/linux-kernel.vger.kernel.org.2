Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22782446AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhKEWjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhKEWjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:39:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF7BC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:36:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j9so9492992pgh.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QL98x9U/Qa90ZzOr5AopLmpOuoSWBwUx/5i1xSLSc5k=;
        b=oXfMfj9J0O8HNOmX4kMPKS85ZSGdzfcfDKW7WKCeXzg+XGuItcu2cNdIpCv7b1ydJh
         OTs4fTWdcfVaj1utbrRQ0SpqLqbGqEG3/kEJXG7nxFznCu+Pj29J3TcD2t/pusOxSfhr
         2DAw6mY+t+nqOD1QcJuhkvJQ0/RhE4t0u50aEGF8GZ39X/5NtjSckpVg4A+22pJoaL5q
         x7z/A5pIXufVcjVXq07HAn+KN+deAEs3VHlBVXoq3Uq08mJtskrAlLYdhVVw99EGY9Tg
         cyP614ZNOByr6i14Ecorxihfo5h3Dn2DQCh4vZYlrVyUi2/BodIvlo3DnvMuL1UlCk/X
         7DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QL98x9U/Qa90ZzOr5AopLmpOuoSWBwUx/5i1xSLSc5k=;
        b=c/0takldAgOH/gMnVNHIuvqpJHQZyydV/XjLJn4+rm/ClmctQi78UiEiCLx2qGq5Br
         psTYrO7dDuu58em8lDnDyQnP6u0XiMRDCPDZoydnxa9kvFaMppj8kva5pwSNv9eDsJnQ
         Xa7zmWwqyz+hHxP/cANc2pO7aKq2KoOBTUVYqZlueJZpWCB0IAr5V/1lXi+sPKBq5U0I
         xtbSPIviYY9OL8PdK87dYugf3IxyoEHZCLBS41u0bxGdXIDF7VM9BrjMZsM39Fv5hqdy
         AmEpo8jdq5laVRRamysN1oXVFkOQD01ear+DyNQA+KrgJu47FIyzf2XZKw/FPOZeJEqH
         yaOQ==
X-Gm-Message-State: AOAM532n9kV8kLXRQUKWuEL/uwVgoVlab1hZqZKzmTaSyUQPXXetV+5T
        A9vimxY2QapMDQcxVhALlB8=
X-Google-Smtp-Source: ABdhPJzp/msi/KagylOnFGxkQ+yeeI8fRkRKdV1x7c+5CxMwBv44xQeCPdH79/B28LDw+cuU+uXwWA==
X-Received: by 2002:a05:6a00:806:b0:49f:9e16:c90f with SMTP id m6-20020a056a00080600b0049f9e16c90fmr6782094pfk.1.1636151818543;
        Fri, 05 Nov 2021 15:36:58 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:837c:e765:475f:22d3])
        by smtp.gmail.com with ESMTPSA id w3sm5728324pfd.195.2021.11.05.15.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:36:57 -0700 (PDT)
Date:   Fri, 5 Nov 2021 15:36:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com
Subject: Re: [PATCH v12] tty: Fix the keyboard led light display problem
Message-ID: <YYWyB1UmQxo0a2WU@google.com>
References: <20211105134816.13982-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105134816.13982-1-changlianzhi@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lianzhi
On Fri, Nov 05, 2021 at 09:48:16PM +0800, lianzhi chang wrote:
> Switching from the desktop environment to the tty environment,
> the state of the keyboard led lights and the state of the keyboard
> lock are inconsistent. This is because the attribute kb->kbdmode
> of the tty bound in the desktop environment (Xorg) is set to
> VC_OFF, which causes the ledstate and kb->ledflagstate
> values of the bound tty to always be 0, which causes the switch
> from the desktop When to the tty environment, the LED light
> status is inconsistent with the keyboard lock status.
> In order to ensure that the keyboard LED lights are displayed
> normally during the VT switching process, when the VT is
> switched, the current VT LED configuration is forced to be issued.
> 
> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  v10:
>  The led state of the input device is no longer synchronized to
>  ledstate, and the related code is deleted. The current plan is
>  changed to: when the VT is switched, the LED state saved by the
>  current VT is forced to be issued.
>  v11:
>  Supplement the signature of the collaborator.
>  
>  drivers/tty/vt/keyboard.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..20013c45b979 100644
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
> @@ -412,8 +413,12 @@ static void do_compute_shiftstate(void)
>  /* We still have to export this method to vt.c */
>  void vt_set_leds_compute_shiftstate(void)
>  {
> +	struct kbd_struct *kb;
>  	unsigned long flags;
>  
> +	kb = kbd_table + fg_console;
> +	if (kb->kbdmode != VC_OFF)
> +		vt_switch = true;

Could you please add explanation here why it is not racy (I do not think
it is as I believe currently executed tasklets can be scheduled).

>  	set_leds();
>  
>  	spin_lock_irqsave(&kbd_event_lock, flags);
> @@ -1247,14 +1252,24 @@ void vt_kbd_con_stop(unsigned int console)
>   */
>  static void kbd_bh(struct tasklet_struct *unused)
>  {
> +	struct kbd_struct *kb;
>  	unsigned int leds;
>  	unsigned long flags;
>  
> +	kb = kbd_table + fg_console;
> +	if (kb->kbdmode == VC_OFF)
> +		return;

Why do we need to do this? Won't this stop setting arbitrary LEDs via
console ioctl?

> +
>  	spin_lock_irqsave(&led_lock, flags);
>  	leds = getleds();
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
> @@ -1643,6 +1658,8 @@ int __init kbd_init(void)
>  	int i;
>  	int error;
>  
> +	vt_switch = false;

No need to explicitly initialize it here, as a static variable it will
be automatically initialized to 0 (false).

> +
>  	for (i = 0; i < MAX_NR_CONSOLES; i++) {
>  		kbd_table[i].ledflagstate = kbd_defleds();
>  		kbd_table[i].default_ledflagstate = kbd_defleds();

Thanks.

-- 
Dmitry
