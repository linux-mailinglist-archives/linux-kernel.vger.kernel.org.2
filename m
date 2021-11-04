Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5244451C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 11:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKDKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhKDKx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 06:53:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90827C061714;
        Thu,  4 Nov 2021 03:51:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so19699770edj.1;
        Thu, 04 Nov 2021 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6I2uPuxsdopu4ALUZ3B2z3XyTqYZnvpIR8bVD6Ndlx4=;
        b=DFa+zvamwu4eDCZxp9GQD2zJtbEMx9q2ET83amQm0ealJO66LJa54CDSgRg5anyB2y
         KaYrQyzicHV7eiRgjR6kmAX+PAbt9ZVvhrZxRc5qT8+u6hFpHd958JLjISNwvsEqJ4Wj
         hkC5OMgANkQSgaN/ngXVFTyQ87zLCFL/j773UsXu/0rR1NSbP8i1Eymvd0myN+fji4+/
         n66oCY8XYHNkKjYt02mt7mHiXoL5NnWzh/CrWIUnoazcjvcIR/EbXzp0C7LoeEvL7q3l
         td1TWtrrZC81eakYOPACYrlb2deEr3WetN/r4aeW/44lI1l4mD6bXp/Gj308RvceBVmy
         h4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6I2uPuxsdopu4ALUZ3B2z3XyTqYZnvpIR8bVD6Ndlx4=;
        b=XMm90YMnS2jTpo7M+ccADo2ibNAd7AToeCJM0fkx9JfXh0eQYTVSJ4Uvcj6UdzTQmg
         Q5NHW5t4ibHT9Fai0AJLPvOEg4uE5l+ufS9eZxP4NfvejblitMFEWA/sZQ4cQAimwu3J
         qE/G/EyYBoslm2BeXPjMJ0v6/fj8r1yG5RmujexqHyNYYuv7mAHgbw9CtduOzjWcydkf
         hw13X2Mfrz4nxGvWHVRaoMwnoRj6lCFZZ/XcktKIRq5CiL7szRmo0WzkPxPHp8nqIy4w
         7kTSCK4lS5wwn7xOdW9v+48uBz9WzuoP+rWOTIPNL30fXTF8sRmoZlkhYzpSc6rFJcZa
         UrkQ==
X-Gm-Message-State: AOAM531k/2yWRPmVFdk3ieYrYpRUl7Ksi0I+DCPN3l7pKiYFYWcpU7sp
        98Jm0VXa6FueLE5yywhSJ4sdAGSlCmwMinKRkAk=
X-Google-Smtp-Source: ABdhPJzmVmUGEM0uAzQyN3dBaB1GHsse/O9va7VC6T780KCn1cAeK95SJKVT1w0aeJTM5Sosh270FaYivI1YWAM6ujo=
X-Received: by 2002:aa7:c44b:: with SMTP id n11mr47423909edr.238.1636023078205;
 Thu, 04 Nov 2021 03:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211104011245.1027675-1-yang.guang5@zte.com.cn>
In-Reply-To: <20211104011245.1027675-1-yang.guang5@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Nov 2021 12:50:30 +0200
Message-ID: <CAHp75VeOJ5XwjpupboaL1DzF03no=j=1HvDrVEy-1dF754On3w@mail.gmail.com>
Subject: Re: [PATCH] USB: UDC: use swap() to make code cleaner
To:     davidcomponentone@gmail.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Yang Guang <yang.guang5@zte.com.cn>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 3:14 AM <davidcomponentone@gmail.com> wrote:

> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.

Same comment as per all your valuable contributions: think about the
code you are modifying a little bit more. Okay?

>         struct net2280_dma      *end;
> -       dma_addr_t              tmp;
>
>         /* swap new dummy for old, link; fill and maybe activate */
>         end = ep->dummy;
>         ep->dummy = req->td;
>         req->td = end;
>
> -       tmp = ep->td_dma;
> -       ep->td_dma = req->td_dma;
> -       req->td_dma = tmp;
> +       swap(ep->td_dma, req->td_dma);

Interestingly, why the previous paragraph was not detected by you as
an opportunity to convert as well?

-- 
With Best Regards,
Andy Shevchenko
