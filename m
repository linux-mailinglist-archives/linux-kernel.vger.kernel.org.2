Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776733F34D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhHTT4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:56:50 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhHTT4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:56:49 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mi23L-1mvCKe1wi9-00e5XP; Fri, 20 Aug 2021 21:56:09 +0200
Received: by mail-wr1-f46.google.com with SMTP id x12so15712968wrr.11;
        Fri, 20 Aug 2021 12:56:09 -0700 (PDT)
X-Gm-Message-State: AOAM533XIR7RoESpMDFEl4xCveGTGfuz0wRwnWy8BDtQohlQP3Nc36yn
        jmLlCwnIpSbVdoeyOHl+vocCRTK5MblTeWFE27g=
X-Google-Smtp-Source: ABdhPJxlsOZO56JajrT3f4dcrPBCUnIdfw1q5w7mc1qjtBPwrpWswZjsj3ahvDK6RwyOb2e2+QJZRAZJL69/UIIllqY=
X-Received: by 2002:adf:e107:: with SMTP id t7mr485780wrz.165.1629489369140;
 Fri, 20 Aug 2021 12:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210820173108.01d5c6de@xhacker.debian> <29e96ece-8541-a7a2-c6a9-453be6644eed@canonical.com>
 <20210820182708.51d13e29@xhacker.debian>
In-Reply-To: <20210820182708.51d13e29@xhacker.debian>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Aug 2021 21:55:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2vkZVt1bb7-iDGaSHp20U9d8QXu6AcrUMceJSS9Q_-4Q@mail.gmail.com>
Message-ID: <CAK8P3a2vkZVt1bb7-iDGaSHp20U9d8QXu6AcrUMceJSS9Q_-4Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: synaptics: add DT for AS370-RDK
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QimpFDRslHCiuY63cyRM+AAa7RQ8Z9xxAuK1gjDezpm3GVvJuEh
 p5CLs+z3EixRSaw6tjsF/NTP5DIzEgx0kuT4tlfAYQD4DbJUZFz+NxVLCK3/8RR+wl7hroa
 hXAITDyQe5cdbG1e8gR8FOAQMcz0gtLhbOajS6GoGqnfmsyXXYWG3LIk//vl6BRq1Na36dO
 6ezvm8CLyRXpl3PqQAqHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mLwtpR0sOQ0=:T0fTHYR5S5lsmlPd0tTNEx
 n38jf770zHkF5KbhPwOWOXm5DHuzSeuFnZGWGkd9aoOSOSMBI2YGehNDUu9Nx3gPu31YmcHMl
 0xDPdkJa0JqtXHCMkebr9V3ja+3kIAIFGh2XzIiJmni4wg6nedzFk8lMMs70NMTMQvDYQtYEn
 VvLnYwMMGncaPfgzEYiej0NrD369Dj/4iCswsv/89y6qwQyguRg2gtJSg3N5ZVTSQHbnDleMA
 DFoD4lc4FUgniWFBGZyERmXSGbF3eQu7hNqh9ihT87SMF2JGAWLLi7qxtQHOPtx2x5a6dnBih
 1IC7kv++8AssIzXZB27rbyO1SessWkI2DKJsEKoinvzIOqcHXXU7CpcoC25g/l6wabQpDCac4
 muEkpVEMzDYWEKyCbkxHK5tOJv9socRfyCqM3qvl6PgmmfuxL3CcjA4sflitGdU1NQlAtQlaI
 tkdivyVJV1yLLLY3JFbGCJAVZosTz5hXZexKKqKgGeP+f53niXi7n1S8dGT5Hascu+/0DOSLD
 bR7Huz8l+0an6TrpSTcOG9wsGCP2rklencgyIimquAwH50aTI301uWtBouO2qVzv1Hcf45Hk8
 MmWzUQvkNlEmhVtXZeYCUjkFvhZUeaG7Q0+kTcuCoc3qbXnX4/c1qMjyzWb7+yRJqwevcsUct
 WlCTR0om0GDgk674hY3DsBAQjy/2z+FtuuYp819KT2bwe31SmGbr9jYgy5ggwBrkZDVFuwTqC
 M5a3flpfPY1BbUaI2+ELCWzPY4xSuI0Iw3JXXSj9Shw9BsvJjTa+4DBMmvoCGrBkIC4YvrFxx
 MBmwUxQkM/AhH3C18yFHcx1hO02zIfUorjsykpRWGIE8+CoaTUJOoHH8MG5PQVhN1VM3fTY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:27 PM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> On Fri, 20 Aug 2021 11:59:30 +0200 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> > On 20/08/2021 11:31, Jisheng Zhang wrote:
> >
> > There is no such binding. You need to update the bindings file (first
> > patch in the series).
>
> This is my plan ;) In fact, "berlin4ct" related binding is also missing.
> I want to convert Documentation/devicetree/bindings/arm/syna.txt
> to yaml, then add missing bindings. But it's too late for 5.15,
>
> If it's fine to keep as370.dtsi without board user(s), we can drop
> this patch. I will solve this issue in next development window.

Yes, doing it for the next cycle is ok.

        Arnd
