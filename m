Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F443C5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbhJ0JDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbhJ0JDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:03:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A40C0613B9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:01:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so4689321lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=cGj+dQ2tGUj7w8Qq500MY8dnGCjVpAmT2MDeSy0C9lE=;
        b=fJvazkFlSD3tNWJJPCL+RPnUEIf4XI54Ni8jkPkIRkyj+BtBWvcd++9iS/CvhOpJao
         tWHklIWl8eb5+2A4UDwDdX+KaowTtMtLpY8wCf2DSvyA2forPPdUOHosAHW+GCI5nldz
         ogctswP04q4xrw5TEoSdUUPFTADvicC8cEIlGAhM2KTqFsaLVLu+a+SKcjrmfugkIsMS
         sL+9/g7VAATgfz0/tTOwQlzeXZyuRiihHQu6+bC4B30f2Qv3CZtzYigE7P7lNIxe+b50
         04WNAV/WTD3Q1ZeGSuE7IjhQRHt5IT14iGYCChpZNEMIXV05+Ccz6qGprnKbnQBNP9DY
         Di6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cGj+dQ2tGUj7w8Qq500MY8dnGCjVpAmT2MDeSy0C9lE=;
        b=3Vd6ksmOYMans4ePA9bK/axnMag+EAfp45PtUxse9ZHOur89tS/leYiUmMkpHvVq1r
         rDL89QcRV2LijfL7qZ5eiXkw4VjoRCXK2l4I/plszzQJ/dDcaAz//Euj/e+v1dS8P7x4
         cMXN1fXT6grkrAACrObAThARGsJf2MM1FGdpXeiS4apu95WeXmvbWGK0zmnsxls3ojOi
         9KMwPh7dQ9LgdNDvHr3INui7c6c/eEGIwf3CAaKUsC0/OcKSjBGsXa4uG3f3S1tAZuqx
         Fi5Wzdh/nFOMBkl7H7jmuBa8LkbIVY3qJRLms29aKm9Ydwo3PucqmrV+uuKHZY8V1eDX
         qwWg==
X-Gm-Message-State: AOAM532NEwuZpuWjisPQE4r1PKM4TNBubVYcTefjxiC/ZIPD4aYw3vnC
        Nqh9pR2VPy89UsANvj9tCzHrZt0h1TLUlL4Or9w=
X-Google-Smtp-Source: ABdhPJwOAcrkR6n+cnye62AvJIu3cqWXHirsEETtvXKKRxRbXuR6Rx3sSlWfGmNcFkJRb/4fa/HQiIaWEMcQH2XIloI=
X-Received: by 2002:a19:f60a:: with SMTP id x10mr18918196lfe.109.1635325280436;
 Wed, 27 Oct 2021 02:01:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 27 Oct 2021 18:00:44 +0900
Message-ID: <CAGTfZH3V=SwDL6Uy6BM++sTnUmvos4vBeJf8_nvso9L6viKPnQ@mail.gmail.com>
Subject: [GIT PULL] extcon next for 5.16
To:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        "cwchoi00@gmail.c" <cwchoi00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.16. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git
tags/extcon-next-for-5.16

for you to fetch changes up to 9e6ef3a25e5e13899381282dbd8d8d157a899262:

dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string
(2021-10-27 14:13:39 +0900)

----------------------------------------------------------------
Update extcon next for v5.16

Detailed description for this pull request:
1. Add support for TUSB320L and update tusb320 extcon driver
- The existing extcon-usbc-tusb320 driver is updated
for supporting the mode setting and reset operation.
Also, this driver supports the simliar TUSB320L device
at the same extcon-usbc-tusb320 extcon provider driver.

2. Use p-unit semaphone lock for register access for extcon-axp288 driver

3. Update the minor clean-up for extcon-max3355 and extcon-usb-gpio driver
----------------------------------------------------------------

Fabio Aiuto (1):
extcon: extcon-axp288: Use P-Unit semaphore lock for register accesses

Linus Walleij (2):
extcon: usb-gpio: Use the right includes
extcon: max3355: Drop unused include

Yassine Oudjana (3):
extcon: usbc-tusb320: Add support for mode setting and reset
extcon: usbc-tusb320: Add support for TUSB320L
dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string

.../bindings/extcon/extcon-usbc-tusb320.yaml | 4 +-
drivers/extcon/Kconfig | 2 +-
drivers/extcon/extcon-axp288.c | 31 +++-
drivers/extcon/extcon-max3355.c | 1 -
drivers/extcon/extcon-usb-gpio.c | 3 +-
drivers/extcon/extcon-usbc-tusb320.c | 163 ++++++++++++++++++++-
6 files changed, 192 insertions(+), 12 deletions(-)
