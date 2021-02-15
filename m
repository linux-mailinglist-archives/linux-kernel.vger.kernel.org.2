Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3146E31C361
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhBOVDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 16:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhBOVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 16:03:42 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D7C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 13:03:02 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id d184so8477948ybf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 13:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkAE5GZrxiH2vo58IArjoyNpu2OSH2wS3QmdhBJRxPw=;
        b=fBiYM/8cpwWuNzjfET79wMLq2L1C9j1U+JdBXA2SsIS5rSyQlK6tMGLPNIGjZ/CBlc
         FMX//k/KWtsHxZsxU51KogB7ZGwS1iSrz7k7c9oTxLCKr+jJZqEZCMHF91ClWGeqb6Qk
         DvXdXbjNkd+ARkJEZiF19lfISZRJMGLLjfkAMBdbYrPQZBzsJa3M3ITWYAs9j07wCY4F
         4dz1HQJtWW/HJ9JcpTMGRL3RgC0IoBthqOMdCGR5Nkvte6hkREdsTscaqxTMpfVImDL3
         EoO2S7tG6EGs2L3w/urnzimTI6j7iAlXLBbrJFuTejHJCX76jDp89qi4WqmP4loVUkSy
         2pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkAE5GZrxiH2vo58IArjoyNpu2OSH2wS3QmdhBJRxPw=;
        b=lv8DhVwWWaCM5TuM5ceW1c0AIzWcTQg7STvSNxOU2pbFti0merzOQ8NIYjoLrorPh8
         UHta6/bNltiry8j0/glRcEM1K64+SI3A1PQTf8+yiV6wk0lkJrBSB6oXJNx0mgkpQh7b
         X4+Iffvm9mySvyt0dDriP/btcSnKg7WI4S7Wjpj97vLT84NjX5QhjtQEMu+QXvovgdoU
         KDIdLrOApHO8EkqTVYPceSrhnsdGutgVpMt3lcksCZS4B4GrZ+7GjZsGif750G2gwFkR
         WI/g3kvLwOk4wGE0PtG2KNPNVFGDlaOf9LIhp7zMDVVexT0+lULhcNHG6J9kyQ40cEWl
         ZEkw==
X-Gm-Message-State: AOAM531nN+Q5EAdP89XENXJaOI9l/ptSDcm84FsM/OvzuXJ4PtWN3QCo
        Pqs76pRcSo2nAj3QWJmConCnUKK3tO1kHe9hnizA3A==
X-Google-Smtp-Source: ABdhPJyxcd5wnEwohM0LtCiiq5LvJ4rEK948KUqaCPyWoHRQNCoIgCY/DDbEww3kFcj7AQbM8yQNeaTdIB3rxf5mdXI=
X-Received: by 2002:a25:dc94:: with SMTP id y142mr14822772ybe.346.1613422981325;
 Mon, 15 Feb 2021 13:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20210215151405.2551143-1-geert+renesas@glider.be>
 <CAGETcx-c5P76JkB-upi8ArDqa=TrR3bJMnpDTO-59sh83opW8g@mail.gmail.com> <CAMuHMdVXCH+27cpC=-viQev1HeN_DkU0=7Dydp4G50z0bB2Ang@mail.gmail.com>
In-Reply-To: <CAMuHMdVXCH+27cpC=-viQev1HeN_DkU0=7Dydp4G50z0bB2Ang@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 15 Feb 2021 13:02:25 -0800
Message-ID: <CAGETcx_B7r6DErnxzDngh_KW9a33f4+cHhvthzfEHX8pO0et8w@mail.gmail.com>
Subject: Re: [PATCH] staging: board: Fix uninitialized spinlock when attaching genpd
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 11:10 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Mon, Feb 15, 2021 at 7:37 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Mon, Feb 15, 2021 at 7:14 AM Geert Uytterhoeven
> > > @@ -148,7 +149,11 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
> > >         pd_args.np = np;
> > >         pd_args.args_count = 0;
> > >
> > > -       return of_genpd_add_device(&pd_args, &pdev->dev);
> > > +       /* Cfr. device_pm_init_common() */
> >
> > What's Cfr?
>
> "compare to" (from Latin "confer").

Can you please change this to "refer to" or "similar to"? Also, not
sure if this comment is even adding anything useful even if you switch
the words.

Also, device_pm_init_common() is used in two places outside of
drivers/base/ with this change. Maybe better to move it to
linux/device.h?

-Saravana
