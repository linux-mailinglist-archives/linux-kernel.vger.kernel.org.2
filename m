Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAED2407DD0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 16:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhILOpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhILOpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 10:45:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ABCC061574;
        Sun, 12 Sep 2021 07:44:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id x11so15137059ejv.0;
        Sun, 12 Sep 2021 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKskk/mcpK5NJYpSi8mIq5lOER0fbwzSwcUkWP/HdDI=;
        b=TK9pfNICgTrA6dqpJv0kStb0ky+o+l8NzT2EjQX5jdCGBfKuj1cbcyvRGcFTTABaKX
         ZymhqRRh09M99g2SOseeKXTOUl+sj3uDnJ7PnJgufu++29wJO/4jegOpZW+r1iKjBgk/
         itAM1tBOQpXbZcZg8Cpa8rs2vOzfTVqAmJkkU1O809zzgAfFHBH4sAsakteoGMovM8xH
         l5F4fDvmX2LvEyoKRJdCOWv5NgGAwVEqjPC+iTqo8MhJQa/dsLr0vcwL0aIxkHXmg0yU
         +Fcv4mjN0DkgA3zuN/hMxx7v8fIfsm4v9TA5rLwXmkPY92Dbnnd7JS3tiS36HorsaetP
         UMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKskk/mcpK5NJYpSi8mIq5lOER0fbwzSwcUkWP/HdDI=;
        b=rnx/VIxbB4heiNZM2mUlsK9l96OZzGkjW5bYM0sIjzfBDTfLX/tRbkggl6egUZdgfY
         V5xds9Kr7aKo8DXkMcK0G2c/7mKgkG8Gto/yb2C89hEU594+7fQwBfdpDGfM/+vS2fYx
         JySau3PHpTIUb+FuydaRqJlniSuuyomZgkFf5iHMMsjuf/2BINnrzXfyD5g72Qcnhs4P
         qJ91lkPuljcnu4ZGcgWQf5UpH3DoVzFBaOLEREQSlPaiTrIQL7rMGLdeSUCiEx2ogm+Y
         fTSXr/LWE9EpWzgIgx73LBwQaXH+rUOdy7KlFd2cS5WKFay1jGUFV1HaFiVs5DH6u4Lb
         muMg==
X-Gm-Message-State: AOAM5300XlcfYKBdezIj3O7HSEd5MelZrQrhvihH3pS2/uEUtnJA8VWR
        AS/q+9aMAXfB+Pp2752uBIeLpXt2YxF2kTcZVto=
X-Google-Smtp-Source: ABdhPJwC2pkQ4Q/AhmTN3T97zJx/3kAkQjB82QJkequ5tqL3IXrFsPo9erMA6114ggq46SVdeEyr2fQ0NI9ijoftPII=
X-Received: by 2002:a17:906:52c5:: with SMTP id w5mr7712138ejn.567.1631457840729;
 Sun, 12 Sep 2021 07:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <08262b12-4345-76a9-87be-66d630af3a59@roeck-us.net>
 <20210908213605.9929-1-pauk.denis@gmail.com> <YTo7OnzCRDZuveHN@smile.fi.intel.com>
 <20210912012451.60a8ef04@penguin.lxd>
In-Reply-To: <20210912012451.60a8ef04@penguin.lxd>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 12 Sep 2021 17:43:24 +0300
Message-ID: <CAHp75VfnNA73c+xBiescOd=YiNR7-zRu91VfFq-MiMhvPy7bGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (nct6775) Use sio_data in superio_* (v2)
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 1:26 AM Denis Pauk <pauk.denis@gmail.com> wrote:
> On Thu, 9 Sep 2021 19:50:02 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Sep 09, 2021 at 12:36:02AM +0300, Denis Pauk wrote:

...

> Should it be such ?

I don't know, but if so, then SoB of Bernhard is missing below.

It's all written in the Submitting Patches document:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-Developed-by: Bernhard Seibold <mail@bernhard-seibold.de>

...

> > > +   int sioreg;
> >
> > It should be unsigned short.

> Should I change all occurrences of sioreg to unsigned short?
> Before my patch it was integer.

Ah, then it's fine. Keep the same type then as is.

-- 
With Best Regards,
Andy Shevchenko
