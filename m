Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CA141714A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbhIXLwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbhIXLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:52:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C1C061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 04:50:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g41so39152973lfv.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEt2247V9zfkMmq1F9RlST40QLwr3RwE9wMC0mnatTk=;
        b=uWdMrY7koAR2hpcHNFqqG1zCoSd5p/Jjf5CeHKm4H8l1Hoam97B8JMcNypK9PrXOhA
         hNxHVQ/YTznhHJQME/HliSyIBBgkodP6GzSZg//VXVhavJdmPeBFgf9HdUTmbHQ9BJth
         qcbdPTeGL51PkKvu5yPfEV1Otx187LgYJ6s55ErkWzgKRNJT26cth4umeN4HCyjmBIOu
         fW1AxvMgrbc8JUze20zR4QlXYWBys49aRQw8fQ81+CYXLNVeLqqbUhvXVdRG9osRugRF
         oL4VAp/pniJDex748IlaewwcsX8L4K4vKHW/YV8rfk6hWwTCs2IvQnmo1zNAxf1CbHiw
         o1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEt2247V9zfkMmq1F9RlST40QLwr3RwE9wMC0mnatTk=;
        b=QttzwDJ2XkeX/ErjlIe3O8B5oajhSr26pYL4PQ4pfFhcvglCsFW+s2Fhpeoa7Xsxd7
         hl66Ww8bknJnzNNZiWYIjEUWrzpSb9cvvs9h9JOCey87Hd0USNpxWHcqAmVU2dEtNHdb
         04LSyx7VhGSUmDeOoADzTyki+UzESpSLh7gA1QMNVMuBv2C0kNUgdqGmjhUnwqGQkCwa
         btEF7/z+w7sEwyyEn6ehK4EJKJijs1QI/q7jfVnvKYkTb5Jd4bWqye6DEEn9b5g0ZQM+
         5YarkSxLbx7QpR43oQDqF871TDLhCj4XAAs62PJUYqboNOMq+H3y4M3uYlJzIVyW9ufE
         W9OQ==
X-Gm-Message-State: AOAM530V49dwkO6Lps88Ovdfxtx10cCykrmEWu8MYnxCD6lhsyS4g2Yd
        8iNy/Ku/K5j1GR7+ukpy2E6WLhGp3Gk68IkBMHZhtA==
X-Google-Smtp-Source: ABdhPJzT8CwjX6XkyqPrbzpNsUJn1D9zAENUSGXKVEkEMrS8jHcKlaUoEVK6FxOCzgq/WxRmjBV5Scn9f5DRr3Vp/tM=
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr8894593lfv.358.1632484232104;
 Fri, 24 Sep 2021 04:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210904000543.2019010-1-saravanak@google.com>
 <20210904000543.2019010-2-saravanak@google.com> <CAPDyKFqkvN=ZrfAnj4CqfjBu_Pj0YH9txnkP-1d=FhaEhbPrPA@mail.gmail.com>
In-Reply-To: <CAPDyKFqkvN=ZrfAnj4CqfjBu_Pj0YH9txnkP-1d=FhaEhbPrPA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Sep 2021 13:49:55 +0200
Message-ID: <CAPDyKFqRR-GD=xZo27a9MgwzKT9mar4m0Bdki1VBxnsZaQy1_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers: bus: simple-pm-bus: Add support for
 probing simple bus only devices
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-oxnas@groups.io,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sept 2021 at 13:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sat, 4 Sept 2021 at 02:05, Saravana Kannan <saravanak@google.com> wrote:
> >
> > fw_devlink could end up creating device links for bus only devices.
> > However, bus only devices don't get probed and can block probe() or
> > sync_state() [1] call backs of other devices. To avoid this, probe these
> > devices using the simple-pm-bus driver.
> >
> > However, there are instances of devices that are not simple buses (they
> > get probed by their specific drivers) that also list the "simple-bus"
> > (or other bus only compatible strings) in their compatible property to
> > automatically populate their child devices. We still want these devices
> > to get probed by their specific drivers. So, we make sure this driver
> > only probes devices that are only buses.
> >
> > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Saravana Kannan <saravanak@google.com>
>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Saravana, Rob,

I have been following your latest discussion in this thread - and it
looks like you guys are moving towards a consensus.

Although, if there is anything I can do to help to complete this, just
tell me and I will jump in immediately.

[...]

Kind regards
Uffe
