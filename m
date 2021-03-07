Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3733031B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 17:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhCGQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 11:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhCGQ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 11:58:17 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD1C06174A;
        Sun,  7 Mar 2021 08:58:17 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id g9so6727894ilc.3;
        Sun, 07 Mar 2021 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+BScBCwBTySUma8nKeNtG77a++lO6VTBqBBOLea9Ch8=;
        b=oe/7dsR0nmGlvLVkEyChzN9JviXQFZc6Swo8ACjsYC1CetQl45ne5vwG+BlNQycTiA
         Y19Sdh6iXYpRaiCFlsVFtnojwiveX7DHjFpqCXizGLsa8AFXENQgN55PAppn3eNSmyQz
         YRSZH6NP9Zb999lMzeqUGC7YojKW0LVFvYMBCkf+uMYooqfFUfGhtoy7dbA1MyUzHtRy
         NKYFHEl+hWOnKTcCdzlfT1jbL5VfFN/pWNxojgaeagKI84tQoCYo7bX5UNso/OlkRQ+M
         FgKG2a55gjZ1CHxKWIwDlZjcLVvxBiFP6Ejh4zlD1gS/taP8VRsJt7hu1GF+TWeCzkNK
         zBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+BScBCwBTySUma8nKeNtG77a++lO6VTBqBBOLea9Ch8=;
        b=kZNFHLU1Lj98cbjAn8yHkkr3TK7F6ftaJ7GJjHTX8PSCt/MDIvq/i9/sEj6EFRDlAw
         lCwlrwscn+J9xYn0DjFzUpe0Htj/gnwv3R+i33B4cTuuCrdSKJrH348bTvGYf0ntb0Bb
         GCKbV0t/8LjlAluDuYp+k++Lv4mF+bSTS312SOoeugAHS+/nyrQddH13yfAxtKGmtMHE
         HtX8Qk11iTYaWpnxPF/5tMywhkV2mxIp2C00NXhqLuh7s6dggToNel/iMrrJv34uQgfZ
         ojLnS4Q9xHFzPoU8tJ4+7MBveIX/cV36yB61kLjpMKq+SVIXu7gJI7oixhyZUOslYg+w
         7WQA==
X-Gm-Message-State: AOAM532W2FFy+8LPHX4fZiVIfACrgkppHh904fuo1rAp5282vWdKhZM3
        X3xnmBiQJAnyT4OKub1qJ4lXh3hCn++bPjuGsjHV6MdJRuiWhg==
X-Google-Smtp-Source: ABdhPJxKO0e3c2xf7KuhKq7pU2Txp1tIGn+wLLl+zyIKNvqP2VUTIaNhs7gF0+ztmzJ02+xYLeJYxKNTy9hQrcOCiXk=
X-Received: by 2002:a92:444e:: with SMTP id a14mr16737739ilm.215.1615136296542;
 Sun, 07 Mar 2021 08:58:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu> <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu> <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
 <20210306165808.GD74411@rowland.harvard.edu> <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
 <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com> <20210307154645.GA103559@rowland.harvard.edu>
In-Reply-To: <20210307154645.GA103559@rowland.harvard.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 7 Mar 2021 17:57:39 +0100
Message-ID: <CA+icZUVLC7=-MsXeGQOrAe1emzGW2UwWYxh3EHGPhjR=chygoQ@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 4:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, Mar 06, 2021 at 09:49:00PM +0100, Sedat Dilek wrote:
>
> > For testing purposes, I stopped these systemd services:
> >
> > 1. systemctl stop smartmontools.service
> >
> > 2. systemctl stop udisks2.service
> >
> > Last seen xhci-reset:
> >
> > [Sat Mar  6 21:37:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> >
> > So, that every 10min xhci-reset was caused by pool-udisksd from udisks2.service.
>
> You have found the cause of your problem!  Great!
>
> And now, obviously order to fix the problem, you'll have to look into
> the udisks2 service.  Maybe you can configure it so that it won't send
> the problem-causing commands.
>

I tried yesterday to add --debug option to the ExexStart line of
udisks2.service, but did not see anything helpful.

There exist more user-space than udisks2 causing these xhci-resets.
The cmd#s are also clear: A1 and 85 - whatever they mean.

As said with Linux v5.10.y and Linux v5.11 I have not seen this.

What about CCing linux-block and linux-scsi people?

- Sedat -
