Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3862744264F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 05:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhKBEEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 00:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhKBEEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 00:04:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FAC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 21:02:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m26so18313967pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 21:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QqWKBtiLlEVmRnVb9bGvQDJVGU+tJbXLq9V50iXxeH0=;
        b=UVwD8ZzHD/4ws3iQav9Pl4tL8MdPfhduwTqqvnwHq8ZWYeznbmU0TPD31FdFkqYX5q
         GsgGWmglafhHgwGXelgjxqHxiiUKNvFZjFAKEPrnSgWnIc+FmE5Fuu9W16D6PzwxPaaV
         IH5dpDE3KkcizbAt3265Iq0Jvzm9BlP7mvcAZlB2mGi5J0hFR0kWiU27zsA0PDtAvuHK
         tcfyIdCa105dgo/UtPnBLt0Sq4jkMUMmn2CdlJEapfpbERboUXC/V0u2OUNNOfrC2ZKj
         496YjF6lr/4Q9MXOGiO4VPwi6ituY39VsAJ4KOa/o9lvQCDuDM5VEucCJIHG33EicFA8
         HvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QqWKBtiLlEVmRnVb9bGvQDJVGU+tJbXLq9V50iXxeH0=;
        b=Gun6oPzhthuD0WBZh9ETwDp1hXgvFD2hP0rMI6lV7rtbwvxcPmSPvuH/vLArNnEcr1
         K6b/p3Yy1H83yYTay18iQdqztvkbobfb2xj6VmCTAsa963l3ARl2wyCAAbZbEdiSy/an
         0ymeBXG0FSuwWNV2vDnCrjJgsoHt6fhnXOSU8NlrVUydJDNLgerAFbKBY9yumFbYl9ah
         63E7LlomYf2dwsBz6OCF+F3Fak1t0INaqV2mIl0uGwOfOcFDvSDlj62uNTQ3xdkougw+
         sUK7FvZlE+i0WfFoM/Uye2lUKMcASgwTtTnl73iY9h0Laj8LW4yAMI5AAE8l/k59oWnN
         b7Ag==
X-Gm-Message-State: AOAM530dUhg5O8NpsmpzlJTopj1qwCQXtI8qdInrCWXnKrbr1jvUfYGc
        yVFf21uyKuQTXXbdVyvylGk=
X-Google-Smtp-Source: ABdhPJxg+fDCfOJxOT+tH6MA5a/Sto4SD5HznAPUOs7qvA4a6+wi97+vPbd86OcnM8NTSGQSNmkdWQ==
X-Received: by 2002:a65:508a:: with SMTP id r10mr25104489pgp.96.1635825731781;
        Mon, 01 Nov 2021 21:02:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:6249:827a:1d9a:60a2])
        by smtp.gmail.com with ESMTPSA id md6sm819741pjb.22.2021.11.01.21.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 21:02:10 -0700 (PDT)
Date:   Mon, 1 Nov 2021 21:02:08 -0700
From:   "dmitry.torokhov" <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?5bi45buJ5b+X?= <changlianzhi@uniontech.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jirislaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        282827961 <282827961@qq.com>
Subject: Re: [PATCH v9] tty: Fix the keyboard led light display problem
Message-ID: <YYC4QGKjY42lZXsE@google.com>
References: <tencent_10C69A8D3BC51F781F21A754@qq.com>
 <YX/iGfXdc8UKUFCx@kroah.com>
 <YYAXVP4v2bCpGA8s@google.com>
 <tencent_0215A22726EA8F7807FF43A9@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_0215A22726EA8F7807FF43A9@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lianzhi,

On Tue, Nov 02, 2021 at 11:16:56AM +0800, 常廉志 wrote:
> 
> Hi Dmitry, I don’t know if I fully understand what you mean, but I will 
> try to fully explain the intent of the current patch.
> (1) What is the current bug phenomenon? I will describe with the Num 
> Lock indicator as the object here.
> 
> Phenomenon 1: Suppose that Xorg is bound to tty1 in the desktop environment. 
> At this time, the Num light of the keyboard is on, and the keypad can input numbers 
> normally; assume that the state of the keyboard light saved by tty2 itself is the 
> opposite (the Num light is off, The keypad cannot enter numbers); at this time, 
> if we use the key combination "ctrl+alt+F2" to switch the system to tty2, we will find 
> that the Num light is still on, but the keypad cannot enter numbers.
> 
> Phenomenon 2: Assuming that you are currently in the tty2 environment, the Num 
> light of the keyboard is on, and the keypad can input numbers normally; assume that 
> the Num state saved by Xorg is the same as that of tty2 (the Num light is on, and the 
> keypad can input numbers normally); At this point, if we use the key combination 
> "ctrl+alt+F1" to switch the system to tty1 (that is, to switch to the desktop environment)
> , we will find that the Num light will not light up, but the small keyboard can input numbers .
> 
> (2) Why do these two phenomena occur?
> The variable static unsigned int ledstate is defined in keyboard.c. ledstate should be used to 
> tell VT the current state of the keyboard light, because after each VT sets the state of the 
> keyboard light, it will synchronize the latest keyboard light state to ledstate( (Implemented 
> in the kbd_bh() function).
> 
> Then the problem comes. The scope of ledstate is only in VT, and it cannot include all the 
> scenes where the keyboard light is set. And, in the desktop environment, "kb->kbdmode == 
> VC_OFF" of tty1, at this time, through the NumLock button, only Xorg's own state can be 
> changed, and the led state stored by tty1 cannot be changed (implemented in the kbd_keycode() 
> function), This results in that the kb->ledflagstate stored by tty1 itself and the ledstate in the tty 
> environment are always 0 at this time.
> 
> When we switch tty, the VT code compares the current tty's kb->ledflagstate and ledstate values.
> If they are inconsistent, change the state of the keyboard light (implemented in the kbd_bh() function).
> 
> In phenomenon 1, in the desktop environment, although the actual state saved by xorg is 1, the state 
> of ledstate of tty is always 0. In the environment of tty2, the state of kb->ledflagstate of tty2 is also 0. 
> At this point, in the kbd_bh() function, comparing these two values ​​is equal, there is no need to set the 
> led light state to the keyboard. So after switching to tty2, the Num light is still on, but the small 
> keyboard cannot input numbers.
> 
> In phenomenon 2, in the tty2 environment, the state of ledstate is set to 1, but the kb->ledflagstate of
> tty1 is 0. At this time, the two values ​​are not equal in the kbd_bh() function, so set the led The light
> status to the keyboard. Xorg did not redistribute the configuration during this process is also one of
> the reasons. And even if Xorg re-issues the configuration at this time, it will cause confusion and only
> one can be set.
> 
> (3) How to solve it?
> To solve the problem of phenomenon 1, we must first enable ledstate to correctly reflect the current 
> state of the keyboard light. Therefore, the solution to all versions of patch is to synchronize the 
> latest led state of the input device to ledstate.

You assume that input's device NumLock LED reflects the state of
terminal. That does not have to be the case.

Now how to solve this... On VT switch redraw_screen() calls
vt_set_leds_compute_shiftstate(). Can we do something like:

	/*
	 * On VT switch pretend our led state is opposite of target
	 * state to ensure we refresh all leds.
	 */
	spin_lock_irqsave(&led_lock, flags);
	leds = getleds();
	leds |= (unsigned int)kbd->lockstate << 8;
	ledstate = ~leds;
	spin_unlock_irqrestore(&led_lock, flags);

	set_leds();

?

> At the same time, to solve the problem of phenomenon 2, when switching to tty1, kbd_bh() also 
> determines the current tty's "kb->kbdmode == VC_OFF". If it is true, don't set the keyboard light 
> state. At the same time, Xorg should also re-issue the status of the keyboard light to ensure that it 
> is correct (I also submitted a patch for this, refer to 
> https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/764).

That makes sense.

Thanks.

-- 
Dmitry
