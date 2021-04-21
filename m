Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AD36673C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhDUIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbhDUIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:46:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:45:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e5so11791782wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nF07lGmK8d790hYBNTxLzN+JqkeiBDMUtoFoxeafsPs=;
        b=PKuxgMvuAnY4j3XFS5LDSlKmE9K0hmcw+6xcrwyF5EYk7C+8Q8rY09FX5klV91bQ+H
         oxmSb48NV+BkZM2nurcQFUv1xeSoPd8ubDufrdjItZVFace8Vy9HXrRYrLCvASct4xst
         k2HVS4BbQnxp0VWuIYmqyQEC00n+oyX/PUzMbomZhrRxe1W5qS/8vi/xIpyFSfSRyQGR
         VD0ijrBlEJVy0twXMsrs3GbESBEL9NBaTOoV8sRIGfz8wN0dTLTFKO9tLjT7A+yyVTuj
         95XwzYTffbWs4+c3mq8VdLDECQASB+DEPMqJcnV/smKRAqP6IVD5PKCha4TOYf9mBp/n
         4DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nF07lGmK8d790hYBNTxLzN+JqkeiBDMUtoFoxeafsPs=;
        b=Ny5TKaaMqeOrYl6a2UpvK+RI+B2B5GtHsiprME6uu6p1/2n4Ski8bWKn1RboYxw27i
         Ir933lLVmJ4ZehCJgviiQr47+eGOfsrpzeQch9MRJR44oX00PytOCV1Qj7KJAsi89iuy
         0ycL6BLO7fTEGFM5FSUVyxbzgUQ+woXpi9AcRDTvM5Avbo79T0635DRYv6TgAlA7KCaM
         FlUg7zYjPbwRoOQm+5Q/uHXe5clza9sFuG6hwm4anwTZTXLt5YtfO7YAVR0vHqkd999N
         GPcqmNpqec6MIslxs0raJ9tBOL6lrqOWbOUGzdw1QGabwYRMURkI2VUiS/kjUxbJFRIQ
         1LHg==
X-Gm-Message-State: AOAM5337bJISEc3QvUJSSI1SK4feVp521tBZPaTq0vjfwgU9v/Hwc4MQ
        1zQUpikLB624dzpRLpazLWw80A==
X-Google-Smtp-Source: ABdhPJxLbEgvbfDHrIA7WnlMIVdZHppOGkiCV3bbFTTWBqmRn3tbZ6PUlt6yVY2Qyreu5khHX/9XXQ==
X-Received: by 2002:adf:f081:: with SMTP id n1mr25780163wro.137.1618994745796;
        Wed, 21 Apr 2021 01:45:45 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id s8sm2246313wrn.97.2021.04.21.01.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:45:45 -0700 (PDT)
Date:   Wed, 21 Apr 2021 08:45:42 +0000
From:   Quentin Perret <qperret@google.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Android Kernel Team <kernel-team@android.com>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v5.4 stable] arm: stm32: Regression observed on "no-map"
 reserved memory region
Message-ID: <YH/mNosARuC1KiuY@google.com>
References: <4a4734d6-49df-677b-71d3-b926c44d89a9@foss.st.com>
 <CAL_JsqKGG8E9Y53+az+5qAOOGiZRAA-aD-1tKB-hcOp+m3CJYw@mail.gmail.com>
 <001f8550-b625-17d2-85a6-98a483557c70@foss.st.com>
 <CAL_Jsq+LUPZFhXd+j-xM67rZB=pvEvZM+1sfckip0Lqq02PkZQ@mail.gmail.com>
 <CAMj1kXE2Mgr9CsAMnKXff+96xhDaE5OLeNhypHvpN815vZGZhQ@mail.gmail.com>
 <d7f9607a-9fcb-7ba2-6e39-03030da2deb0@gmail.com>
 <YH/ixPnHMxNo08mJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH/ixPnHMxNo08mJ@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 Apr 2021 at 08:31:00 (+0000), Quentin Perret wrote:
> FWIW I did test this on Qemu before posting. With 5.12-rc8 and a 1MiB
> no-map region at 0x80000000, I have the following:
> 
> 40000000-7fffffff : System RAM
>   40210000-417fffff : Kernel code
>   41800000-41daffff : reserved
>   41db0000-4210ffff : Kernel data
>   48000000-48008fff : reserved
> 80000000-800fffff : reserved
> 80100000-13fffffff : System RAM
>   fa000000-ffffffff : reserved
>   13b000000-13f5fffff : reserved
>   13f6de000-13f77dfff : reserved
>   13f77e000-13f77efff : reserved
>   13f77f000-13f7dafff : reserved
>   13f7dd000-13f7defff : reserved
>   13f7df000-13f7dffff : reserved
>   13f7e0000-13f7f3fff : reserved
>   13f7f4000-13f7fdfff : reserved
>   13f7fe000-13fffffff : reserved
> 
> If I remove the 'no-map' qualifier from DT, I get this:
> 
> 40000000-13fffffff : System RAM
>   40210000-417fffff : Kernel code
>   41800000-41daffff : reserved
>   41db0000-4210ffff : Kernel data
>   48000000-48008fff : reserved
>   80000000-800fffff : reserved
>   fa000000-ffffffff : reserved
>   13b000000-13f5fffff : reserved
>   13f6de000-13f77dfff : reserved
>   13f77e000-13f77efff : reserved
>   13f77f000-13f7dafff : reserved
>   13f7dd000-13f7defff : reserved
>   13f7df000-13f7dffff : reserved
>   13f7e0000-13f7f3fff : reserved
>   13f7f4000-13f7fdfff : reserved
>   13f7fe000-13fffffff : reserved
> 
> So this does seem to be working fine on my setup. I'll try again with
> 5.4 to see if I can repro.

I just ran the same experiment on v5.4.102 which is where the
regression was reported, and I'm seeing the same correct result...

> Also, 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove already
> reserved regions") looks more likely to cause the issue observed here,
> but that shouldn't be silent. I get the following error message in dmesg
> if I if place the no-map region on top of the kernel image:
> 
> OF: fdt: Reserved memory: failed to reserve memory for node 'foobar@40210000': base 0x0000000040210000, size 1 MiB
> 
> Is that triggering on your end?

So that really sounds like the cause of the issue here, though arguably
this should be indicative a something funny in the DT.

Thanks,
Quentin
