Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA8B3B37E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhFXUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:36:19 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F4BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:34:00 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id s10-20020a4aeaca0000b029024c2acf6eecso719904ooh.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=LGVLOwTMQf02AApisXt8714vIkGSE5Hn9MHMhj7anOA=;
        b=XFxU9zrqgC9ofH8LrrvjQGG/EntrxKD1JQX2pAZoDRug3TJloNyZsdidjCNjNVJPcu
         lC7vtWp9bpY7SMCt1A+CCCEbfn+nMF/pKOSgdlfPhjk+4QedG+lqxPbPQDRNBsyJH6XX
         Ce0vEutBX2I90tb8y0dR9byyU5w5xfhMVcobM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=LGVLOwTMQf02AApisXt8714vIkGSE5Hn9MHMhj7anOA=;
        b=GTCjijo3gHIpC6rylaqDUvfjG784VsDeZS3JA0llTfyGyh9qg4Lu1SyF7qRDNMFsvR
         Iw9ABZpVI6jndMSzwId6EVkDm+grSSPUEJ1HRK1HRGlDats2zKC9ZVbO7UtRL8muHgXQ
         j/ceESlp7hzE47EZe5/wlqMnhlUvzC6d5VvNmwsNvzYSYeQlptymp77X9TtX82bvAasp
         AH+bFuz8ElrsG6jZk9xhV3jPsxPVGd34XmAOcw5og220RcBt91Sk2d0UM6+BICLmRXiZ
         8ufRPgDU9GXdmAR7qVutPaenLzemM/bc4Fj+qa2yUlf4Coxq6OIixM+ncgAe9VZSdFGj
         weBw==
X-Gm-Message-State: AOAM533aZzn7DjAfnK9JGWy1qEQz+ylm4fd+yB9QiYRu6VI3EkdvWMgB
        V+IUrZQXRybPVboE2Gc/lqNQGXW53WwHz88GMRrQJw==
X-Google-Smtp-Source: ABdhPJyGVI9vpTiB7DmD7vEDFP3PgX1RutuQHWzb5jNfz5eRMrVafr+ft2whOyQUjr4FN/VhH72pAeVGbFz7j6xSkBo=
X-Received: by 2002:a4a:3e0e:: with SMTP id t14mr6067704oot.16.1624566839749;
 Thu, 24 Jun 2021 13:33:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jun 2021 13:33:59 -0700
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoxg0OhHUONm4dsOTyJperfM7bkkHpK0ikqP8u9mgi97w@mail.gmail.com>
References: <20210621201051.3211529-1-swboyd@chromium.org> <CAPDyKFr=sapFwgsDrZw5ZokcryGDpXDQTnv9kzAiijfuT6cw9g@mail.gmail.com>
 <CAE-0n53=AuYcBSTKkvDmNHpLMq7j4yTeMh5j80uN5dobqvC5ag@mail.gmail.com> <CAPDyKFoxg0OhHUONm4dsOTyJperfM7bkkHpK0ikqP8u9mgi97w@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 24 Jun 2021 13:33:59 -0700
Message-ID: <CAE-0n53d7_LeyyQv7OvxoMuvi6xz7NKtgCENN7Zp7fVUKSUNPA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Shrink locking area of the gpd_list_lock
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ulf Hansson (2021-06-23 02:55:24)
> On Wed, 23 Jun 2021 at 10:31, Stephen Boyd <swboyd@chromium.org> wrote:
> > lock as far down as possible to fix the problem, which is holding it
> > over the calls into OPP.
>
> Yes, we don't want that.
>
> >
> > If I've read the code correctly it serves no purpose to grab the
> > gpd_list_lock here in genpd_add_provider() because we grab the
> > of_genpd_mutex and that is protecting the of_genpd_providers list
> > everywhere else. Is that right? Put another way, This hunk of the patch
> > can be dropped and then your concern will be addressed and there isn't
> > anything more to do.
>
> It certainly can be dropped from the $subject patch, please re-spin to
> update that.
>
> However, there are additional changes that deserve to be done to
> improve the behaviour around the locks. More precisely, the
> &gpd_list_lock and the &of_genpd_mutex should be completely decoupled,
> but there are some other related things as well.
>
> Probably it's easier if I post a patch, on top of yours, to try to
> further improve the behavior. I would appreciate it if you could help
> with the test/review then.

Sure no problem. I've sent v2 with this hunk dropped. I can test your
followup.
