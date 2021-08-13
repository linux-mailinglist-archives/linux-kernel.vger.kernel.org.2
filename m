Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB733EBD40
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhHMUWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhHMUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:22:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE327C061756;
        Fri, 13 Aug 2021 13:22:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d4so21950022lfk.9;
        Fri, 13 Aug 2021 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7yfeT04tjUL7ni0Yt8y/2t/fuxpmrzJm7LGRe7fQGzE=;
        b=edN0LhhIrqQ06BnpYKmePZuINDREBj4Vg4HmsJfZEJumcvXIgS+6Jn8pkssXze2FCP
         dpRCv3rpvoQl5Q24npLm959uFpi3Z+34sfiJ8TNJ6SLwhqMGfF8fXr3PUnlVVjqgBbC5
         AMlC2/9lRIZVE4+X3fJ7/Ha0auTa5rkYkdf6CatOk7ZPNGgM1whkHODI5gohanuT5o1g
         r9Ipn2OweaqzyJbl0mlkvzrXfWAv5Ft4zxU8mHwqb+hHUm6FYioH23JdWglKQIpnXSc1
         jyVUkDnX87yChzGLn+KMkkc6QlGh0ZQCvPz66gg4Rwr0ZwtiXuE2u76u0rf3cykjuhzh
         hdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yfeT04tjUL7ni0Yt8y/2t/fuxpmrzJm7LGRe7fQGzE=;
        b=Kw6iCOHfLmn6QfmyayF9gg9UvCsQOkUCIrUhhhImsvyBfrWp9aYKSKqrASTU3yHNjt
         0XqF5RkL7irP3j5iOeUmuTawEZM1IwNSWYcx6ZKIaakKd/T1LjCe4zJcHATv75RW8cgk
         jKCLXJrrceDVsCxIDCxCfR1D6O0OVNxZ8RYN2ktW1J3hB6XHYnpbUfFFZUDfk/nrzpGk
         l+QdhcJYhCRZ0q2Dr4VQ5HYcUCmL1tld55I1219nTXHdWDPvPDBDcRdcYuflRLjnwsMm
         T30msF/1U/jP3y9BdrlaWKLBlwycRpzAd9t7j8sh5m2GYg48NypepCjECHXUm1eW3YW8
         gXRA==
X-Gm-Message-State: AOAM532mIDo6egHpjtMLTHtNvfK4NmBTOrSdIiiW4pyWDjfU1ACal+cy
        U1zZ6tYBBPxJVB27mzOT1WDhwwLtwLrPUw==
X-Google-Smtp-Source: ABdhPJyAdbA8wN2UeAbOsI93HcBJOLw/Dv/Fzut774JJ7yspwylBcA0NOjnTcynazvYAPtzwmBJvMw==
X-Received: by 2002:ac2:410e:: with SMTP id b14mr2853493lfi.114.1628886134157;
        Fri, 13 Aug 2021 13:22:14 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id n8sm239853lfl.103.2021.08.13.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:22:13 -0700 (PDT)
Date:   Fri, 13 Aug 2021 23:22:12 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        ruslan.bilovol@gmail.com, mika.westerberg@linux.intel.com,
        maze@google.com, jj251510319013@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: optional SETUP/SET_REPORT mode
Message-ID: <20210813232212.5cba6d33@reki>
In-Reply-To: <20210813145823.GA38198@rowland.harvard.edu>
References: <20210813114551.72898-1-mdevaev@gmail.com>
        <20210813145823.GA38198@rowland.harvard.edu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
> In other words, a device does not need to have an interrupt-OUT 
> endpoint, but if it does have one then the host must use it.

You're right. Although the actual behavior of the hosts is not different
from what I wrote - they really just ignore out endpoint.
I will eventually fix this in the patch description.

> > However, this raises several problems.
> > 
> > (1) Some host OS drivers without OUT Endpoint support can't receive  
> 
> Can't _transmit_ output reports.  This is understandable, since such 
> hosts aren't compliant with the standard.

Thank you, this is a typo. With the replacement of the word, the meaning
is fixed. They really don't work. Hosts do not use OUT endpoint
and transmit reports.

> >     reports at all. In the case of the keyboard, it becomes impossible
> >     to get the status of the LEDs from the host OS.
> > 
> > (2) Some BIOSes and UEFIs not only don't support the OUT Endpoint,
> >     they cannot work with HID with this configuration at all.  
> 
> What configuration, exactly?  Do you mean that they can't work with 
> HID interfaces that include an interrupt-OUT endpoint?

Yep. They see OUT endpoint and refuse to use the device in various ways,
for example, they don't continue the initialization process after receiving
the descriptor. The failure behavior may differ, but it always leads to
a refuse or to the fact that the device simply does not poll IN endpoint.

> >     For example, absolutely all Apple UEFIs in all Macs can't handle
> >     the OUT Endpoint in accordance with the HID standard so it makes
> >     impossible to enter the Boot Menu using the hotkey at boot.  
> 
> These hosts simply give up when they see an HID interface with an 
> interrupt-OUT endpoint?  They don't just ignore it and continue on?

Exactly. Hosts will either stop the initialization process when they receive
a handle with an OUT endpoint, or they will not be able to work in any other way.

While investigating the problem with Apple, I realized that their UEFI
is presumably iterated over endpoints and simply does not break the loop
when an IN endpoint is detected. They reach OUT endpoint (which follows IN),
see that it is not IN endpoint, repeat the last initialization ops three times
(SET_IDLE, etc.) and refuse to work with our keyboard. If I change the order
of the endpoints in the descriptor and do OUT first and then IN, then everything
will work in the case of Apple, but this is obviously a violation of the standard,
since it explicitly describes the order of IN and then the optional OUT.

And it only helps with Apple. So the correct solution was to make SETUP/SET_REPORT
because this satisfies all devices. For the order of the endpoints, see 7.2 of HID 1.11:

> The HID class uses the standard request Get_Descriptor as described in the USB
> Specification ... That is, the order shall be:
> Configuration descriptor
>   Interface descriptor (specifying HID Class)
>     HID descriptor (associated with above Interface)
>       Endpoint descriptor (for HID Interrupt In Endpoint)
>       Optional Endpoint descriptor (for HID Interrupt Out Endpoint)

> Why not always allow f_hid to receive reports over ep0?  The HID 
> standard doesn't forbid this.

Previously, this was the case, but then this functionality was removed
for two reasons: using OUT endpoint takes up a USB channel less than SETUP
and allows you to transfer more data from HID gadget, and also allows you
to organize a queue. The queue could have been organized without this change,
but the first point is more significant. I found the correspondence
so that you can read the history of the issue, link below.

That change was not a problem as long as f_hid was mainly used for the keyboard
at the OS level. Now I am making an open source KVM-over-IP based on this
and the compatibility hell have risen to full height.

> Missing the SHA value of the commit.

99c515005857ff7d6cd5c2ba272ccab5dc0ea648

Also the descussion: https://www.spinics.net/lists/linux-usb/msg65494.html

Sorry, I couldn't find this on lore.kernel.org. Maybe I didn't search well,
or this correspondence is too old, 2012.
