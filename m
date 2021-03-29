Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9A34D248
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhC2OV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2OVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:21:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7113DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:21:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t20so4463071plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cDnq1q/ixaVc6yHqM4JadYnjCDMnNs61XGSyJlHYRyk=;
        b=H3whbVbFholAqsAFuvE5aKB4O0j6HZRSQkOH1Lbo2CZvs8Tn6pJCAWdTBhgI6cWryY
         AKc+CF+ytasxVg7EPkmzQVmZUdOkt5dYfk2/w2H34X2fYN3+BCm5li8sacGt+wEKxono
         UumcHsGW4RspbwyCmboTuvV2loHyNPM0J3QMfysZxBa6fbm7Ziqdjif6DfEIkntDIjNo
         rv2mwBeAVM22D1I2kCR2CiWEApdVWdvyKazNZO973AYbBoqj0wZSew05tU02L4RZO5ub
         icSj/1+a2GlnId1eruP7Y4wmNBKP6TufMfxgrHfZl4Igxvm0GCBjssxJKvAzBHU07DD6
         +ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cDnq1q/ixaVc6yHqM4JadYnjCDMnNs61XGSyJlHYRyk=;
        b=IbpwWs3VDfeH/vCjHAqShJP/8Ud7n5WHBU/nwxS4cDEa/0aZRRl1wLQ7IwYaqiLqaJ
         3jOS1RFZ2RcXC2Wfmk85tYl+gYzeNUZgVnI7R1svlQ8nNEP3be19gpVtooctcrrE0c47
         VXVVoLbRazgk+dVWYwdyOCVgojJlNDn/qAM4vA8LHF5TBnfczkOIXrUnvL17MlFWvomb
         Jh60f1DaN2/vuucv+uWPTvZK3FoNKtWpZe6Utb4RqbrIm/3M9a4q4o5o/0o2dJKRVmKx
         /o55c+cL6RRKYwF+35JHebnwfpsL6BI8EMfsVDZPNvPU1x8uWwBVS0NVn8ZGFb4mWb4k
         KxKA==
X-Gm-Message-State: AOAM531lcFI745DRBVqyx4Q64kzHbDepUz1xHlSRQJypJfD3pDJ5eTzV
        VPEFxdlT+E0uhUdxiNxFAQw=
X-Google-Smtp-Source: ABdhPJyMfesfAI+aeZ8X5IYw6bq3nvO6ogxfTIzFkCMwUSimERD+wU0BC02VyGiVZerlz3W1EUAj0g==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr25983414pjq.94.1617027684948;
        Mon, 29 Mar 2021 07:21:24 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:3c:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id i14sm8322554pgl.79.2021.03.29.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:21:24 -0700 (PDT)
Date:   Mon, 29 Mar 2021 07:21:22 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daphne Preston-Kendall <dpk@nonceword.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an
 error when TAI has not been configured
Message-ID: <20210329142122.GB20909@hoboy.vegasvil.org>
References: <87sg4iupzs.fsf@nanos.tec.linutronix.de>
 <20210327032859.GA3168@hoboy.vegasvil.org>
 <YGGbAIoCKDbZLQQ0@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGGbAIoCKDbZLQQ0@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:16:48AM +0200, Miroslav Lichvar wrote:
> On Fri, Mar 26, 2021 at 08:28:59PM -0700, Richard Cochran wrote:
> > Using ntpd on Debian, the service will set the offset, but only after
> > synchronization with the upstream server has been established, and
> > this takes about five minutes, IIRC.
> 
> With the iburst option it shouldn't take more than 10 seconds. There
> might be an issue wrt stepping the clock when the initial offset is
> large.

Really?  Debian has 

    # pool.ntp.org maps to about 1000 low-stratum NTP servers.  Your server will
    # pick a different set every time it starts up.  Please consider joining the
    # pool: <http://www.pool.ntp.org/join.html>
    pool 0.debian.pool.ntp.org iburst
    pool 1.debian.pool.ntp.org iburst
    pool 2.debian.pool.ntp.org iburst
    pool 3.debian.pool.ntp.org iburst

I guess I'll measure again, but I'm pretty sure it took a long time to
get to TAI being set.

> In Fedora and derived distros using chrony by default the
> TAI-UTC offset should be set right on the first update of the clock as
> expected.

(Maybe it is time to switch to chrony ;)

Thanks,
Richard
