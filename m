Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9BC443A09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBXyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhKBXyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:54:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B338C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:51:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so154909pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qt0/23auoTMv6veLw+XEVIQ0c4MWIwE9bvcbG+AtpIg=;
        b=S+7tPio6594UcZ76kPOpsfDFcT9yDrShzEcvJ4zqJo2++7nZRvqSyNyV4Y1xbg7XuH
         92/ph6lnebZ1WG8JZiasPRbZhfw3VZNzLZ/+Fza3K2VWBQAy2QzPqssxjj6muePa8qIX
         0kyqO6ZTcKeuzisJJW4LZCYmn7+wVlWbuR0T9bJfuqrrxOeExeMXWDCBYR7e522Bvg0O
         EW99KCaclz466t91OkpGOowBWz9Whk+Ls9UBOAgl2RDBtZAI8RlX3rKTtSJ2Bxb6hXJM
         sTtQe8esgs8601mIWP8waL0+vMW/jrYWuRgcJbiWKsHZuOSJkXcQQ5QKARp6ch9CllQx
         nxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qt0/23auoTMv6veLw+XEVIQ0c4MWIwE9bvcbG+AtpIg=;
        b=Udq/EboKWdOaS2MCU/I9pnkKjVOBc1fzMmNEEm/6lqADQ2R4j/1mazne4mzGUa2fLn
         MPwFtWzIgs7FW71NrC2k1FlOVze8jMgnNxfQrBW/SAxY07m29cAQjyAm7gC0oawGZdlG
         UsVy261zmvGESHuma8TQuYgQcFxl1+21BWXx5d9rnKLbt/1BALKWcXaFIKpFgGma8sWA
         cdb/kvrEildSAloK2xMAm5NaFt394nV2doir7NPmHdCrmdmHDMdEtrFWuEU4A8m1iDyU
         421FwqP4nYfksgnsFlTv8pA3vSPXcYMEDPbh0rCxCWi8cC2qgYNnvFID1R5TBn6+hGKq
         yHpw==
X-Gm-Message-State: AOAM532NJJ+jb+60BNJ8dOU/k6q37wLFGKcwANg5cjNh4xyU94E1aEo5
        DzCllYY2+4hD3U8MPV0Evck=
X-Google-Smtp-Source: ABdhPJzyvp7jOK3kbhLTxYPIFODEd5sfeMGqHStr43KzAYkYnfeyZBEvVfstCkNy9Yvz+DkWB2G60A==
X-Received: by 2002:a17:902:bd46:b0:141:9a52:fa25 with SMTP id b6-20020a170902bd4600b001419a52fa25mr32762721plx.64.1635897103884;
        Tue, 02 Nov 2021 16:51:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9ff4:d422:7d09:b7e7])
        by smtp.gmail.com with ESMTPSA id y25sm263138pfa.70.2021.11.02.16.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:51:42 -0700 (PDT)
Date:   Tue, 2 Nov 2021 16:51:40 -0700
From:   "dmitry.torokhov" <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?5bi45buJ5b+X?= <changlianzhi@uniontech.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jirislaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        282827961 <282827961@qq.com>
Subject: Re: [PATCH v9] tty: Fix the keyboard led light display problem
Message-ID: <YYHPDBDuYvcr4I/S@google.com>
References: <tencent_10C69A8D3BC51F781F21A754@qq.com>
 <YX/iGfXdc8UKUFCx@kroah.com>
 <YYAXVP4v2bCpGA8s@google.com>
 <tencent_0215A22726EA8F7807FF43A9@qq.com>
 <YYC4QGKjY42lZXsE@google.com>
 <tencent_58FBAAE735B7BF622A690384@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_58FBAAE735B7BF622A690384@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 03:09:20PM +0800, 常廉志 wrote:
> > >
> > > Hi Dmitry, I don’t know if I fully understand what you mean, but I will
> > > try to fully explain the intent of the current patch.
> > > (1) What is the current bug phenomenon? I will describe with the Num
> > > Lock indicator as the object here.
> > >
> > > Phenomenon 1: Suppose that Xorg is bound to tty1 in the desktop environment.
> > > At this time, the Num light of the keyboard is on, and the keypad can input numbers
> > > normally; assume that the state of the keyboard light saved by tty2 itself is the
> > > opposite (the Num light is off, The keypad cannot enter numbers); at this time,
> > > if we use the key combination "ctrl+alt+F2" to switch the system to tty2, we will find
> > > that the Num light is still on, but the keypad cannot enter numbers.
> > >
> > > Phenomenon 2: Assuming that you are currently in the tty2 environment, the Num
> > > light of the keyboard is on, and the keypad can input numbers normally; assume that
> > > the Num state saved by Xorg is the same as that of tty2 (the Num light is on, and the
> > > keypad can input numbers normally); At this point, if we use the key combination
> > > "ctrl+alt+F1" to switch the system to tty1 (that is, to switch to the desktop environment)
> > > , we will find that the Num light will not light up, but the small keyboard can input numbers .
> > >
> > > (2) Why do these two phenomena occur?
> > > The variable static unsigned int ledstate is defined in keyboard.c. ledstate should be used to
> > > tell VT the current state of the keyboard light, because after each VT sets the state of the
> > > keyboard light, it will synchronize the latest keyboard light state to ledstate( (Implemented
> > > in the kbd_bh() function).
> > >
> > > Then the problem comes. The scope of ledstate is only in VT, and it cannot include all the
> > > scenes where the keyboard light is set. And, in the desktop environment, "kb->kbdmode ==
> > > VC_OFF" of tty1, at this time, through the NumLock button, only Xorg's own state can be
> > > changed, and the led state stored by tty1 cannot be changed (implemented in the kbd_keycode()
> > > function), This results in that the kb->ledflagstate stored by tty1 itself and the ledstate in the tty
> > > environment are always 0 at this time.
> > >
> > > When we switch tty, the VT code compares the current tty's kb->ledflagstate and ledstate values.
> > > If they are inconsistent, change the state of the keyboard light (implemented in the kbd_bh() function).
> > >
> > > In phenomenon 1, in the desktop environment, although the actual state saved by xorg is 1, the state
> > > of ledstate of tty is always 0. In the environment of tty2, the state of kb->ledflagstate of tty2 is also 0.
> > > At this point, in the kbd_bh() function, comparing these two values ​​is equal, there is no need to set the
> > > led light state to the keyboard. So after switching to tty2, the Num light is still on, but the small
> > > keyboard cannot input numbers.
> > >
> > > In phenomenon 2, in the tty2 environment, the state of ledstate is set to 1, but the kb->ledflagstate of
> > > tty1 is 0. At this time, the two values ​​are not equal in the kbd_bh() function, so set the led The light
> > > status to the keyboard. Xorg did not redistribute the configuration during this process is also one of
> > > the reasons. And even if Xorg re-issues the configuration at this time, it will cause confusion and only
> > > one can be set.
> > >
> > > (3) How to solve it?
> > > To solve the problem of phenomenon 1, we must first enable ledstate to correctly reflect the current
> > > state of the keyboard light. Therefore, the solution to all versions of patch is to synchronize the
> > > latest led state of the input device to ledstate.
> 
> > You assume that input's device NumLock LED reflects the state of
> > terminal. That does not have to be the case.
> 
> > Now how to solve this... On VT switch redraw_screen() calls
> > vt_set_leds_compute_shiftstate(). Can we do something like:
> 
> > /*
> > * On VT switch pretend our led state is opposite of target
> > * state to ensure we refresh all leds.
> > */
> > spin_lock_irqsave(&led_lock, flags);
> > leds = getleds();
> > leds |= (unsigned int)kbd->lockstate << 8;
> > ledstate = ~leds;
> > spin_unlock_irqrestore(&led_lock, flags);
> > 
> > set_leds();
> > 
> > ?
> Hi Dmitry:
> /*
> * The following piece of code exists in the kbd_bh() function
> */
> spin_lock_irqsave(&led_lock, flags);
> leds = getleds();
> leds |= (unsigned int)kbd->lockstate << 8;
> ledstate = ~leds;

  ^^^^^^^^^^^^^^^^^

This is not the exact code that exists in kbd_bh(). It lacks the line
above which should cause LEDs be synchronized once set_leds()/kbd_bh()
runs.

> spin_unlock_irqrestore(&led_lock, flags);
> 
> Moreover, the process of calling the set_leds() function is 
> the process of calling the kbd_bh function:
> static void set_leds(void)
> {
> tasklet_schedule(&keyboard_tasklet);
> }
> static DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh);
> 
> I don't really understand what you mean here, but one thing 
> can be confirmed, my patch just synchronizes the current input 
> device's led state to ledstate. Moreover, after VT's 
> kb->ledflagstate is set to the input device, it will also 
> be synchronized to ledstate (the original logic of the kbd_bh() 
> function), which does not destroy the original internal logic of 
> VT. In addition, I have tested it, whether it is switching 
> between the desktop environment (tty1) and tty2~6, or switching 
> between tty2~6, the indicator status of the keyboard light is 
> correct, and it is normal in the multi-keyboard state. . 

And I keep telling you that your approach to solving the problem is not
correct because state of a random input device is not necessarily
connected to the state of a VT.

Thanks.

-- 
Dmitry
