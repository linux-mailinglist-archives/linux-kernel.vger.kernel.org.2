Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1DF3F7DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhHYVZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:25:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhHYVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:25:56 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MMoT4-1mZZL63hNU-00InKl for <linux-kernel@vger.kernel.org>; Wed, 25 Aug
 2021 23:25:08 +0200
Received: by mail-wr1-f50.google.com with SMTP id d26so1577967wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:25:08 -0700 (PDT)
X-Gm-Message-State: AOAM533SxapwIDVmHjsJ+n3axOPZKVofqN8Ot/ltT3iPZlJvgT0DFBp1
        yMGmI6r1gL4qfBfylkhnz6jVojJHiJOoOoCoJgI=
X-Google-Smtp-Source: ABdhPJz08oY+9k8hER1UjFLfk+E38YWeg1Ykjl7lNBjtT9AgP1ywFE3On/Z0DeDHB+fjH+K4PP1B1ijWf8t4VnXal3I=
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr178744wri.99.1629926708563;
 Wed, 25 Aug 2021 14:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210825205041.927788-1-vladimir.oltean@nxp.com> <20210825205041.927788-3-vladimir.oltean@nxp.com>
In-Reply-To: <20210825205041.927788-3-vladimir.oltean@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 25 Aug 2021 23:24:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1oDeU-S5dLqKTT3YFvGREvNt_a=PTkVoDhUJYquJGePQ@mail.gmail.com>
Message-ID: <CAK8P3a1oDeU-S5dLqKTT3YFvGREvNt_a=PTkVoDhUJYquJGePQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: syscon: request a regmap with raw spinlocks for
 some devices
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:16WoTw5KqwMVF0YunEfB1oegZEDxI50eglQaeJxkv3tEg0BVcXY
 cSjFejjKRR2m7EcDDVhBol6aS+Zs8mZcAo2/o8SvAiZzqVrkdNEM8RkTz5Ngedl0ezTbL+b
 8HXolDaEzRD1k0DwPlGAZ9t5ge7WwV9/YoVn8mHv4bJ2QNpZSnlEgmiUEWhW8ms0+PUoNBm
 +Tq80iJJN4xCosZCNkLCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cnP1+K8iRL0=:SEWCW4k5ZipyG96Tq7a3eC
 NeUh9+OMH0sKQQdS4G+5cm0XDgU+RYa7/d9zIDV5rf2rc22eyJbJeiYWwfwAVJW1OuEFtmJ4X
 SXmf6QX+T2cJSkqbBmmqkm6z3vZIrCAnj8cnx2qHoC9x2jYPAHERJkfZNQeXJd46WX/4vbgE/
 GvviNXtqNe0Mj3z4kGzwUsYPreZnw0lr2xNDH1nl+F75PTJs2nkc7lrKYa5rWhXlb8W5ZgXJ+
 4dvfuptQYyMKDtX26QrVIKVHj132IjnrM+lDV+KyvSczY3ZaA721FogJZ6VnESEJYQn77ms0C
 dei368o/N2BdgE0giWfJsFrn/kdV4IO/EzH76XMUC4VmexiWjNVhh6mvj0O2EbN501x6FM9Dw
 3iGTIt1ATAeCxve/oxNAqmHT+lcb28Nwc2hcwogF4F9t/gQk7yxwk2xojcb78o4TJ0uU5/yzV
 NlpoisyvkTnFa00KjYRySB3LjMUkaOr/n/ZYsyOxdeiFe53miV22BtGWl1XhE0Pt6ekjyeu1C
 Ygo/SjP5mXgmi7mftDl39JRC2R0heQC9BNM6P4ZHGCIxDjvjIdpbp5CtHxSTjUsmY5dFuYmPG
 G1uL1jLHiSQNjDWkyyuqirxrmg0Rr+qNfOtzLh+2bGA/4Ys/P2art2XnbjEtPDqgKR31qBkvQ
 8KWpUC1v6XKYzQe2tlngLpljBkUcQIVmi6wKGvNuDUNgFfEQc5lVo09UsbAejunxDdIIa8CKw
 h6OigjpGqkGtyOGXe5Vee6DfSmC43FSVlMA+zsGldITui1s1opGZ910WKi8XY1lzfNlCa9wQ/
 q2mLxq1JcITVeqpZ7RNyrjbDAtyZr2Sq34vHyPrh1zMd96KEwK8lOoovkKQg/5B/NmnA1/avE
 3PhBc4V8PhE7VmRRhutg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 10:50 PM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:
>
> This patch solves a ls-extirq irqchip driver bug in a perhaps
> non-intuitive (at least non-localized) way.
>
> The issue is that ls-extirq uses regmap, and due to the fact that it is
> being called by the IRQ core under raw spinlock context, it needs to use
> raw spinlocks itself. So it needs to request raw spinlocks from the
> regmap config.
>
> All is fine so far, except the ls-extirq driver does not manage its own
> regmap, instead it uses syscon_node_to_regmap() to get it from the
> parent syscon (this driver).
>
> Because the syscon regmap is initialized before any of the consumer
> drivers (ls-extirq) probe, we need to know beforehand whether to request
> raw spinlocks or not.
>
> The solution seems to be to check some compatible string. The ls-extirq
> driver probes on quite a few NXP Layerscape SoCs, all with different
> compatible strings. This is potentially fragile and subject to bit rot
> (since the fix is not localized to the ls-extirq driver, adding new
> compatible strings there but not here seems plausible). Anyway, it is
> probably the best we can do without major rework.
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This should work, but how hard would it be to change the ls-extirq
driver instead to not use the syscon driver at all but make the extirq
driver set up the regmap itself?

Are there any other users of the syscon?

         Arnd
