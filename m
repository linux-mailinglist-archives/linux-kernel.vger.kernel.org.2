Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF349458E07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhKVMKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhKVMKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:10:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80953C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 04:07:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso16519058wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 04:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I/lns3JozvdBWsG5gLpvC9TjVferBOu8G0kcSRzZQCI=;
        b=RZ31e18lUbsrENkBf1dLNPvKUWacSJQrJL7FN3F01jZ9/3tJsEdiN0VqajjN3ykAhE
         qEKMGQy5rKTEbI09opmPZG6wNS0WMllO2SWDPRBVEVPFqMnHVekkyYRM5Qkobb0J0Up0
         0lPEP87Bi3cXxCEnVUmvgv8l3usiAMxXPAIpX2j94bHQip//yKuER/GbMmQpGdOPQoJ5
         f4Igld+Wcbpbzk2ezT23BF/Z69oPgd04Ts7u/yIxER1TokmX4h3/aYXVthkyVVkVVtiZ
         EgQvvOtCRIMma6iubYGwtkTKCcG4eTG26wPwZAxT0V5ARggV3Qf2FPQctwmV+Xhn1VqD
         B0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I/lns3JozvdBWsG5gLpvC9TjVferBOu8G0kcSRzZQCI=;
        b=A/sbVXFU2YeXCsPouIrdvGFjEaMjJ2nxb1m43/vEJmnFkTecSfmk0Rufy6ivxJrHDN
         1FddF19pTuOrpixOEmPkOATS4nNotoDyH9CVwD6K3bmPoF+smnRrlBZEkj3HwXzemclZ
         LEfNHpcbKdGOQ1mVGPrS/WzcLBiU1IShCtTc+23BDgNRexkmbNQmQrkgWcPqvu/J4o1Y
         tpNskaOv7qjSsNPSre7cg1IISjjgp1L32nmJRS1dPki9fq7eva0qSaNqEUTw3w1EUg3M
         tnX5l1NX0SzG3oAXhUtTQ1NZLdWp0ZfgbSaGjj0Yvco5vicNy4tzdUqV0q+AHrgWawSx
         ptIQ==
X-Gm-Message-State: AOAM531oV9aSIWVg4wznSb3elEuAkax2/89xtawYF1Xe4DcQhKu3gpN2
        FSTYFzmovMSKaWg4tgbt5J8=
X-Google-Smtp-Source: ABdhPJyiZ5R8a8GqNkJdUjIoIZBg4q1RiL+lX3GpBascwmgyappv5NtfGTonomEl1+rTn4NIPxHeSA==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr28320984wme.116.1637582863090;
        Mon, 22 Nov 2021 04:07:43 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id u14sm8839589wrt.49.2021.11.22.04.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 04:07:42 -0800 (PST)
Message-ID: <45e55a35-759b-fcb7-40cb-f29a27ed3693@gmail.com>
Date:   Mon, 22 Nov 2021 13:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 00/20] Add memberof(), split headers, and simplify code
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
 <YZt8PdBH5JcWTurH@smile.fi.intel.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YZt8PdBH5JcWTurH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/21 12:17, Andy Shevchenko wrote:
> 
> What happens to the indentation in your emails?!
> It looks like a bad poem :-)

Ahh, hehe!

It's a habit of writing manual pages source code.  It makes it easier to 
edit the ideas while writing.

Recently, I learned that this goes back to Kernighan:

     Brian W. Kernighan, 1974 [UNIX For Beginners]:

     [
     Hints for Preparing Documents

     Most documents go through several versions
     (always more than you expected)
     before they are finally finished.
     Accordingly,
     you should do whatever possible
     to make the job of changing them easy.

     First,
     when you do the purely mechanical operations of typing,
     type so subsequent editing will be easy.
     Start each sentence on a new line.
     Make lines short,
     and break lines at natural places,
     such as after commas and semicolons,
     rather than randomly.
     Since most people change documents
     by rewriting phrases and
     adding, deleting and rearranging sentences,
     these precautions simplify any editing you have to do later.
     ]

See <https://rhodesmill.org/brandon/2012/one-sentence-per-line/>.

> 
> On top of that, never start a new thread inside the previous one.
> 

ACK.

Thanks,
Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
