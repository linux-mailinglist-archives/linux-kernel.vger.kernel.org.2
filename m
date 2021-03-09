Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A354C332F97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhCIUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhCIUGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:06:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C8C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:06:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so4845981wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dHRmbrM3KWulojFZhNKV291nWkTUk3bmfohuz+F2Tcw=;
        b=auw2BJ+dQ7gOqzvAudyJMbYLSPCw7kh0jYY02Bb36lSiy77PvVB6yteSimyQWPdlnq
         xjGLoAFjbRG/574YhpD7GvJOihvw2KINedCN/aWkagYkliMMQR29L+N+WIwyTnKK0I44
         WzRQ/Ba72ZjQnpd7jkQswiXeLDZZe0T9pfDZZLz4jcigE3jdMiLdc9gUVjON5mF11JrP
         lDHwd+1wHBdDe7bwEUPT8S85Q3HSr4LtPopegzEzlSaJU4C0ka9C0kNwOkk2C7YCAsn1
         kM2AD6DWdSzN6UZcdC79ycSqKxZ2vJ1UBeTBFbCAvPmdMW6Q6w6s89fXIe5+A2XP2nc9
         FORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dHRmbrM3KWulojFZhNKV291nWkTUk3bmfohuz+F2Tcw=;
        b=YB9gNEwQRV7+WMfMq74ICYys4QEdMajkQIFUs7ghteS1NDYKPXCYTwBQtxkQZq1zHm
         sMOqPMRjl1Vb/Uk8z/Sd2468InqM2F26ZlotPF8mokoRjVVaxLEIRYnlMST4m2l4vklM
         jExORN6Kub7ZHApGSpv5qkOf/Vzd4kk39AvGHXd0+2UCpEdXg0lJY9jHdP88taMXfREm
         lIVCsbwWg0VJZXKLv/sOFFSvesb7ad6HO07yAUgGJNNqRk2aJdUvkHWU0xg7M9KEnDnH
         L4SQpyLDHcPt6zh5Cl26pd8pcHi0IGxwGlWalN/k/49AWM9iqJ1TjlLIkQ7NmH2mUFxA
         1Nfg==
X-Gm-Message-State: AOAM530cPI+7Mxa5QQKCKESEKVuf0HU2stsy5b1M/ye97aiLCyUJ3vB+
        +qGTsMuwBQt8Lek9M92a1pRX7g==
X-Google-Smtp-Source: ABdhPJww49mobpHvdor3/BRnqcZ6OmXfgHG6MTKfiMfuxXt5Do7WiWHFOYCUV0yxQC+PlTOygjrf+g==
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr5728195wmb.20.1615320373465;
        Tue, 09 Mar 2021 12:06:13 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id h20sm5401371wmb.1.2021.03.09.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 12:06:12 -0800 (PST)
Date:   Tue, 9 Mar 2021 20:06:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD and Platform/X86 due for
 the v5.13 merge window
Message-ID: <20210309200611.GB4931@dell>
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
 <20210224201005.1034005-1-david.e.box@linux.intel.com>
 <20210309181206.GT4931@dell>
 <4b282693-95c5-a738-e114-ae07f6e113fc@redhat.com>
 <20210309191701.GY4931@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309191701.GY4931@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021, Lee Jones wrote:

> On Tue, 09 Mar 2021, Hans de Goede wrote:
> 
> > Hi Lee,
> > 
> > On 3/9/21 7:12 PM, Lee Jones wrote:
> > > Enjoy!
> > > 
> > > The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> > > 
> > >   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> > 
> > I thought we were supposed to avoid using 5.12-rc1 as a base to avoid people
> > hitting the swapfile related disk-corruption when bisecting?
> > 
> > See: https://lwn.net/Articles/848431/
> 
> Interesting.  First I'd heard of it.
> 
> > So it might be better to redo this branch with 5.12-rc2 as a base ?
> 
> I already have 3 immutable branches based on -rc1.
> 
> Will need to look further into this to see what I can do.
> 
> Please bear with me.

Okay, discard this one.  I'll do another first thing.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
