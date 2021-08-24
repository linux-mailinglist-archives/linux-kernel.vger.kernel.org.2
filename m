Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DEB3F6108
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhHXO4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbhHXO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:56:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E8C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:55:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u3so44998072ejz.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mXDyxGT/kpxC6uWA72Z+qj3+klh2d+94KRyCB7cfVnc=;
        b=CB8iXaouudRzPCxddZVYxkn/FvS8q9eYgYUuFNmXzTk/2WxfLMuXobRiD5djRoIJMq
         lBdv1SMLqHPtzDiMns9sa4Wr++zBE/lu9753gblKhOADbdyIJ/HCM2AWGnt3qTGd3VPF
         u3KeqbsRq4f2B0RWy604Lcz6dEzfOy88dk//pjG630eREywEkcRsJNeNXFPIMbiog2hW
         H+xFzFtE6aMBCc2+J15+laOyfFyRLpSMzxEh2Xqul6s7njMfcYYJs+T8HpI/6c6+ZDXt
         NGOhyMurT+pc9ru/tcvwMc+tZ611csXfgb6YlTTfplsbcb/gMUjz0EAiGdYhkHUCarMW
         xUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXDyxGT/kpxC6uWA72Z+qj3+klh2d+94KRyCB7cfVnc=;
        b=o5ymFWUdZZQy/35B3DSjz22HQnXLwbFeVwMGkW17qnBBdKc8PrZ/8GhIVNaxGUJ3AU
         2aKqV9bJ9HX5kjrZvV4E6fLvZ6LG7Tmi4MnskgAoncYpecZ5kVLg8N0/3wimKFycblt6
         X7xfcKpfCIg15wUB2r7DQorGlN0N3GQMdNL84929vy96I7n6k7U7D2rWYCPC+yFAws3w
         SS2SHXmR3g+GPTTZz2T6Y1rDaauHqKQuks2bY9rp+wB7xIlM0ngVTMvysDfWhFzJclg+
         WrHPv6NE9K2yq95pyq5Mz8aYl1s3nGkPOD0rt+ANluYFEUlXW9OZyqOEdfzc6ElhzsvF
         0icg==
X-Gm-Message-State: AOAM533CDnIQOBCGpU2Zay12kEbAxJLlWdtoOTJge/jSsbef3qcoDPxp
        a41pyZYQJesYzkPrnjBxs8c=
X-Google-Smtp-Source: ABdhPJx2Lyew0IkZKTfJqVKpv+GkyxmSSM83q0wdPZ5yizZ9oXTkXKUuFSet9cbV1aNL/jI2UNzSOQ==
X-Received: by 2002:a17:906:1901:: with SMTP id a1mr41214311eje.129.1629816919719;
        Tue, 24 Aug 2021 07:55:19 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id f26sm6947341eds.90.2021.08.24.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:55:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 16:55:17 +0200
Message-ID: <6176148.qlhjVQ1gkj@localhost.localdomain>
In-Reply-To: <99d69811-deff-d346-634e-20e9fdead7c8@gmail.com>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com> <6601006.JhxPbakEoc@localhost.localdomain> <99d69811-deff-d346-634e-20e9fdead7c8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 2:09:10 PM CEST Pavel Skripkin wrote:
> On 8/24/21 3:01 PM, Fabio M. De Francesco wrote:
> > On Tuesday, August 24, 2021 1:07:46 PM CEST Pavel Skripkin wrote:
> >> 
> >> Btw, not related to your patch, but I start think, that this check:
> >> 
> >> 
> >> 	if (!pIo_buf) {
> >> 		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
> >> 		status = -ENOMEM;
> >> 		goto release_mutex;
> >> 	}
> >> 
> >> Should be wrapped as
> >> 
> >> 	if (WARN_ON(unlikely(!pIo_buf)) {
> >> 		...
> >> 	}
> >> 
> >> Since usb_vendor_req_buf is initialized in ->probe() and I can't see 
> >> possible calltrace, which can cause zeroing this pointer.
> > 
> > I see that usb_vendor_req_buf is initialized in rtw_init_intf_priv(). It depends on a
> > kzalloc() success on allocating memory. Obviously it could fail to allocate. If it fails,
> > rtw_init_intf_priv() returns _FAIL to its caller(s) (whichever they are - I didn't go too
> > deep in understanding the possible calls chains).
> > 
> 
> Call chain is the most interesting part here :)
>
>      rtw_drv_init()		<-- probe()
>        usb_dvobj_init()
> 	rtw_init_intf_priv()
> 
> If kzalloc fails, then whole ->probe() routine fails, i.e device will be 
> disconnected.

I guess that if probe fails and then the device get disconnected it's not a
big problem, in the sense that nothing of very bad could happen.

> There is no read() calls before rtw_init_intf_priv(), so 
> if kzalloc() call was successful, there is no way how usb_vendor_req_buf 
> can be NULL, since read() can happen only in case of successfully 
> connected device.

Yes, though I have very little knowledge of how drivers work, it make sense 
to me too that read(s) can happen only in case of successful connection.

> Anyway, it can be NULL in case of out-of-bound write or smth else,

This is really something I don't know.

> but 
> there is no explicit usb_alloc_vendor_req_buf = NULL in this driver.
> We should complain about completely wrong driver behavior, IMO :)
> 
> Does it make sense?

I'm not sure, whether or not we now have an answer to your question 
about the necessity to use WARN_ON... I think it's up to your judgement,
because I cannot help on this topic :(

Regards,

Fabio

> With regards,
> Pavel Skripkin
> 




