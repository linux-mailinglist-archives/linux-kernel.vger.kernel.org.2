Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7123E0514
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbhHDQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:00:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:59551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239420AbhHDQAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628092786;
        bh=tuR6AkZISPXXqL00+nsRnE8ZS+JUJdPGMUFCl9+7OOE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VDkfS4H9+cjqBGWamQJGJ2qDdeGKeFNzwgupNxJI/osZJdrqbwx/OFfPlNk+dGuF3
         E3++vQkisCH/2anjySNtyFnxC60F/1a8vKJYdLBYhuBW+mx35z4Fp1zPyzgYF+MRJA
         nWHXlMAdKwEtyK/4pK+tu7S63NBvIwmEywJeRG5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.147.17] ([217.61.147.17]) by web-mail.gmx.net
 (3c-app-gmx-bap67.server.lan [172.19.172.67]) (via HTTP); Wed, 4 Aug 2021
 17:59:46 +0200
MIME-Version: 1.0
Message-ID: <trinity-7bda902b-2c2b-4b74-99fe-9258b7ebedcf-1628092786728@3c-app-gmx-bap67>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dafna.hirschfeld@collabora.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Aw: Re: [PATCH v2] soc: mmsys: mediatek: add mask to mmsys routes
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 4 Aug 2021 17:59:46 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <e8c990b6-180d-9702-d8cc-fd1e98dfc744@gmail.com>
References: <20210729070549.5514-1-linux@fw-web.de>
 <e8c990b6-180d-9702-d8cc-fd1e98dfc744@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Pl2oZIbBfTHdTqxy1K+GtDsXwd+8D6NgmDBAp/R6ZBuiXJ2kPj6p5pQ2NaW/n6Y6nvchJ
 kNbjXbyWCcZv0vgTgGTcf0x64rMKq7xUJupfCismXTI27PB98kcXP4qSep6ajzN4+YyR0KN0ZZ0w
 7Fyq7AGtnlN08LwUEUx9XNxYHMAgmqGGfIdlM0iwf5QhHP3yAnFN5K+DPxCTPJpbDWoC6YkyJU9t
 8G3aPvW5jPUOMrLc+BtqPolWzEgVXdAkxfHoVG6sXdeCHPYTKz5RDiq3rdokBexjrOy6jODOKGSk
 Xs=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OEk3L5WrzAo=:CBZrIqJSgoQJZwtNJLHmxv
 5jkT6aWTK06g7D2Wr/ab+IqwbfXemJFLCE9GZAVPHR3YWou1FpE3L2ST41vJ6JSEi7+llQ1sA
 5Dt2XGLTHwqeI2jEMnGlo2QudFRFeeVSVXtz9Ko0R7Sd50x9+ke5+JKUz3Pm1tRvoZoe9kLQ7
 i88SQRn7JXoZAawHcO4ucyU4YKsJUxQNOaErmnNu+cBoje5IWl8Oz6dZqiEn8wVy+301y0mdW
 fNw5Q9DzYB6uo3r6l80w2BTdUSqOmuGEHh3B4pe/vMJAzRtARCNE9fOQ02eYjrfK+7nke9xWF
 rQ7MNJ6to4a4yjylhe+NAVteXAod6fbgCPzVHmmHrY5vEkTj+JXWeF5izx3hkzCNwHANAfwZE
 Se2YdVjM7YUtYHsCnt/nDM0Rr5wvvLk0SoHXKSrI2RJ6N+9r0PUs5bAnqxnFwUPbZDWosaX3t
 oFTjcV1CS49aHoLQyDI6F0WYJS4BQbpcsYkCyGZLf854daUCjoudWzRc7AORIoePqO2C8R0sS
 m2rU7K8h62vTPor14/vPpMXlrIdKp9HO06QAA6U0xoZd04GufR0J1mbY1bjuQQLBQzLlFFEHm
 Wx4WEPppLQgFlx0uWE/esxR4b3x4BWyt1xaux+48V04Dheu95mxnm8LRRSdZqR57X7O9WZ6ug
 6vsAC+SZgpK84JTHxz3Mj2APgv5DmA7d5dq9ravMf7D39XVEqUfXanWHszdc/UZwpiT3Na94D
 U8Y3BI2oN1KFLV/dF3pMgL6vPJlOkLPwoO3ToSXr5U3BXtIUqHntuwr4l0CzzICo4ZBU7w1G3
 zZ5oLI7hINMY/QpHw1HeCS5A1ZxiNaIc3kbbEvmNeulBRJAzoE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gesendet: Mittwoch, 04. August 2021 um 17:17 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>

> My understanding is, that this does not break mt8173 and other SoCs that use the
> default routing table. Correct?

i took the mask values from CK Hu's Patch, mt7623 uses this table and with it hdmi works again (was broken by the array-commit). I'm not sure on which devices Chun-Kuang has tested it, he only suggests to add the mask again from his commit to fix mt7623.

https://patchwork.kernel.org/project/linux-mediatek/patch/20210710132431.265985-1-linux@fw-web.de/#24335233

I can only test on mt7623/BPI-R2...

there is a new patchset for mt8192 which adds a new routing-table, which needs to be extended with mask values (without it wil not work, but maybe duplicate values may work):

https://patchwork.kernel.org/project/linux-mediatek/patch/1627894773-23872-3-git-send-email-yongqiang.niu@mediatek.com/

regards Frank

> Added now to v5.14-next/soc
> Thanks.

Thanks too
