Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55F73C61B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhGLRTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:19:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:44189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhGLRTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626110171;
        bh=wmB0Rr9IQPBFqwimqWcf2igVM9vM9Uvnv61KwxUy1F0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kDJ6GpEThEucJ6kkIwvk3MbwBQ4M+BELrFJ4RmxfFiBt/ffm2yug8OcsiF3s966QM
         Dv3qu3+eBUi9Fx0B/BOUgzxnkXVFfRKmfyVyMVKIWEKNhgPBBgYDNA8C/d3CLgD+/Q
         Nwh3sNdT2YYE4AUugEv7dUea4D64QgkmygtbvOXk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.225.139] ([157.180.225.139]) by web-mail.gmx.net
 (3c-app-gmx-bs28.server.lan [172.19.170.80]) (via HTTP); Mon, 12 Jul 2021
 19:16:11 +0200
MIME-Version: 1.0
Message-ID: <trinity-02bc17fc-b458-4d17-baca-8afe30e4c92c-1626110171249@3c-app-gmx-bs28>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Aw: Re: [PATCH] soc: mediatek: mmsys: fix HDMI output on
 mt7623/bananapi-r2
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Jul 2021 19:16:11 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <456f0611-1fc7-75ac-ff45-9afd94190283@collabora.com>
References: <20210710132431.265985-1-linux@fw-web.de>
 <456f0611-1fc7-75ac-ff45-9afd94190283@collabora.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:3b3zuNuyYHAQu9Aq/AFNd3jBsrHOgzDw46MqypI0YOFxUQS6/rnXzfEUHUh5ESpFXzKOO
 pD8jmMsdfLTDif/vZg/Sp51P6PqmxTJAtrm8ytcEfrP4r51/+IXGDezxKiy4wd3k5VXj6C5ol1RN
 WJ7UdDAaaqyVmqpjv1sVSplsNFQFntB+8NDilMGEoRyPy2XOdNttOpNmgnpgKXSLMcUVp6jPtZpM
 mxuLAGwRAQH291NEcQ3FGu0R9yBX58deSR0w7jJJ/6PFO6iFgY/UpYtU0S5t/xuwjZEJNthV2eV4
 gs=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eSKhF8PrMVA=:Z1dESeqor7vV5bK1IYE3ge
 42AW+RgtomeayWkMY57YT+JHjReiHY51YMVDORTwTKbJABWbFSnLdJqnSTk17PEujXIDIMsdM
 q+vICb3ZTo7h9rMjq04RVvK8c6ZBVxohoFAOnIMchNMbQP19SendItVbb3q7yfaJkYKtawL0b
 yXtbs2id09y6w1gWw8TwL7+57Dsy9c2JWVgaX94jkTIw+wxJLDx4SH4++6ig4BcwoeXxVnlZx
 pEKHzkvNFIYMsebpwufypJmGkY3jdFhBJv04aWeho/TRBDKLuoY21U0eZhRBilhzpBI4QNXXe
 1Qren1Tob3rF191kW/IKvY996OiQOe7ISGFuRy+x4rjieYgeKObgzdge0gdEF5JbYlJ1hCmts
 a2nz+z9Nc5ONbFlBiySoyuXPM2QJRu++PnkrYAaZ+uUOpTgW+23e4zqqxO6qYGJKwSnq92Atm
 qsecxASir6b1lK1j5gy4Od02ZCDjenDohTZHTqhCg7i8vOMueFtd+CQzj8dzP68jJSqLrPo/i
 641ZTB4pCOCCB54py4R+F2cR8beJ6Tf8IJI6kTjq08mBwEyf1oOeX/uq0nzvQsy9Wg34K3Uh3
 hYg67X728n0ZakdmgUsC+mFfF/NoQub/voGEWo1pF6uctgA5g0DAqd50PSpfAKbbF/mGPa05q
 b2SVix7U+lhESJXw0gRR5YeqTjdEbz88HAFzgVXPlAdwE4jOXhmCgWzzFU5T3vr1AciEXqUTA
 iEbjRcGNgm9m2aonqs6YXedL4QY6ubsKadknzDrqKYwmyQH2PYoL8Dw8kF7qbXBcFwRzE1QJr
 JoXGrT3F0y4vubRbioeCvuB2b+GpNk6vUwceHs5SFra3XMXGY0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it turns out that problem is the read+or of the new value

i reverted my patch and changed

reg = readl_relaxed(mmsys->regs + routes[i].addr) | routes[i].val;
writel_relaxed(reg, mmsys->regs + routes[i].addr);

to

writel_relaxed(routes[i].val, mmsys->regs + routes[i].addr);

and it works too, but maybe it breaks other platforms

regards Frank
