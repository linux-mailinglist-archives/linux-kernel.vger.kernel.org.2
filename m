Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD2345C03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCWKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhCWKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:35:22 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66852C061574;
        Tue, 23 Mar 2021 03:35:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r17so11250095pgi.0;
        Tue, 23 Mar 2021 03:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWAvqft9JedT2B96X6yHK5pb6yvAkoVdHbtPbK/yIfw=;
        b=ifyW8P+mSBCOQbXmxOGwhvFPTFvCwpMJxsbmwKDiWFf5CHyBK+grJ6e1WOobrFHvLA
         eBzy/+4IVausTeE02KYech/kFIRG1Je5eGdI1CMFHhCNiQP6BtcL76P3SjYS9M4l3sxS
         ScfDHn7+OIZifE8BGr6UZKO39/i9Hh27+6h3febVo88l+Fx7A4cFqq1y1wAFBvm0c1+/
         Boiy7vPzLU2JINrZ+Ld1yx2s82p601Ue/ylGZGTh9EV0YTyc99GYn/lmfS3LmIdoMDNe
         sGPHKqN0oEfXPQl6jC034Z+INZ8S2/U3tmGTspZ75PmeWZxBEKqdcdvtXtlckpiD6e/A
         0ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWAvqft9JedT2B96X6yHK5pb6yvAkoVdHbtPbK/yIfw=;
        b=rlhn/bm3uzQIFLC2jSM5ia8h5TwlvcOQhikJ0raQJOHlzm5dqMGG2OA06NaETkUz7J
         T1n46VL/Y2hjRLuxD5tzUm9kdoxLRVQmYWxF6DOoDnICrLNL4B+rZSustfuNQU91s7/p
         yH6J09U++6XLSCAHYYZaWWbQknOYZcT5XCGgkzRnnW6/cj52l3GMXFiMtzhU2p/elSOn
         bPBT6hCnz+McYIFQ7VKGcQfFSnpbCeplhmHzG/OfytMANJM1bWoyMQQM083pvsayfoye
         qrfewceS1NFaqn4XF0er/JfDoVLR3x8cQuMyH6dufLL3CyxwsE91d9zuAEDmL5RB750t
         4DkA==
X-Gm-Message-State: AOAM533VWAAw23IgLZPZ1PROmcOJDrcnmhCORKHLyniBd9YGVf8f/JUX
        3bSoRFwozIPI6HcaYoaj4d04qqo8xy8OSfShvic=
X-Google-Smtp-Source: ABdhPJw+Hv9JzKIF6rFK/LLIZRQvbJiUkx7pz5USjk4dQ/hKMfBStWpzJPkTk/2x4B1Ecg/LB/9K8FgdvMVENuFI25k=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr4875381plq.17.1616495721814; Tue, 23 Mar
 2021 03:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210322211149.6658-1-andriy.shevchenko@linux.intel.com>
 <20210322211149.6658-4-andriy.shevchenko@linux.intel.com> <dc377e4c-d601-790c-f20b-7e89c5d4e587@gmail.com>
In-Reply-To: <dc377e4c-d601-790c-f20b-7e89c5d4e587@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Mar 2021 12:35:05 +0200
Message-ID: <CAHp75VfyTOqEwypc-HcXqy+bgCt_Ch7c3c9rVJJeHMcz6MgJvA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] usb: gadget: pch_udc: Move pch_udc_init() to
 satisfy kernel doc
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:46 AM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
> On 23.03.2021 0:11, Andy Shevchenko wrote:
>
> > Kernel doc and the content described by it shouldn't be teared apart.
>
>     s/teared/torn/?

Thanks!
I will change if the maintainer asks to resend or if it will be
another version for some other reason.


-- 
With Best Regards,
Andy Shevchenko
