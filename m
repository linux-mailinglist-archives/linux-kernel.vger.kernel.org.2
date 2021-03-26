Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF734A997
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCZOW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCZOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:22:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:22:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b9so5803677wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jPrss6MgeIvEfu+cUNSjrJCOpcljezeh6+dDf7NPDa0=;
        b=NjVCbBdVhpCtF7cQoLz45keDeqicZaSTkXDP951der0x2QQYIp9fHHev6kcunhfpz6
         bUdkTdaiPd2oW5CwM83DHOv6FmDQCUbkZxXVzeOz3Qrd/FjNADrDk6oRM7POjoYXOPTT
         x7PNhS1oVP1P3xCW6vYeVjOCO7CA7bbiNY9Ik38D3mcwW9SCYHoqci7628F8tm57vSmm
         VO+NUhBWAh9mib0vaqb2FCXCjHfWhxHX0b8FhNx8eIMBdoF78kQ7/f3pD2QO8ovWqMwx
         uAAUplq3CihgzTk3bAjsK6w9XUzDrtieZd7xiYqxupACowD34HMzX3HWc0fo9RnjanJc
         elYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jPrss6MgeIvEfu+cUNSjrJCOpcljezeh6+dDf7NPDa0=;
        b=pcWRr/Bzkou7nxcybHd7gf6k7EiYOGgMpJYUNDa8n5ibVc6/WBZGLfd9XKNsBPdsCQ
         8U4pyFyzASeMDPIOKjGJAzUUVP7MP2jZeX25Ba6H3qpsrU0sC9TNd28jYKElB8POCcOF
         Snokl+anl8DRnyOX6cvaPPrpk9MseyLo6mcxi5FYXJZfPC7Pxv/C5mX+JE7+wPJTLNTn
         2VpfJs99cTrFMGeMZ1SzrJDrtwJBHx/byABqDwufsJVAVpcuw69QxmFpuLJOb9Ujag43
         So8SgZp9npTchaOKtFb0lvzMZJ0pVCJShYyH8fIpZcV24lfibCbgQhBuw7QLYN3eTrcJ
         tlVg==
X-Gm-Message-State: AOAM531+ATwBp39HwI7PZO2qu2wrYo+GzW5zkDmxdEPWvr4dki+OgZo8
        TcJos+xQQhyvU/+pB1wz52lhrQ==
X-Google-Smtp-Source: ABdhPJwZ8BOpa2TGeYwtefzDJ+tZQkFdJIoEeZ72w1wchMYOQ50a7VJGaZoN4pp7Dmug5Uv1b+VT2A==
X-Received: by 2002:adf:d207:: with SMTP id j7mr14783922wrh.150.1616768540289;
        Fri, 26 Mar 2021 07:22:20 -0700 (PDT)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id f16sm12744884wrt.21.2021.03.26.07.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:22:19 -0700 (PDT)
Date:   Fri, 26 Mar 2021 14:22:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anssi Hannula <anssi.hannula@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        Dario Pagani <dario.pagani.146+linuxk@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jiri Kosina <jikos@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kim Kuparinen <kimi.h.kuparinen@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, Lopez Casado <nlopezcasad@logitech.com>,
        "L. Vinyard, Jr" <rvinyard@cs.nmsu.edu>,
        Masaki Ota <masaki.ota@jp.alps.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        message to <vojtech@ucw.cz>,
        Michael Haboustak <mike-@cinci.rr.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Zhang Lixu <lixu.zhang@intel.com>
Subject: Re: [PATCH 00/25] Rid W=1 warnings from HID
Message-ID: <20210326142217.GA2916463@dell>
References: <20210324173404.66340-1-lee.jones@linaro.org>
 <20210326114202.3862b8c5@jic23-huawei>
 <20210326142041.GZ2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326142041.GZ2916463@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021, Lee Jones wrote:

> On Fri, 26 Mar 2021, Jonathan Cameron wrote:
> 
> > On Wed, 24 Mar 2021 17:33:39 +0000
> > Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > > This set is part of a larger effort attempting to clean-up W=1
> > > kernel builds, which are currently overwhelmingly riddled with
> > > niggly little warnings.
> > 
> > Lee, it's a bit novel to cc linux-iio on the cover letter but
> > none of the actual patches..  Or least none of them reached
> > me or lore.kernel.org
> 
> Looks like only 18 of the 25 actually made it onto the list.
> 
> How odd!

Ouch!  That's why then:

  4.3.0 Temporary System Problem.  Try again later (10). p19sm1466367edr.57 - gsmtp

> Hold on, I'll submit a [RESEND].
> 
> > I'm sure they are great :)
> 
> Naturally!
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
