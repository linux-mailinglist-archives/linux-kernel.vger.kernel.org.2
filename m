Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC13CA0E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhGOOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhGOOqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:46:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:43:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y4so6489303pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=re68oozSXCNcEuLqYPK0MfMJDizX2uWBaEmtTrtMpWI=;
        b=vcTTxOzuIbNNJKDsiYkUiKcmzWQC/UzlH2SLX9olvT4MqNK2/ddS4NllYspfxm6Hhp
         bs8o2CJIDCun6S5T4C/1gv0qEAoJ6AFe7/Z14RD38jzHJSMjjezVf5e0hiu2nUwmOatA
         JbyCAkZpuDFui/LcaKU+61wrru/fNtMpnHoiUu8b+LS4hT1HxwFEZ4Zn56xIxkmXqBdq
         pIdphAwzM5IIH/w6vckqOxnOiH3xnckCzsYlmdhwN9p1zhZAO0qXOVjEFPW5BjXOlIiN
         XmSSaB65KC+yVfLML9it4AYHvuxAoBqmgRFY6K4JEFlXsf8aqumH5kflvV8AMZn3dysp
         gbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=re68oozSXCNcEuLqYPK0MfMJDizX2uWBaEmtTrtMpWI=;
        b=kzZU4cZ7y4aq2iHt/PejfDhfMzmvKKxRvVcQ9RJr5+iHBnuhjhO/c0Msw4kfV8EcIn
         XRQZ/rQfb0k4kPbvXr47alqHuaKLKPZUpHAU2kGDZ3uuFZ2cCCKrp40+ve0CVUm0HJ1w
         GmnWj0DLxGZ+yL8icdfNtyNW1rheISaW7Xg4aR+91NA/lxs7mgujChZuxGMj6JMZQ+5o
         apj6NnSSk/e3miPiK0Vqml/USlwjmU0BT00qvUqKOqeLqTsyif0JLXucvzwq7QJtxLDy
         2kj+F8nXxsSvY2c+scCz+7FpED94DSX03d46Va8UdGMhtusobJQUXx3aIKKNPKqugVeq
         DMhQ==
X-Gm-Message-State: AOAM532wl6OuLflQygAPPzOWp0fXH9nvnAthUObKNFp1+8x3uYRKEe6F
        3BlUy4sfzQC/cM1la/pj/mL6NVotvUeHKbv7lbiBKvcF+zA=
X-Google-Smtp-Source: ABdhPJwiAj51g++PDpSWSBfxB90tZ0lCiNnIZprzlOKYyQB8KmSDoXZY0iYQu8MkkTZYGWCvp7IZYnhwROqWnZkvuIc=
X-Received: by 2002:a63:d014:: with SMTP id z20mr4959361pgf.203.1626360198909;
 Thu, 15 Jul 2021 07:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210715132310.31514-1-andriy.shevchenko@linux.intel.com> <20210715142546.GG27830@1wt.eu>
In-Reply-To: <20210715142546.GG27830@1wt.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jul 2021 17:42:39 +0300
Message-ID: <CAHp75VereWXovC3Bc_Gb_KpkE_-hfZQC+OpHM0v6hyOByS8B_g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] auxdisplay: charlcd: Drop unneeded terminator entry
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 5:27 PM Willy Tarreau <w@1wt.eu> wrote:
> On Thu, Jul 15, 2021 at 04:23:10PM +0300, Andy Shevchenko wrote:
> > Besides 0 not being, strictly speaking, a pointer it's redundant after
> > the actual terminator NULL entry. Drop the former for good.
>
> It seems to me that there is confusion caused by the absence of
> the field names

My gosh, you are right!
v2 on its way, thanks for review!

-- 
With Best Regards,
Andy Shevchenko
