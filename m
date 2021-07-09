Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D1B3C253C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhGINvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhGINvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:51:22 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C59C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 06:48:38 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id y20so3589645uap.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRCNV6ZFXJBs7PclJlD2iVg5/YJ4bok8pXgNIFrGMCg=;
        b=D8weDgVP9EZ6NE1BrJTnQpXcjrMNbz6dvAHF9BhcWGd8eoy+R/hdnzmyd8aKXNysFg
         cEpjEMsrTF/wPnc3XCy9a0ukDS/2/v+0GKJTv8f7/Yr6++wMXcCpY06ZPVDICwgxrZWb
         /5idRWlyo5bwnmJbAvZPI0zmZxN/JH0anz3lBYBV8bfxpjDukdpEqst336HMXRimz+tv
         E1X4wsXYwk8zQVBQ0AFdyFr/nzF6gPLBmd3QWIpy1hBRkrySF2UBqpnxAU54N6R07hsL
         0Uao7+rDqyppSQ8BSb0HaJy04YII2rv2Mh9lqmidT2IZwDkD7w333VUUfy4ZMtkVzGTL
         UdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRCNV6ZFXJBs7PclJlD2iVg5/YJ4bok8pXgNIFrGMCg=;
        b=aicCeLZ+UibuzT4ziBY1BYkaoQN7fZXAMS3gM73Gm7spymAu8p3QLxuWbJkCghUUZO
         bgVyadHvDsBrG+Rqbvop1sS/rRCw6XE3pzKRt2aFeEL9v74cky9jZ2C9JbQBA2W1cvKP
         Ljq+mTEvTWJjUG/kVlyAH37Wrsx7a7zu95MKRZoxMzByip0QLpe5tYBEsBfvzMN9lvDd
         lzOuLbjtjG5g+DlMHULLivYsTZmxgy0P67+q6YnLkBU4SNt1GL0T/JFcwKs3Q/nDZAzt
         QKT/xmgpiF4YLYZ6cGnUFAB8cQ6E440nVFVWSTt0yg70E2ve97LDORYy+pk1ZcxUAKMH
         RVHA==
X-Gm-Message-State: AOAM530LCZHLT8cJOlp8z4Hztyaa9bdnih+C1hp62XWdkl/q4ci7oA25
        vFWc/U23KKP7z6BL1onJACN0d7XMfMd7DxuWfK1yOA==
X-Google-Smtp-Source: ABdhPJxTkyvoa54J3Do+B5qntDhoazM0lWih9gehETjT94wFgYdJD2Vf42Bi655Hk/alRbkSfWJgef4zVRhXPf5FUzE=
X-Received: by 2002:a9f:2f14:: with SMTP id x20mr38311816uaj.104.1625838517384;
 Fri, 09 Jul 2021 06:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
 <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
 <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com> <CAMuHMdWcvAeeif6HwBMrQUs2z+jKcfY1DuKRYeyB+GTkiXGjSw@mail.gmail.com>
In-Reply-To: <CAMuHMdWcvAeeif6HwBMrQUs2z+jKcfY1DuKRYeyB+GTkiXGjSw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jul 2021 15:48:01 +0200
Message-ID: <CAPDyKFo8SCbmJXQJJ4OR8_Tg=+YdK76k2Sg=KcO3t7ve2zzaHw@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Don't attach a device to genpd that
 corresponds to a provider
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 at 15:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, Jul 9, 2021 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Jul 9, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > According to the common power domain DT bindings, a power domain provider
> > > > must have a "#power-domain-cells" property in its OF node. Additionally, if
> > > > a provider has a "power-domains" property, it means that it has a parent
> > > > domain.
> > >
> > > OK.
> > >
> > > > It has turned out that some OF nodes that represents a genpd provider may
> > > > also be compatible with a regular platform device. This leads to, during
> > > > probe, genpd_dev_pm_attach(), genpd_dev_pm_attach_by_name() and
> > > > genpd_dev_pm_attach_by_id() tries to attach the corresponding struct device
> > > > to the genpd provider's parent domain, which is wrong. Instead the genpd
> > >
> > > Why is that wrong?
> >
> > It may lead to that the struct device that corresponds to a genpd
> > provider may be attached to the parent domain. In other words, the
> > parent domain will not only be controlled by a child domain
> > (corresponding to the provider), but also through the provider's
> > struct device. As far as I can tell, this has never been the intent
> > for how things should work in genpd.
>
> Ah, you're worried about the case where the subdomain is a child of
> the parent domain, but the actual subdomain controller (represented
> by the platform device) isn't?

Well, even if the platform device represents a subdomain controller,
should it really be attached to the parent domain?

In any case, it means that the provider needs to manage runtime PM,
etc for its struct device to not prevent the parent domain from being
powered off.

Hmm, in the end this is just a matter of expectation of what will
happen during the attach. Perhaps it's just my worries that are wrong.
:-)

>
> > So wrong or not, I guess it depends on what you expect to happen.
> >
> > Do you see an issue with changing this?
>
> I don't have any hardware where the DTS describes a node as being
> both a power domain consumer and a provider.
> SH/R-Mobile uses a nested domain description in DT, but there are
> no platform devices created for the nested child domains, only for
> the top domain.

Okay, thanks for reviewing!

Kind regards
Uffe
