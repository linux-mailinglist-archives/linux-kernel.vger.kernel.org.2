Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF013F3900
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 08:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhHUGc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 02:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhHUGc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 02:32:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868EC061575;
        Fri, 20 Aug 2021 23:31:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so17423586wrs.0;
        Fri, 20 Aug 2021 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nJe+VaUQYca4KABO1XS982WELsgGiKMA/OFGfeoypuY=;
        b=VkPrpg+PFX6FsOJ99Xxme6dUQFWOFu/uJgzinQVsjBJUxHfA/nstQYe3DhEYQ0rk59
         S+PfxDR3WHwumZuXGI2hZTd4RezEpXuEwaIB0zPJgia/+B+I/+5D4ohIfJZVNmbkGHVd
         KHr4RAXgENrthm3YFZ4JLLo8j29HpNSQNNPR4Y1DfnF0J3TqyOX0Y/iQExWdEm0Thz/5
         raKonaMVisWkl23MTJ5c+nWiorxPJ4jDJb8jjwqEMyOIG/kMLIrMwtkiqh0IV+Odme3S
         i5oZ+3vYMU7LlBQexIplRig1nzRuRAlaZEwR+U8h4HnVY6a/JmbZYkLHniHJOX+qOVLM
         Rutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nJe+VaUQYca4KABO1XS982WELsgGiKMA/OFGfeoypuY=;
        b=C44zVjFqvs8zrHgZehnA2FDQ/fmM4WKCr8+SgoaO1c3R063UMseJcMqZko0cdMQkHO
         nVmFCksegDM1sFA8KJXVFLxyp5b5NPeB+pIuDa1e+OZg1EV/waNXReWQeLwGHqO006t9
         beT/gJ4GN8LiLfcKF30ds1Tw0YXh/WX3UNZ8tMrrLlqo2bUxYooz5N8CYVyangl01Ld2
         rePau4qiEh5zSjOha1Be3ZpkUo8yo4jRQ2Gw8Q+6EeCyjFy0MMWHUWwMF3Oe0unw+2LD
         AaF4wqy664JbVhlo8z5hsjV6qcQZ518hpAGlwzzmrtwhFTWOT0LKSe8TeljvO+KzvujD
         /Gmw==
X-Gm-Message-State: AOAM5310kBuAtJ3lmxHL8OexyOrJGOqWoDVVzcG7gn6RukcJq/ch2fyM
        CUEdwVHI4HrXQZIEmjeuB0Q=
X-Google-Smtp-Source: ABdhPJxlL7UgiNMPo1Z2ex6GQDB9brsG5Fx06AQ8ms5jxoBFHW3TQjd9lrqoN5OMj7jj0etQPxCTUw==
X-Received: by 2002:a05:6000:12cf:: with SMTP id l15mr2306999wrx.381.1629527507953;
        Fri, 20 Aug 2021 23:31:47 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id o7sm6858616wmc.46.2021.08.20.23.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 23:31:46 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 21 Aug 2021 08:31:45 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Ian Turner <vectro@vectro.org>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <YSCd0aBXNX4rj3Vb@eldamar.lan>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
 <20201028091043.GC1947336@kroah.com>
 <20201106104725.GC2785199@kroah.com>
 <YR+nwZtz9CQuyTn+@lorien.valinor.li>
 <077990d1e354777c4c6a33866a0916bed6a97ed5.camel@sipsolutions.net>
 <bd81136b-3b52-fbda-780a-9dc58bdeb268@vectro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd81136b-3b52-fbda-780a-9dc58bdeb268@vectro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, Aug 20, 2021 at 07:08:57PM -0400, Ian Turner wrote:
> On 8/20/21 9:29 AM, Benjamin Berg wrote:
> > On Fri, 2021-08-20 at 15:01 +0200, Salvatore Bonaccorso wrote:
> > > At least one user in Debian (https://bugs.debian.org/992004) would be
> > > happy to have those backported as well to the 5.10.y series (which we
> > > will pick up).
> > > 
> > > So if Benjamin ack's this, this would be great to have in 5.10.y.
> > Sure, it is reasonable to pull it into 5.10. At the time it just seemed
> > to me that it was enough of a corner case to not bother.
> > 
> > Note that there was a somewhat related fix later on (for Qualcomm UCSI
> > firmware), which probably makes sense to pull in too then.
> > 
> > Including Bjorn into the CC list for that.
> > 
> > commit 8c9b3caab3ac26db1da00b8117901640c55a69dd
> > Author: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Date:   Sat May 15 21:09:53 2021 -0700
> > 
> >      usb: typec: ucsi: Clear pending after acking connector change
> > Benjamin
> 
> I feel that I should mention that I haven't actually tested this change, so
> it's just conjecture on my part that it would fix my issue (though it does
> seem to track pretty closely). I am happy to do that testing if it would
> save others time.

Ah apologies, I was under the impression that you confirmed that this
was already the right fix. It is pretty close to what you describe, so
if you can additionally confirm the fix, that would be great.

Regards,
Salvatore
