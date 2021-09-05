Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26E6400DBD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 02:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbhIEApk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 20:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhIEApj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 20:45:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B9C061575;
        Sat,  4 Sep 2021 17:44:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t12so6006590lfg.9;
        Sat, 04 Sep 2021 17:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kVN3qzkth5QOb06HFPcyMlkLWYEuWGGJ6G7ec86BjU=;
        b=Nn0XHYFt2qPH2gMijVa7kVGv2UQj7xB9+FowwYlHoy1l6SkG4QsDMSDKhA9Xomcbd3
         iCjnJ5/7DQoTdEL559dJytbQiYgxB9LzL0CpgBvB2VrFEy2Z+s43TvSHUyCy0/hm0c49
         GoBGnpR0sh863gVIIq3YePyZrFVy/VPHYxtVNJMm03gpqUZ98azEc3GYpK4YAYPjX1xR
         DbmioVnWn6irNvUwu4jtvErKgC3vEdimnLfbL7QZjJ7T1qApC75+zuEy4CBtIf7VG6EY
         qKB6MTRVDpR9wedvkNUg1t+S08ywDtywFQ+8y+rETvSpakCQmqxINSG/Gm9KpJsmecB2
         JREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kVN3qzkth5QOb06HFPcyMlkLWYEuWGGJ6G7ec86BjU=;
        b=pHjhrKRkwQqFITLyEyh7KYnYFrg2pQpJ0t6kh4RSsLpO7mms00kAQna6aphbXytTBZ
         6WiNneCq+dNr6qvE4G6rVpickcpmLnHh3Bs8woeqE+5Pn5ygsHdNvMuBTh0ENGmkf6yI
         nARcIwu6QKhxAev2PCPgwEb/y6sy8sVeOvHsOjOeZTwl9tAdRAcoAnsuujFVAOiSJE33
         0cxYZZxjZCA3T5IBz/Ftr9H97VUJu0oA79dZ7hYTPvoFm3pE/NlvxzdDSWxPPudUH3XB
         gX6w78YdMmReGdVVIt0+Fdg019eFy2fVIh93nUdP03zzQV7HLmjOWPvV3HpT0nUKmaXy
         hS0w==
X-Gm-Message-State: AOAM531HAQO3fna1SL+U6CpMkmV45umRoNe/ZyRRjx/BFPdglliCkMPI
        C3Jl+W9Qveu/IHUK4MRaqLM8kW/uAB0HLdDgHEw=
X-Google-Smtp-Source: ABdhPJz9Fk8HNtohSfwo7rjgRVFX6SvFNZ/ssvzRfFL4dMeTmWP0vEzHEVqPOP7XGfioX/y6w1/VfYveftg+PzS6F3M=
X-Received: by 2002:a05:6512:1508:: with SMTP id bq8mr4564651lfb.457.1630802675786;
 Sat, 04 Sep 2021 17:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210904235418.2442-1-miles.chen@mediatek.com>
In-Reply-To: <20210904235418.2442-1-miles.chen@mediatek.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 4 Sep 2021 21:44:24 -0300
Message-ID: <CAOMZO5DX08Ovije65xaHFUmmtsgh6JpqZ-sHRbdtxjYRUXUePg@mail.gmail.com>
Subject: Re: [PATCH v3] clk: imx: use module_platform_driver
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

On Sat, Sep 4, 2021 at 8:54 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
> Replace builtin_platform_driver_probe with module_platform_driver_probe
> because CONFIG_CLK_IMX8QXP can be set to =m (kernel module).
>
> Fixes: e0d0d4d86c766 ("clk: imx8qxp: Support building i.MX8QXP clock driver as module")
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
