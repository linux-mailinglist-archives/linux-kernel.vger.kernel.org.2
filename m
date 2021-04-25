Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C436A8BA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhDYSB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 14:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhDYSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 14:01:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064EC061574;
        Sun, 25 Apr 2021 11:00:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id z16so38605525pga.1;
        Sun, 25 Apr 2021 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3xnyyXl8Zdin1DIWvD41f6uZR/KPwcFkPpRMWNH32o=;
        b=dTdGdV+RagTyq72wYBAVUTWK4TLHMS0gEtgZqYA91S8vO7eF3Z8irSUGX00VvrpONf
         y016962iSNwN5d6ahPtlMy9MWGBxRG+pZSwGjQwkYkNMuP3kyCOFoe1SpgO22SLBr3Fn
         A6j5GMp0XhoPLeq9fL28nwXjPt1Wj0Ii1fPQMZEf2bDQVWXSKjIOYU1zpif7ANsH8v9r
         0zSOdRi8gCvtAER0NuKgM3S2SgTyLn9xFXl+9EMNxXKsxqbRk6HJgZXomkHcEhzXMZmw
         sgsPwCtjM1q4UXjFfGONBBWy9mYZYFirSJT34mMwWeAhS+1GTJrlgUZRkkbH4x4kkkTg
         2MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3xnyyXl8Zdin1DIWvD41f6uZR/KPwcFkPpRMWNH32o=;
        b=kuclnDOOrVujF0gHWm3gXuOKkHrYpQ+JvxwEt8FX29wo1Q5ZSC9eI+oloYDajhZ6Hw
         TTzL1EtiZug8z+RPgpNZMviWF/+y8WI8yN7fnwSsBSXb/Xjzs2M70S86Bw1XX+Ocnmk7
         l5MCSkyWVu9iIgRTd3RpxawmYxldr5WAkyoX/0OarrJ0qoVmdS+FhGf1PAy5XjF43TUy
         3QZUwr25cE1FRePFiCTda977KRTSpYayyfnQ35fmUW35VuCqG+NpA8cG1hheBec0h+AP
         3XM5/+me1BYSTpv1lAJc3TBGXfnhZE9SaqMppd56yw8XaX2Ml4iISwTAfbpoyVQ8Ltfk
         gSQQ==
X-Gm-Message-State: AOAM532HTK5EKHqrvqxbmcx/l3Dqb5NSBNW97hvp64vO0DAcVmpzDYSK
        /tG0N5lR1xYzZhiDiNnhg/mVSjRlqGt4fZq1/9e85dI3rAj/FQ==
X-Google-Smtp-Source: ABdhPJySCNXwFAtWJ0zYn0NeMXeGHPMJxUlAmbsYuTbk1486MVOrnPXqtKofoBvmNMzJEVSafPxcQ7tt7QAYqOIwVK0=
X-Received: by 2002:a63:cd11:: with SMTP id i17mr13237609pgg.74.1619373644543;
 Sun, 25 Apr 2021 11:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210425150947.5862-1-ftoth@exalondelft.nl>
In-Reply-To: <20210425150947.5862-1-ftoth@exalondelft.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 25 Apr 2021 21:00:28 +0300
Message-ID: <CAHp75VecaOXdXh5O5NBA9EtoMnPEE_0mmvcFiXVUgw6cT1s51Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: dwc3: pci: Enable usb2-gadget-lpm-disable for
 Intel Merrifield
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 6:26 PM Ferry Toth <ftoth@exalondelft.nl> wrote:
>
> On Intel Merrifield LPM is causing host to reset port after a timeout.

the host

> By disabling LPM entirely this is prevented.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 066c09593454 ("usb: dwc3: pci: Enable extcon driver for Intel Merrifield")
> ---
>  drivers/usb/dwc3/dwc3-pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> index 4c5c6972124a..e5d7eed2e60c 100644
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@ -122,6 +122,7 @@ static const struct property_entry dwc3_pci_mrfld_properties[] = {
>         PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
>         PROPERTY_ENTRY_BOOL("snps,dis_u3_susphy_quirk"),
>         PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
> +       PROPERTY_ENTRY_BOOL("snps,usb2-gadget-lpm-disable"),
>         PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
>         {}
>  };
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
