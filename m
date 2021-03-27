Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96A34B40C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 04:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhC0D3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhC0D3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:29:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DFCC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 20:29:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h20so1831654plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 20:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XtPWAZA9eTLzUykFCimEArM4fZDHqFEi9LTCa54qAS4=;
        b=ewCD38hdt+uMPe8ie3aNETXbNM0h992GPd/XUVPqG25npRQuY+3xBaahlCBBeRQvbU
         Ohf4En5goontX+dGez6YO9SV9Iz2P8VUICw+oZW0hZUEmNzvZV3baoef33uvrqZzbtS0
         CNc53HRRc/r7i5OtPlrYXEovFeEmcO+OvNBqOcLEKFQVibq8f0UjglRQ9VvVFWESVIex
         LpsJmTx0/2Jr06l8DEgoyZcV3AJapUWc8WdpvP0CZt/ZaGMIcWj5D2arPwdBDPjM1GLV
         id9WvyepH/nR5BVHUEeAbkK3bu2Lj2wEiyWMqbzAoA4JSOZCmUqn/7TWyvXDMef3NGdp
         FCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XtPWAZA9eTLzUykFCimEArM4fZDHqFEi9LTCa54qAS4=;
        b=TmJ8/y6la7hu4Zbk3rzS1NzmZAUkMnFhWe/7aC+YhTP5ttTIuvrasx9hvgRrpwLz8i
         QS8gyWkElb4QpwbzhEujWiIguWct+pUp1ZFTWfjxIhIxexWNjkWo2gzY6n/M2PUBk5H+
         NhI7RsQmrWQkuS9oso4crvrlqK9AcAcbrBRcay0EBJ2j3U3lbsnEBlQhpgl9pBNysodx
         Bt1aClHS+868i4Na/IM7N1iF1+GWz0qkF6i9WwC5mZBlTHZ3R8UDmQg5DpW8Ohifzejd
         tux5V2IQG1GFYcfZj8fJ3bGsMheUEDSf7sbxz+93xcE2/caIWRmPaQaghGZ0AYzVn7iS
         kTMA==
X-Gm-Message-State: AOAM533URXop6kiQq5jbobkZlEZ0k9nw6jEmP77Vzk4QyHBJ8zJoylmJ
        H/gpBDRWZGGAw/dgKhT69M8=
X-Google-Smtp-Source: ABdhPJx+f0rPIXJh9LcPnDL7dF8Kld3VQl/T/PUrJTlseyVn1uST7VLq57MqWBdKiWS32Ldz1B5Ebw==
X-Received: by 2002:a17:90b:ed0:: with SMTP id gz16mr16494077pjb.106.1616815742626;
        Fri, 26 Mar 2021 20:29:02 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:48:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id k127sm10541907pfd.63.2021.03.26.20.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 20:29:02 -0700 (PDT)
Date:   Fri, 26 Mar 2021 20:28:59 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daphne Preston-Kendall <dpk@nonceword.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an
 error when TAI has not been configured
Message-ID: <20210327032859.GA3168@hoboy.vegasvil.org>
References: <87sg4iupzs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg4iupzs.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:13:43PM +0100, Thomas Gleixner wrote:
> On Sat, Mar 13 2021 at 17:44, bugzilla-daemon wrote:
> > Unfortunately, although the majority of distributions ship with a leap
> > second file from the zoneinfo database, many or most of them (I have
> > Arch here) do not configure ntpd to know about it, so ntpd does not
> > set things up properly for CLOCK_TAI to work.

I'm not sure about "many or most" distros.  In Debian, the ntp package
depends on tzdata, and the default /etc/ntp.conf does use the leap
seconds file.

> That would be a user visible change and might hit existing user space by
> surprise, so that's not a necessarily a good option.

Agreed.
 
> and the kernel on it's own has no way to check for and retrieve an
> up-to-date version. That's why it is delegated to user space.

Right, the kernel can't make any assumptions about the TAI-UTC offset.

> I hope the NTP/TAI wizards have some more insight/opinions on this.

I agree that ntpd and the current distros don't handle this very well,
but all the pieces are there to allow user space to handle TAI and
leap seconds as reasonably as possible.  The fundamental issue is that
there is no way to determine the TAI-UTC offset without some kind of
input from the real world.

Even with GPS, after a cold boot you cannot know the offset
immediately, because the leap second information is broadcast in the
almanac only every 12.5 minutes, and so you can be left in suspense
for a long time.

Using ntpd on Debian, the service will set the offset, but only after
synchronization with the upstream server has been established, and
this takes about five minutes, IIRC.

If waiting 5 or 12.5 minutes is too long for your requirements, you
can boot strap the time from RTC [1] and then consult the leap seconds
table [2] to set the TAI-UTC offset in the kernel via adjtimex().

Unfortunately there is no user space utility for setting TAI-UTC, but
I hacked one 'adjtimex' program for this purpose:

    https://github.com/richardcochran/ntpclient-2015

Getting back to the original point of the kernel returning an error,
I don't see a need for this.  Applications that require correct leap
seconds can simply call adjtimex() and wait until the initial zero
value is changed by ntpd/etc to the correct offset.  That isn't
fundamentally harder than calling clock_gettime() and waiting until
the error would go away.

Thanks,
Richard

1. Assuming the RTC was set and has a fresh battery, and assuming no
   leap seconds occurred while your computer was off!

2. Assuming the RTC value is not newer than the expiration date of the
   leap seconds file.



