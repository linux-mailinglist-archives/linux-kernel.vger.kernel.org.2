Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460E645490B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbhKQOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhKQOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:44:42 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDFC061570;
        Wed, 17 Nov 2021 06:41:43 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id d130so1827294vke.0;
        Wed, 17 Nov 2021 06:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQX8G7rKHKZpQg48Q5MVfIqJ7w7XTW5bUNjp+OA8epI=;
        b=pMaVYoNziyx91tIqKDpmfA1rvzysvj9AE6tuddjG6iKNtXx/lW/n36v+UGgHq5vKUt
         SS8Il5Gv7NvjuRu1MASBDQDJdQX2EV9P307lFq0fyps9KKWU102O97l8c4DLGfA8oNUb
         m4PG8RN0EisgBYWCKsI6DNGDtgOUn9+1P6R/HH8nIQvVsu2P6idJ01WZ5Gn9EJCLKG0F
         TBuYlVegMOZNRrrMYmTlw5Xjm8Uwmod7tZUlqqPVcqXbwnxlP59VrE14oa/6EdS3Rhd9
         Br0ibo8pZHVIteHwZyEa2hIAYAtlfXHwbKZFadnVYZb7QmAdqg0674oJh79grhCYNAip
         cWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQX8G7rKHKZpQg48Q5MVfIqJ7w7XTW5bUNjp+OA8epI=;
        b=gkgNUVid97V7lyzpm7cbkjgOXZqY6wZa0anrRE2YL0UEP/YFNGeXUptveOYYLCtZsZ
         1S6nmjwqhpEf8a95KXpyeU4DXbWzgnRPRnD4eFUDIKUBAKMileMtKitlykW89pnzlh4i
         P71Gnp5JGHZhjODxzihaytl7Ok/QkX+TOfmd8uq6T3QlsGQRNUDQJypQtpVYjUxFD95I
         weaPqnoja7qrC/ZegjB9L1l59sm/7mZbK6MIBXC1UNrt3tl8mhEtko11jihgaY11rhV9
         sZNPXp1YQOx8JSzEaiooA5RGDnyn7qLWqUKthmEETd8uezU71fvPyiC+rMhh1p/mUt3T
         8tqA==
X-Gm-Message-State: AOAM5330IyK5SYo326cLuSUVv0ydNZbLclY/xzuO5tGCEcnS/NpM7nEv
        4QMW1rOTe2n6Elaa8EhyWjXi42wmIuVESqMx+GQ=
X-Google-Smtp-Source: ABdhPJwkgwfg9vWaWtU0OosC5rdhZC3+RSAz0/4plgC3o++3h8wcVw0CbJO3vSK9W9mlwjRknryDJMg2DiycQX81KdA=
X-Received: by 2002:a1f:9158:: with SMTP id t85mr89356241vkd.8.1637160102615;
 Wed, 17 Nov 2021 06:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20211117133202.775633-1-aford173@gmail.com>
In-Reply-To: <20211117133202.775633-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 Nov 2021 11:41:32 -0300
Message-ID: <CAOMZO5DbzD7FBDcPN63oZzc4usVN0ZbOPe8nbUj_BuSwdozTsA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mn: Fix imx8mn_clko1_sels
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        cstevens@beaconembedded.com, Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:32 AM Adam Ford <aford173@gmail.com> wrote:
>
> When attempting to use sys_pll1_80m as the parent for clko1, the
> system hangs.  This is due to the fact that the source select
> for sys_pll1_80m was incorrectly pointing to m7_alt_pll_clk, which
> doesn't yet exist.
>
> According to Rev 3 of the TRM, The imx8mn_clko1_sels also incorrectly
> references an osc_27m which does not exist, nor does an entry for
> source select bits 010b.  Fix both by inserting a dummy clock into
> the missing space in the table and renaming the incorrectly name clock
> with dummy.
>
> Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
