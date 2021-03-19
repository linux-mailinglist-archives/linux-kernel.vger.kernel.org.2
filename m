Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5734192D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCSKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCSKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:01:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA217C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q5so5531815pfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9LufqdUnFpJuSHq7VG+1cDzdDjsh6C7NF9D7mHBSgE=;
        b=g6shrotdYjJwb555YNp4B7fES2GhlOJy0e8xbWUiB4lv97yIBTg1glm+2zR4M08ZtX
         w+07s5RPj0Q26PrdbbQuos8lGr442EIE9yIz7g2+JvnGc14ks0n5a5RwQVO1yn3udj4T
         AYrQxniHTV0WhCYxHS4RuFAr7DyLbf7Yp1EOMII78Gt8TxxWAjKmF7Pd00+nQxG9ubsD
         wifHKH/elFO57l9i76I8cAHFKWyo8PhcIBV4YkmMNYSaslmz1v3P6FyKtk46+/8Vmery
         GxUFT8V5AekKeExnJ7KGMmj9NtN/1eWpGIVc1gp+FD0oUQ6qF+bRmvkj8rylMgcI30Mr
         hG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9LufqdUnFpJuSHq7VG+1cDzdDjsh6C7NF9D7mHBSgE=;
        b=R1pC2jQ+DOgAWmLUeB0nE/l25i/ICCvIP1V5Le5+G6ArViLm7ammyWrtHxu9ckgXHV
         oG+s2ZgJQrWVvQrINl+5YBG8u0ESNjMtpPz+A2yccgvs9mt5cIVPW7qx9RohieRrIP4f
         lw3m0th4IgjCfTE+exPUM0oVnLAJkfghOmQkV2yOwjg+q/ciymQIiTTe7yvKIbKFSypV
         mKNADX6g5D1YwCCPrbJrnQv3v93eQ8tKqobXoPSqKV25z/bSORaVHnynxPPrYo3oFB51
         VKYKmEHjL9dmkMDclCQ6JReVzy9886qpAom2UCzxhGodojAZ0rnUi5/X0r6Uxrq1D32c
         fYQg==
X-Gm-Message-State: AOAM533icB2OBY0XNw6TpOBEItg/XOKmyluweXuzhhXAoyOnVPpnzHva
        oxAw3M7b0o6wtEBNmRYF4edfKgk4+E1EVWqoNDA=
X-Google-Smtp-Source: ABdhPJxbDPG8NljK+tr4M/GEgg/TBah6wYjT89ZRqQIGWrdHtGVIPdXZYQvPnOmMytwBlslG0IYoYkUoEPVUtJyzai8=
X-Received: by 2002:a05:6a00:1596:b029:200:c2c9:95e7 with SMTP id
 u22-20020a056a001596b0290200c2c995e7mr8460683pfk.73.1616148108258; Fri, 19
 Mar 2021 03:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <YD6nF1oJVMeCzn6R@rikard> <YFNNVHZeKIMHco+a@smile.fi.intel.com> <20210319083937.GH2916463@dell>
In-Reply-To: <20210319083937.GH2916463@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 12:01:32 +0200
Message-ID: <CAHp75Ve3qgFOJxsDouL+ku4t7zxC8e7X1ta8wiL-eRCCpe51hA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] mfd: intel_quark_i2c_gpio: revert "Constify static
 struct resources"
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:41 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 18 Mar 2021, Andy Shevchenko wrote:
> > On Tue, Mar 02, 2021 at 09:59:03PM +0100, Rikard Falkeborn wrote:
> > > On Tue, Mar 02, 2021 at 03:56:16PM +0200, Andy Shevchenko wrote:

...

> > > Sorry about that :(
> > >
> > > Reviewed-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> >
> > Thanks for review!
> >
> > Lee, this series has a critical bug fix, should I do something or you is going
> > to apply this soon?
>
> It's on my to-review list.
>
> I can prioritise bug fixes though - can it be applied by itself?

Sire, that's why it's at the beginning of the series.

-- 
With Best Regards,
Andy Shevchenko
