Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32469441E61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhKAQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhKAQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:38:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A33C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:35:36 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g184so17645056pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CX8lGyRtx8fZCFhyVkh/P6EoWxIoZ3wh9wlLJwAISFA=;
        b=Tx6zpbWjkbs//Xe3nVgElH65ffkuoDZf3jMRLumIli9y4gu8dgT8Wpp5+Pfcc39ZYa
         0bFPqXytNz01L7aiX6COd2PKl1ljJ8/5aciu6ZHVu6j7C0P/bIiBkubhui16rfhtV3Eq
         7rpdBwIFKpCn+PKzHov21ehmPybPI6L+MB6hvyin3FiLIEdlPJhNGs5bm8ddvOiLaZY4
         SGPScZTwF7qaIUSGc7RgKzUSsI4SsnkKO0iPiCY4aJv8Yo/fMobrLXBPG3vpeTeNbpa3
         jMFbere9qxyqFjlQ4XUeiYyUVAxT8u2nknsMOtvmWqKs2C89Wsh3M02OZbm71IbYWkSQ
         xifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CX8lGyRtx8fZCFhyVkh/P6EoWxIoZ3wh9wlLJwAISFA=;
        b=Gx9hhxU+MzfVWjr8foXgHFR8QV0rf4P4H89Bbo0XhPnLxvzHW98e4WcGbojz7A3iPm
         95h4pMVLTfYoeBzGQPkrJVPTTBy1vbLuVP586+c+XzPJDV75BdZhat2AjTuVo6CQPXCP
         mBh2raNRokXxjEz4rKFR8vAFDQHNcKbbN4d8SzwcoliDgoIHSOqJWFF/MqyZeQsbQOry
         UH6m0XKlJryM1qyQ9Ld8gaYu3jfpHAYJUuDKh/S9c+y1eO1qOgOPbRwj9lSblaCTDpid
         fjm9IsbzI3EUs6bkYCg6Zfly9RI8acLM9L/la/7HBNYTPe0WJFXIL477YUemxiUgdZp6
         F05Q==
X-Gm-Message-State: AOAM531DGwPPkfJyaJKX4/QEp3DuL3sysvoK5VilONWv1DatwTvxykqt
        B54XNooOfnEu9kn4RKf2F2p9rkkiJRc=
X-Google-Smtp-Source: ABdhPJwVas685rUieCUz7BFq/vaCuW9ozTZRRN+BFB/kW7KxVvXUWuVMZui0cJ1Wi0FkBd4ud5mUxw==
X-Received: by 2002:a63:7d01:: with SMTP id y1mr22944428pgc.343.1635784535957;
        Mon, 01 Nov 2021 09:35:35 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:6249:827a:1d9a:60a2])
        by smtp.gmail.com with ESMTPSA id d24sm15698609pfn.62.2021.11.01.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:35:34 -0700 (PDT)
Date:   Mon, 1 Nov 2021 09:35:32 -0700
From:   "dmitry.torokhov" <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?5bi45buJ5b+X?= <changlianzhi@uniontech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jirislaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        282827961 <282827961@qq.com>
Subject: Re: [PATCH v9] tty: Fix the keyboard led light display problem
Message-ID: <YYAXVP4v2bCpGA8s@google.com>
References: <tencent_10C69A8D3BC51F781F21A754@qq.com>
 <YX/iGfXdc8UKUFCx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YX/iGfXdc8UKUFCx@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 01:48:25PM +0100, Greg KH wrote:
> On Mon, Nov 01, 2021 at 08:35:47PM +0800, 常廉志 wrote:
> > > Switching from the desktop environment to the tty environment,
> > > the state of the keyboard led lights and the state of the keyboard
> > > lock are inconsistent. This is because the attribute kb->kbdmode
> > > of the tty bound in the desktop environment (Xorg) is set to
> > > VC_OFF, which causes the ledstate and kb->ledflagstate
> > > values of the bound tty to always be 0, which causes the switch
> > > from the desktop When to the tty environment, the LED light
> > > status is inconsistent with the keyboard lock status.
> > > 
> > > Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> > > ---
> > >  v7-->v8:
> > >  Optimize the implementation of kbd_update_ledstate function
> >  > 
> > >  Why not adopt the opinions of Greg KH and Andy Shevchenko:
> > >  (1) In the structure struct input_dev, the definition of led is
> > >  like this: unsigned long led[BITS_TO_LONGS(LED_CNT)]; If you
> > >  define it like this: unsigned long newstate = *dev->led; I
> > >  always feel that there is still big end and Little endian problem.
> > >  (2) The test_bit function is used to avoid the problem of large
> > >  and small ends, and the current algorithm (v8) also exists
> > >  elsewhere in the kernel: the atkbd_set_leds function (drivers/
> > >  input/keyboard/atkbd.c).
> > >  (3) In the current keyboard.c code, the code is already very good,
> > >  and it is already relatively independent. If you modify the type
> > >  of ledstate to u64 or modify the macro definitions such as
> > >  VC_NUMLOCK, it feels that it is not very meaningful, and this It
> > >  will also cause other related modifications. Of course, this is
> > >  only my current opinion. If everyone still feels that it is
> > >  necessary to modify, I will do it this way. Of course, this
> > >  process may be a bit longer, and I think it is necessary to
> > >  conduct more tests.
> > >  
> > >  v9: Change description information: xorg-->Xorg
> > > ……
> > 
> > Hi, friends, I would like to ask whether this version of patch is possible, if not,
> > I will try my best to find a way to complete the next version!
> 
> It's the merge window right now, we can't do anything with this until
> after 5.16-rc1 is out.  So give us until then at the least please, then
> I will review it again.

As I mentioned, the state of physical LED on a keyboard does not
necessarily reflect state of logical LED state in tty/vt. One can assign
LED on their keyboard to be an indicator of being connected to mains by
assigning "AC-trigger" to it. So the way this patch tries to fix the
issue (by reading internal state of an individual input device) is
wrong.

We keep separate led and lock states for each VT instance, and they
should be applied when switching to/from a VT. Are you saying that in
certain scenarios this switch is not happening? Can see if that can be
fixed?

Thanks.

-- 
Dmitry
