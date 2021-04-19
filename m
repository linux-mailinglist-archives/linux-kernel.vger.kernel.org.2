Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF55363AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 07:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhDSFMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 01:12:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46829 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDSFMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 01:12:21 -0400
Received: from mail-oo1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lYMCM-0005D1-Sp
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 05:11:51 +0000
Received: by mail-oo1-f70.google.com with SMTP id s17-20020a4a3b110000b02901ed1f7f795dso864337oos.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 22:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyd+1dQ+ErVKx1JdIk658NVw080X5wV+ShvBB/puUzQ=;
        b=AlwxgPeOiVksBB5ekoMFwFVjAZnGUQth39J1o6INDzI9AOkvS3/44s7Tns8DWBXKYR
         548h+r5DFIWH6bGA/nXMSPkFDxN/rZ0ckv7/BXCjbPr2q1qdeUKLno8K9BfnovTcEBGG
         cZG/iFD9fl8rSzX6Ow+MSVeYjyzL49K5RCEwbjBznrfBnQL/f5p9QAIy1NtD+Atfq0Ci
         BZylxhsPzd7dCCaoeFgJAuPda1XW30g94bXLaCaYD0md986QFEttrMvHTctsVlC/aTL9
         3P6VSL6UU4gRm8/vYr8S248PWFQPirtdv8RzOiV67gl4tz1i97y++5Gvf5g6DEt/Y0bC
         eGCQ==
X-Gm-Message-State: AOAM532RiUXSclf0J8Qs3GTQydsPMJloE5Vw1LUqDVkyeOAHI1cJezLf
        gfVfInVYV5pLPDQpplOvUWNyXptx8v4m9ZBnmRXD56w3+w6vaEEL5bc9H6KFD4BL34w0oimw5a5
        VrAnOKsOfbklwH40Nc5tpYD7O/rJIw+fn5+4rb2bnxoV+AkLZwkis09V56g==
X-Received: by 2002:aca:4a97:: with SMTP id x145mr5301612oia.177.1618809109752;
        Sun, 18 Apr 2021 22:11:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpJa6ylhblmCS1U6HZP/ShZUCaOgayMXlZjsfRHo8e1chf9R7/IjhN3RhkaSFPWBbv0l5kmU3+dLlUBWDpMMQ=
X-Received: by 2002:aca:4a97:: with SMTP id x145mr5301604oia.177.1618809109571;
 Sun, 18 Apr 2021 22:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210415114856.4555-1-chris.chiu@canonical.com>
 <YHgyP8tGNM1Wi5dJ@kroah.com> <CABTNMG0MuaSkWZhiTwtWjPTg5WZ-Vdt9Ju9-RzBke9JjCBJo8Q@mail.gmail.com>
 <20210415184637.GA15445@rowland.harvard.edu> <CABTNMG3aweq43eQcONif2_M4JF3ARmBgOKE18v7vzHvaJnjrtA@mail.gmail.com>
 <20210416153932.GD42403@rowland.harvard.edu>
In-Reply-To: <20210416153932.GD42403@rowland.harvard.edu>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 19 Apr 2021 01:11:38 -0400
Message-ID: <CABTNMG25qPvVu7+EsvEgaUsU_v6jKkSKCaU5VR8CiX3oLQ4VFg@mail.gmail.com>
Subject: Re: [PATCH v3] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's Realtek Hub
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:39 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Apr 16, 2021 at 09:24:30AM +0800, Chris Chiu wrote:
> > On Fri, Apr 16, 2021 at 2:46 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 12:13:43AM +0800, Chris Chiu wrote:
> > > > One thing worth mentioning here, I never hit the hub_ext_port_status -71
> > > > problem if I resume by waking up from the keyboard connected to the hub.
> > >
> > > I thought you said earlier that the port got into trouble while it was
> > > suspending, not while it was resuming.  You wrote:
> > >
> > > > [ 2789.679812] usb 3-4-port3: can't suspend, status -110
> > >
> > > So if the problem occurs during suspend, how can it be possible to avoid
> > > the problem by taking some particular action later while resuming?
> > >
> >
> > The ETIMEDOUT is still there, but the port can resume w/o problems and I
> > don't really know what the hub did. I can only reset_resume the hub to bring it
> > back if I'm not waking up from the connected keyboard.
>
> What if two devices are plugged into the hub, only one of them is
> runtime suspended, and you need to runtime resume that device?  Then you
> can't do a reset-resume of the hub, because the hub isn't suspended.
>
> > > > But the usbcore kernel log shows me wPortStatus: 0503 wPortChane: 0004
> > > > of that port while resuming. In normal cases, they are 0507:0000.
> > >
> > > The 0004 bit of wPortChange means that the suspend status has changed;
> > > the port is no longer suspended because the device attached to that port
> > > (your keyboard) issued a wakeup request.
> > >
> > > >  I don't know how to SetPortFeature() with setting the status change bit only.
> > >
> > > You can't.  Only the hub itself can set the wPortChange bits.
> > >
> > > > Or maybe it's just some kind of timing issue of the
> > > > idle/suspend/resume signaling.
> > >
> > > Not timing.  It's because you woke the system up from the attached
> > > keyboard.
> > >
> > > Alan Stern
> >
> > Got it. I'm just confused by the USB 2.0 spec 11.24.2.7.2 that
> > "Hubs may allow setting of the status change bits with a SetPortFeature()
> >  request for diagnostic purposes."
>
> Yeah, I don't think very many hubs actually do that.
>
> > So for this case, I think USB_QUIRK_RESET_RESUME would be a
> > better option to at least bring back the port. Any suggestion about what
> > kind of test I can do on this hub? Thanks
>
> I'm not sure what you're proposing.
>
> If (as mentioned above) the hub doesn't handle the
> Set-Port-Feature(suspend) request properly, then we should avoid issuing
> that request.  Which means runtime suspend attempts should not be
> allowed, as in your most recent patch.
>
> Alan Stern

Sorry that I didn't make myself clear. I found that if I applied RESET_RESUME
quirk on the problematic hub, the Set-Port-Feature(suspend) timeout error
disappeared. SInce the timeout is not happening for each suspend by default,
I suspect maybe reset-resume take everything back to clean state for the hub
and the Set-Port-Feature(suspend) can be taken care of w/o problems.

I didn't like RESET_RESUME because runtime PM would not work on the quirked
device. But if the Set-Port-Feature(suspend) can't be handled and
skipped, I can't
expect the runtime PM to work for all devices connected to the hub either.
Is that right? If what I proposed in the patch can not get better
result than existing
quirk, I think using the RESET_RESUME would be a better option. Any suggestions?

Chris
