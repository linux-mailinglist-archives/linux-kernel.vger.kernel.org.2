Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4935A30C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhDIQXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDIQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432AC061760;
        Fri,  9 Apr 2021 09:23:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t22so4325008pgu.0;
        Fri, 09 Apr 2021 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDusQ2OuAkZSg4NVX/t5wwyf/vXXXB7lfR1OxJXRB3s=;
        b=WU/t+K7gJF1eKmth+Fx8Km+m0zRCt40wXeHPJ+ncI4YKlr24IOVGAREsDJZ0ex+uwf
         14mRXDVbiWwylGSwCgFMXFomPLW6VeUisk4BsjOAPrUUsbhFx1BKmgwxlF0v5vwiUg/d
         u2SfhHFD23syf4FuFsKqyYoRrj94ysVAvtOVlfIYGOvLFAx9+mfY05k8HBwbORjzn2YH
         CgVP1jh7Q6N/8Y6BxnLbttOPKXOyXMdblAeThxbXiQUUg1LDdymLezykkJUz5kc9WSmS
         ZT/qBtcESMiHHUzJQQzQhluY0c7HFLv427B++neqy7OwhhKoP7AJY3/FHcGcTJ5cCgvb
         bgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDusQ2OuAkZSg4NVX/t5wwyf/vXXXB7lfR1OxJXRB3s=;
        b=cWPuoDCKU3givSP0KaxCy+3ecQ3m3C+2NJjdFhBG9oDLtVhp0VlG7FPz8/idWuaUH2
         qC0muCOCS8Yxe3Xh+J/HOX8ZTu21U6W3pSquQnklTPjb5+2BDgiziVF47vER1oj+/FNf
         +Cikm03PQ/UIa51O/fLv0RKmmPs0i8K9UspJ7aPKGxroq6WNO1RPEWNbVxZxHv6rSvag
         vwxah4xJZDuzKghquD3UNvzKWa/XO5HdeAXFPgh3R0T6QoyBT+n1QR0hZRNXUMOkrVJZ
         i9G8lj95dyVyI1IAZoLufjqHP2C7ZNHSC8N3yRe0iegneOARC6BTQW3Eg0nb3Fjq9CLo
         2+IA==
X-Gm-Message-State: AOAM533i6gfaySBZSO6Ao4O7rvggM4NpXsuegbesiw5IN75jxdRAzSsJ
        iV0J4dBu8ncUjCkkZkNq3CN5gNEP95JtmnBnVfQ=
X-Google-Smtp-Source: ABdhPJwLYPqG7zCqxZIsi/geZhQoa08NeY7Kg13aATTx89RIAVutBerolpUW4gNQU2b0iPy8nazkY8b3QcebcgDP3hw=
X-Received: by 2002:aa7:8593:0:b029:246:c18b:ff16 with SMTP id
 w19-20020aa785930000b0290246c18bff16mr3915775pfn.40.1617985407948; Fri, 09
 Apr 2021 09:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210409155216.31867-1-johan@kernel.org>
In-Reply-To: <20210409155216.31867-1-johan@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Apr 2021 19:23:11 +0300
Message-ID: <CAHp75Vds=yXk3yYMh1yyDb0o_YyVTh3-6iKh8rYKwYHORebdkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] USB: serial: cp210x: provide gpio valid mask
To:     Johan Hovold <johan@kernel.org>
Cc:     Pho Tran <photranvan0712@gmail.com>, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 6:52 PM Johan Hovold <johan@kernel.org> wrote:
>
> Use the new GPIO valid-mask feature to inform gpiolib which pins are
> available for use instead of handling that in a request callback.
>
> This also allows user space to figure out which pins are available
> through the chardev interface without having to request each pin in
> turn.

Thanks! I like the series.
Independently on reaction on my comments:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Johan
>
>
> Johan Hovold (2):
>   USB: serial: cp210x: provide gpio valid mask
>   USB: serial: cp210x: add gpio-configuration debug printk
>
>  drivers/usb/serial/cp210x.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> --
> 2.26.3
>


-- 
With Best Regards,
Andy Shevchenko
