Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC03E003B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhHDLdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:33:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:58305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237000AbhHDLdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628076796;
        bh=ff67APoHVniOOMt0cwe7Q/LFXBx0DO1rCUYFjM5SPiU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A4DpLSMGsTNcJhEVIZIX0JYPz4NLlphYSB/9/6ajkzGVKQYVG6NrMgbX4glOfLB/m
         ZVcNZOnLI3eQXk7bzJ8X4yiX05nY+VtcWw0scXOlvW3Bknjx6EOnrPD1VpZMKnEq5Y
         fWREb0mnmd054k4xpgS6QDESXTKGWVOLwOKMm484=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.147.17] ([217.61.147.17]) by web-mail.gmx.net
 (3c-app-gmx-bap67.server.lan [172.19.172.67]) (via HTTP); Wed, 4 Aug 2021
 13:33:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-62b8c96c-2408-46d3-9690-e78af2f0c250-1628076795963@3c-app-gmx-bap67>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Sungbo Eo <mans0n@gorani.run>, Min Guo <min.guo@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re:  [PATCH 0/2] Add MUSB for MT7623
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 4 Aug 2021 13:33:16 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <f3607979-ea50-fc1c-0afe-a55881aa24f0@gorani.run>
References: <20210803151320.71531-1-mans0n@gorani.run>
 <trinity-0f9449b8-5114-46e5-9a4f-00b62155a938-1628010948338@3c-app-gmx-bs54>
 <f3607979-ea50-fc1c-0afe-a55881aa24f0@gorani.run>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:aW7aDZrU2GL2RmeyjencG7kyYZUvA3SIsL8kdEa159ahF31Bfc6bcg0se/F1FQJUMRl/7
 fndSvU8W13kKFBOS+y7Zxx3HiDz/L/jTf1WUoEKqL6sqsCc7nu/rs35bbTK+cMI4N/pqYrudzXt7
 mhyKkA+YPBqQpC5mLpDLLYP9WnvhAycD+gJ0RU8ggjVP2YlRVK8sz0BPBtkyN9KDADyZW3oT+p7+
 glqcyfoGX8kYS1On/w9ScM00tOwWtwl9zmcWwd0GqHfLE8QEjXrTIASmfVSyVm7Q+S2BatDCzkmg
 bI=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MWGHEi+iFo0=:/jSc6JzpIdUVdjAoOKpZR8
 ciqXC+A849Qolk/zQmKqUBObRQ9eN6VjaoHXAdPcsOHAh7d0YTcl0OqB+hmYPn9xHbaYlJVMt
 QNHPn16Ud9bJvdDmVuQsnGMsvXD1GbPRvBwkxieevyVl0VOhoxSAeH0rwjKO00/qRMFt1nw2X
 OMiqey8zKkc5BJL3m65/6EiyQqLmDISpGsqU5YHnZuTSYRdadwBqYDxdhX9SlKYb9rv3Lf/ue
 FN8G0y/TS8INTqz0u9alM28NEEXh4HRhKK32bN0q5bGRqWQ81OyMI7kG8f7oE4KqrDlCSXLKw
 sq3V+Dg8IUZknXWu2DprXtX/i1jPGrFR1q9JpME45IVhPDc/pAA6Y32bdJAZMV7qOjGOYYZ40
 lBnvxqmHHPC38R2tT9FSXKm0ib+ROqMQ+hkC5CKmgwRz73kL3nvM91g1hCxSS0lAChnx0bsnA
 dfGSumSiFPPVkow/jWu1W1+OuVTZKbDERxuG9iEGqHEutXX4zraZp2JonP5JTS38If+0Xwhk1
 bcgWFaQHDOCLGuogMznQmN+/SQfv/bdAQ+FWmCSRYBt6doqBFkN8JgtLsUhI2QOhEOMv7rul8
 To66kn2S+R0XyHHJYubCxI0dazzf4jxIcv7cG7Bg/4oLxvhTyYs1epIBaiZUfZxdvZ6IX/7A7
 6aRm45uxQ9kXIQM7/viPoHQafQvGVUAxzBrksJhWIjn3bLa7PpBSKPTGR+SGIwPrApaa04me+
 OOOxFkujAgpk2ZYeEBNnfpsHppxco6jdlEu3TFwK2qZCTYwpBPU2lIgPOCIg3+Ax/na+hMwQM
 JopytI+thP795Nhxi8AUjmMRK8MvA5udnbpzrru1yzMemqhYJ4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

another strange thing is, after some bootups (i boot kernel from tftp, but=
 also on full power cycle),
musb-driver maps musb-hdrc.4.auto instead of #1

root@bpi-r2:~# dmesg | grep musb
[    5.502914] musb-hdrc musb-hdrc.4.auto: MUSB HDRC host driver
[    5.508782] musb-hdrc musb-hdrc.4.auto: new USB bus registered, assigne=
d bus number 5

and then nothing works (no roleswitch, no power which does not work with p=
inctl / without regulator).
It's hard to test if things working before, do no more work if device is n=
amed differently.

maybe Min Guo can help here?

after bootup mode is b_idle in my case (currently do not change if i conne=
ct otg cable)

root@bpi-r2:~# cat /sys/devices/platform/11200000.usb/musb-hdrc.4.auto/mod=
e
b_idle

regards Frank
