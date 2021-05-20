Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEDB38BA81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhETXow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhETXoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:44:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB55C061761
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:43:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a2so26977047lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53C1hfvSqmgg+nungZ28Wt68bSH0DONGE5fhh6kZnQc=;
        b=ENX17ixMrZ6LlFjW2Hbl22WtfgniaMbSi4okNpeMs4vVauku+eqDwyn6oEZESJXMxY
         PQyf7UprsW4oHu38k5myavH9faHMeACdc956gz0xg+9c6hfrXYWwf/ttU5SyDqe6HIkC
         XwI52FPB/ACpKyTG/3ghEmAoxWRpNz0TsnvXVvFGzHD6pRaKLL+KWov4ezpDXg2Z7hoZ
         HRqXf7x6XKl73GWbkCgRLdaKQ55VON9F+LfovOgkqN2So3Es3oA/Ht70YfUXv1VoPM6/
         dtmNHBcLemlfAUVve/bIApLnwG+SdheSFgmZHY3nlzA4EdEIi6+qXAxcjnFpGiAbebZ/
         zcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53C1hfvSqmgg+nungZ28Wt68bSH0DONGE5fhh6kZnQc=;
        b=rMfalO/8v3MpuAkNg2aBlJ/ZWhbWapRuLAxvTdnfBF2FzQabALXztUyZJouu3Me+yj
         JoqLzPFtOp5fRkU4nA+zLMV9xCK38GgvtIsJwFVN0qzzDy+SjQelsjYxIVFe+3reqM9M
         6um1hQqrKhEDuOa+Odj5ivf8jwTi9AR7wzQtO1Mo08ZEFyUyd7C8pLtYK698RPF1miaI
         Fey7DTyogk7THMfE/tblxgpeJZ5FutR3EuDbE/FUF+g+012krVCoDsXryt3ytaQjF/0i
         mJUQ2TJfnvKO7IXZRnxu26iguW3UwiyakYu77RU42B/gWev8zcWKS3CK5/ofe9mh9uOS
         CltQ==
X-Gm-Message-State: AOAM532dO7THFS8nQbzxWizEp/hhYedsyLyyyeQu3pLZ4OFi5r7sYOVo
        YSVeIEOkhc3oMejHl6e/hm95R4BqqKWP/39mGs3cNg==
X-Google-Smtp-Source: ABdhPJygNMj5WuHzIbvLGIODNPR3orcEL5Kz4yD//0OspA/+6bWSXTMD99hFbettxaKcI97pqpWgO+KAhFftCGBncM0=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr4401lfq.29.1621554200649;
 Thu, 20 May 2021 16:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621518686.git.geert+renesas@glider.be> <8abfe44e2ad77b6309866531ec662c5daf1e4dbf.1621518686.git.geert+renesas@glider.be>
In-Reply-To: <8abfe44e2ad77b6309866531ec662c5daf1e4dbf.1621518686.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 May 2021 01:43:09 +0200
Message-ID: <CACRpkdY1XY55HMEtkdUa-GDdy9v-47rD2aHQ90yObSKo3cmzVg@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: qcom-apq8060: Correct Ethernet node name
 and drop bogus irq property
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 3:58 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> make dtbs_check:
>
>     ethernet-ebi2@2,0: $nodename:0: 'ethernet-ebi2@2,0' does not match '^ethernet(@.*)?$'
>     ethernet-ebi2@2,0: 'smsc,irq-active-low' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> There is no "smsc,irq-active-low" property, as active low is the
> default.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think Bjorn Andersson has to apply this patch.

Yours,
Linus Walleij
