Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0E38D501
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhEVKEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhEVKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:04:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30E9C061574;
        Sat, 22 May 2021 03:03:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t9so3793334ply.6;
        Sat, 22 May 2021 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Vw6OT/X2I8phVFQgo2JGHgLRH7v5/W/41Zd3gPR0WQ=;
        b=Pz4E5zKBRzuWTe0v+MdVzRRpDRPcbVMk+3kD+V1hThCV8TW1okkHlLRS+hduCbZ/+C
         Odz7NHUddIw7+d+g7lvfaaq734Omovm2pYn6WqLva/xnD4oGEqayQWzE734gSQxadmoW
         kmOG70dYY+iOuZg0sd0w5nYZPxA9+L9WYh0VKBvSkoxR1scwcpqqsDpaFrRDbbaTutIu
         v6MA6nLt2UWSNldwzGJXYFRoMyxwl3B8w+nu1x+zYoyanAsXAdcPt80S65oo+GA/HQ0o
         c/fBuX1Q6tRY/9Hj45HrtyvufmaKlRuv69SpEz/hJZL1PmBwWw7TwC5wP65v4/ugap0j
         c+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Vw6OT/X2I8phVFQgo2JGHgLRH7v5/W/41Zd3gPR0WQ=;
        b=hgiQUNnMtBec5Tmc2MPN8p3yWDUomVYR9hWmWvJARYS6PYtvOz+rQtYeWr33TSTNWL
         FQWTOzjNRat3HbNKeIY+bbaz+L0C8/ko3u6CtwwjH64foY1t1h0thtzdXse+1q9aSD9S
         +kH5qVbasa7RykiOINhyQXVg/cGRTS/E8pDyn4iDS5B12oRVYI8O/aPR2TJZm5vOLANv
         wJVWLGyLDwbPIxp2/u3nGWuppM6ek6OaPoM3Olmru4cvl1clfgYjT1uHPm8EoqMTGiN/
         GJqLENaX1MGt28ccgFrDh5ChwNoJFgJ/cniWgGGshqoK6ZQwde/P1Ohpbas3W2AG5DMg
         Ijww==
X-Gm-Message-State: AOAM532AGWtyuxyzddWvVULGVQXPv2v3VhEQPskFx2WfiNhqhikJMXqa
        unUfX2vn9gB5RLXFeoOBnmbT+Upyi73s3w4ycT4=
X-Google-Smtp-Source: ABdhPJyIb/W1BamR0UOY29I7lyEAu4FI6g2E1KSYBxoSZlhdJpgAjaNtx8Id232/4Cl3Zgm38oDAvZ+oOwx47MkD/a8=
X-Received: by 2002:a17:90b:1091:: with SMTP id gj17mr13869023pjb.129.1621677798237;
 Sat, 22 May 2021 03:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 13:03:01 +0300
Message-ID: <CAHp75VfhKM9z_yMzux8F07tmukxZpJOCZXtFDEZenCjrU26_Sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] misc/pvpanic: Fix some errro handling path and
 simplify code
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        pizhenwei@bytedance.com, Paolo Bonzini <pbonzini@redhat.com>,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 9:54 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> This serie was previously sent in 2 parts, one for -pci.c and one for
> -mmio.c.
> Execpt the patch 5/5 which is new, the 4 first patches are the same as the
> ones previously posted. Only the description has been slighly updated.
>
> Pacth 5/5 is a proposal to simplify code and turn 'pvpanic_probe()' into a
> fully resource managed version.
> This way callers don't need to do some clean-up on error in the
> probe and on remove.
>
>
> "Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>" was only
> added on patch 1 and 3. I was unsure if his Reviewed-by was also related to
> the s/GFP_ATOMIC/GFP_KERNEL/ of patch 2 et 4.

To be sure, always send a series with a cover letter :-)
Yes, 2 and 4 were also included.

> Christophe JAILLET (5):
>   misc/pvpanic-pci: Fix error handling in 'pvpanic_pci_probe()'
>   misc/pvpanic-pci: Use GFP_KERNEL instead of GFP_ATOMIC
>   misc/pvpanic-mmio: Fix error handling in 'pvpanic_mmio_probe()'
>   misc/pvpanic-mmio: Use GFP_KERNEL instead of GFP_ATOMIC
>   misc/pvpanic: Make 'pvpanic_probe()' resource managed
>
>  drivers/misc/pvpanic/pvpanic-mmio.c | 17 ++--------------
>  drivers/misc/pvpanic/pvpanic-pci.c  | 22 ++++-----------------
>  drivers/misc/pvpanic/pvpanic.c      | 30 ++++++++++++++---------------
>  drivers/misc/pvpanic/pvpanic.h      |  3 +--
>  4 files changed, 22 insertions(+), 50 deletions(-)
>
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
