Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0606838BA71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhETXhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhETXhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:37:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21917C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:36:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f12so21849260ljp.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiEYhj/hJUSD/IDU7Y0eQJGcwJ9in+XbFu7eZe0F0iA=;
        b=bCiqxklQUSu5WbC8cR0qbg43ubrwUlEo+xRP/SPjrzU8k7Sk/7u4MDrwPDTxTrorx0
         jB/aGOgr0DTvdY+i9cqOzEDDnr6QOLRBYZbLYO07a7zr5FhAaFIljYHosfG0/Fp1oTd+
         6f13yW40uvztfICfWMkp6B1huQAXz7k1FNT1067ApXqdFHbd74T7tyTxBIbJrf5je598
         UUnqk2cDJbI/dm2iggSb+OiNdqi/Whmvvpnb2sNMb4iiBUERoQQihcmt7Os9PX4BurxO
         ldIDpTMQK22BqM61QwJZs8sxOIR+Og6C2TgeotgXyrwiUhMUaUpGpXiIBobEjwzd1tFl
         rSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiEYhj/hJUSD/IDU7Y0eQJGcwJ9in+XbFu7eZe0F0iA=;
        b=PYQyHnhhg7XwfeTjRyhSOUIKKr/qyQfjShfGhwJgxR/PEWDXIQnPDiXfaLkH4pHibZ
         LvShd2sjj3lFLWL0A1YhI+zRKlNR9rTBWXGV8kGhmL83xqhQ693UwPcNsVNsrUkMWwAe
         56T3XUqZmtM2GhnsrhnREp+5UxZ1VaXWyTJUVZOg2/MesJCoEARYqzpht93IICrLFirz
         UfNJZXMgOMdjDUp/sulrbAENumSnqV9By9Q3pEuX8LXSfD5rJwuXeNLSKp0oCkS8b/iK
         QCHyfgvlpWVagV/EjLlnX22kHADNTa45EucsaApowy+2f2UlKa5EoujKJFe27ttzwD4L
         54FA==
X-Gm-Message-State: AOAM530+pI6YT6i73G1fIbgTalOEON/9FnAPuWwpd9963FGOyXyKxNMS
        kLtkq4tpF3NYkKIiGjVO7/p1KY8uaT1/pT7GDCdIF9UMo+8=
X-Google-Smtp-Source: ABdhPJylu8m2f30rIC/TH4AdN7RIzUYo0nBAHSBJEWQsjgqKV/fZKjWZcZqM/jwKsFKS52g6UOmCZxr0U3BasgOtyPs=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr4604039ljt.200.1621553778519;
 Thu, 20 May 2021 16:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210520161702.3746174-1-lee.jones@linaro.org>
In-Reply-To: <20210520161702.3746174-1-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 May 2021 01:36:07 +0200
Message-ID: <CACRpkdZgpFL4ALGr16hua-uSnM-5SrOZ1KGMkzTEDrZmwh_1=w@mail.gmail.com>
Subject: Re: [RESEND 1/1] clk: versatile: remove dependency on ARCH_*
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 6:17 PM Lee Jones <lee.jones@linaro.org> wrote:

> From: Peter Collingbourne <pcc@google.com>
>
> It is now possible to build a modular kernel for vexpress by
> not setting CONFIG_ARCH_VEXPRESS=y and instead setting =m on the
> drivers that it normally implies. This is with the exception of
> CLK_VEXPRESS_OSC which is currently hidden behind a dependency on
> one of several ARCH_* variables. Remove that dependency so that
> CLK_VEXPRESS_OSC may be enabled without it.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I435a21e2e5f6187db54f4ef2079b60028ab2ea69
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
