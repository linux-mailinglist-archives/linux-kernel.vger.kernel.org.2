Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F113D05AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhGTWww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbhGTWtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:49:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2156C0613E6;
        Tue, 20 Jul 2021 16:29:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a127so806022pfa.10;
        Tue, 20 Jul 2021 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yXTkTmuny/F5ybcYYjxfeJY3HO6uZ+FEd6FMbHwKSms=;
        b=GCXcviTFW7S78Ev6I0At3AKjSKt5TGb/r6jL6ATW+uOdJf3eAYtjY53nu/9YNUgoMX
         Ei2KGGftuYNhvdJFOriZZJB97Q20QlS2gMJyKqgQfgfYgcBuAhFWHFJ5B8RvnxxnOE/8
         3fZelZ3igBe2ABygeS0dEHCi06EB7aVQ/HeexF0dDPgVgw+BMWIZ5X0Q+Oda+ZjjStj1
         7Gr+2YTDOuXQNMeaddKmbLksZE2BaY2bFTEfBzNiV99g+xfifQ+4Pb6lB0+g4GB7D4Ym
         BdHUv3BgGEAJnpQZt34+1ijZf6UIpk3JwF+oHn4q1sl3LrZaA8YtGabPWwCKY0Lei1TC
         hwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXTkTmuny/F5ybcYYjxfeJY3HO6uZ+FEd6FMbHwKSms=;
        b=ugWgBDxRdk8oQY/3dJ1m+C6YpixD6oDHF7bn/a2+Hwd0vdN8EPgsw8IwDLScVIsJzH
         ngL4C0YEM7JZIKWUEEkS6UJbBaB586ZoyTW0P3qIlhyfzjP92XxtYmGeFE8H9SXi7ZxZ
         R80Qf3bVS+OgxyhCQF9Nuv/BG6s3zXAB8OKpvGGAXVrbSp7mATpmCdgG8gLAlYMT49ul
         YGGaV81umW+Rw17Y2HHfuQ5kdwDGdMxIVsuwT7j2e0F8IPpgA/g2LPvQkEMdr1olsJcd
         Rfj2JvSHqppJQxW3CoqEBiV2gkG/Oqfq9AlwAky03dVVSnF+4H0VmPFYkjRk5aBCSR89
         2xew==
X-Gm-Message-State: AOAM530Uh//eomSa4BnFJ3wiqRxDxDOYRO53IpU8sx7bat8QTNNpdDK5
        rJPxGXosSB3Vef0gEi8ghr0=
X-Google-Smtp-Source: ABdhPJyUjdCP2bjsSZ8zVaIL7MREf3ygbzRPbhSp8Dk20L1iZ962hdLT+jESGTHyC7EXJjhX6rZI2g==
X-Received: by 2002:a05:6a00:158e:b029:32b:9de5:a199 with SMTP id u14-20020a056a00158eb029032b9de5a199mr33271341pfk.76.1626823763853;
        Tue, 20 Jul 2021 16:29:23 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id d13sm24532683pfn.136.2021.07.20.16.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 16:29:23 -0700 (PDT)
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
X-Google-Original-From: Moritz Fischer <moritzf@epycbox.lan>
Date:   Tue, 20 Jul 2021 16:29:22 -0700
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Moritz Fischer <mdf@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: Renesas USB host broken after commit d143825baf15
Message-ID: <YPdcUrR5J6vA2Glr@epycbox.lan>
References: <s5h7dhkoaa2.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7dhkoaa2.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On Wed, Jul 21, 2021 at 01:06:29AM +0200, Takashi Iwai wrote:
> Hi,
> 
> the recent patch landed in 5.13.2 stable tree from the upstream commit
> d143825baf15 ("usb: renesas-xhci: Fix handling of unknown ROM state")
> seems causing a regression on a few machines, as reported on openSUSE
> Bugzilla:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1188485
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1188515
> 
> Reverting it on top of 5.13.3 fixed the problem, so it's likely the
> cause.  Could you guys take a look?

I've sent out a revert patch.

https://lore.kernel.org/linux-usb/20210719070519.41114-1-mdf@kernel.org/T/#u

I think the driver has more problems but I'll tackle that in a follow up
patch, lets get this unbricked, first.

Sorry for the inconvenience,

Moritz
