Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C231C27B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBOTcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBOTcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:32:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55CBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:32:07 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 189so4754941pfy.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3nj9/R/NkkK99k6HujqpUsnIKZSJ7ODAWop9jG8uEo=;
        b=rlpr9Y17GqcS3VcCW+l+bS1nW3xiXbddJLqCQV49EqcSpGV+KSbl8a+FrYFs9PvSYs
         it8iWSpJw1gsM6AGOhmH5Acw2KmSdULF0CtLUbpv1I2R6STtXs02IIl8hkKiuQrTcClp
         gnpNivl1Mi0M80qg3y9K82mqykBBymTRSXTNI+7NyuKpk2tirw6/VycnssOaap/hbbRM
         aoyntdpV8PSwl9fmqwLS6X81BO88m0k21D/riSbB2g+a2Jud+lXOz+nB4Ew3UND3WIr2
         OpusKjkcH5p5Sf2vfYR7Obk5HSn1xhQe1A1Xn5XMmt5nQ6eZnXSjlWHxq4HTxliPGZwx
         aMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3nj9/R/NkkK99k6HujqpUsnIKZSJ7ODAWop9jG8uEo=;
        b=ixoYRrM4wdpWD5uOvYTISYprJ+EBHFBNtR+KBXw1KwenxkZ6M/f7J1jkZNBhYdswKF
         SWdAFu6Jb8Ug5dJeUTcrc0DtirDTp74MuvyGBhgBE+A0KGyFRMQBy6aBmSFHmpL97EZ3
         rMXK5jibfyZ05rM1wVP2aECKPqllzeGiupix4Qu0ZSFw3sBCpM1lYrqqBnpBHbO2vyJP
         l0xxdEg53qprxWoojht/xElv5ACD/suR0X+xyWKqlTg8SLV3Mux9AK8v9xZH1FGcuoQo
         NAXsPAMSnW80sp83tJWldaK8iSQe+UDBSTt32zfv31r2NJ00O0hU8T99HqDvUflFWsoL
         HFxg==
X-Gm-Message-State: AOAM532MdXG4MnAPCeLekWIFuXd85zQqmkgFAhrUN2lMJ9vvs3HYSMVi
        voOVbZyEBGYpSTLd+O/nEm1L4A==
X-Google-Smtp-Source: ABdhPJwYGpgEV2/GV9/dgnc2/rEWjl2dK3GYAnKQrXXgndNQF0w/cYvidbBIhC5ZupXR2KlChWCpFA==
X-Received: by 2002:a63:181e:: with SMTP id y30mr15574858pgl.324.1613417527139;
        Mon, 15 Feb 2021 11:32:07 -0800 (PST)
Received: from [192.168.72.184] (157-131-244-194.fiber.dynamic.sonic.net. [157.131.244.194])
        by smtp.gmail.com with ESMTPSA id y1sm196040pjt.37.2021.02.15.11.32.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2021 11:32:06 -0800 (PST)
Message-ID: <1613417521.3853.5.camel@chimera>
Subject: Re: [PATCH 1/4] add generic builtin command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Walker <danielwa@cisco.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        linuxppc-dev@lists.ozlabs.org, Daniel Walker <dwalker@fifo99.com>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Date:   Mon, 15 Feb 2021 11:32:01 -0800
In-Reply-To: <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
References: <20190319232448.45964-2-danielwa@cisco.com>
         <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
         <20190320232328.3bijcxek2yg43a25@zorba>
         <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
         <20190321151308.yt6uc3mxgppm5zko@zorba>
         <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 15:15 -0700, Andrew Morton wrote:
> On Thu, 21 Mar 2019 08:13:08 -0700 Daniel Walker <danielwa@cisco.com> wrote:
> > On Wed, Mar 20, 2019 at 08:14:33PM -0700, Andrew Morton wrote:
> > > The patches (or some version of them) are already in linux-next,
> > > which messes me up.  I'll disable them for now.
> >  
> > Those are from my tree, but I remove them when you picked up the series. The
> > next linux-next should not have them.
> 
> Yup, thanks, all looks good now.

This patchset is currently neither in mainline nor in -next. May I ask
what happened to it? Thanks.

