Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18173CAFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhGOXj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhGOXj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:39:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61051C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:36:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p186so8492897iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBVYR9g+h8A+5teM3Ad8ihslkNXeVYq4wqO+7J+522c=;
        b=IQqtzEZWqSLu0Yn2iQfeTzXwHVkk/yV2fKaTZBgdotcff88pQSrJSSBD2U/BV7Q0gV
         K2J3HAdEkTjjqVE/e+5mkDmR3sgdiG0wViqKyJ4HTzs6+LZH6Y4RzCeiIM3+Bk4bUt7W
         aQ49Zm6sQamJQHCBKSopnHTIvzxJefpFEOdzJZSexKSaENr+iySzUa6hEVap6r4GGb9f
         EJ+y+nrNpn7onPhGbDDe8u5wTdwch8n/zyQTxPEGqD1eA/b+tQnYBWBRXrHyLtGD/2ZN
         mllYzM9QRmmbMgUbXtLu+phFVfGihQs62Ri1diZ8WeUmg1LPzp8dIjoJwgPN3L/BS5Bz
         IRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBVYR9g+h8A+5teM3Ad8ihslkNXeVYq4wqO+7J+522c=;
        b=eE/u/MiUZM3uhDSVqnmU/uOf1MFSAcp7nd4xSnQlKjIvZpGT9HfUFaA/itx6Zr0k2T
         uNJH647XgvxiBslPcuBJzG564/jiGg5nx5QZlH0mEUiqBgE5OuQcz452RTuxQuJSkEqk
         HImm+pFtYZhQkhJ1qJ8q+e+S+DvW2iuzIwDOi6AwtDn1KWuUcPu9zdDUREW6xSjH4Pps
         TL3HpeuyK1Ffumyxnc6ohFxXpMLNmgPcheWT+MibbizrGz9k47Q6XX1A8AmULbUMzOZa
         jExEeZDvSIZSwJNEzKYYrAhPXIW+TnHyvo2FQ40q6lRy+fI6OzcW3VZZ7dH+zG4EKi1o
         YUmg==
X-Gm-Message-State: AOAM533+62qEweREbUB/4EWHPvgAD/LECzXR22MZDTSsrfAncoZTVGLC
        eSAndckiW/axhjuoYrWF7vJNL00G44/cBcGv/LT1tRDS
X-Google-Smtp-Source: ABdhPJylg1C55Oo2vJGtz8rwh4bcUW7Nbdt50DDkKVQ4055kY+lOT4AONNF0x59LMPd6DEYcVE4Bq/gJ5BkEU8+saP0=
X-Received: by 2002:a02:2b21:: with SMTP id h33mr6024434jaa.31.1626392190738;
 Thu, 15 Jul 2021 16:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210715144152.83582-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210715144152.83582-1-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jul 2021 01:36:19 +0200
Message-ID: <CANiq72nGiQrnyR8My_z7EP+ZFAVPqS0ztdGod5QD-tPVna8pJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] auxdisplay: charlcd: Drop unneeded initializers
 and switch to C99 style
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 4:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> For structure initializers the fields are 0 (or NULL) by default, so
> there is no need to fill them explicitly. Besides that, much easier
> to read when initializers use C99 style. Hence, convert to C99 style
> as well.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Queued, thanks!

Cheers,
Miguel
