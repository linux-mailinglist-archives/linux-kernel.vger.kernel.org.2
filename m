Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1D634CF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhC2LfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhC2Ler (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:34:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F61C061574;
        Mon, 29 Mar 2021 04:34:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u10so15533585lju.7;
        Mon, 29 Mar 2021 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1/R1XphoAkVry8zc1fxL9DKWTUBErY7ZmGmBHxUfKs=;
        b=bKIsqfk3VLuh1MyLuIhzFAURd+vO2mRsHK3O3QTqJ4FU53QbpVSzrASmkomLo1qbhT
         sCBTL+Hk1H5EGb5Z10CVd2elUNODVZJRbyXSGb4WvGH4GZOLjH69JGFDKpHt1YbcUkGM
         zieMAf4Z8NtIQ9jBUVxOPQv8uNsI5E8FxKini/NMCOJQT15XcIID+tyVmOelLir6Zk3T
         rcyvrjXqrfaS+lyczPV5e2vZvvaiFdv8WKfVe0RhWrwXLtxugwGSVGsU2qPxucM1Ubau
         OVvTEQzMFGY5EJ/G0Uvb7xc9aBRDBPz/wdomVAf4Pn3jhYRxMR7aZXtvVGsCVAmGG/tv
         gOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1/R1XphoAkVry8zc1fxL9DKWTUBErY7ZmGmBHxUfKs=;
        b=kbZyZuyYUJLlrqu0wjjYL5vRiNpQP8zUc8iZzRGfinKi8YHt6dR6xdgdeuS6w4i0aN
         G08A+AAEUiBGWY5UzF7rTHLcfzVIBJ6SVTFzpOd5pOsXDj3cMmqEgbZhKG0hulz/CH35
         TL2EqzpLapxEcJzsXPJsQpGKTtXjCeFDHwxCZGOE9/xe4+9AYYjrSDMrNHYmI4btQjVf
         Do7zBHfRGGQ55r/zMi3J/P96yu6qrIiCk8H3WvE34zDqXRnUZG7ZuSpLozcJQRmY3CYi
         dKK61//W8aTk2AXoKlHaDL+ck6TbW2at52nfFuYHPG0Uupb0Xm1GbTnKw+aTR3aHDxEi
         odxA==
X-Gm-Message-State: AOAM532Ulvy/6jmi2MQzkMRlhR9owxfy+ZuJnUhMjHgbfJCqWDPPyfkL
        B8CafCljlmEpujza8w+RSVYy1mxgeK+H2L3huck=
X-Google-Smtp-Source: ABdhPJx3iPPCoc+iw8VS+NXlQfLxOFzLLjuNoGBhMASpCD+3oiVf+Evo/hbO9Uo7gXDei2gOLANPvTdrbOg10q/qVp8=
X-Received: by 2002:a2e:575c:: with SMTP id r28mr17636576ljd.347.1617017685625;
 Mon, 29 Mar 2021 04:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210329112819.64043-1-s.riedmueller@phytec.de> <20210329112819.64043-3-s.riedmueller@phytec.de>
In-Reply-To: <20210329112819.64043-3-s.riedmueller@phytec.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Mar 2021 08:34:34 -0300
Message-ID: <CAOMZO5DMnqZTedg_bb=NCZ4_cfP1sDam=N0-FrDRYTeKi+4n-g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6: pbab01: Set vmmc supply for both SD interfaces
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 8:28 AM Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:
>
> Setting the vmmc supplies is crucial since otherwise the supplying
> regulators get disabled and the SD interfaces are no longer powered
> which leads to system failures if the system is booted from that SD
> interface.

It seems that this deserves a Fixes tag.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
