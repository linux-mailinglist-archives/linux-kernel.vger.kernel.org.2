Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22508364580
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhDSN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:57:59 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbhDSN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:57:58 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Md6dH-1m7pQ40RGt-00aF3s; Mon, 19 Apr 2021 15:57:27 +0200
Received: by mail-wr1-f50.google.com with SMTP id m9so21407641wrx.3;
        Mon, 19 Apr 2021 06:57:27 -0700 (PDT)
X-Gm-Message-State: AOAM530hd5THLP8sNLQ/bCY837AAZSGxYoaHKVYwnMh7dXJyaBAThGul
        adXTBjlUY5QVsbPyJqkHaGecbqMOo1CqxX9PvR4=
X-Google-Smtp-Source: ABdhPJy9unBhJAs1A1vsfAqD5VJWjn3s3JNXApCpMos5sX1l7PV8pNqCwemCX23fbcibgwHMtR1BIfEvdX4jMjdJ3E0=
X-Received: by 2002:adf:db4f:: with SMTP id f15mr14806757wrj.99.1618840646771;
 Mon, 19 Apr 2021 06:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-13-alexandre.torgue@foss.st.com> <ececc78c-4fca-bb93-ef62-5d107501d963@pengutronix.de>
 <96da49dc-f24d-aa12-e1d8-39b5a5b6fbc9@foss.st.com>
In-Reply-To: <96da49dc-f24d-aa12-e1d8-39b5a5b6fbc9@foss.st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Apr 2021 15:57:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1bGAUbqTGqyz+PB=7fuVLkJce0awtx1Z9PE3uiX6uysQ@mail.gmail.com>
Message-ID: <CAK8P3a1bGAUbqTGqyz+PB=7fuVLkJce0awtx1Z9PE3uiX6uysQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] ARM: dts: stm32: fix DSI port node on STM32MP15
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XR4K4Z+kZU8Ibtcu18bsudZCm3PW6mgXezQPBJzwdP7hqvRsQbr
 1hc8Jo8DSidaGale7gP6v5y3IUFZITOKNG65JCjiNB11CdRytcZtjb8vKDaDu7WqN/DpFUn
 qZCHZelyBK7Pwg5iHI6KrPk5AGTKY3G1q/mLFX5/XApBxLWs9rlKsYW1/JS4GsDTpFYEtG6
 MZd2o9aGwsnGwUc/kkBcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2jsqTNmJfDY=:ta/YRgmk2ctxW8Sv/Yi6f9
 H1VSlUiITvFJWM3iwO62j/IQL+Vd3j/hGd5NbEXjZn+ODD2qBaXiB+vWjH3tgQXWuEr4bbZwE
 26QYgcuXuv41M5BXc6ZTxVVduV7rOPic0U7Qe+IoTCF9Z1GM36yS1bsiHXOxw7cdh7zXZYo9S
 r8vd8k69qSAzFL6aOA+YEgYdopwFZT1H7yZswVzHdlGGGMkwvZTyJPtiLYaRzVJFGpNE6QJf/
 49G6krnMhqjQh48EVsuYTkz9bHC4iY4I6IrU0OrDAigzcSzSnrhRq3aONqMWl6aL2JQ0F+1S5
 PrTK8R80e6X8r0euVQOri00g3XhzljHAsRrqGnYTFWs9ZPxYm4LW4kX8/iznabCvE/ThI/iFS
 JLiT2qJzM79iiHOmpv13fw7Hr6wk7FzZZjFmGa4IdNPId4pqhHJH23ZvZkbcOgqqXdUzsHsy9
 v7Ytu0Ua95IQMNurjV3MyGERl+EZ6QlNiqOaOkrm7Yc6fTvCOpQ3zo/tbdiFryk4EspL2vez0
 uRGVFs4Bn7hZbkN9a3GGuU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 2:23 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
> On 4/15/21 12:43 PM, Ahmad Fatoum wrote:
> > On 15.04.21 12:10, Alexandre Torgue wrote:
> >> Running "make dtbs_check W=1", some warnings are reported concerning
> >> DSI. This patch reorder DSI nodes to avoid:
> >>
> >> soc/dsi@5a000000: unnecessary #address-cells/#size-cells without
> >> "ranges" or child "reg" property
> >
> > This reverts parts of commit 9c32f980d9 ("ARM: dts: stm32: preset
> > stm32mp15x video #address- and #size-cells"):
> >
> >      The cell count for address and size is defined by the binding and not
> >      something a board would change. Avoid each board adding this
> >      boilerplate by having the cell size specification in the SoC DTSI.
> >
> >
> > The DSI can have child nodes with a unit address (e.g. a panel) and ones
> > without (ports { } container). ports is described in the dtsi, panels are
> > described in the dts if available.
> >
> > Apparently, the checker is fine with
> > ports {
> >       #address-cells = <1>;
> >       #size-cells = <0>;
> > };
> >
> > I think my rationale for the patch above was sound, so I think the checker
> > taking offense at the DSI cells here should be considered a false positive.
>
> If it's a "false positive" warning then we need to find a way to not
> print it out. Else, it'll be difficult to distinguish which warnings are
> "normal" and which are not. This question could also be applied to patch[3].
>
> Arnd, Rob what is your feeling about this case ?

I don't have a strong opinion on this either way, but I would just
not apply this one for 5.13 in this case. Rob, Alexandre, please
let me know if I should apply the other patches before the
merge window, I usually don't mind taking bugfixes late before the
merge window, but I still want some level of confidence that they
are actually correct.

Ahmad, if you feel strongly about this particular issue, would you like
to suggest a patch for the checker?

        Arnd
