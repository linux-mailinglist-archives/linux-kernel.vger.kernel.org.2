Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A56361729
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 03:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhDPBZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 21:25:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44851 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhDPBZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 21:25:08 -0400
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lXDDu-0004Fg-EF
        for linux-kernel@vger.kernel.org; Fri, 16 Apr 2021 01:24:42 +0000
Received: by mail-oo1-f71.google.com with SMTP id i19-20020a4addd30000b02901e60c4a9d91so1806004oov.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 18:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bulXpuI8tDY/fXBLLWUp4LPd3sUmoquDA0BYMthGL8=;
        b=ppZN1gX1EnPhJ6F7sd7AWr7blfmtiWMKJrIHhiNc7ldVxZjsmQOsj401jom2W9gPDU
         9aAU1SvHIdshyC6+RZY6dWpiLY7JxcppUc5wU7dhLvDbRNBAISP2di2fceT3KR2cNGMb
         EGLkLGjnKuFwIFqvB8UiSrbWJ+/CKSq2JI8GNoqNYRV6JBR04wwV9iqiCCHx2siv+VDz
         1sbHRSHJuJ8wGw5QiR9m3+nyViIeULoyxvWIKsJV+6MpR0uPRozYmMct2JpS+Y1ZxnKy
         tVtI4XYDtlCiwkUJ8lyODROpgvy9lk1DR98/0BboDlhVGZoEJI4DYidFyjfeJ2c9si0t
         4vjg==
X-Gm-Message-State: AOAM531bhOgc64OLtpKDdT6C0PGIVvkQZ+xWOiUPMpb28E0/Y+HRbaEQ
        L4n2qAGVrlW+mn8mTqZpNoyfT6cCjqNZA+ehkZ3BPFXiJkw7xNVvA4YJxhD5v/FfCl+8UrxbvG/
        E9QeOjSf9AnGUrp/ts693L/N+97xtkBUYs3/T1CyEMRl8fcfBqdvAIKVTuw==
X-Received: by 2002:aca:3d86:: with SMTP id k128mr4686943oia.86.1618536281414;
        Thu, 15 Apr 2021 18:24:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUYMs3Voy4p3YzB2JUL6Tw+mcqQowmMYhCSZOCiwF1/JS0cUV9GKzuwm1ePj5j0g2W6M1ZSo0Rf9NKKCbhjdU=
X-Received: by 2002:aca:3d86:: with SMTP id k128mr4686934oia.86.1618536281250;
 Thu, 15 Apr 2021 18:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210415114856.4555-1-chris.chiu@canonical.com>
 <YHgyP8tGNM1Wi5dJ@kroah.com> <CABTNMG0MuaSkWZhiTwtWjPTg5WZ-Vdt9Ju9-RzBke9JjCBJo8Q@mail.gmail.com>
 <20210415184637.GA15445@rowland.harvard.edu>
In-Reply-To: <20210415184637.GA15445@rowland.harvard.edu>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Fri, 16 Apr 2021 09:24:30 +0800
Message-ID: <CABTNMG3aweq43eQcONif2_M4JF3ARmBgOKE18v7vzHvaJnjrtA@mail.gmail.com>
Subject: Re: [PATCH v3] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's Realtek Hub
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 2:46 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Apr 16, 2021 at 12:13:43AM +0800, Chris Chiu wrote:
> > One thing worth mentioning here, I never hit the hub_ext_port_status -71
> > problem if I resume by waking up from the keyboard connected to the hub.
>
> I thought you said earlier that the port got into trouble while it was
> suspending, not while it was resuming.  You wrote:
>
> > [ 2789.679812] usb 3-4-port3: can't suspend, status -110
>
> So if the problem occurs during suspend, how can it be possible to avoid
> the problem by taking some particular action later while resuming?
>

The ETIMEDOUT is still there, but the port can resume w/o problems and I
don't really know what the hub did. I can only reset_resume the hub to bring it
back if I'm not waking up from the connected keyboard.

> > But the usbcore kernel log shows me wPortStatus: 0503 wPortChane: 0004
> > of that port while resuming. In normal cases, they are 0507:0000.
>
> The 0004 bit of wPortChange means that the suspend status has changed;
> the port is no longer suspended because the device attached to that port
> (your keyboard) issued a wakeup request.
>
> >  I don't know how to SetPortFeature() with setting the status change bit only.
>
> You can't.  Only the hub itself can set the wPortChange bits.
>
> > Or maybe it's just some kind of timing issue of the
> > idle/suspend/resume signaling.
>
> Not timing.  It's because you woke the system up from the attached
> keyboard.
>
> Alan Stern

Got it. I'm just confused by the USB 2.0 spec 11.24.2.7.2 that
"Hubs may allow setting of the status change bits with a SetPortFeature()
 request for diagnostic purposes."

So for this case, I think USB_QUIRK_RESET_RESUME would be a
better option to at least bring back the port. Any suggestion about what
kind of test I can do on this hub? Thanks

Chris
