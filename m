Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296EA3F4514
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhHWGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhHWGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:41:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CFCC061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:40:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y7so29631028ljp.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOSScg11+0lHrDw6MS1CV2sNd8OdE1zWDqg1qjqqW2Y=;
        b=PYypPGwhJKWIPHwv0PNNxvgnPr8zgWPvGUeVW/uOkbS0Yv1LkNwjUiYPwyaBu+NxwW
         dYV+82j3pW0jpoHiJeHbehsfiEC8JgTXafrSgSTiLwmlPR+F4eg9qpAJg72XDqbx9Mvc
         gvHQPEr4y/JXHUQ4fJSKsQdp9nRZWGHp+2Lh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOSScg11+0lHrDw6MS1CV2sNd8OdE1zWDqg1qjqqW2Y=;
        b=FiXZT+rR9IKz7VI71o13hbMB36f5h8ODtmvBk9d/nM60fJCRrlEgasai430UhkDgSe
         eyy6iazprIL15A5TQtQwPqARKVjUMzVqFYOeRKIMiUac8Jmvy61r9ZLEhSQu6rqnvEgI
         8WnEv4H393TPfTEMUkek7d/EROYV06hnxhbye/gfqF5OHCucnspf8cuEaGuuYTkl6uMO
         hVi5wtqOGUYLVj7N4JG5rZNUE2YAiJFT9K7J6O+vDFnSQI7chkZK81aXRhasuKxx+TkK
         ErpRQO1zRu3pnI6k+g06VlZ2D9axCdsepUZp8Wu/bGB3yHzl8lWYVp/7c36y7q1Lf58Q
         tiag==
X-Gm-Message-State: AOAM5334NV2L8s/BgSmVbspCOeI9r8dfC3oHWJm5orMBQcUNP+63Ynwc
        oHxJTlrEzzMdchw4fJthuxKyLdW9vNAyrMCasxVREg==
X-Google-Smtp-Source: ABdhPJzCaNaaScS5j8xwc/H16iJK+VtsRDRaMiPRceRnRRAxbyhImqfGwZYwLIHLdB0yA9X834FjhBCHEBgVDLi4C9I=
X-Received: by 2002:a2e:b0e2:: with SMTP id h2mr25865507ljl.23.1629700837011;
 Sun, 22 Aug 2021 23:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-5-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-5-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 14:40:26 +0800
Message-ID: <CAGXv+5G8WUW5ByA12ELrUvHVshwj2nm2wMLYZeFt82g4C7BXpw@mail.gmail.com>
Subject: Re: [v2 04/24] clk: mediatek: Add API for clock resource recycle
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:18 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> In order to avoid resource leak when fail clock registartion appears,

Typo. Please fix if you respin a new version.

> so add the common interface to handle it.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
