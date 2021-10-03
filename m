Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255E942004F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhJCGdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 02:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJCGc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 02:32:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFE4C0613EC;
        Sat,  2 Oct 2021 23:31:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba1so51394528edb.4;
        Sat, 02 Oct 2021 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Iysf0qA0sgin8jQAL4XbQr0aqoukRZCUSGxOD3j4TM=;
        b=eLKEEi8zS+ZwymjQEHuug5MtBj5t2S0JAKnsAQFr2235roonRqTLHEDpm7lAhJytvt
         9QGES/mww4egaNz1FhNJrj2/xNDqGl+yGlvvES2LTJOLpqKukhEGOFKsVPuYteMjo5d3
         8Qd+CXKGsXr7ezSK+aqrVi8fmmi/6nwpGfolpLRwL0IZpKoeUiQhe4DKE+lOLMC1iTWx
         JvR0OD2xFL4y1v0E/cN/CMJXRbFhYiNuaVZyvUnnPLNPbp3eDmpmV2R8sazhkF7I6hmK
         drOXa6gz+pXV/lgtmZWIX51U0R/JpZ4uMoWerprKuejwpd81lv1q3hgiF5ULncIFjV5T
         x/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Iysf0qA0sgin8jQAL4XbQr0aqoukRZCUSGxOD3j4TM=;
        b=AuydOYU2+NmNhdPqlywP9iMkdxAJLHo731TaHkral0eVUoolKG8nc/6xDFlECxEOkV
         em3R1XCqhi81W50AKUlP3eDZP5oAj8IXOy5Ipny08J3PB11agqQmr25dssJZEw7MjGE/
         vSZjZRQVtQsZz06GCtNBGA7izTUrQQ7r41fHeVjpJKUPrGwxPH62Wad3gl/g6g9gvmY4
         xmiG54Iva/BS+nNDk5RO05qOhCNay6Y/vNKwkBZq7ric6uE/8xSguWvcWyOiBBtaZGWs
         1ABj1CdhuJdAlV3fvWXAFcMduC6M+IQ8bruPSe2ftEF4BNC3R75khPgpFhO12364DqhX
         BKjQ==
X-Gm-Message-State: AOAM532VcCFeu3go1Z6gg6ZQ/weLQ4UY8sKVcW8OO0hNiOt3wSWTA624
        EODQf2HOFwZvg2P6O6IqcIHcz41tS6uGfMOMhnY=
X-Google-Smtp-Source: ABdhPJw9aUEYb/aD6GIVj+3bJwaGBAqkvKQVrDQd3c1ZLrspBsEJ8mWVNUswFTSLaRPWW9Hpn1oyuLwmA12KOubBOYg=
X-Received: by 2002:a17:906:3596:: with SMTP id o22mr8662751ejb.356.1633242669771;
 Sat, 02 Oct 2021 23:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com> <20211002210857.709956-3-pauk.denis@gmail.com>
In-Reply-To: <20211002210857.709956-3-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Oct 2021 09:30:33 +0300
Message-ID: <CAHp75VfVwxbHEzhvmEcyZce-hXrrr7oFq+xAWY4Kb1nB-EHEEQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Use custom scale for ASUS motherboards.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Kamil Pietrzak <kpietrzak@disroot.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 12:10 AM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Use custom scaling factor for:
> * TUF GAMING Z490-PLUS
> * TUF GAMING Z490-PLUS (WI-FI)
>
> Voltage scaling factors are based on Asus software on Windows.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>

> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Instead of repeating it in each message, use mail headers, i.e. pass
--cc 'Name One <email@one>, Name Two <email@two>' to git format-patch.

...

> +
> +               if (strcmp(board_name, "TUF GAMING Z490-PLUS") == 0 ||
> +                   strcmp(board_name, "TUF GAMING Z490-PLUS (WI-FI)") == 0)

I would expect this to grow, so do the same trick with match_string().

> +                       custom_scale = true;
>         }


-- 
With Best Regards,
Andy Shevchenko
