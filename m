Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBB032C12C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836953AbhCCSsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:48:17 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:41437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577675AbhCCSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:00:40 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N32y5-1lvkbC46nN-013Keh; Wed, 03 Mar 2021 18:58:08 +0100
Received: by mail-oi1-f180.google.com with SMTP id f3so26894885oiw.13;
        Wed, 03 Mar 2021 09:58:07 -0800 (PST)
X-Gm-Message-State: AOAM530v+WWZYdq/qhe+f4dauFP2anBkdnto3TdCe2nzRiKANYbHkr/p
        UUgN2xMrdTLx2I+neHTI3O8Fft6UMNJZFQ3GEPo=
X-Google-Smtp-Source: ABdhPJzzJfRRKzwYBNzVUERUAqNQNP5C2ETLtTx+v1cIJmFo1UR0Rx+93x8/9H/paFP4aN1JmYsqTM0ornWISfVST6Y=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr1226oib.67.1614794286717;
 Wed, 03 Mar 2021 09:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20210204030316.489-1-alistair@alistair23.me> <20210204030316.489-3-alistair@alistair23.me>
In-Reply-To: <20210204030316.489-3-alistair@alistair23.me>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Mar 2021 18:57:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1knYa-UHBz4Z0XNPDiM7Qd7GvVV-wHXfjMWbA9MxCcXw@mail.gmail.com>
Message-ID: <CAK8P3a1knYa-UHBz4Z0XNPDiM7Qd7GvVV-wHXfjMWbA9MxCcXw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: imx_v6_v7_defconfig: Regenerate
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:L7jtTnV5+qCWCawfmmKJn4QKJ3hbpK+IY1w6EIZyPJIkjCfh/fk
 cbHowfqJUd6fXC9cz16Y3RZxAM0RXqjk8F2aKu2JQjo2iNrxg3IjsmRWBJpNw26rXULrk90
 oExxwbv5kc+PqWNxvWNJDMFUdP9EthynK2WfFfcMgFfTL6mG0bBZKygReX+WDnA3nJggQmY
 yMZZudp94vbiqNWuUhPNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ydgaBXHcEO0=:05x+gxeQb+ny5OcrPIahVI
 Q8v1hl0ujBLLknZz3xzTfGypS37sNrc7D0t2/K1NIH11g1BGeuaLAIVTPg2mG4iIKCHpdNnPa
 3a4sW7hrfkhX+2AA4yLm/wDki38bZ/58TFS67BtM2K01BQIIsdtc8ovhXZqjFbrZ6ZImhUXyF
 5eel94sn84hs+jBDMPFrM+HeZ2R3X8uYCwQcJdWVPTYPyYC32X2r7DQsgtoZlsyU4IDeO7vso
 SVnCHO6dW/qZNIfc+b6bBgFF6yD/DVcKb6HWGsFrm4WqgtrsotF7jBg/e/sntyLRpkzWcDO12
 wbQRYvoctISvoVlLuKemC67OwUHmTvhmSBzu9GiJTkEdCTzGMlwj5TVLPuQo+AUUivDyAhfiJ
 CqkLfCmmGHh+8PUkFOaxFqEJzPX3n7tP+sZi1QYXWC4VCLn97lorFsaftauE6XCmLwOJAPghR
 E4BjFnKcsAc8jOpRJmefsRoBNRjIxF4Gam3Z7uyEVpug1OS8hHpSqJQ85E7jmDyR9rDXCxAN+
 DAmcMeoIEHCJCO5jcXWCMPr3kWAn7ousI8hBD5Q2hCsRBrFTcz2qKwynM9wWZ/9sg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 4:03 AM Alistair Francis <alistair@alistair23.me> wrote:
>
> Run make imx_v6_v7_defconfig; make savedefconfig to regenerate the
> defconfig.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

I need to do something across all our defconfigs at some point, but I want
to be done more thoroughly:

For any option or group of options that disappears from a defconfig file, I
want to see one patch (ideally across all such files) that explains why
the option that used to be intentionally enable is no longer there. If it
got renamed or replaced by something else, that should be set instead.
If there is a new dependency, we may need to enable that in addition
to the old option, rather than dropping it silently.

For options that just move around in the file, I would group them in
a final cleanup patch.

     Arnd
