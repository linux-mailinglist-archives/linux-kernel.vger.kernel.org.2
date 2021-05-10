Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043F3780DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEJKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:10:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0401CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:09:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t18so15983642wry.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lak2E9+GUDiZzQG7k+ylmHyUCfztik4DxRUQZhkU5ro=;
        b=nsMo1rF1vPg3fCmcCDlqdsBsdgZ5+6CPz5Gu0r6CwIQYLumGthyt4retDR0aK4EgUP
         yyKicUUKjZfNGMwp9Q0WmSB2nM0M8EtUXosj6TV7arw7hetwGwzyEL9V2JyujJyOgFm7
         DSY77eZhkenaZf0E88XJEdkhM7bfP3/fGsFTsdSYmy5/h4FX7UmG/PDKoQB3zo1Z1P+F
         /3uhv17qjoVThYO5j0SJ7dRrNk2xaSwqt0qJLiLjKEQKd8e8m4vVj0C/yeXfUUoSY2ud
         U11cMdSApBnhI1JXzwXYzOEOynxCi1+daV9oN+LrTugJsh/Vt44kRT/WdQJ0jvRMrAg2
         s8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lak2E9+GUDiZzQG7k+ylmHyUCfztik4DxRUQZhkU5ro=;
        b=OjwTdqMLk4NfxCwstRTD0Nd6UsLg8+zBKb0ExtAUNGwnIA0GNmlAKKGu54d4SIuyWv
         1AfqmDiMzim8vy+2oWz6hr/OCTETyADZKeL3VK2sNUQUEl/P/S0kyxDDZ74PuVmsdtDL
         7IMWG79ykF4RefUKH2RvGvXUIwbM6QM33cwJGKstc4XeRoHwPvxbkwPDwPPkv0fL2QAX
         mGlaWy8lHDnVCZXl7sg48C9VcXt0cNUiBNy7QFHdh32M99LjXcymAGOE28OVl71Nm5pt
         Md7QjtSgexVDvaxM/9K9oqbuQhecowxunV8bPfr8kuZxuHfPID8RGbhYzRq5heOo5B+a
         xz3w==
X-Gm-Message-State: AOAM533G3SiiMGcUYfY8Dbkv3us44BY6QetriS4ylbyqdxCjPw3y+rnY
        +BTJGuuBzQd97Ybx4BTB5xCO3w==
X-Google-Smtp-Source: ABdhPJz3z5wg+OafyD48OYDvMBz7h7pieXW/43X8WIeydnOfIZSxiOuGs4DIsfygLyGkonGdYzcN6A==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr29569846wro.293.1620641356622;
        Mon, 10 May 2021 03:09:16 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n5sm22274941wrx.31.2021.05.10.03.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:09:16 -0700 (PDT)
Date:   Mon, 10 May 2021 10:09:13 +0000
From:   Quentin Perret <qperret@google.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <YJkGSb72aKg6ScGo@google.com>
References: <4a4734d6-49df-677b-71d3-b926c44d89a9@foss.st.com>
 <CAL_JsqKGG8E9Y53+az+5qAOOGiZRAA-aD-1tKB-hcOp+m3CJYw@mail.gmail.com>
 <001f8550-b625-17d2-85a6-98a483557c70@foss.st.com>
 <CAL_Jsq+LUPZFhXd+j-xM67rZB=pvEvZM+1sfckip0Lqq02PkZQ@mail.gmail.com>
 <CAMj1kXE2Mgr9CsAMnKXff+96xhDaE5OLeNhypHvpN815vZGZhQ@mail.gmail.com>
 <d7f9607a-9fcb-7ba2-6e39-03030da2deb0@gmail.com>
 <YH/ixPnHMxNo08mJ@google.com>
 <cc8f96a4-6c85-b869-d3cf-5dc543982054@gmail.com>
 <YIFzMkW+tXonTf0K@google.com>
 <ad90b2bb-0fab-9f06-28dd-038e8005490b@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad90b2bb-0fab-9f06-28dd-038e8005490b@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Friday 07 May 2021 at 17:15:20 (+0200), Alexandre TORGUE wrote:
> Did you get time to continue some tests on this issue ?

I did try a few things, but still fail to reproduced :/

> On my side this DT is not working:
> 
> memory@c0000000 {
>         reg = <0xc0000000 0x20000000>;
> };
> 
> reserved-memory {
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges;
> 
>         gpu_reserved: gpu@d4000000 {
>                 reg = <0xd4000000 0x4000000>;
>                 no-map;
>         };
> };

So this does change how memory appears in /proc/iomem for me switching
from 5.4.101 to v5.4.102 -- for the former d4000000-d7ffffff doesn't
appear at all, and for the latter it appears as 'reserved'.

But still, it never gets accounted as System RAM for me ...

> Let me know if I can help.

Could you please confirm you get a correct behaviour with 5.10.31 like
Florian? If so, then bisecting to figure out what we're missing in older
LTSes would help, but again it feels like we should just revert -- this
wasn't really a fix in the first place.

Thanks,
Quentin
