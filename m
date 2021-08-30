Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A993FB2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhH3JS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:18:27 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:44794 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhH3JSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:18:24 -0400
Received: by mail-ej1-f51.google.com with SMTP id me10so29648420ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LV1Dv/lfaMGckmLJ6U2h2Nf+rA41Zasx4c2yrKkh8eM=;
        b=WA/A77eGuKlXoNo9jlZSGRPNJJ//XLMOJI+kRi68zS2sCI75KTbdoahVqSx00gqZDX
         kWSZ6zQkEGC4u4tviUtbjnECWrk6H+N7KB/UTSErU3b7gQs+cR1njF49vgq9j0FgQUbh
         FqmHACwsI0IXdla8s2n/04ARQL4v/an6tch9Zl/L2MoVgkbmM9wd952j4BDRukEa2AJ0
         gEPN8OaMwwt2mwlgAVhQ+Krf8jfkKwBmQ/quQDzZ/7teTwYmSWRPww2Ue3UYg5tCay/p
         yHrzs9IxB4UUHzXSuyaKvYxjIee7tqiqByWiqmKmRYWfCosWp7+7+0k6cDLUkjaF+MwI
         Y+BQ==
X-Gm-Message-State: AOAM5301iSNpwA40w3bbT/yJGo37GRN4JqrexNYosGx8K7h1djNUL7Jo
        SXwfyFZClja/wXFKCS2roDRGKTAqMf4=
X-Google-Smtp-Source: ABdhPJxCzi9kIMhJPmZqJYEsqEC4SIp8vLKbuWd8Mq1RkXcy59VaaWTwODD8qjMqgj3eJ/z2e0y7uQ==
X-Received: by 2002:a17:906:720e:: with SMTP id m14mr24061578ejk.500.1630315050675;
        Mon, 30 Aug 2021 02:17:30 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with UTF8SMTPSA id oy14sm6087650ejb.66.2021.08.30.02.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 02:17:30 -0700 (PDT)
Message-ID: <0f094eb9-11d4-1bd5-0a1b-823317ad4f7d@kernel.org>
Date:   Mon, 30 Aug 2021 11:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] console: consume APC, DM, DCS
Content-Language: en-US
To:     nick black <dankamongmen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YSydL0q8iaUfkphg@schwarzgerat.orthanc>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YSydL0q8iaUfkphg@schwarzgerat.orthanc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 08. 21, 10:56, nick black wrote:
> console: consume APC, DM, DCS
> 
> The Linux console's VT102 implementation already
> consumes OSC ("Operating System Command") sequences,
> probably because that's how palette changes are
> transmitted. In addition to OSC, there are three other
> major clases of ANSI control strings: APC ("Application
> Program Command"), PM ("Privacy Message", and DCS
> ("Device Control String"). They are handled similarly
> to OSC in terms of termination.
> 
> Source: vt100.net
> 
> Add three new enumerated states, one for each of these
> types. All three are handled the same way right now--they
> simply consume input until terminated. I hope to expand
> upon this firmament in the future. Add new predicate
> ansi_control_string(), returning true for any of these
> states. Replace explicit checks against ESosc with calls
> to this function. Transition to these states appropriately
> from the escape initiation (ESesc) state.
> 
> This was motivated by the following Notcurses bugs:
> 
>   https://github.com/dankamongmen/notcurses/issues/2050
>   https://github.com/dankamongmen/notcurses/issues/1828
>   https://github.com/dankamongmen/notcurses/issues/2069
> 
> where standard VT sequences are not consumed by the
> Linux console. It's not necessary that the Linux console
> *support* these sequences, but it ought *consume* these
> well-specified classes of sequences.
> 
> Tested by sending a variety of escape sequences to the
> console, and verifying that they still worked, or were
> now properly consumed. Verified that the escapes were
> properly terminated at a generic level. Verified that
> the Notcurses tools continued to show expected output on
> the Linux console, except now without escape bleedthrough.
> 
> Signed-off-by: nick black <dankamongmen@gmail.com>
> ---
> diff --git drivers/tty/vt/vt.c drivers/tty/vt/vt.c
> index ef981d3b7bb4..62b77ee3f8d1 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -2059,7 +2059,7 @@ static void restore_cur(struct vc_data *vc)
>   
>   enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
>   	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore, ESnonstd,
> -	ESpalette, ESosc };
> +	ESpalette, ESosc, ESapc, ESpm, ESdcs };
>   
>   /* console_lock is held (except via vc_init()) */
>   static void reset_terminal(struct vc_data *vc, int do_clear)
> @@ -2133,20 +2133,28 @@ static void vc_setGx(struct vc_data *vc, unsigned int which, int c)
>   		vc->vc_translate = set_translate(*charset, vc);
>   }
>   
> +/* is this state an ANSI control string? */
> +static bool ansi_control_string(unsigned int state)
> +{
> +	if (state == ESosc || state == ESapc || state == ESpm || state == ESdcs)
> +		return true;
> +	return false;

So simply:
return state == ESosc || state == ESapc || state == ESpm || state == ESdcs;

I wonder if we can simply hide them all behind single ESignore?

> +}
> +
>   /* console_lock is held */
>   static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
>   {
>   	/*
>   	 *  Control characters can be used in the _middle_
> -	 *  of an escape sequence.
> +	 *  of an escape sequence, aside from ANSI control strings.
>   	 */
> -	if (vc->vc_state == ESosc && c>=8 && c<=13) /* ... except for OSC */
> +	if (ansi_control_string(vc->vc_state) && c >= 8 && c <= 13)
>   		return;
>   	switch (c) {
>   	case 0:
>   		return;
>   	case 7:
> -		if (vc->vc_state == ESosc)
> +		if (ansi_control_string(vc->vc_state))
>   			vc->vc_state = ESnormal;
>   		else if (vc->vc_bell_duration)
>   			kd_mksound(vc->vc_bell_pitch, vc->vc_bell_duration);
> @@ -2207,6 +2215,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
>   		case ']':
>   			vc->vc_state = ESnonstd;
>   			return;
> +		case '_':
> +			vc->vc_state = ESapc;
> +			return;
> +		case '^':
> +			vc->vc_state = ESpm;
> +			return;
>   		case '%':
>   			vc->vc_state = ESpercent;
>   			return;
> @@ -2224,6 +2238,9 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
>   			if (vc->state.x < VC_TABSTOPS_COUNT)
>   				set_bit(vc->state.x, vc->vc_tab_stop);
>   			return;
> +		case 'P':
> +			vc->vc_state = ESdcs;
> +			return;
>   		case 'Z':
>   			respond_ID(tty);
>   			return;
> @@ -2520,8 +2537,14 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
>   		vc_setGx(vc, 1, c);
>   		vc->vc_state = ESnormal;
>   		return;
> +	case ESapc:
> +		return;
>   	case ESosc:
>   		return;
> +	case ESpm:
> +		return;
> +	case ESdcs:
> +		return;
>   	default:
>   		vc->vc_state = ESnormal;
>   	}
> 


-- 
js
suse labs
