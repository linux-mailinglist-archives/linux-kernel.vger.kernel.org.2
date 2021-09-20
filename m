Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA05412AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhIUBpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhIUBlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:41:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC43CC06EAAF;
        Mon, 20 Sep 2021 13:50:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e15so34022989lfr.10;
        Mon, 20 Sep 2021 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KdWjc4JH8nTnUNPhQ1Hy5/Kks3XFtj9NpPMeFZ5VIA=;
        b=k7HBRtk5aJbC4XVF8r6dm4MO4GClWLIob482BKxdVR+kSRNHdUzMoLfOXK8hTHbjo6
         Cl4zJuQFw4DxGVkgu/BmiahSFSTFnwOJK81AQTOcjGx0KgPF9w5DPmNnbAC0QSKoekYt
         rocy89V2TgkTuG/Akwu8IvVyyrwAUo9YyPCaGmWsmx37nWgeA2PCFgsyscYZ2gV3JoVh
         +OuctQs5AdbxcW+GnBjMftq5X0Y0TD/B5bTs8bXQvGY+rCsXLmBwKA0jw4JX7ez/csms
         iLwxN0LqMtXo/qW+0Y/vC4geUdLzG9qIbBWCSCZ8szXVSW5QwSz/fEVwJJqbbHXoXUx5
         KN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KdWjc4JH8nTnUNPhQ1Hy5/Kks3XFtj9NpPMeFZ5VIA=;
        b=4i6Vre8/BNPOvcaqFlZG+atS09D+Vdzlu0SzAfyfA3o/I+gGaousIJxHVH8SYbXlPV
         J5OSvT0PwH0PdyLHw/LvUC5jQFj4+0bvk2IiFqxtL7fFajFT0fKY1zS4o5K1aEQNyYMa
         KdkXKkBTWfX4+CktL44Zn8dLy1xgQlSePerEdp50I20Gm/UOfz/ZM8TkkOmgsho/x0Lw
         xMaKqpVEtJ9bJFGwPV9a6SV5IFzLh9JyJSPFkjR7o1wZNugTZXiumXQXBQtM/aJtCHJ8
         z2WgsgrZLrqBjlgN0C7eyg0fkLV8kFua4yF4bNnofF5CJyWCkrIzawhhBSNBb22KWewV
         vYog==
X-Gm-Message-State: AOAM533PBOiDkfMcREuR09h+ZympaUbY9Oxsgo72SsuCHznsrnG6f3Ix
        6gp+aH+cm9ZGWktezsUIpEWOaMsI1RGZ86B6Pmc=
X-Google-Smtp-Source: ABdhPJzdSPc1ysd6zimh89UIluqCez0p6d1nQRGqtI7tYeyxtoD3btqW2Gmh+clpP5MxGT1VBx51ZYufzyx9Ds02DTk=
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr25236214ljp.203.1632171056766;
 Mon, 20 Sep 2021 13:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
 <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
 <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com>
 <CAOMZO5CGuKQ0yVyoD86G3KnxoBd2fq+uCTTLoqVR-13Y5a-36Q@mail.gmail.com>
 <CAEyMn7bN247-J=Qz-k3LZMVYb8pdYSP3BSCsNE9yyvfDfmdK0g@mail.gmail.com>
 <CAOMZO5DEg81E23QBpsv44BxytEhNNoXy-r5BbnubUJTERzWYLQ@mail.gmail.com>
 <CAEyMn7Yvc_tck=Hd8GE1a7uO8nRsrkdJ7b_jL6EY0-U6b=TjoQ@mail.gmail.com> <039c9214-423f-0f62-f6d2-6f2c969512fa@kontron.de>
In-Reply-To: <039c9214-423f-0f62-f6d2-6f2c969512fa@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Sep 2021 17:50:45 -0300
Message-ID: <CAOMZO5A4x_v8wtGyDjLdMg_hS1=UZH3LV-e+Dyz=spmSaLyAaw@mail.gmail.com>
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Heiko Thiery <heiko.thiery@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

On Mon, Sep 20, 2021 at 11:26 AM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:

> Commit ed5a419bb019 ("usb: chipidea: imx: "fsl,usbphy" phandle is not
> mandatory now") explains, that the core driver already covers reading
> the "phys" property (see ci_hdrc_probe()):
>
>   Since the chipidea common code support get the USB PHY phandle from
>   "phys", the glue layer is not mandatory to get the "fsl,usbphy"
>   phandle any more.
>
> This seems to be the reason why ci_hdrc_imx_probe() doesn't return any
> error in case "fsl,usbphy" is not set. It expects that the core will
> handle data->phy = NULL and already checks for a "phys" property.

chipidea core populates ci->usb_phy when phys is used.

The charger detection function only checks data->usb_phy, so they
don't see ci->usb_phy that was populated by the chipidea core.

We could change the signature of all charger detection functions to
receive struct ci_hdrc *ci, but that will be a huge patch that will
probably not meet
the stable requirements, so I think to minimally fix stable we should
go with the proposed fix I suggested.



>
> Therefore I'm not sure Fabio's fix is the right way to go. Could it be
> that the ci_hdrc_imx driver expects that it will be probed before the
> ci_hdrc core and this isn't true in Heiko's case?
