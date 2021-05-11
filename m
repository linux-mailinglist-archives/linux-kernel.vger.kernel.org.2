Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C258379CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEKCdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKCdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:33:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A3C061574;
        Mon, 10 May 2021 19:32:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v12so18499823wrq.6;
        Mon, 10 May 2021 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/+vS3STyzsuRrA5ULZ0b5xvOuXc+zqUV+MLKt6AlCR0=;
        b=q+7H9pPng+5qxH0InZN+bqanKx3JKfp4yajEtsnA88mdvmVXtVD+ZoPO4vcQGyroY6
         GCwceu/0iqIJ0eZkoGaqcQnFx+KRtw8WcV1y4j2hEjoMLNNoflYovNXY0HVT+2iHIiv4
         4DCPxiJoUc7eHMeKdhZ234W/CuwDF5fu2yODwMnkYq5RLRaJTnAYSIUhQBetUeP5klxf
         8qqBc1SU2zbBsAonHf4ZXrJ+iti0DglydM1/VwKayh1Ub0uZoxo4Ehw2RKWYDR58+DR1
         bESrLIIX6FaebxiIy31D47XLtrnjbRzBAjMVaDOwbk3VU7cpZg5NG5t5Zf+lyR66PswT
         4Awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+vS3STyzsuRrA5ULZ0b5xvOuXc+zqUV+MLKt6AlCR0=;
        b=VrUf19A6kzUmwXCVjv7fLlLAqR2M+q0tC+N8fOw9ZTWybksvcdiRYdG0io+Ae6eFCG
         NF11ptnuYAUVDqHRMFsjk3UGOUzMAu5/EX8dgp1LWyIu5BjQ6H+tl4Eq/tuEyq/c8nY/
         nloLlGXxbu/5bqG9oyEXabdaF2N+v/uoGmnq2S0SX1WKwMWYKLa+dBD57iB8ZxsRX8Ct
         JOPtpHEs1uY/MyEvZ6yqd6IF1cCwKfBUb4Kq4u6Iz45IS8lpuMAKaa+45/SKAHELJTsK
         3ADfrmHCjcrmf8a2tlomWfUfzxe/xkRty0fw/R0D9htJq4a67JpXb4s44yb+9toBp5cU
         XInA==
X-Gm-Message-State: AOAM530RvbxWgDFr2Qu/IIZ/MmWC0vsVLW27kXox7HXhXaEl8t522b0k
        9DZdRU4aN4+/zNTDC/mAd0E=
X-Google-Smtp-Source: ABdhPJxPjt1eyqE/Zfj1O2V+poyu98BDQTYs0vA0tz9komJip5ET1xFqdGfAWbqxzhfhEtALlQt+uA==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr34477639wrs.17.1620700356668;
        Mon, 10 May 2021 19:32:36 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.gmail.com with ESMTPSA id z6sm21597526wmf.9.2021.05.10.19.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 19:32:36 -0700 (PDT)
Date:   Tue, 11 May 2021 04:32:34 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: Enlarge IO_SPACE_LIMIT needed for some SoC
Message-ID: <YJnswvYFUjlNS7Fa@Ansuel-xps.localdomain>
References: <20210511021656.17719-1-ansuelsmth@gmail.com>
 <YJnq3Y3/I1kdV1Ov@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJnq3Y3/I1kdV1Ov@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 03:24:29AM +0100, Matthew Wilcox wrote:
> On Tue, May 11, 2021 at 04:16:54AM +0200, Ansuel Smith wrote:
> > Ipq8064 SoC requires larger IO_SPACE_LIMIT on second and third pci port.
> 
> Do you really?  I mean, yes, theoretically, I understand it, the
> hardware supports 64kB of I/O port space per root port.  But I/O
> port space is rather deprecated these days.  My laptop has precisely
> two devices with I/O ports, one with 64 bytes and the other with 32
> bytes.  Would you really suffer by allocating 16kB of I/O port
> space to each root port?

We were talking about this in the other wrong patch. I also think this
much space looks wrong. The current ipq806x dts have this space so it's
actually broken from a long time. The only reason pci worked before was
because the pci driver didn't actually check if the settings were right.
New kernel introduced more checks and this problem showed up. (to be
more precise, the pci port are commonly used by the ath10k wifi and the
second ath10k wifi fails to init because of this problem)
If you can give me any hint on how to check if the space can be reduced
I would be very happy to investigate it.
In the driver I notice that the max buffer is set to 2k, could be this a
hint?

