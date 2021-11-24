Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1DC45CA43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhKXQp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbhKXQp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:45:27 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C2DC061714
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:42:17 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a14so6508624uak.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5R6IHrrJZEwUVoXpTtYS2PUjhcdwGv4YOZvYHY1k68o=;
        b=RVXX/GG4EzkWVeqnrRga8LF891j5wdFRx5Peo0g1y/FoS3gqW1o4yi5TS2MSmmc8xB
         NS73/8W1n0RMEXgnVFysTcJp9zEW9pMBIj6r2x/0E2FZVOUNrZbdSUK5B5wmUI8MgI5c
         yYzTwEaYRo1+D0ShURJSDX+zviGsTEhXpLG5fgIxC+YlbUqoODGPYs6/EZuAkQV/ZD0O
         uTM4/go4ARX0Zyomvq4IJV6Fm0ozsOpX5NyD56cZ5QUnW0FK2LW1AyPEcvEWZvOvGBXR
         KrRXXcY4h71uwJHiK9IgkhEElCArWfl7he88vaSnKzH8djsM/tJz36yNd2b4ZBCZvKW/
         HSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5R6IHrrJZEwUVoXpTtYS2PUjhcdwGv4YOZvYHY1k68o=;
        b=QlCu22AjZ2mxgAmzasUK/TrPu/BIUBI+2YeoPJmhYAXpxa8PbItMyvVGQE+DHDs9Fz
         u76Qa6/HB3hubVfifTP+rrExs2M1Wl68dqWRi0XGxi2Po/UhICgltngwdiLoZPSZCQjV
         GoG51xEKysjpDYKDbGYATiHc62ijIml62btGzJZBcnDuD6VecgYDn32uK0KO1JiJkp/S
         rdph1GACAADCytnaNjlaFUVKTnHsRmuayN6HX997ht/njc3VqlT/tQKrsWTl7g2aX3ZO
         LRN7r2lIJA8QY30lMvnWqcef4sGyZsOWwCmZUIyaAKWgxzvduTgEgYJ2yxRBNtGRVall
         PiSQ==
X-Gm-Message-State: AOAM530i0sD4/HoVvc+R/3SnKLkcs/jB31XdJiqDd+HN45PgL5hqOy3v
        ZldRf6k8/FzZWoIutQHJ4ReHwhcKbGWMUtudPpw=
X-Google-Smtp-Source: ABdhPJxFX5pY9EJ9pVkIUOB7kNrAGhD/+ruY3ovxmzYR/XNuheAOTA2GwqZb4BBdrOAHXSTSF2bwYhA+/NDH/4r1Erg=
X-Received: by 2002:ab0:39cb:: with SMTP id g11mr12509774uaw.53.1637772136639;
 Wed, 24 Nov 2021 08:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20211124142530.366-1-i.bornyakov@metrotek.ru>
In-Reply-To: <20211124142530.366-1-i.bornyakov@metrotek.ru>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 24 Nov 2021 13:42:05 -0300
Message-ID: <CAOMZO5BF5Npq8Exf6Gr9Pzxx2-Bk8oFfCnPuCGpQDKs-YixhsA@mail.gmail.com>
Subject: Re: [PATCH] bus: imx-weim: optionally enable continuous burst clock
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, system@metrotek.ru
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On Wed, Nov 24, 2021 at 11:39 AM Ivan Bornyakov <i.bornyakov@metrotek.ru> wrote:
>
> To enable continuous burst clock, add "fsl,continuous-burst-clk" along
> with "fsl,burst-clk-enable" property to the weim bus's devicetree node.
>
> Example:
> weim: weim@21b8000 {
>         compatible = "fsl,imx6ul-weim", "fsl,imx6q-weim";
>         reg = <0x021b8000 0x4000>;
>         clocks = <&clks 143>;
>         #address-cells = <2>;
>         #size-cells = <1>;
>         ranges = <0 0 0x50000000 0x08000000>;
>         fsl,weim-cs-gpr = <&gpr>;
>         fsl,burst-clk-enable;
>         fsl,continuous-burst-clk;
>
>         client-device@0 {
>                 ...
>         };
> };
>
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

Please also send a patch that documents the new property in the bindings doc:
Documentation/devicetree/bindings/bus/imx-weim.txt

Thanks
