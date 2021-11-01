Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174824419FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhKAKhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhKAKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:37:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2750C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 03:34:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v127so12952612wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SMxVE993gd6+Fa5JpVknnvYvOLxz+iLd5q1Fx2KECxk=;
        b=TWgZd0lHH9CJqqOc3dgYEzoC6RktC0gVtYMX5f3/f4jLpjBGFCOiH/HfdnVKITYfJt
         Ung48t8EZS6G6q6tRDp4ofGxwrTBvLWPgpZA4ZPIL2NxVg3A5JLfddOb7aJPZ3fP/WJr
         yJKTqo7+MXBMfPoqKYOXKtT7I3a6PfQRFmKZ/pdVgDtbN3EgdJdfUGNJESWZIKq2OPHR
         YTnqIgLin2GL9f81aNkwTrKpPoPxAWHrGQNK8gkDKWdDhpxEgi06O977kuEuNYIerq2s
         IZHcxAqIa4xpbPS0pEXump22JPdbgy39Sp/S3QmC5SD/UiOyUHQUMyV5fc+9n9y9EjB2
         sUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMxVE993gd6+Fa5JpVknnvYvOLxz+iLd5q1Fx2KECxk=;
        b=HNaamEsIZIa9Ezmjcpgr38xqpJQ1J5j384ynT5I0USzsXeou4gmbp6RArb2cGqQieH
         PJ4g/8rCwNKBPcG0jH3lnzRfjxrtQq0beT/BG4JxJfrb1QvLYoXoKd1qOxe+vm0A3Y6H
         nkCia0OzCxNGWH/koE3ncyTuwUNubcJsnidhW/sXHf6P0QOw0dWxntbpKmzGYkqCjT2x
         /Eku1MMwW7Qwhy84e8YtKibLqjnM68+G6sOy5Zu5vhI5QLvycQ6mniHzolGPIO57UBrk
         dmEsNNOY1N8horSyE0x/apsQAIC6gTlLq3Lnere/qvnQ5CaiQUEwznS0hSPe/Y/isXqm
         Hquw==
X-Gm-Message-State: AOAM532G9lXuFEXqLeedZMXMQ834kSsjWq/u8EoH0K/2gzKguY0B5ELr
        Euu/mzXNQuiKvJ0XNxNmTg==
X-Google-Smtp-Source: ABdhPJxkfcWWxu0T1+SSX5tU5BJoP92EPP6ZG6PjzKeKR2VibuhpKhrJB0ZVt77ZGv3L+tMWdFmYWQ==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr30044230wma.72.1635762880402;
        Mon, 01 Nov 2021 03:34:40 -0700 (PDT)
Received: from rampage-hp2 (static-90-251-248-205.vodafonexdsl.co.uk. [90.251.248.205])
        by smtp.gmail.com with ESMTPSA id p188sm12294386wmp.30.2021.11.01.03.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 03:34:39 -0700 (PDT)
Date:   Mon, 1 Nov 2021 10:34:45 +0000
From:   Jonathan Clarke <jonathan.a.clarke@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] Make top/rear speaker, mute and micmute leds work on HP
 x360 14-ea000 laptops that use Realtek 245 codec
Message-ID: <20211101103445.GA1064130@rampage-hp2>
References: <20211029154313.1005394-1-jonathan.a.clarke@gmail.com>
 <s5h35oisug0.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h35oisug0.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look at this patch so quickly, Takashi.

On Sat, Oct 30, 2021 at 12:01:03PM +0200, Takashi Iwai wrote:
> Could you give more descriptions?  The patch isn't trivial at all, and
> it needs more explanations.

Yes, will do.

> > +           /* output mute is set via SET_COEF_INDEX,SET_PROC_COEF */
> > +           spec->mute_led_polarity = 0;
> > +           spec->mute_led_coef.idx = 0x0b;
> > +           spec->mute_led_coef.mask = 0xffff;
> > +           spec->mute_led_coef.on = 0xa02f;
> > +           spec->mute_led_coef.off = 0x7774;
> > +           snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
>
> I guess this COEF isn't only about mute-LED but actually does mute the
> output?  IIRC, the bit 0x08 corresponds to the LED.  If so, it's
> better to split.  Basically this snd_hda_gen_add_mute_led_cdev() and
> mute_led_coef stuff are only for the mute LED control.  e.g. you can
> change the mute LED independently via sysfs.

Thanks for suggesting this.

Having tested, I can confirm that setting this coef only affects
the output mute LED, and does not affect output.

I will therefore assume that current implementation in my patch is OK,
but let me know if it still needs changing (maybe I've misunderstood).

For reference to other users, the commands to test are:
# output LED on
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x0b
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0xa02f

# output LED off
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x0b
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x7774

Many thanks, Jonathan
