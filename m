Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E435B3186B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBKJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhBKJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:04:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8848C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:03:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u16so1010507wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z771/bm/kXqOy0/vLLlH9QpmLWs+tJ8/KNoncxwMUdo=;
        b=iULsp7rOOuJLQncHYPd54EX205A/wgn9LMEkoMuShflKsb5D8OIM8LXcLjk9SNZGpu
         wLWaUKvu/emYslAAkS4BDAAenbJoM4KSIdu3PdDWq7qdPZtIhQJ8ZLLOsdkpmunQ3wDv
         mIsxhljXVZ+jouSJa6N/DQfubgE9yTzWyNJXma/4iy4sOw8nr79a7wPi5xf6W2I3Nzmn
         XPGlu5HofT8C5c3VZMUME+k3qfGgeSKRLhBUhXhEoz2udg7F4XMdDz9t9zPhi1BeMyNU
         k3032vRBpRe5wplW3VA1uZgXHIWm2zXt6ElYGSqweaco9sypWK7csanRSnn7jA1niSIq
         lGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z771/bm/kXqOy0/vLLlH9QpmLWs+tJ8/KNoncxwMUdo=;
        b=AyDvksqxx08O2r0Cz7xcKJnIHZ6ymb8sDSy81eWZTbjpZTzTZoJQYWWS0ETh/HLj21
         EspL1CgvSeTfZ8opU4l18A3nCOdyzYjIIEORKJcwGNRZ5H1Y9td/ly4seXwcmd1bW4Xb
         V9D17ibFcy/GONElzzUK4Q+M+cJLj5FrwSL8zO0Xga5n/L4ZnMN/2ada+UvdhYpzYF07
         1CLzTCxkxHJfPWdvul11ZV4sb1WGY0jwDEw/bIX80csV3iFL1EtAA5bd1HR5Qx/wam09
         ImuSwitSK8tvmJXJE4mgnW0Q/HqW/2vRflHYVhTCgbTwMY6+fpIk91615jorAlfK3lLo
         dVGg==
X-Gm-Message-State: AOAM532ThSvCtZlQwzFIkKE+yPGCBIoqb5z0AQ4m5Swo5YpC1w9WJF7Y
        cg5Ni1ao9z1O61yCY0L4HzfI8w==
X-Google-Smtp-Source: ABdhPJyYzHOUDG2VHz5DvpRbcSCzV+wNS/9Vt1wgJnvrlbMZklHtaHiVCC1YXNpeF+zeoqW/CRkn8w==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr4105035wmi.148.1613034210472;
        Thu, 11 Feb 2021 01:03:30 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id y63sm8731001wmd.21.2021.02.11.01.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 01:03:29 -0800 (PST)
Date:   Thu, 11 Feb 2021 09:03:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [RESEND PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx
 drivers maintainer
Message-ID: <20210211090327.GB4572@dell>
References: <20210210172908.336537-1-krzk@kernel.org>
 <1b31c98b-2344-c502-6071-89b9d4a886a5@ti.com>
 <20210210173632.fcbmzk4zdcwb5kps@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210173632.fcbmzk4zdcwb5kps@kozik-lap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021, Krzysztof Kozlowski wrote:

> On Wed, Feb 10, 2021 at 11:33:49AM -0600, Dan Murphy wrote:
> > Krzysztof
> > 
> > On 2/10/21 11:29 AM, Krzysztof Kozlowski wrote:
> > > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > > credits and add Dan Murphy from TI to look after:
> > >   - TI LP855x backlight driver,
> > >   - TI LP8727 charger driver,
> > >   - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Cc: Dan Murphy <dmurphy@ti.com>
> > 
> > Unfortunately I need to remove my ACK.  My TI email will be disabled this
> > Friday.
> > 
> > No replacement has been identified
> 
> Ah, then I propose to mark entries as orphaned - without any maintainer.
> Other option is to remove them entirely so they will be covered by
> regular power supply entry.
> 
> Any preferences here?

Counter-proposal: Since they are driver-level entries, just remove
them altogether.  They are not orphaned as they will still come under
the subsystem umbrella.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
